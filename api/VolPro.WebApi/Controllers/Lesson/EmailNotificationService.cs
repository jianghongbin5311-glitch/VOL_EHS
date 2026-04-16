using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace VolPro.MES.Controllers
{
    /// <summary>
    /// Lesson Learn 邮件通知服务
    /// 使用公司内部 SMTP 服务器（端口25，无需认证）发送通知邮件。
    /// 配置来源：appsettings.json → Email 段。
    /// </summary>
    public class EmailNotificationService
    {
        private readonly string _fromName;
        private readonly string _fromEmail;
        private readonly string _serverIP;
        private readonly int _serverPort;
        private readonly bool _enableSsl;
        private readonly string _authPwd;
        private readonly string _environment;

        public EmailNotificationService(IConfiguration configuration)
        {
            _fromName = configuration["Email:FromName"] ?? "Lesson Learn System";
            _fromEmail = configuration["Email:FromEmail"] ?? "LessonLearn@nexteer.com";
            _serverIP = configuration["Email:ServerIP"] ?? "10.243.98.117";
            _serverPort = int.TryParse(configuration["Email:ServerPort"], out var port) ? port : 25;
            _enableSsl = bool.TryParse(configuration["Email:EnableSsl"], out var ssl) && ssl;
            _authPwd = configuration["Email:AuthPwd"] ?? "";
            _environment = configuration["Email:Environment"] ?? "Development";
        }

        /// <summary>
        /// 发送单封邮件
        /// </summary>
        public async Task<(bool Success, string Message)> SendEmailAsync(
            string toEmail,
            string subject,
            string htmlBody,
            List<string> ccEmails = null)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(toEmail))
                    return (false, "收件人邮箱不能为空");

                // 非生产环境时在标题添加环境标识
                if (_environment != "Production")
                {
                    subject = $"[{_environment}] {subject}";
                }

                using var smtpClient = new SmtpClient(_serverIP, _serverPort)
                {
                    EnableSsl = _enableSsl,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = string.IsNullOrEmpty(_authPwd)
                };

                // 仅在有密码时设置凭据
                if (!string.IsNullOrEmpty(_authPwd))
                {
                    smtpClient.Credentials = new NetworkCredential(_fromEmail, _authPwd);
                }

                using var mailMessage = new MailMessage
                {
                    From = new MailAddress(_fromEmail, _fromName),
                    Subject = subject,
                    Body = htmlBody,
                    IsBodyHtml = true,
                    SubjectEncoding = System.Text.Encoding.UTF8,
                    BodyEncoding = System.Text.Encoding.UTF8
                };

                mailMessage.To.Add(new MailAddress(toEmail));

                if (ccEmails != null)
                {
                    foreach (var cc in ccEmails)
                    {
                        if (!string.IsNullOrWhiteSpace(cc))
                            mailMessage.CC.Add(new MailAddress(cc));
                    }
                }

                await smtpClient.SendMailAsync(mailMessage);
                return (true, "邮件发送成功");
            }
            catch (Exception ex)
            {
                return (false, $"邮件发送失败: {ex.Message}");
            }
        }

        /// <summary>
        /// 发送任务逾期提醒
        /// </summary>
        public async Task<(bool Success, string Message)> SendTaskOverdueReminderAsync(
            string ownerEmail,
            string ownerName,
            string lessonNo,
            string taskTitle,
            string dueDate)
        {
            var subject = $"⚠ Lesson Learn 任务逾期提醒 - {lessonNo}";
            var body = BuildHtmlTemplate(
                "任务逾期提醒",
                $@"<p>Hi {ownerName},</p>
                <p>以下 Lesson Learn 任务已逾期，请尽快跟进处理：</p>
                <table style='border-collapse:collapse;width:100%;margin:16px 0;'>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>LL 编号</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{lessonNo}</td>
                    </tr>
                    <tr>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;background:#f8fafc;'>任务名称</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{taskTitle}</td>
                    </tr>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>截止日期</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;color:#ef4444;font-weight:bold;'>{dueDate}</td>
                    </tr>
                </table>
                <p>请登录 Lesson Learn 系统查看详细信息并完成任务闭环。</p>");

            return await SendEmailAsync(ownerEmail, subject, body);
        }

        /// <summary>
        /// 发送审批通知（提交/驳回/发布）
        /// </summary>
        public async Task<(bool Success, string Message)> SendApprovalNotificationAsync(
            string toEmail,
            string toName,
            string lessonNo,
            string titleEn,
            string action,
            string operatorName,
            string comment = "")
        {
            var actionText = action switch
            {
                "submit" => "提交审批",
                "reject" => "审批驳回",
                "publish" => "审批发布",
                _ => action
            };

            var actionColor = action switch
            {
                "submit" => "#3b82f6",
                "reject" => "#ef4444",
                "publish" => "#22c55e",
                _ => "#64748b"
            };

            var subject = $"📋 Lesson Learn {actionText} - {lessonNo}";
            var body = BuildHtmlTemplate(
                $"Lesson Learn {actionText}",
                $@"<p>Hi {toName},</p>
                <p>以下 Lesson Learn 记录状态已变更：</p>
                <table style='border-collapse:collapse;width:100%;margin:16px 0;'>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>LL 编号</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{lessonNo}</td>
                    </tr>
                    <tr>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;background:#f8fafc;'>标题</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{titleEn}</td>
                    </tr>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>操作</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>
                            <span style='background:{actionColor};color:#fff;padding:4px 12px;border-radius:12px;font-size:13px;'>{actionText}</span>
                        </td>
                    </tr>
                    <tr>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;background:#f8fafc;'>操作人</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{operatorName}</td>
                    </tr>
                    {(string.IsNullOrWhiteSpace(comment) ? "" : $"<tr style='background:#f1f5f9;'><th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>备注</th><td style='border:1px solid #e2e8f0;padding:10px;'>{comment}</td></tr>")}
                </table>
                <p>请登录 Lesson Learn 系统查看详细信息。</p>");

            return await SendEmailAsync(toEmail, subject, body);
        }

        /// <summary>
        /// 发送问题中心状态变更通知
        /// </summary>
        public async Task<(bool Success, string Message)> SendProblemStatusChangeAsync(
            string toEmail,
            string toName,
            string issueNo,
            string description,
            string newStatus)
        {
            var statusColor = newStatus switch
            {
                "Closed" => "#22c55e",
                "Open" => "#ef4444",
                _ => "#f59e0b"
            };

            var subject = $"🔔 问题中心状态变更 - {issueNo} → {newStatus}";
            var body = BuildHtmlTemplate(
                "问题状态变更通知",
                $@"<p>Hi {toName},</p>
                <p>以下问题记录状态已更新：</p>
                <table style='border-collapse:collapse;width:100%;margin:16px 0;'>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>Issue No.</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;font-weight:bold;'>{issueNo}</td>
                    </tr>
                    <tr>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;background:#f8fafc;'>问题描述</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>{description}</td>
                    </tr>
                    <tr style='background:#f1f5f9;'>
                        <th style='border:1px solid #e2e8f0;padding:10px;text-align:left;'>新状态</th>
                        <td style='border:1px solid #e2e8f0;padding:10px;'>
                            <span style='background:{statusColor};color:#fff;padding:4px 12px;border-radius:12px;font-size:13px;'>{newStatus}</span>
                        </td>
                    </tr>
                </table>
                <p>请登录系统查看详细信息。</p>");

            return await SendEmailAsync(toEmail, subject, body);
        }

        /// <summary>
        /// 构建 HTML 邮件模板
        /// </summary>
        private string BuildHtmlTemplate(string title, string content)
        {
            return $@"<!DOCTYPE html>
<html><head><meta charset='utf-8'></head>
<body style='font-family:""Segoe UI"",Arial,sans-serif;background:#f7f9fd;margin:0;padding:0;'>
<div style='max-width:640px;margin:0 auto;background:#ffffff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.08);margin-top:24px;margin-bottom:24px;'>
    <!-- Header -->
    <div style='background:linear-gradient(135deg,#4f46e5,#7c3aed);padding:28px 32px;'>
        <h1 style='margin:0;color:#ffffff;font-size:22px;font-weight:700;'>{title}</h1>
        <p style='margin:6px 0 0;color:rgba(255,255,255,0.85);font-size:13px;'>Lesson Learn System · Nexteer Automotive</p>
    </div>
    <!-- Body -->
    <div style='padding:28px 32px;color:#334155;font-size:14px;line-height:1.7;'>
        {content}
    </div>
    <!-- Footer -->
    <div style='background:#f8fafc;padding:18px 32px;border-top:1px solid #e2e8f0;'>
        <p style='margin:0;color:#94a3b8;font-size:12px;'>
            此邮件由 Lesson Learn System 自动发送，请勿直接回复。
            {(_environment != "Production" ? $"<br/><span style='color:#f59e0b;'>⚠ 当前环境: {_environment}</span>" : "")}
        </p>
    </div>
</div>
</body></html>";
        }
    }
}
