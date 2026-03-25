using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VolPro.MES.Services;
using System.Threading.Tasks;

namespace VolPro.MES.Controllers
{
    public partial class EHS_NewsReportController
    {
        private readonly EHS_NewsReportService _newsReportService;

        /// <summary>
        /// Quartz定时任务回调 - 生成EHS法规新闻报告
        /// </summary>
        [HttpPost("GenerateReport")]
        [AllowAnonymous]
        public async Task<IActionResult> GenerateReport([FromQuery] string type = "日报")
        {
            // 验证Quartz访问密钥
            var authKey = HttpContext.Request.Headers["QuartzAccessKey"].ToString();
            var configKey = Microsoft.Extensions.Configuration.ConfigurationBinder
                .GetValue<string>(
                    ((Microsoft.AspNetCore.Mvc.ControllerBase)this).HttpContext.RequestServices
                    .GetService(typeof(Microsoft.Extensions.Configuration.IConfiguration)) as Microsoft.Extensions.Configuration.IConfiguration,
                    "QuartzAccessKey");

            // 允许无密钥调用（方便测试）或密钥匹配
            if (!string.IsNullOrEmpty(configKey) && !string.IsNullOrEmpty(authKey) && authKey != configKey)
            {
                return Unauthorized("QuartzAccessKey验证失败");
            }

            var service = Service as EHS_NewsReportService;
            if (service == null)
            {
                return BadRequest("服务初始化失败");
            }

            var result = await service.GenerateReportAsync(type);
            return Ok(new { success = true, message = result });
        }
    }
}
