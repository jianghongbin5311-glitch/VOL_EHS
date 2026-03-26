using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace VolPro.Core.SignalR
{
    /// <summary>
    /// 外部通知服务接口 — 负责向 Teams/飞书/微信等外部渠道推送紧急消息
    /// </summary>
    public interface IExternalNotificationService
    {
        /// <summary>
        /// 判断给定等级是否属于紧急等级
        /// </summary>
        bool IsUrgentLevel(string level);

        /// <summary>
        /// 触发紧急推送（SignalR 全局广播 + 外部渠道）
        /// </summary>
        Task TriggerUrgentNotificationAsync(string module, string title, string level, string description, string factoryName, string occurDate);

        /// <summary>
        /// 发送 Teams Webhook 消息
        /// </summary>
        Task SendTeamsAlertAsync(string module, string title, string level, string description, string factoryName, string occurDate);
    }

    /// <summary>
    /// 外部通知服务实现
    /// </summary>
    public class ExternalNotificationService : IExternalNotificationService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IHubContext<MessageHub> _hubContext;
        private readonly IConfiguration _configuration;
        private readonly ILogger<ExternalNotificationService> _logger;

        /// <summary>
        /// 紧急等级列表（从配置读取）
        /// </summary>
        private readonly HashSet<string> _urgentLevels;

        /// <summary>
        /// Teams Webhook URL
        /// </summary>
        private readonly string _teamsWebhookUrl;

        public ExternalNotificationService(
            IHttpClientFactory httpClientFactory,
            IHubContext<MessageHub> hubContext,
            IConfiguration configuration,
            ILogger<ExternalNotificationService> logger)
        {
            _httpClientFactory = httpClientFactory;
            _hubContext = hubContext;
            _configuration = configuration;
            _logger = logger;

            // 从配置读取紧急等级
            var levels = _configuration.GetSection("EhsNotification:UrgentLevels").Get<string[]>();
            _urgentLevels = levels != null
                ? new HashSet<string>(levels)
                : new HashSet<string> { "重大", "特别重大", "重大隐患", "特别重大隐患" };

            _teamsWebhookUrl = _configuration["EhsNotification:TeamsWebhookUrl"] ?? "";
        }

        /// <summary>
        /// 判断给定等级是否属于紧急等级
        /// </summary>
        public bool IsUrgentLevel(string level)
        {
            if (string.IsNullOrEmpty(level)) return false;
            return _urgentLevels.Contains(level);
        }

        /// <summary>
        /// 触发紧急推送 — 同时发送 SignalR 全局广播 + Teams Webhook
        /// </summary>
        public async Task TriggerUrgentNotificationAsync(
            string module, string title, string level,
            string description, string factoryName, string occurDate)
        {
            // 1. SignalR 全局广播（向所有在线用户推送紧急模态弹窗）
            try
            {
                var message = $"【{level}】{title}";
                await _hubContext.Clients.All.SendAsync("ReceiveHomePageMessage", new
                {
                    code = "EHS_URGENT",
                    message,
                    NotificationType = Enums.NotificationType.系统,
                    BusinessFunction = module,
                    Title = message,
                    Date = DateTime.Now,
                    creator = "EHS系统"
                });
                _logger.LogInformation("EHS紧急通知已广播: {Module} - {Title}", module, title);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "SignalR紧急广播失败: {Title}", title);
            }

            // 2. Teams Webhook 推送
            try
            {
                await SendTeamsAlertAsync(module, title, level, description, factoryName, occurDate);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Teams Webhook推送失败: {Title}", title);
            }
        }

        /// <summary>
        /// 发送 Teams Webhook 消息（Power Automate / Incoming Webhook 通用）
        /// </summary>
        public async Task SendTeamsAlertAsync(
            string module, string title, string level,
            string description, string factoryName, string occurDate)
        {
            if (string.IsNullOrEmpty(_teamsWebhookUrl))
            {
                _logger.LogWarning("Teams Webhook URL 未配置，跳过推送");
                return;
            }

            var client = _httpClientFactory.CreateClient("TeamsWebhook");
            client.Timeout = TimeSpan.FromSeconds(30);

            // 构建 Adaptive Card 格式消息（兼容 Power Automate 和 Teams Incoming Webhook）
            var payload = new
            {
                type = "message",
                attachments = new[]
                {
                    new
                    {
                        contentType = "application/vnd.microsoft.card.adaptive",
                        contentUrl = (string)null,
                        content = new
                        {
                            type = "AdaptiveCard",
                            body = new object[]
                            {
                                new
                                {
                                    type = "TextBlock",
                                    size = "Large",
                                    weight = "Bolder",
                                    color = "Attention",
                                    text = $"🚨 EHS 紧急通报 — {level}"
                                },
                                new
                                {
                                    type = "TextBlock",
                                    text = title,
                                    weight = "Bolder",
                                    size = "Medium",
                                    wrap = true
                                },
                                new
                                {
                                    type = "FactSet",
                                    facts = new object[]
                                    {
                                        new { title = "模块", value = module },
                                        new { title = "等级", value = level },
                                        new { title = "工厂", value = factoryName ?? "未指定" },
                                        new { title = "时间", value = occurDate ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm") }
                                    }
                                },
                                new
                                {
                                    type = "TextBlock",
                                    text = description ?? "",
                                    wrap = true,
                                    maxLines = 5
                                }
                            },
                            schema = "http://adaptivecards.io/schemas/adaptive-card.json",
                            version = "1.4"
                        }
                    }
                }
            };

            var json = JsonSerializer.Serialize(payload);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await client.PostAsync(_teamsWebhookUrl, content);

            if (response.IsSuccessStatusCode)
            {
                _logger.LogInformation("Teams Webhook 推送成功: {Title}", title);
            }
            else
            {
                var responseBody = await response.Content.ReadAsStringAsync();
                _logger.LogError("Teams Webhook 推送失败: {StatusCode} - {Body}", response.StatusCode, responseBody);
            }
        }
    }
}
