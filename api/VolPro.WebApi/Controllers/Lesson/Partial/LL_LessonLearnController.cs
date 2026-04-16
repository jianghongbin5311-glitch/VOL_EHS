using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using VolPro.Entity.DomainModels;
using VolPro.MES.Services;

namespace VolPro.MES.Controllers
{
    public partial class LL_LessonLearnController
    {
        [HttpPost("Search")]
        public async Task<IActionResult> Search([FromBody] LL_LessonLearnSearchRequest request)
        {
            var service = Service as LL_LessonLearnService;
            if (service == null)
            {
                return Ok(new { status = false, message = "Lesson Learn 服务初始化失败" });
            }
            var result = await service.SearchAsync(request);
            return Ok(new { status = true, data = result });
        }

        [HttpGet("Detail/{id}")]
        public async Task<IActionResult> Detail(int id, [FromQuery] bool increaseView = true)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                if (service == null)
                {
                    return Ok(new { status = false, message = "Lesson Learn 服务初始化失败" });
                }
                var result = await service.GetDetailAsync(id, increaseView);
                if (result == null)
                {
                    return Ok(new { status = false, message = "未找到指定 Lesson Learn 记录" });
                }
                return Ok(new { status = true, data = result });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("SaveDraft")]
        public async Task<IActionResult> SaveDraft([FromBody] LL_LessonLearnSaveRequest request)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                var result = await service.SaveDraftAsync(request, "保存草稿");
                return Ok(new { status = true, data = result, message = "保存成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("GenerateLessonNo")]
        public async Task<IActionResult> GenerateLessonNo([FromBody] LL_LessonLearnNumberRequest request)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                var result = await service.GenerateLessonNoAsync(request);
                return Ok(new { status = true, data = result, message = "编号已生成" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Submit/{id}")]
        public async Task<IActionResult> Submit(int id, [FromBody] dynamic payload)
        {
            try
            {
                var comment = payload?.comment == null ? string.Empty : (string)payload.comment;
                var service = Service as LL_LessonLearnService;
                var result = await service.ChangeStatusAsync(id, 1, "提交审批", false, comment);
                return Ok(new { status = true, data = result, message = "已提交审批" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Reject/{id}")]
        public async Task<IActionResult> Reject(int id, [FromBody] dynamic payload)
        {
            try
            {
                var comment = payload?.comment == null ? string.Empty : (string)payload.comment;
                var service = Service as LL_LessonLearnService;
                var result = await service.ChangeStatusAsync(id, 2, "审批驳回", false, comment);
                return Ok(new { status = true, data = result, message = "已驳回" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Publish/{id}")]
        public async Task<IActionResult> Publish(int id, [FromBody] dynamic payload)
        {
            try
            {
                var comment = payload?.comment == null ? string.Empty : (string)payload.comment;
                var service = Service as LL_LessonLearnService;
                var result = await service.ChangeStatusAsync(id, 3, "审批发布", true, comment);
                return Ok(new { status = true, data = result, message = "已发布并锁定" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Unlock/{id}")]
        public async Task<IActionResult> Unlock(int id)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                var result = await service.UnlockAsync(id);
                return Ok(new { status = true, data = result, message = "已解锁" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("SetActive/{id}")]
        public async Task<IActionResult> SetActive(int id, [FromBody] dynamic payload)
        {
            try
            {
                var isActive = payload?.isActive != null && (bool)payload.isActive;
                var service = Service as LL_LessonLearnService;
                var result = await service.SetActiveAsync(id, isActive);
                return Ok(new { status = true, data = result, message = isActive ? "已启用" : "已停用" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Metric/{id}/{metric}")]
        public async Task<IActionResult> Metric(int id, string metric)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                var result = await service.ToggleMetricAsync(id, metric);
                return Ok(new { status = true, data = result, message = "统计已更新" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("RecordDownload/{id}")]
        public async Task<IActionResult> RecordDownload(int id, [FromBody] dynamic payload)
        {
            var path = payload?.path == null ? string.Empty : (string)payload.path;
            var service = Service as LL_LessonLearnService;
            var success = await service.RecordAttachmentDownloadAsync(id, path);
            return Ok(new { status = success });
        }

        [HttpPost("ParsePpt")]
        public async Task<IActionResult> ParsePpt(IFormFile file)
        {
            var service = Service as LL_LessonLearnService;
            if (service == null)
            {
                return Ok(new { status = false, message = "Lesson Learn 服务初始化失败" });
            }
            var result = await service.ParsePptAsync(file);
            return Ok(new { status = result.Success, data = result, message = result.Message });
        }

        [HttpGet("ExportExcel")]
        public async Task<IActionResult> ExportExcel(
            [FromQuery] string keyword,
            [FromQuery] string tag,
            [FromQuery] string category,
            [FromQuery] string lessonLevel,
            [FromQuery] int? status,
            [FromQuery] bool? isActive,
            [FromQuery] string productLine)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                if (service == null)
                {
                    return Ok(new { status = false, message = "Lesson Learn 服务初始化失败" });
                }
                var request = new LL_LessonLearnSearchRequest
                {
                    Page = 1,
                    PageSize = 10000,
                    Keyword = keyword,
                    Tag = tag,
                    Category = category,
                    LessonLevel = lessonLevel,
                    Status = status,
                    IsActive = isActive,
                    ProductLine = productLine
                };
                var result = await service.SearchAsync(request);
                var items = result?.Items ?? new System.Collections.Generic.List<LL_LessonLearnListItem>();

                var sb = new System.Text.StringBuilder();
                sb.AppendLine("LL编号,标题,分类,LL属性,产品平台,适用产品线,状态,进度,浏览,收藏,点赞,版本,生效状态,最后修改");
                foreach (var item in items)
                {
                    var statusText = item.Status == 1 ? "待审核" : item.Status == 2 ? "已驳回" : item.Status == 3 ? "已发布" : "编辑中";
                    var activeText = (item.IsActive ?? true) ? "Active" : "Inactive";
                    sb.AppendLine($"\"{Csv(item.LessonNo)}\",\"{Csv(item.TitleEn)}\",\"{Csv(item.Category)}\",\"{Csv(item.LessonLevel)}\",\"{Csv(item.ProductPlatformsText)}\",\"{Csv(item.ApplicableProductLinesText)}\",\"{statusText}\",{item.Progress ?? 0},{item.ViewCount ?? 0},{item.FavoriteCount ?? 0},{item.LikeCount ?? 0},{item.VersionNo ?? 0},\"{activeText}\",\"{item.ModifyDate?.ToString("yyyy-MM-dd HH:mm") ?? ""}\"");
                }

                var bytes = System.Text.Encoding.UTF8.GetPreamble().Concat(System.Text.Encoding.UTF8.GetBytes(sb.ToString())).ToArray();
                return File(bytes, "text/csv; charset=utf-8", $"LessonLearn_Export_{DateTime.Now:yyyyMMdd_HHmmss}.csv");
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Upload")]
        public async Task<IActionResult> Upload(IFormFile fileInput)
        {
            try
            {
                if (fileInput == null || fileInput.Length == 0)
                {
                    return Ok(new { status = false, message = "请选择文件" });
                }
                var uploadDir = Path.Combine(AppContext.BaseDirectory, "Upload", "LessonLearn");
                if (!Directory.Exists(uploadDir))
                {
                    Directory.CreateDirectory(uploadDir);
                }
                var fileName = $"{Guid.NewGuid():N}_{fileInput.FileName}";
                var savePath = Path.Combine(uploadDir, fileName);
                using (var stream = new System.IO.FileStream(savePath, System.IO.FileMode.Create))
                {
                    await fileInput.CopyToAsync(stream);
                }
                return Ok(new { status = true, data = $"Upload/LessonLearn/{fileName}" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpGet("ExportOnePage")]
        public async Task<IActionResult> ExportOnePage([FromQuery] int id)
        {
            try
            {
                var service = Service as LL_LessonLearnService;
                if (service == null)
                {
                    return Ok(new { status = false, message = "Lesson Learn 服务初始化失败" });
                }
                var detail = await service.GetDetailAsync(id, false);
                if (detail == null)
                {
                    return Ok(new { status = false, message = "未找到指定 Lesson Learn 记录" });
                }

                var html = $@"<!DOCTYPE html><html><head><meta charset='utf-8'><title>LL One Page - {detail.LessonNo}</title>
<style>body{{font-family:Arial,sans-serif;max-width:900px;margin:0 auto;padding:24px;font-size:13px}}
h1{{color:#1e1b4b;font-size:22px;border-bottom:3px solid #4f46e5;padding-bottom:8px}}
h2{{color:#312e81;font-size:16px;margin-top:20px;border-left:4px solid #4f46e5;padding-left:8px}}
table{{width:100%;border-collapse:collapse;margin:10px 0}}th,td{{border:1px solid #e2e8f0;padding:6px 10px;text-align:left}}
th{{background:#f1f5f9;color:#334155;font-size:12px}}.meta{{color:#64748b;margin:4px 0}}</style></head>
<body><h1>{detail.LessonNo ?? "Lesson Learn"} - {detail.TitleEn ?? ""}</h1>
<div class='meta'>分类: {detail.Category ?? "-"} | LL属性: {detail.LessonLevel ?? "-"} | 版本: V{detail.VersionNo ?? 0} | 状态: {(detail.Status == 3 ? "已发布" : "编辑中")}</div>
<h2>基础信息</h2><table><tr><th>Issue System</th><td>{detail.IssueSource ?? "-"}</td><th>Issue No.</th><td>{detail.IssueNo ?? "-"}</td></tr>
<tr><th>CPI + Program</th><td>{detail.CpiProgram ?? "-"}</td><th>Customer</th><td>{detail.Customer ?? "-"}</td></tr>
<tr><th>Part No.</th><td>{detail.PartNo ?? "-"}</td><th>Plant</th><td>{detail.Plant ?? "-"}</td></tr></table>
<h2>问题描述</h2>";
                foreach (var block in detail.IssueDescription ?? new System.Collections.Generic.List<LL_LessonLearnTextBlock>())
                {
                    html += $"<p>{System.Net.WebUtility.HtmlEncode(block.En ?? "")}</p><p style='color:#64748b'>{System.Net.WebUtility.HtmlEncode(block.Zh ?? "")}</p>";
                }
                html += "<h2>根本原因</h2>";
                foreach (var block in detail.RootCause ?? new System.Collections.Generic.List<LL_LessonLearnTextBlock>())
                {
                    html += $"<p>{System.Net.WebUtility.HtmlEncode(block.En ?? "")}</p><p style='color:#64748b'>{System.Net.WebUtility.HtmlEncode(block.Zh ?? "")}</p>";
                }
                html += "<h2>纠正措施</h2>";
                foreach (var block in detail.CorrectiveActions ?? new System.Collections.Generic.List<LL_LessonLearnTextBlock>())
                {
                    html += $"<p>{System.Net.WebUtility.HtmlEncode(block.En ?? "")}</p><p style='color:#64748b'>{System.Net.WebUtility.HtmlEncode(block.Zh ?? "")}</p>";
                }
                html += "<h2>全球经验教训</h2>";
                foreach (var block in detail.GlobalLessons ?? new System.Collections.Generic.List<LL_LessonLearnTextBlock>())
                {
                    html += $"<p>{System.Net.WebUtility.HtmlEncode(block.En ?? "")}</p><p style='color:#64748b'>{System.Net.WebUtility.HtmlEncode(block.Zh ?? "")}</p>";
                }
                html += "</body></html>";

                var htmlBytes = System.Text.Encoding.UTF8.GetBytes(html);
                return File(htmlBytes, "text/html; charset=utf-8", $"LL_OnePage_{detail.LessonNo ?? id.ToString()}_{DateTime.Now:yyyyMMdd}.html");
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        private static string Csv(string value) => (value ?? "").Replace("\"", "\"\"");
    }
}
