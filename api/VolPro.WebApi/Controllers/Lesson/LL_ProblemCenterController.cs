using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VolPro.Entity.DomainModels;
using VolPro.MES.Services;

namespace VolPro.MES.Controllers
{
    /// <summary>
    /// 问题中心 Controller - 管理产品线问题的录入、追踪、闭环与转化为 LL。
    /// 依赖独立数据表 LL_ProblemCenter（待后续 Migration 创建）。
    /// 当前版本提供编译正确的 API 骨架，在数据表未创建前返回 demo 数据。
    /// </summary>
    [Route("api/LL_ProblemCenter")]
    [ApiController]
    public class LL_ProblemCenterController : ControllerBase
    {
        [HttpPost("Search")]
        public IActionResult Search([FromBody] dynamic request)
        {
            try
            {
                // TODO: 替换为 EF Core 查询 LL_ProblemCenter 表
                var demo = GetDemoItems();
                return Ok(new { status = true, data = new { total = demo.Count, items = demo } });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Save")]
        public IActionResult Save([FromBody] dynamic form)
        {
            try
            {
                // TODO: 插入/更新到 LL_ProblemCenter 表
                return Ok(new { status = true, message = "保存成功（Demo 模式）" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("ConvertToLL")]
        public IActionResult ConvertToLL([FromBody] dynamic payload)
        {
            try
            {
                // TODO: 读取 ProblemCenter 记录 → 自动创建 LL_LessonLearn → 返回新 ID
                return Ok(new { status = false, message = "ConvertToLL 功能正在开发中，请稍后启用。" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpGet("ExportExcel")]
        public IActionResult ExportExcel([FromQuery] string keyword, [FromQuery] string type, [FromQuery] string status)
        {
            try
            {
                var items = GetDemoItems();
                var sb = new System.Text.StringBuilder();
                sb.AppendLine("Issue No,录入时间,闭环时间,Issue Description,Component,Type,Priority,Affect Plant,Action Plan,Action Owner,Issue Owner,目标关闭日,实际关闭日,Status,Comments");
                foreach (var item in items)
                {
                    sb.AppendLine($"\"{item["IssueNo"]}\",\"{item["RecordDate"]}\",\"{item["CloseDate"]}\",\"{item["IssueDescription"]}\",\"{item["Component"]}\",\"{item["Type"]}\",\"{item["Priority"]}\",\"{item["AffectPlant"]}\",\"{item["ActionPlan"]}\",\"{item["ActionOwner"]}\",\"{item["IssueOwner"]}\",\"{item["TargetCloseDate"]}\",\"{item["ActualCloseDate"]}\",\"{item["Status"]}\",\"{item["Comments"]}\"");
                }
                var bytes = System.Text.Encoding.UTF8.GetPreamble().Concat(System.Text.Encoding.UTF8.GetBytes(sb.ToString())).ToArray();
                return File(bytes, "text/csv; charset=utf-8", $"ProblemCenter_Export_{DateTime.Now:yyyyMMdd_HHmmss}.csv");
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        private static List<Dictionary<string, object>> GetDemoItems()
        {
            return new List<Dictionary<string, object>>
            {
                new Dictionary<string, object>
                {
                    { "Problem_Id", 1 }, { "IssueNo", "CEPS-D-0001" }, { "RecordDate", "2026-04-01" },
                    { "CloseDate", "" }, { "IssueDescription", "Noise-32mm worm bearing-Insufficient axial load capacity" },
                    { "Component", "Worm Gear" }, { "Type", "D" }, { "Priority", "H" },
                    { "AffectPlant", "S3,S7,S8" }, { "ActionPlan", "Define design improvement plan" },
                    { "ActionOwner", "Meicheng Fu" }, { "IssueOwner", "Dillon Li" },
                    { "TargetCloseDate", "2026-04-08" }, { "ActualCloseDate", "" },
                    { "Status", "Open" }, { "Comments", "" }
                },
                new Dictionary<string, object>
                {
                    { "Problem_Id", 2 }, { "IssueNo", "REPS-P-002" }, { "RecordDate", "2026-03-15" },
                    { "CloseDate", "" }, { "IssueDescription", "Revalidate torque sequence after fixture maintenance" },
                    { "Component", "Rack" }, { "Type", "P" }, { "Priority", "M" },
                    { "AffectPlant", "S3" }, { "ActionPlan", "Define test plan" },
                    { "ActionOwner", "David Xu" }, { "IssueOwner", "Jun Xu" },
                    { "TargetCloseDate", "2026-04-04" }, { "ActualCloseDate", "2026-04-03" },
                    { "Status", "Closed" }, { "Comments", "推荐 APQP 作 Follow up" }
                }
            };
        }
    }
}
