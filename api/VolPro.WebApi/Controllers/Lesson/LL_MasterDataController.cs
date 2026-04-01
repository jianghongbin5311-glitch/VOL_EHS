using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VolPro.Core.EFDbContext;
using VolPro.Entity.DomainModels;

namespace VolPro.MES.Controllers
{
    [Route("api/LL_MasterData")]
    public class LL_MasterDataController : ControllerBase
    {
        [HttpPost("Search")]
        public async Task<IActionResult> Search([FromBody] LL_MasterDataSearchRequest request)
        {
            try
            {
                using var ctx = new ServiceDbContext();
                var query = ctx.Set<LL_MasterData>().AsQueryable();
                var dataType = (request?.DataType ?? string.Empty).Trim();
                if (!string.IsNullOrWhiteSpace(dataType))
                {
                    query = query.Where(x => x.DataType == dataType);
                }
                var keyword = (request?.Keyword ?? string.Empty).Trim();
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    query = query.Where(x => x.DataCode.Contains(keyword) || x.DataName.Contains(keyword) || x.ParentName.Contains(keyword) || x.Remark.Contains(keyword));
                }
                if (request?.IsEnabled != null)
                {
                    var isEnabled = request.IsEnabled == true;
                    query = query.Where(x => (x.IsEnabled ?? true) == isEnabled);
                }

                var rows = await query
                    .OrderBy(x => x.Sort ?? 9999)
                    .ThenBy(x => x.DataCode)
                    .ThenBy(x => x.DataName)
                    .Select(x => ToRow(x))
                    .ToListAsync();

                return Ok(new { status = true, data = new { items = rows, total = rows.Count } });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpGet("Bundle")]
        public async Task<IActionResult> Bundle()
        {
            try
            {
                using var ctx = new ServiceDbContext();
                var rows = await ctx.Set<LL_MasterData>()
                    .Where(x => x.IsEnabled != false)
                    .OrderBy(x => x.Sort ?? 9999)
                    .ThenBy(x => x.DataCode)
                    .ThenBy(x => x.DataName)
                    .ToListAsync();

                var bundle = new LL_MasterDataBundle
                {
                    Plants = rows.Where(x => x.DataType == "Plant").Select(ToRow).ToList(),
                    Workshops = rows.Where(x => x.DataType == "Workshop").Select(ToRow).ToList(),
                    Lines = rows.Where(x => x.DataType == "Line").Select(ToRow).ToList(),
                    ProductLines = rows.Where(x => x.DataType == "ProductLine").Select(ToRow).ToList(),
                    TagSuggestions = rows.Where(x => x.DataType == "Tag").Select(ToRow).ToList(),
                    DocumentTypes = rows.Where(x => x.DataType == "DocumentType").Select(ToRow).ToList()
                };

                return Ok(new { status = true, data = bundle });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Save")]
        public async Task<IActionResult> Save([FromBody] LL_MasterDataSaveRequest request)
        {
            try
            {
                if (request == null)
                {
                    return Ok(new { status = false, message = "请求不能为空" });
                }

                var dataType = (request.DataType ?? string.Empty).Trim();
                var dataCode = (request.DataCode ?? string.Empty).Trim();
                var dataName = (request.DataName ?? string.Empty).Trim();

                if (string.IsNullOrWhiteSpace(dataType) || string.IsNullOrWhiteSpace(dataCode) || string.IsNullOrWhiteSpace(dataName))
                {
                    return Ok(new { status = false, message = "类别、编码、名称不能为空" });
                }

                using var ctx = new ServiceDbContext();
                var duplicate = await ctx.Set<LL_MasterData>().AnyAsync(x =>
                    x.DataType == dataType &&
                    x.DataCode == dataCode &&
                    x.MasterData_Id != request.MasterData_Id);
                if (duplicate)
                {
                    return Ok(new { status = false, message = "同类型下编码已存在" });
                }

                var now = DateTime.Now;
                var entity = request.MasterData_Id > 0
                    ? await ctx.Set<LL_MasterData>().FirstOrDefaultAsync(x => x.MasterData_Id == request.MasterData_Id)
                    : null;

                if (entity == null)
                {
                    entity = new LL_MasterData
                    {
                        CreateDate = now,
                        Creator = "codex"
                    };
                    ctx.Set<LL_MasterData>().Add(entity);
                }

                entity.DataType = dataType;
                entity.DataCode = dataCode;
                entity.DataName = dataName;
                entity.ParentCode = (request.ParentCode ?? string.Empty).Trim();
                entity.ParentName = (request.ParentName ?? string.Empty).Trim();
                entity.Sort = request.Sort ?? 0;
                entity.IsEnabled = request.IsEnabled != false;
                entity.IsDefault = request.IsDefault == true;
                entity.Ext1 = (request.Ext1 ?? string.Empty).Trim();
                entity.Ext2 = (request.Ext2 ?? string.Empty).Trim();
                entity.Remark = (request.Remark ?? string.Empty).Trim();
                entity.ModifyDate = now;
                entity.Modifier = "codex";

                await ctx.SaveChangesAsync();
                return Ok(new { status = true, data = ToRow(entity), message = "保存成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        [HttpPost("Delete/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                using var ctx = new ServiceDbContext();
                var entity = await ctx.Set<LL_MasterData>().FirstOrDefaultAsync(x => x.MasterData_Id == id);
                if (entity == null)
                {
                    return Ok(new { status = false, message = "记录不存在" });
                }

                var hasChildren = await ctx.Set<LL_MasterData>().AnyAsync(x => x.ParentCode == entity.DataCode && x.DataType != entity.DataType);
                if (hasChildren)
                {
                    return Ok(new { status = false, message = "请先删除下级主数据再删除当前记录" });
                }

                ctx.Set<LL_MasterData>().Remove(entity);
                await ctx.SaveChangesAsync();
                return Ok(new { status = true, message = "删除成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = ex.Message });
            }
        }

        private static LL_MasterDataRow ToRow(LL_MasterData x)
        {
            return new LL_MasterDataRow
            {
                MasterData_Id = x.MasterData_Id,
                DataType = x.DataType,
                DataCode = x.DataCode,
                DataName = x.DataName,
                ParentCode = x.ParentCode,
                ParentName = x.ParentName,
                Sort = x.Sort ?? 0,
                IsEnabled = x.IsEnabled != false,
                IsDefault = x.IsDefault == true,
                Ext1 = x.Ext1,
                Ext2 = x.Ext2,
                Remark = x.Remark,
                CreateDate = x.CreateDate?.ToString("yyyy-MM-dd HH:mm:ss"),
                ModifyDate = x.ModifyDate?.ToString("yyyy-MM-dd HH:mm:ss")
            };
        }
    }
}
