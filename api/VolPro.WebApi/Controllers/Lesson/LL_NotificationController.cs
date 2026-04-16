using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace VolPro.MES.Controllers
{
    /// <summary>
    /// Lesson Learn 邮件通知 Controller
    /// 提供 API 接口供前端触发任务提醒、审批通知等邮件发送。
    /// </summary>
    [Route("api/LL_Notification")]
    [ApiController]
    public class LL_NotificationController : ControllerBase
    {
        private readonly EmailNotificationService _emailService;

        public LL_NotificationController(IConfiguration configuration)
        {
            _emailService = new EmailNotificationService(configuration);
        }

        /// <summary>
        /// 发送任务逾期提醒邮件
        /// </summary>
        [HttpPost("TaskOverdueReminder")]
        public async Task<IActionResult> TaskOverdueReminder([FromBody] TaskReminderRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.OwnerEmail))
                {
                    return Ok(new { status = false, message = "责任人邮箱不能为空" });
                }

                var result = await _emailService.SendTaskOverdueReminderAsync(
                    request.OwnerEmail,
                    request.OwnerName ?? "同事",
                    request.LessonNo ?? "-",
                    request.TaskTitle ?? "-",
                    request.DueDate ?? "-"
                );

                return Ok(new { status = result.Success, message = result.Message });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"发送失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 批量发送任务逾期提醒
        /// </summary>
        [HttpPost("BatchTaskReminder")]
        public async Task<IActionResult> BatchTaskReminder([FromBody] List<TaskReminderRequest> requests)
        {
            try
            {
                if (requests == null || requests.Count == 0)
                {
                    return Ok(new { status = false, message = "没有需要发送的提醒" });
                }

                int successCount = 0;
                int failCount = 0;
                var errors = new List<string>();

                foreach (var request in requests)
                {
                    if (string.IsNullOrWhiteSpace(request?.OwnerEmail)) continue;

                    var result = await _emailService.SendTaskOverdueReminderAsync(
                        request.OwnerEmail,
                        request.OwnerName ?? "同事",
                        request.LessonNo ?? "-",
                        request.TaskTitle ?? "-",
                        request.DueDate ?? "-"
                    );

                    if (result.Success)
                        successCount++;
                    else
                    {
                        failCount++;
                        errors.Add($"{request.OwnerEmail}: {result.Message}");
                    }
                }

                return Ok(new
                {
                    status = true,
                    message = $"已发送 {successCount} 封提醒邮件，失败 {failCount} 封",
                    data = new { successCount, failCount, errors }
                });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"批量发送失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 发送审批流程通知
        /// </summary>
        [HttpPost("ApprovalNotification")]
        public async Task<IActionResult> ApprovalNotification([FromBody] ApprovalNotificationRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.ToEmail))
                {
                    return Ok(new { status = false, message = "收件人邮箱不能为空" });
                }

                var result = await _emailService.SendApprovalNotificationAsync(
                    request.ToEmail,
                    request.ToName ?? "同事",
                    request.LessonNo ?? "-",
                    request.TitleEn ?? "-",
                    request.Action ?? "submit",
                    request.OperatorName ?? "-",
                    request.Comment ?? ""
                );

                return Ok(new { status = result.Success, message = result.Message });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"发送失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 发送问题中心状态变更通知
        /// </summary>
        [HttpPost("ProblemStatusChange")]
        public async Task<IActionResult> ProblemStatusChange([FromBody] ProblemStatusChangeRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.ToEmail))
                {
                    return Ok(new { status = false, message = "收件人邮箱不能为空" });
                }

                var result = await _emailService.SendProblemStatusChangeAsync(
                    request.ToEmail,
                    request.ToName ?? "同事",
                    request.IssueNo ?? "-",
                    request.Description ?? "-",
                    request.NewStatus ?? "Open"
                );

                return Ok(new { status = result.Success, message = result.Message });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"发送失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 通用邮件发送（自定义标题和内容）
        /// </summary>
        [HttpPost("SendCustomEmail")]
        public async Task<IActionResult> SendCustomEmail([FromBody] CustomEmailRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.ToEmail))
                {
                    return Ok(new { status = false, message = "收件人邮箱不能为空" });
                }

                var result = await _emailService.SendEmailAsync(
                    request.ToEmail,
                    request.Subject ?? "Lesson Learn 通知",
                    request.HtmlBody ?? "",
                    request.CcEmails
                );

                return Ok(new { status = result.Success, message = result.Message });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"发送失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 测试邮件连通性（POST /api/LL_Notification/TestConnection）
        /// </summary>
        [HttpPost("TestConnection")]
        public async Task<IActionResult> TestConnection([FromBody] TestEmailRequest request)
        {
            try
            {
                var toEmail = request?.ToEmail ?? "LessonLearn@nexteer.com";
                var result = await _emailService.SendEmailAsync(
                    toEmail,
                    "Lesson Learn System - 邮件连通测试",
                    "<p>此邮件为系统自动发送的连通性测试邮件。</p><p>如果您收到此邮件，说明 SMTP 配置正确。</p>"
                );

                return Ok(new { status = result.Success, message = result.Message });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"测试失败: {ex.Message}" });
            }
        }
    }

    #region Request Models

    public class TaskReminderRequest
    {
        public string OwnerEmail { get; set; }
        public string OwnerName { get; set; }
        public string LessonNo { get; set; }
        public string TaskTitle { get; set; }
        public string DueDate { get; set; }
    }

    public class ApprovalNotificationRequest
    {
        public string ToEmail { get; set; }
        public string ToName { get; set; }
        public string LessonNo { get; set; }
        public string TitleEn { get; set; }
        public string Action { get; set; }
        public string OperatorName { get; set; }
        public string Comment { get; set; }
    }

    public class ProblemStatusChangeRequest
    {
        public string ToEmail { get; set; }
        public string ToName { get; set; }
        public string IssueNo { get; set; }
        public string Description { get; set; }
        public string NewStatus { get; set; }
    }

    public class CustomEmailRequest
    {
        public string ToEmail { get; set; }
        public string Subject { get; set; }
        public string HtmlBody { get; set; }
        public List<string> CcEmails { get; set; }
    }

    public class TestEmailRequest
    {
        public string ToEmail { get; set; }
    }

    #endregion
}
