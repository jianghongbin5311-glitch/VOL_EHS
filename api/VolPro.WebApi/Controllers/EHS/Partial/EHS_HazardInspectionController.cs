using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VolPro.Core.Controllers.Basic;
using VolPro.Core.EFDbContext;
using VolPro.Entity.DomainModels;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace VolPro.MES.Controllers
{
    public partial class EHS_HazardInspectionController
    {
        [HttpGet, Route("Dashboard")]
        public async Task<IActionResult> GetDashboard()
        {
            try
            {
                using var ctx = new ServiceDbContext();
                var now = DateTime.Now;
                var startOfMonth = new DateTime(now.Year, now.Month, 1);
                var startOfDay = now.Date;

                // === 排查计划 ===
                var inspections = await ctx.Set<EHS_HazardInspection>().ToListAsync();
                var totalPlans = inspections.Count;
                var completedPlans = inspections.Count(x => x.Status == 2 || x.Status == 3);
                var pendingPlans = inspections.Count(x => x.Status == 0);
                var inProgressPlans = inspections.Count(x => x.Status == 1);
                var overduePlans = inspections.Count(x => x.Status != 2 && x.Status != 3
                    && x.PlanDate.HasValue && x.PlanDate.Value < now);
                var completionRate = totalPlans > 0 ? Math.Round((double)completedPlans / totalPlans * 100, 0) : 0;

                var recentPlans = inspections
                    .OrderByDescending(x => x.CreateDate)
                    .Take(10)
                    .Select(x => new
                    {
                        id = x.Inspection_Id,
                        title = x.Title,
                        type = x.InspectionType,
                        inspector = x.InspectorName,
                        planDate = x.PlanDate?.ToString("yyyy-MM-dd"),
                        actualDate = x.ActualDate?.ToString("yyyy-MM-dd"),
                        status = x.Status ?? 0,
                        statusText = x.Status == 0 ? "计划中" : x.Status == 1 ? "进行中" : x.Status == 2 ? "已完成" : "已关闭",
                        area = x.Area,
                        hazardCount = x.HazardCount ?? 0
                    })
                    .ToList();

                // === 隐患数据 ===
                var hazards = await ctx.Set<EHS_HazardReport>().ToListAsync();
                var todayHazards = hazards.Count(x => x.DiscoveryDate.HasValue && x.DiscoveryDate.Value.Date == startOfDay);
                var pendingHazards = hazards.Count(x => x.Status == 0 || x.Status == 1);
                var monthNewHazards = hazards.Count(x => x.CreateDate.HasValue && x.CreateDate.Value >= startOfMonth);
                var totalHazards = hazards.Count;
                var closedHazards = hazards.Count(x => x.Status == 3);
                var rectifyRate = totalHazards > 0 ? Math.Round((double)closedHazards / totalHazards * 100, 0) : 0;

                // === 月度趋势(6个月) ===
                var monthlyTrend = Enumerable.Range(0, 6)
                    .Select(i =>
                    {
                        var month = now.AddMonths(-5 + i);
                        var mStart = new DateTime(month.Year, month.Month, 1);
                        var mEnd = mStart.AddMonths(1);
                        return new
                        {
                            month = mStart.ToString("yyyy-MM"),
                            label = mStart.ToString("M月"),
                            count = hazards.Count(x => x.CreateDate.HasValue && x.CreateDate.Value >= mStart && x.CreateDate.Value < mEnd)
                        };
                    })
                    .ToList();

                // === 类型分布 ===
                var typeDistribution = hazards
                    .Where(x => !string.IsNullOrEmpty(x.HazardType))
                    .GroupBy(x => x.HazardType)
                    .Select(g => new { name = g.Key, count = g.Count() })
                    .OrderByDescending(x => x.count)
                    .Take(8)
                    .ToList();

                // === 等级分布 ===
                var levelDistribution = hazards
                    .Where(x => !string.IsNullOrEmpty(x.HazardLevel))
                    .GroupBy(x => x.HazardLevel)
                    .Select(g => new { name = g.Key, count = g.Count() })
                    .OrderByDescending(x => x.count)
                    .ToList();

                // === 隐患台账(最近20条) ===
                var recentHazards = hazards
                    .OrderByDescending(x => x.CreateDate)
                    .Take(20)
                    .Select(x => new
                    {
                        id = x.Hazard_Id,
                        hazardNo = x.HazardNo,
                        title = x.Title,
                        level = x.HazardLevel,
                        type = x.HazardType,
                        location = x.Location,
                        dept = x.DeptName,
                        date = x.DiscoveryDate?.ToString("yyyy-MM-dd"),
                        reporter = x.ReporterName,
                        rectifier = x.RectifyPersonName,
                        deadline = x.RectifyDeadline?.ToString("yyyy-MM-dd"),
                        status = x.Status ?? 0,
                        statusText = x.Status == 0 ? "待整改" : x.Status == 1 ? "整改中" : x.Status == 2 ? "待验收" : "已关闭"
                    })
                    .ToList();

                return Ok(new
                {
                    status = true,
                    data = new
                    {
                        planStats = new { total = totalPlans, completed = completedPlans, pending = pendingPlans, inProgress = inProgressPlans, overdue = overduePlans, completionRate },
                        recentPlans,
                        hazardStats = new { today = todayHazards, pendingCount = pendingHazards, rectifyRate, monthNew = monthNewHazards, total = totalHazards },
                        monthlyTrend,
                        typeDistribution,
                        levelDistribution,
                        recentHazards
                    }
                });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }
    }
}
