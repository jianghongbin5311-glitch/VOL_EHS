using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
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
    }
}
