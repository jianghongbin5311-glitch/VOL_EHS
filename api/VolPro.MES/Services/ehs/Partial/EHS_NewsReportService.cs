using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace VolPro.MES.Services
{
    public partial class EHS_NewsReportService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_NewsReportRepository _repository;
        private readonly IConfiguration _configuration;

        [ActivatorUtilitiesConstructor]
        public EHS_NewsReportService(
            IEHS_NewsReportRepository dbRepository,
            IHttpContextAccessor httpContextAccessor,
            IConfiguration configuration
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
            _configuration = configuration;
        }

        /// <summary>
        /// 调用内部ChatGPT生成EHS法规新闻报告
        /// </summary>
        public async Task<string> GenerateReportAsync(string reportType)
        {
            var baseUrl = _configuration["EhsAi:BaseUrl"];
            var apiKey = _configuration["EhsAi:ApiKey"];
            var model = _configuration["EhsAi:Model"] ?? "Internal_ChatGPT4o";

            if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(apiKey))
            {
                return "EhsAi配置缺失，请检查appsettings.json中的EhsAi节";
            }

            var now = DateTime.Now;
            string timeRange;
            string reportTitle;

            switch (reportType)
            {
                case "周报":
                    var weekStart = now.AddDays(-(int)now.DayOfWeek - 6);
                    var weekEnd = weekStart.AddDays(6);
                    timeRange = $"{weekStart:yyyy-MM-dd} 至 {weekEnd:yyyy-MM-dd}";
                    reportTitle = $"EHS外部法规新闻周报（{timeRange}）";
                    break;
                case "月报":
                    var monthStart = new DateTime(now.Year, now.Month, 1).AddMonths(-1);
                    var monthEnd = monthStart.AddMonths(1).AddDays(-1);
                    timeRange = $"{monthStart:yyyy-MM-dd} 至 {monthEnd:yyyy-MM-dd}";
                    reportTitle = $"EHS外部法规新闻月报（{monthStart:yyyy年MM月}）";
                    break;
                default: // 日报
                    timeRange = $"{now:yyyy-MM-dd}";
                    reportTitle = $"EHS外部法规新闻日报（{now:yyyy-MM-dd}）";
                    break;
            }

            var systemPrompt = @"你是一个专业的EHS（环境、健康、安全）法规分析师。请检查以下网站过去相关时间内与苏州/江苏制造业EHS相关的新内容:

网站：
1. 苏州市应急管理局 (yjglj.suzhou.gov.cn)
2. 苏州市政府安全质量 (www.suzhou.gov.cn/szsrmzf/aqzl/)
3. 苏州市生态环境局 (sthjj.suzhou.gov.cn)
4. 江苏省应急管理厅 (yjglt.jiangsu.gov.cn)
5. 应急管理部 (www.mem.gov.cn)

筛选关键词：安全生产、事故调查、行政处罚、危化品、有限空间、粉尘涉爆、特种设备、VOC、危废、环境执法、隐患排查、应急预案

对于每条相关内容，请以JSON数组输出，每条记录包含以下字段：
{
  ""title"": ""标题"",
  ""date"": ""日期(yyyy-MM-dd)"",
  ""source"": ""来源"",
  ""sourceUrl"": ""链接"",
  ""summary"": ""摘要(100字内)"",
  ""category"": ""类别(事故/处罚/法规/检查/预警/培训)"",
  ""impact"": ""对工厂EHS的影响"",
  ""action"": ""建议动作""
}

要求：
- 只保留真正相关内容
- 去掉宣传类新闻
- 按重要性排序
- 如果没有找到相关内容，返回空数组 []
- 只输出JSON数组，不要其他文字";

            var userPrompt = $"请生成 {reportType}，时间范围: {timeRange}。分析所有与苏州/江苏制造业EHS相关的最新法规、政策、事故和执法动态。";

            try
            {
                using var httpClient = new HttpClient();
                httpClient.Timeout = TimeSpan.FromSeconds(120);

                var requestBody = new
                {
                    model = model,
                    messages = new[]
                    {
                        new { role = "system", content = systemPrompt },
                        new { role = "user", content = userPrompt }
                    },
                    temperature = 0.3,
                    max_tokens = 4000
                };

                var json = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiKey}");

                var response = await httpClient.PostAsync(baseUrl, content);
                var responseBody = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                {
                    // 保存失败记录
                    var failReport = new EHS_NewsReport
                    {
                        ReportType = reportType,
                        ReportDate = now,
                        Title = reportTitle,
                        Content = null,
                        AiModel = model,
                        GenerateStatus = 3,
                        ErrorMessage = $"HTTP {(int)response.StatusCode}: {responseBody}",
                        Status = 1,
                        CreateDate = now,
                        Creator = "AI_System",
                        CreateID = 1
                    };
                    _repository.DbContext.Set<EHS_NewsReport>().Add(failReport);
                    await _repository.DbContext.SaveChangesAsync();
                    return $"AI调用失败: HTTP {(int)response.StatusCode}";
                }

                // 解析AI返回内容
                using var doc = JsonDocument.Parse(responseBody);
                var aiContent = doc.RootElement
                    .GetProperty("choices")[0]
                    .GetProperty("message")
                    .GetProperty("content")
                    .GetString();

                // 尝试解析AI返回的JSON数组
                var items = new List<AiNewsItem>();
                try
                {
                    // 去掉可能的markdown代码块标记
                    var cleanContent = aiContent.Trim();
                    if (cleanContent.StartsWith("```"))
                    {
                        var firstNewLine = cleanContent.IndexOf('\n');
                        cleanContent = cleanContent.Substring(firstNewLine + 1);
                        if (cleanContent.EndsWith("```"))
                            cleanContent = cleanContent.Substring(0, cleanContent.Length - 3);
                    }
                    items = JsonSerializer.Deserialize<List<AiNewsItem>>(cleanContent.Trim(),
                        new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
                }
                catch
                {
                    // 如果无法解析为JSON数组，直接存储为Markdown格式的报告
                    var markdownReport = new EHS_NewsReport
                    {
                        ReportNo = $"RPT-{now:yyyyMMdd}-{now:HHmm}",
                        ReportType = reportType,
                        ReportDate = now,
                        Title = reportTitle,
                        Content = aiContent,
                        Summary = $"{reportType} - AI生成于 {now:yyyy-MM-dd HH:mm}",
                        Category = "综合",
                        AiModel = model,
                        GenerateStatus = 2,
                        Status = 1,
                        CreateDate = now,
                        Creator = "AI_System",
                        CreateID = 1
                    };
                    _repository.DbContext.Set<EHS_NewsReport>().Add(markdownReport);
                    await _repository.DbContext.SaveChangesAsync();
                    return "报告已生成(Markdown格式)";
                }

                if (items == null || items.Count == 0)
                {
                    return "本期无相关内容";
                }

                // 为每条新闻创建记录
                var reportNo = 1;
                foreach (var item in items)
                {
                    var report = new EHS_NewsReport
                    {
                        ReportNo = $"RPT-{now:yyyyMMdd}-{reportNo:D3}",
                        ReportType = reportType,
                        ReportDate = now,
                        Title = item.Title ?? reportTitle,
                        Content = BuildMarkdownContent(item),
                        Summary = item.Summary,
                        Category = item.Category,
                        Source = item.Source,
                        SourceUrl = item.SourceUrl,
                        Impact = item.Impact,
                        Action = item.Action,
                        AiModel = model,
                        GenerateStatus = 2,
                        Status = 1,
                        CreateDate = now,
                        Creator = "AI_System",
                        CreateID = 1
                    };
                    _repository.DbContext.Set<EHS_NewsReport>().Add(report);
                    reportNo++;
                }
                await _repository.DbContext.SaveChangesAsync();
                return $"成功生成{items.Count}条{reportType}记录";
            }
            catch (Exception ex)
            {
                var failReport = new EHS_NewsReport
                {
                    ReportType = reportType,
                    ReportDate = now,
                    Title = reportTitle,
                    AiModel = model,
                    GenerateStatus = 3,
                    ErrorMessage = ex.Message,
                    Status = 1,
                    CreateDate = now,
                    Creator = "AI_System",
                    CreateID = 1
                };
                _repository.DbContext.Set<EHS_NewsReport>().Add(failReport);
                await _repository.DbContext.SaveChangesAsync();
                return $"生成失败: {ex.Message}";
            }
        }

        private string BuildMarkdownContent(AiNewsItem item)
        {
            var sb = new StringBuilder();
            sb.AppendLine($"## {item.Title}");
            sb.AppendLine();
            sb.AppendLine($"**日期**: {item.Date}");
            sb.AppendLine();
            sb.AppendLine($"**来源**: {item.Source}");
            if (!string.IsNullOrEmpty(item.SourceUrl))
                sb.AppendLine($"**链接**: [{item.Source}]({item.SourceUrl})");
            sb.AppendLine();
            sb.AppendLine($"**类别**: {item.Category}");
            sb.AppendLine();
            sb.AppendLine("### 摘要");
            sb.AppendLine(item.Summary);
            sb.AppendLine();
            sb.AppendLine("### 对工厂EHS的影响");
            sb.AppendLine(item.Impact);
            sb.AppendLine();
            sb.AppendLine("### 建议动作");
            sb.AppendLine(item.Action);
            return sb.ToString();
        }

        private class AiNewsItem
        {
            public string Title { get; set; }
            public string Date { get; set; }
            public string Source { get; set; }
            public string SourceUrl { get; set; }
            public string Summary { get; set; }
            public string Category { get; set; }
            public string Impact { get; set; }
            public string Action { get; set; }
        }
    }
}
