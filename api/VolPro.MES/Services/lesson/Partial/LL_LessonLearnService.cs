using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;
using VolPro.Core.EFDbContext;
using VolPro.Core.ManageUser;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;

namespace VolPro.MES.Services
{
    public partial class LL_LessonLearnService
    {
        private const string ModuleIssueDescription = "IssueDescription";
        private const string ModuleRootCause = "RootCause";
        private const string ModuleCorrectiveActions = "CorrectiveActions";
        private const string ModuleGlobalLessons = "GlobalLessons";
        private const string ModuleSupplementalNotes = "SupplementalNotes";

        private const string FileTypeGeneral = "General";
        private const string FileTypeContentImage = "ContentImage";
        private const string FileTypeDocumentBefore = "DocumentBefore";
        private const string FileTypeDocumentAfter = "DocumentAfter";

        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly ILL_LessonLearnRepository _repository;

        [ActivatorUtilitiesConstructor]
        public LL_LessonLearnService(
            ILL_LessonLearnRepository repository,
            IHttpContextAccessor httpContextAccessor
        ) : base(repository)
        {
            _repository = repository;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<LL_LessonLearnPageResult> SearchAsync(LL_LessonLearnSearchRequest request)
        {
            request ??= new LL_LessonLearnSearchRequest();
            var page = request.Page <= 0 ? 1 : request.Page;
            var pageSize = request.PageSize <= 0 ? 10 : request.PageSize;
            using var ctx = new ServiceDbContext();
            var query = ctx.Set<LL_LessonLearn>().AsQueryable();

            if (!string.IsNullOrWhiteSpace(request.Keyword))
            {
                var keyword = request.Keyword.Trim();
                query = query.Where(x =>
                    (x.LessonNo ?? "").Contains(keyword) ||
                    (x.TitleEn ?? "").Contains(keyword) ||
                    (x.TitleCn ?? "").Contains(keyword) ||
                    (x.TagsText ?? "").Contains(keyword) ||
                    (x.ApplicableProductLinesText ?? "").Contains(keyword));
            }
            if (!string.IsNullOrWhiteSpace(request.Category))
            {
                query = query.Where(x => x.Category == request.Category);
            }
            if (!string.IsNullOrWhiteSpace(request.LessonLevel))
            {
                query = query.Where(x => x.LessonLevel == request.LessonLevel);
            }
            if (request.Status.HasValue)
            {
                query = query.Where(x => x.Status == request.Status.Value);
            }
            if (!string.IsNullOrWhiteSpace(request.ProductLine))
            {
                query = query.Where(x => (x.ApplicableProductLinesText ?? "").Contains(request.ProductLine));
            }
            if (!string.IsNullOrWhiteSpace(request.Tag))
            {
                query = query.Where(x => (x.TagsText ?? "").Contains(request.Tag));
            }
            if (!string.IsNullOrWhiteSpace(request.Plant))
            {
                query = query.Where(x => (x.Plant ?? "").Contains(request.Plant));
            }
            if (request.IsActive.HasValue)
            {
                query = query.Where(x => (x.IsActive ?? true) == request.IsActive.Value);
            }

            var total = await query.CountAsync();
            var rows = await query
                .OrderByDescending(x => x.ModifyDate ?? x.CreateDate)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(x => new LL_LessonLearnListItem
                {
                    LessonLearn_Id = x.LessonLearn_Id,
                    LessonNo = x.LessonNo,
                    TitleEn = x.TitleEn,
                    TitleCn = x.TitleCn,
                    Category = x.Category,
                    LessonLevel = x.LessonLevel,
                    Status = x.Status,
                    Progress = x.Progress,
                    ProductPlatform = x.ProductPlatform,
                    ProductPlatformsText = x.ProductPlatformsText,
                    LlGroup = x.LlGroup,
                    Plant = x.Plant,
                    Workshop = x.Workshop,
                    PartVersion = x.PartVersion,
                    ApplicableProductLinesText = x.ApplicableProductLinesText,
                    TagsText = x.TagsText,
                    ViewCount = x.ViewCount,
                    FavoriteCount = x.FavoriteCount,
                    LikeCount = x.LikeCount,
                    VersionNo = x.VersionNo,
                    IsLocked = x.IsLocked,
                    IsActive = x.IsActive,
                    DocumentTypesText = x.DocumentTypesText,
                    CreateDate = x.CreateDate,
                    ModifyDate = x.ModifyDate,
                    Creator = x.Creator,
                    Modifier = x.Modifier
                })
                .ToListAsync();

            return new LL_LessonLearnPageResult
            {
                Total = total,
                Items = rows
            };
        }

        public async Task<LL_LessonLearnDetailDto> GetDetailAsync(int id, bool increaseView)
        {
            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == id);
            if (entity == null)
            {
                return null;
            }
            if (increaseView)
            {
                entity.ViewCount = (entity.ViewCount ?? 0) + 1;
                await ctx.SaveChangesAsync();
            }
            return await BuildDetailAsync(ctx, entity);
        }

        public async Task<LL_LessonLearnDetailDto> SaveDraftAsync(LL_LessonLearnSaveRequest request, string action = "保存草稿")
        {
            if (request == null)
            {
                throw new Exception("提交数据不能为空");
            }

            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var now = DateTime.Now;
            var userName = GetCurrentUserName();
            var userId = GetCurrentUserId();

            LL_LessonLearn entity;
            if (request.LessonLearn_Id > 0)
            {
                entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == request.LessonLearn_Id);
                if (entity == null)
                {
                    throw new Exception("未找到要保存的 Lesson Learn 记录");
                }
                if (entity.IsLocked == true)
                {
                    throw new Exception("当前页面已锁定，请先解锁后再编辑");
                }
            }
            else
            {
                entity = new LL_LessonLearn
                {
                    CreateDate = now,
                    Creator = userName,
                    CreateID = userId,
                    Status = 0,
                    ViewCount = 0,
                    FavoriteCount = 0,
                    LikeCount = 0,
                    VersionNo = 0,
                    IsLocked = false,
                    IsActive = true
                };
                ctx.Set<LL_LessonLearn>().Add(entity);
            }

            ApplyRequest(entity, request);
            await EnsureLessonNoUniqueAsync(ctx, entity.LessonNo, entity.LessonLearn_Id);
            entity.Progress = CalculateProgress(request);
            entity.AnalysisCycleDays = entity.CreateDate.HasValue ? (int)Math.Max(0, (now - entity.CreateDate.Value).TotalDays) : 0;
            entity.ModifyDate = now;
            entity.Modifier = userName;
            entity.ModifyID = userId;
            entity.ApprovalOwner = string.IsNullOrWhiteSpace(entity.ApprovalOwner) ? "Nexteer Issue Owner" : entity.ApprovalOwner;

            await ctx.SaveChangesAsync();
            await ReplaceChildrenAsync(ctx, entity.LessonLearn_Id, request);

            var detail = await BuildDetailAsync(ctx, entity);
            ctx.Set<LL_LessonLearnVersionEntity>().Add(new LL_LessonLearnVersionEntity
            {
                LessonLearn_Id = entity.LessonLearn_Id,
                VersionNo = entity.VersionNo,
                Action = action,
                Operator = userName,
                StatusText = GetStatusText(entity.Status),
                Comment = string.Empty,
                SnapshotJson = Serialize(detail),
                ActionTime = now
            });
            await ctx.SaveChangesAsync();
            detail.HistoryRecords = await LoadHistoryAsync(ctx, entity.LessonLearn_Id);
            return detail;
        }

        public async Task<LL_LessonLearnDetailDto> ChangeStatusAsync(int id, int status, string action, bool lockAfterChange, string comment = "")
        {
            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == id);
            if (entity == null)
            {
                throw new Exception("未找到指定 Lesson Learn 记录");
            }
            if (entity.IsLocked == true && status != 0)
            {
                throw new Exception("当前页面已锁定，请先解锁后再操作");
            }
            if (status == 1)
            {
                await ValidateBeforeSubmitAsync(ctx, entity);
            }

            var userName = GetCurrentUserName();
            var userId = GetCurrentUserId();
            var now = DateTime.Now;
            entity.Status = status;
            entity.ModifyDate = now;
            entity.Modifier = userName;
            entity.ModifyID = userId;
            if (status == 3)
            {
                entity.VersionNo = (entity.VersionNo ?? 0) + 1;
            }
            entity.ApprovalOwner = string.IsNullOrWhiteSpace(entity.ApprovalOwner) ? "Nexteer Issue Owner" : entity.ApprovalOwner;
            if (status == 1)
            {
                entity.SubmittedDate = now;
            }
            if (status == 3)
            {
                entity.PublishedDate = now;
            }
            if (lockAfterChange)
            {
                entity.IsLocked = true;
            }

            await ctx.SaveChangesAsync();
            var detail = await BuildDetailAsync(ctx, entity);
            ctx.Set<LL_LessonLearnVersionEntity>().Add(new LL_LessonLearnVersionEntity
            {
                LessonLearn_Id = entity.LessonLearn_Id,
                VersionNo = entity.VersionNo,
                Action = action,
                Operator = userName,
                StatusText = GetStatusText(entity.Status),
                Comment = comment,
                SnapshotJson = Serialize(detail),
                ActionTime = now
            });
            await ctx.SaveChangesAsync();
            detail.HistoryRecords = await LoadHistoryAsync(ctx, entity.LessonLearn_Id);
            return detail;
        }

        public async Task<LL_LessonLearnDetailDto> UnlockAsync(int id)
        {
            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == id);
            if (entity == null)
            {
                throw new Exception("未找到指定 Lesson Learn 记录");
            }
            var now = DateTime.Now;
            var userName = GetCurrentUserName();
            entity.IsLocked = false;
            entity.Status = 0;
            entity.ModifyDate = now;
            entity.Modifier = userName;
            await ctx.SaveChangesAsync();

            var detail = await BuildDetailAsync(ctx, entity);
            ctx.Set<LL_LessonLearnVersionEntity>().Add(new LL_LessonLearnVersionEntity
            {
                LessonLearn_Id = entity.LessonLearn_Id,
                VersionNo = entity.VersionNo,
                Action = "解锁",
                Operator = userName,
                StatusText = GetStatusText(entity.Status),
                Comment = "页面重新进入编辑中",
                SnapshotJson = Serialize(detail),
                ActionTime = now
            });
            await ctx.SaveChangesAsync();
            detail.HistoryRecords = await LoadHistoryAsync(ctx, entity.LessonLearn_Id);
            return detail;
        }

        public async Task<LL_LessonLearnDetailDto> SetActiveAsync(int id, bool isActive)
        {
            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == id);
            if (entity == null)
            {
                throw new Exception("未找到指定 Lesson Learn 记录");
            }

            var userName = GetCurrentUserName();
            var now = DateTime.Now;
            entity.IsActive = isActive;
            entity.ModifyDate = now;
            entity.Modifier = userName;
            await ctx.SaveChangesAsync();

            var detail = await BuildDetailAsync(ctx, entity);
            ctx.Set<LL_LessonLearnVersionEntity>().Add(new LL_LessonLearnVersionEntity
            {
                LessonLearn_Id = entity.LessonLearn_Id,
                VersionNo = entity.VersionNo,
                Action = isActive ? "启用" : "停用",
                Operator = userName,
                StatusText = GetStatusText(entity.Status),
                Comment = isActive ? "记录重新启用" : "记录设置为停用",
                SnapshotJson = Serialize(detail),
                ActionTime = now
            });
            await ctx.SaveChangesAsync();
            detail.HistoryRecords = await LoadHistoryAsync(ctx, entity.LessonLearn_Id);
            return detail;
        }

        public async Task<LL_LessonLearnDetailDto> ToggleMetricAsync(int id, string metric)
        {
            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var entity = await ctx.Set<LL_LessonLearn>().FirstOrDefaultAsync(x => x.LessonLearn_Id == id);
            if (entity == null)
            {
                throw new Exception("未找到指定 Lesson Learn 记录");
            }
            var metricType = (metric ?? string.Empty).Trim().ToLowerInvariant();
            if (metricType != "favorite" && metricType != "like")
            {
                throw new Exception("不支持的统计类型");
            }

            var userId = GetCurrentUserId();
            var userName = GetCurrentUserName();
            var existed = await ctx.Set<LL_LessonLearnUserMetricEntity>()
                .FirstOrDefaultAsync(x =>
                    x.LessonLearn_Id == id &&
                    x.MetricType == metricType &&
                    (
                        (userId > 0 && x.UserId == userId) ||
                        (!string.IsNullOrWhiteSpace(userName) && x.UserName == userName)
                    ));

            if (existed == null)
            {
                ctx.Set<LL_LessonLearnUserMetricEntity>().Add(new LL_LessonLearnUserMetricEntity
                {
                    LessonLearn_Id = id,
                    MetricType = metricType,
                    UserId = userId > 0 ? (int?)userId : null,
                    UserName = userName,
                    CreateDate = DateTime.Now
                });
            }
            else
            {
                ctx.Set<LL_LessonLearnUserMetricEntity>().Remove(existed);
            }

            await ctx.SaveChangesAsync();
            entity.FavoriteCount = await ctx.Set<LL_LessonLearnUserMetricEntity>().CountAsync(x => x.LessonLearn_Id == id && x.MetricType == "favorite");
            entity.LikeCount = await ctx.Set<LL_LessonLearnUserMetricEntity>().CountAsync(x => x.LessonLearn_Id == id && x.MetricType == "like");
            await ctx.SaveChangesAsync();
            return await BuildDetailAsync(ctx, entity);
        }

        public async Task<bool> RecordAttachmentDownloadAsync(int id, string path)
        {
            if (string.IsNullOrWhiteSpace(path))
            {
                return false;
            }

            using var ctx = new ServiceDbContext();
            ctx.QueryTracking = true;
            var files = await ctx.Set<LL_LessonLearnFile>()
                .Where(x => x.LessonLearn_Id == id && x.Path == path)
                .ToListAsync();
            if (!files.Any())
            {
                return false;
            }

            foreach (var item in files)
            {
                item.DownloadCount = (item.DownloadCount ?? 0) + 1;
            }
            await ctx.SaveChangesAsync();
            return true;
        }

        public async Task<LL_LessonLearnImportResult> ParsePptAsync(IFormFile file)
        {
            if (file == null || file.Length == 0)
            {
                return new LL_LessonLearnImportResult { Success = false, Message = "请选择有效的 PPTX 文件" };
            }
            if (!string.Equals(Path.GetExtension(file.FileName), ".pptx", StringComparison.OrdinalIgnoreCase))
            {
                return new LL_LessonLearnImportResult { Success = false, Message = "当前只支持解析 .pptx 文件" };
            }

            using var stream = new MemoryStream();
            await file.CopyToAsync(stream);
            stream.Position = 0;
            using var archive = new ZipArchive(stream, ZipArchiveMode.Read, true);
            var slideEntry = archive.GetEntry("ppt/slides/slide1.xml");
            if (slideEntry == null)
            {
                return new LL_LessonLearnImportResult { Success = false, Message = "未找到首张幻灯片内容" };
            }

            var textList = ReadSlideTexts(slideEntry);
            var rawText = string.Join("\n", textList);
            var result = new LL_LessonLearnImportResult
            {
                Success = true,
                Message = "解析成功",
                RawText = rawText,
                TitleEn = textList.FirstOrDefault(x => !IsSectionHeader(x)) ?? string.Empty,
                LessonNo = TryReadValue(textList, new[] { "LL #", "LL#", "LL No", "LL NO" }),
                Category = TryReadValue(textList, new[] { "Cat", "Category" }),
                ProductLine = TryReadValue(textList, new[] { "PL", "Product Line" }),
                IssueSource = TryReadValue(textList, new[] { "Issue", "Issue System" }),
                IssueNo = TryReadValue(textList, new[] { "Issue No", "Issue No." }),
                IssueType = TryReadValue(textList, new[] { "Type" }),
                CPI = TryReadValue(textList, new[] { "CPI" }),
                Customer = TryReadValue(textList, new[] { "Customer" }),
                Program = TryReadValue(textList, new[] { "Program" }),
                PartNo = TryReadValue(textList, new[] { "PN", "Part No", "Part No." }),
                Plant = TryReadValue(textList, new[] { "Plant" })
            };

            result.IssueDescription = BuildSectionBlocks(rawText, new[] { "Issue Description", "问题描述" });
            result.RootCause = BuildSectionBlocks(rawText, new[] { "Root Cause", "根本原因" });
            result.CorrectiveActions = BuildSectionBlocks(rawText, new[] { "Corrective Actions", "纠正措施" });
            result.GlobalLessons = BuildSectionBlocks(rawText, new[] { "Global Lessons Learned", "Global Lessons", "全球经验教训" });
            result.SupplementalNotes = BuildSectionBlocks(rawText, new[] { "Supplemental Information", "补充信息" });
            if (!result.IssueDescription.Any() && !string.IsNullOrWhiteSpace(rawText))
            {
                result.IssueDescription.Add(new LL_LessonLearnTextBlock
                {
                    Sort = 1,
                    En = rawText,
                    Zh = string.Empty
                });
            }
            return result;
        }

        public async Task<LL_LessonLearnNumberResult> GenerateLessonNoAsync(LL_LessonLearnNumberRequest request)
        {
            request ??= new LL_LessonLearnNumberRequest();
            var productLine = NormalizeLessonSegment(string.IsNullOrWhiteSpace(request.ProductPlatform) ? request.ProductLine : request.ProductPlatform);
            var categoryCode = GetCategoryCode(request.Category);
            if (string.IsNullOrWhiteSpace(productLine))
            {
                throw new Exception("生成 LL 编号前，请先选择产品所属平台");
            }
            if (string.IsNullOrWhiteSpace(categoryCode))
            {
                throw new Exception("生成 LL 编号前，请先选择有效的 LL 分类");
            }

            var prefix = $"LL-{productLine}-{categoryCode}-";
            using var ctx = new ServiceDbContext();
            var numbers = await ctx.Set<LL_LessonLearn>()
                .Where(x => x.LessonNo.StartsWith(prefix) && (request.LessonLearn_Id <= 0 || x.LessonLearn_Id != request.LessonLearn_Id))
                .Select(x => x.LessonNo)
                .ToListAsync();

            var maxNo = 0;
            foreach (var lessonNo in numbers)
            {
                var suffix = lessonNo?.Replace(prefix, string.Empty) ?? string.Empty;
                if (int.TryParse(suffix, out var current) && current > maxNo)
                {
                    maxNo = current;
                }
            }

            return new LL_LessonLearnNumberResult
            {
                ProductLine = productLine,
                Category = request.Category,
                Prefix = prefix,
                LessonNo = $"{prefix}{(maxNo + 1):0000}"
            };
        }

        private async Task ReplaceChildrenAsync(ServiceDbContext ctx, int lessonLearnId, LL_LessonLearnSaveRequest request)
        {
            await DeleteChildrenAsync(ctx, lessonLearnId);

            var productLines = (request.ApplicableProductLines ?? new List<string>())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .Select((x, index) => new LL_LessonLearnProductLine
                {
                    LessonLearn_Id = lessonLearnId,
                    ProductLine = x.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (productLines.Any())
            {
                ctx.Set<LL_LessonLearnProductLine>().AddRange(productLines);
            }

            var tags = (request.Tags ?? new List<string>())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .Select((x, index) => new LL_LessonLearnTag
                {
                    LessonLearn_Id = lessonLearnId,
                    TagName = x.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (tags.Any())
            {
                ctx.Set<LL_LessonLearnTag>().AddRange(tags);
            }

            var documentTypes = (request.DocumentTypes ?? new List<string>())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .Select((x, index) => new LL_LessonLearnDocumentType
                {
                    LessonLearn_Id = lessonLearnId,
                    DocumentType = x.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (documentTypes.Any())
            {
                ctx.Set<LL_LessonLearnDocumentType>().AddRange(documentTypes);
            }

            var reviews = (request.ReviewRecords ?? new List<LL_LessonLearnReview>())
                .Where(x => HasReviewContent(x))
                .Select((x, index) => new LL_LessonLearnReviewEntity
                {
                    LessonLearn_Id = lessonLearnId,
                    Round = x.Round?.Trim(),
                    ReviewDate = x.ReviewDate?.Trim(),
                    Reviewer = x.Reviewer?.Trim(),
                    ReviewerTitle = x.ReviewerTitle?.Trim(),
                    Result = x.Result?.Trim(),
                    Comments = x.Comments?.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (reviews.Any())
            {
                ctx.Set<LL_LessonLearnReviewEntity>().AddRange(reviews);
            }

            var participants = (request.Participants ?? new List<LL_LessonLearnParticipant>())
                .Where(x => !string.IsNullOrWhiteSpace(x?.Name) || !string.IsNullOrWhiteSpace(x?.Title))
                .Select((x, index) => new LL_LessonLearnParticipantEntity
                {
                    LessonLearn_Id = lessonLearnId,
                    Name = x.Name?.Trim(),
                    Title = x.Title?.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (participants.Any())
            {
                ctx.Set<LL_LessonLearnParticipantEntity>().AddRange(participants);
            }

            var tasks = (request.Tasks ?? new List<LL_LessonLearnTask>())
                .Where(x => HasTaskContent(x))
                .Select((x, index) => new LL_LessonLearnTaskEntity
                {
                    LessonLearn_Id = lessonLearnId,
                    Title = x.Title?.Trim(),
                    Owner = x.Owner?.Trim(),
                    DueDate = x.DueDate?.Trim(),
                    Progress = x.Progress,
                    Status = x.Status?.Trim(),
                    Notes = x.Notes?.Trim(),
                    Sort = index + 1
                })
                .ToList();
            if (tasks.Any())
            {
                ctx.Set<LL_LessonLearnTaskEntity>().AddRange(tasks);
            }

            var contentBindings = new List<ContentBinding>();
            AddContentBindings(ctx, lessonLearnId, ModuleIssueDescription, request.IssueDescription, contentBindings);
            AddContentBindings(ctx, lessonLearnId, ModuleRootCause, request.RootCause, contentBindings);
            AddContentBindings(ctx, lessonLearnId, ModuleCorrectiveActions, request.CorrectiveActions, contentBindings);
            AddContentBindings(ctx, lessonLearnId, ModuleGlobalLessons, request.GlobalLessons, contentBindings);
            AddContentBindings(ctx, lessonLearnId, ModuleSupplementalNotes, request.SupplementalNotes, contentBindings);

            var documentChangeBindings = (request.DocumentChanges ?? new List<LL_LessonLearnDocumentChange>())
                .Where(HasDocumentChangeContent)
                .Select((x, index) => new DocumentChangeBinding
                {
                    Source = x,
                    Entity = new LL_LessonLearnDocumentChangeEntity
                    {
                        LessonLearn_Id = lessonLearnId,
                        ChangeType = x.ChangeType?.Trim(),
                        BeforeFileName = x.BeforeFileName?.Trim(),
                        AfterFileName = x.AfterFileName?.Trim(),
                        Sort = index + 1
                    }
                })
                .ToList();
            if (documentChangeBindings.Any())
            {
                ctx.Set<LL_LessonLearnDocumentChangeEntity>().AddRange(documentChangeBindings.Select(x => x.Entity));
            }

            await ctx.SaveChangesAsync();

            var files = new List<LL_LessonLearnFile>();
            foreach (var binding in contentBindings)
            {
                var images = binding.Source.Images ?? new List<LL_LessonLearnAttachment>();
                files.AddRange(images
                    .Where(IsValidAttachment)
                    .Select((image, index) => ToFileEntity(
                        lessonLearnId,
                        FileTypeContentImage,
                        image,
                        index + 1,
                        binding.Entity.ModuleType,
                        binding.Entity.LessonLearnContent_Id,
                        null)));
            }

            foreach (var binding in documentChangeBindings)
            {
                var beforeFiles = binding.Source.BeforeFiles ?? new List<LL_LessonLearnAttachment>();
                files.AddRange(beforeFiles
                    .Where(IsValidAttachment)
                    .Select((file, index) => ToFileEntity(
                        lessonLearnId,
                        FileTypeDocumentBefore,
                        file,
                        index + 1,
                        null,
                        null,
                        binding.Entity.LessonLearnDocumentChange_Id)));

                var afterFiles = binding.Source.AfterFiles ?? new List<LL_LessonLearnAttachment>();
                files.AddRange(afterFiles
                    .Where(IsValidAttachment)
                    .Select((file, index) => ToFileEntity(
                        lessonLearnId,
                        FileTypeDocumentAfter,
                        file,
                        index + 1,
                        null,
                        null,
                        binding.Entity.LessonLearnDocumentChange_Id)));
            }

            var generalAttachments = request.Attachments ?? new List<LL_LessonLearnAttachment>();
            files.AddRange(generalAttachments
                .Where(IsValidAttachment)
                .Select((file, index) => ToFileEntity(
                    lessonLearnId,
                    FileTypeGeneral,
                    file,
                    index + 1,
                    null,
                    null,
                    null)));

            if (files.Any())
            {
                ctx.Set<LL_LessonLearnFile>().AddRange(files);
            }
            await ctx.SaveChangesAsync();
        }

        private async Task DeleteChildrenAsync(ServiceDbContext ctx, int lessonLearnId)
        {
            var files = await ctx.Set<LL_LessonLearnFile>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (files.Any())
            {
                ctx.Set<LL_LessonLearnFile>().RemoveRange(files);
            }

            var documentTypes = await ctx.Set<LL_LessonLearnDocumentType>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (documentTypes.Any())
            {
                ctx.Set<LL_LessonLearnDocumentType>().RemoveRange(documentTypes);
            }

            var reviews = await ctx.Set<LL_LessonLearnReviewEntity>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (reviews.Any())
            {
                ctx.Set<LL_LessonLearnReviewEntity>().RemoveRange(reviews);
            }

            var participants = await ctx.Set<LL_LessonLearnParticipantEntity>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (participants.Any())
            {
                ctx.Set<LL_LessonLearnParticipantEntity>().RemoveRange(participants);
            }

            var tasks = await ctx.Set<LL_LessonLearnTaskEntity>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (tasks.Any())
            {
                ctx.Set<LL_LessonLearnTaskEntity>().RemoveRange(tasks);
            }

            var contents = await ctx.Set<LL_LessonLearnContent>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (contents.Any())
            {
                ctx.Set<LL_LessonLearnContent>().RemoveRange(contents);
            }

            var documentChanges = await ctx.Set<LL_LessonLearnDocumentChangeEntity>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (documentChanges.Any())
            {
                ctx.Set<LL_LessonLearnDocumentChangeEntity>().RemoveRange(documentChanges);
            }

            var productLines = await ctx.Set<LL_LessonLearnProductLine>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (productLines.Any())
            {
                ctx.Set<LL_LessonLearnProductLine>().RemoveRange(productLines);
            }

            var tags = await ctx.Set<LL_LessonLearnTag>().Where(x => x.LessonLearn_Id == lessonLearnId).ToListAsync();
            if (tags.Any())
            {
                ctx.Set<LL_LessonLearnTag>().RemoveRange(tags);
            }

            await ctx.SaveChangesAsync();
        }

        private async Task<LL_LessonLearnDetailDto> BuildDetailAsync(ServiceDbContext ctx, LL_LessonLearn entity)
        {
            var lessonId = entity.LessonLearn_Id;
            var productLines = await ctx.Set<LL_LessonLearnProductLine>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .Select(x => x.ProductLine)
                .ToListAsync();

            var tags = await ctx.Set<LL_LessonLearnTag>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .Select(x => x.TagName)
                .ToListAsync();

            var documentTypes = await ctx.Set<LL_LessonLearnDocumentType>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .Select(x => x.DocumentType)
                .ToListAsync();

            var contents = await ctx.Set<LL_LessonLearnContent>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ToListAsync();

            var documentChanges = await ctx.Set<LL_LessonLearnDocumentChangeEntity>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ToListAsync();

            var files = await ctx.Set<LL_LessonLearnFile>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ThenBy(x => x.UploadTime)
                .ToListAsync();

            var reviews = await ctx.Set<LL_LessonLearnReviewEntity>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ToListAsync();

            var participants = await ctx.Set<LL_LessonLearnParticipantEntity>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ToListAsync();

            var tasks = await ctx.Set<LL_LessonLearnTaskEntity>()
                .Where(x => x.LessonLearn_Id == lessonId)
                .OrderBy(x => x.Sort)
                .ToListAsync();

            var history = await LoadHistoryAsync(ctx, lessonId);

            return new LL_LessonLearnDetailDto
            {
                LessonLearn_Id = entity.LessonLearn_Id,
                LessonNo = entity.LessonNo,
                TitleEn = entity.TitleEn,
                TitleCn = entity.TitleCn,
                Category = entity.Category,
                LessonLevel = entity.LessonLevel,
                ProductPlatform = entity.ProductPlatform,
                ProductPlatforms = ParseMultiTextValues(entity.ProductPlatformsText, entity.ProductPlatform),
                LlGroup = entity.LlGroup,
                IssueSource = entity.IssueSource,
                IssueNo = entity.IssueNo,
                IssueUrl = entity.IssueUrl,
                IssueType = entity.IssueType,
                CPI = entity.CPI,
                CpiProgram = entity.CpiProgram,
                Customer = entity.Customer,
                Program = entity.Program,
                PartNo = entity.PartNo,
                PartVersion = entity.PartVersion,
                Plant = entity.Plant,
                Workshop = entity.Workshop,
                ProductionLine = entity.ProductionLine,
                CellName = entity.CellName,
                ApprovalOwner = entity.ApprovalOwner,
                IsActive = entity.IsActive,
                PfmeaEnabled = entity.PfmeaEnabled,
                PfmeaDescription = entity.PfmeaDescription,
                PfmeaBefore = new LL_LessonLearnPfmeaScore
                {
                    Severity = entity.PfmeaBeforeSeverity ?? 0,
                    Occurrence = entity.PfmeaBeforeOccurrence ?? 0,
                    Detection = entity.PfmeaBeforeDetection ?? 0
                },
                PfmeaAfter = new LL_LessonLearnPfmeaScore
                {
                    Severity = entity.PfmeaAfterSeverity ?? 0,
                    Occurrence = entity.PfmeaAfterOccurrence ?? 0,
                    Detection = entity.PfmeaAfterDetection ?? 0
                },
                DfmeaEnabled = entity.DfmeaEnabled,
                DfmeaDescription = entity.DfmeaDescription,
                DfmeaBefore = new LL_LessonLearnPfmeaScore
                {
                    Severity = entity.DfmeaBeforeSeverity ?? 0,
                    Occurrence = entity.DfmeaBeforeOccurrence ?? 0,
                    Detection = entity.DfmeaBeforeDetection ?? 0
                },
                DfmeaAfter = new LL_LessonLearnPfmeaScore
                {
                    Severity = entity.DfmeaAfterSeverity ?? 0,
                    Occurrence = entity.DfmeaAfterOccurrence ?? 0,
                    Detection = entity.DfmeaAfterDetection ?? 0
                },
                Status = entity.Status,
                Progress = entity.Progress,
                AnalysisCycleDays = entity.AnalysisCycleDays,
                ViewCount = entity.ViewCount,
                FavoriteCount = entity.FavoriteCount,
                LikeCount = entity.LikeCount,
                VersionNo = entity.VersionNo,
                IsLocked = entity.IsLocked,
                SubmittedDate = entity.SubmittedDate,
                PublishedDate = entity.PublishedDate,
                CreateDate = entity.CreateDate,
                ModifyDate = entity.ModifyDate,
                Creator = entity.Creator,
                Modifier = entity.Modifier,
                BasicInfo = new LL_LessonLearnBasicInfo
                {
                    LlCategoryCode = entity.LlCategoryCode,
                    LlGroupNote = entity.LlGroupNote,
                    VersionRemark = entity.VersionRemark
                },
                ApplicableProductLines = productLines,
                Tags = tags,
                DocumentTypes = documentTypes,
                IssueDescription = BuildTextBlocks(contents, files, ModuleIssueDescription),
                RootCause = BuildTextBlocks(contents, files, ModuleRootCause),
                CorrectiveActions = BuildTextBlocks(contents, files, ModuleCorrectiveActions),
                GlobalLessons = BuildTextBlocks(contents, files, ModuleGlobalLessons),
                SupplementalNotes = BuildTextBlocks(contents, files, ModuleSupplementalNotes),
                DocumentChanges = BuildDocumentChanges(documentChanges, files),
                Attachments = files
                    .Where(x => x.FileType == FileTypeGeneral)
                    .OrderBy(x => x.Sort)
                    .Select(ToAttachmentDto)
                    .ToList(),
                ReviewRecords = reviews.Select(x => new LL_LessonLearnReview
                {
                    Round = x.Round,
                    ReviewDate = x.ReviewDate,
                    Reviewer = x.Reviewer,
                    ReviewerTitle = x.ReviewerTitle,
                    Result = x.Result,
                    Comments = x.Comments
                }).ToList(),
                Participants = participants.Select(x => new LL_LessonLearnParticipant
                {
                    Name = x.Name,
                    Title = x.Title
                }).ToList(),
                Tasks = tasks.Select(x => new LL_LessonLearnTask
                {
                    Title = x.Title,
                    Owner = x.Owner,
                    DueDate = x.DueDate,
                    Progress = x.Progress ?? 0,
                    Status = x.Status,
                    Notes = x.Notes
                }).ToList(),
                HistoryRecords = history
            };
        }

        private async Task<List<LL_LessonLearnHistory>> LoadHistoryAsync(ServiceDbContext ctx, int lessonLearnId)
        {
            return await ctx.Set<LL_LessonLearnVersionEntity>()
                .Where(x => x.LessonLearn_Id == lessonLearnId)
                .OrderByDescending(x => x.VersionNo)
                .ThenByDescending(x => x.ActionTime)
                .Take(50)
                .Select(x => new LL_LessonLearnHistory
                {
                    VersionNo = x.VersionNo ?? 0,
                    Action = x.Action,
                    Operator = x.Operator,
                    Time = x.ActionTime.HasValue ? x.ActionTime.Value.ToString("yyyy-MM-dd HH:mm:ss") : string.Empty,
                    StatusText = x.StatusText,
                    Comment = x.Comment
                })
                .ToListAsync();
        }

        private List<LL_LessonLearnTextBlock> BuildTextBlocks(List<LL_LessonLearnContent> contents, List<LL_LessonLearnFile> files, string moduleType)
        {
            var sectionRows = contents
                .Where(x => x.ModuleType == moduleType)
                .OrderBy(x => x.Sort)
                .ToList();

            return sectionRows.Select(x => new LL_LessonLearnTextBlock
            {
                Sort = x.Sort ?? 0,
                En = x.ContentEn,
                Zh = x.ContentZh,
                Images = files
                    .Where(f => f.FileType == FileTypeContentImage && f.LessonLearnContent_Id == x.LessonLearnContent_Id)
                    .OrderBy(f => f.Sort)
                    .Select(ToAttachmentDto)
                    .ToList()
            }).ToList();
        }

        private List<LL_LessonLearnDocumentChange> BuildDocumentChanges(List<LL_LessonLearnDocumentChangeEntity> rows, List<LL_LessonLearnFile> files)
        {
            return rows.Select(x => new LL_LessonLearnDocumentChange
            {
                ChangeType = x.ChangeType,
                BeforeFileName = x.BeforeFileName,
                AfterFileName = x.AfterFileName,
                BeforeFiles = files
                    .Where(f => f.FileType == FileTypeDocumentBefore && f.LessonLearnDocumentChange_Id == x.LessonLearnDocumentChange_Id)
                    .OrderBy(f => f.Sort)
                    .Select(ToAttachmentDto)
                    .ToList(),
                AfterFiles = files
                    .Where(f => f.FileType == FileTypeDocumentAfter && f.LessonLearnDocumentChange_Id == x.LessonLearnDocumentChange_Id)
                    .OrderBy(f => f.Sort)
                    .Select(ToAttachmentDto)
                    .ToList()
            }).ToList();
        }

        private LL_LessonLearnAttachment ToAttachmentDto(LL_LessonLearnFile file)
        {
            return new LL_LessonLearnAttachment
            {
                Category = file.Category,
                Name = file.Name,
                Path = file.Path,
                Size = file.Size ?? 0,
                DownloadCount = file.DownloadCount ?? 0,
                UploadTime = file.UploadTime.HasValue ? file.UploadTime.Value.ToString("yyyy-MM-dd HH:mm:ss") : string.Empty,
                CaptionEn = file.CaptionEn,
                CaptionZh = file.CaptionZh
            };
        }

        private LL_LessonLearnFile ToFileEntity(
            int lessonLearnId,
            string fileType,
            LL_LessonLearnAttachment file,
            int sort,
            string moduleType,
            int? contentId,
            int? documentChangeId)
        {
            return new LL_LessonLearnFile
            {
                LessonLearn_Id = lessonLearnId,
                FileType = fileType,
                ModuleType = moduleType,
                LessonLearnContent_Id = contentId,
                LessonLearnDocumentChange_Id = documentChangeId,
                Category = file.Category?.Trim(),
                Name = file.Name?.Trim(),
                Path = file.Path?.Trim(),
                Size = file.Size,
                DownloadCount = file.DownloadCount,
                UploadTime = TryParseDateTime(file.UploadTime) ?? DateTime.Now,
                CaptionEn = file.CaptionEn?.Trim(),
                CaptionZh = file.CaptionZh?.Trim(),
                Sort = sort
            };
        }

        private void AddContentBindings(
            ServiceDbContext ctx,
            int lessonLearnId,
            string moduleType,
            List<LL_LessonLearnTextBlock> source,
            List<ContentBinding> bindings)
        {
            var rows = (source ?? new List<LL_LessonLearnTextBlock>())
                .Where(HasTextBlockContent)
                .Select((x, index) =>
                {
                    var entity = new LL_LessonLearnContent
                    {
                        LessonLearn_Id = lessonLearnId,
                        ModuleType = moduleType,
                        Sort = x.Sort > 0 ? x.Sort : index + 1,
                        ContentEn = x.En?.Trim(),
                        ContentZh = x.Zh?.Trim()
                    };
                    bindings.Add(new ContentBinding { Entity = entity, Source = x });
                    return entity;
                })
                .ToList();

            if (rows.Any())
            {
                ctx.Set<LL_LessonLearnContent>().AddRange(rows);
            }
        }

        private void ApplyRequest(LL_LessonLearn entity, LL_LessonLearnSaveRequest request)
        {
            var productPlatforms = NormalizeDistinctTextList(request.ProductPlatforms);
            var primaryProductPlatform = !string.IsNullOrWhiteSpace(request.ProductPlatform)
                ? request.ProductPlatform?.Trim()
                : productPlatforms.FirstOrDefault() ?? string.Empty;

            entity.LessonNo = request.LessonNo?.Trim();
            entity.TitleEn = request.TitleEn?.Trim();
            entity.TitleCn = request.TitleCn?.Trim();
            entity.Category = request.Category?.Trim();
            entity.LessonLevel = request.LessonLevel?.Trim();
            entity.ProductPlatform = primaryProductPlatform;
            entity.ProductPlatformsText = string.Join(", ", productPlatforms);
            entity.LlGroup = request.LlGroup?.Trim();
            entity.IssueSource = request.IssueSource?.Trim();
            entity.IssueNo = request.IssueNo?.Trim();
            entity.IssueUrl = BuildIssueUrl(request.IssueSource, request.IssueNo, request.IssueUrl);
            entity.IssueType = request.IssueType?.Trim();
            entity.CPI = request.CPI?.Trim();
            entity.CpiProgram = request.CpiProgram?.Trim();
            entity.Customer = request.Customer?.Trim();
            entity.Program = request.Program?.Trim();
            entity.PartNo = request.PartNo?.Trim();
            entity.PartVersion = request.PartVersion?.Trim();
            entity.Plant = request.Plant?.Trim();
            entity.Workshop = request.Workshop?.Trim();
            entity.ProductionLine = request.ProductionLine?.Trim();
            entity.CellName = request.CellName?.Trim();
            entity.ApprovalOwner = request.ApprovalOwner?.Trim();
            entity.IsLocked = request.IsLocked ?? false;
            entity.IsActive = request.IsActive ?? entity.IsActive ?? true;
            entity.PfmeaEnabled = request.PfmeaEnabled ?? false;
            entity.PfmeaDescription = request.PfmeaDescription?.Trim();
            entity.PfmeaBeforeSeverity = request.PfmeaBefore?.Severity;
            entity.PfmeaBeforeOccurrence = request.PfmeaBefore?.Occurrence;
            entity.PfmeaBeforeDetection = request.PfmeaBefore?.Detection;
            entity.PfmeaAfterSeverity = request.PfmeaAfter?.Severity;
            entity.PfmeaAfterOccurrence = request.PfmeaAfter?.Occurrence;
            entity.PfmeaAfterDetection = request.PfmeaAfter?.Detection;
            entity.DfmeaEnabled = request.DfmeaEnabled ?? false;
            entity.DfmeaDescription = request.DfmeaDescription?.Trim();
            entity.DfmeaBeforeSeverity = request.DfmeaBefore?.Severity;
            entity.DfmeaBeforeOccurrence = request.DfmeaBefore?.Occurrence;
            entity.DfmeaBeforeDetection = request.DfmeaBefore?.Detection;
            entity.DfmeaAfterSeverity = request.DfmeaAfter?.Severity;
            entity.DfmeaAfterOccurrence = request.DfmeaAfter?.Occurrence;
            entity.DfmeaAfterDetection = request.DfmeaAfter?.Detection;
            entity.LlCategoryCode = request.BasicInfo?.LlCategoryCode?.Trim();
            entity.LlGroupNote = request.BasicInfo?.LlGroupNote?.Trim();
            entity.VersionRemark = request.BasicInfo?.VersionRemark?.Trim();
            entity.ApplicableProductLinesText = string.Join(", ", (request.ApplicableProductLines ?? new List<string>()).Where(x => !string.IsNullOrWhiteSpace(x)).Select(x => x.Trim()).Distinct());
            entity.TagsText = string.Join(", ", (request.Tags ?? new List<string>()).Where(x => !string.IsNullOrWhiteSpace(x)).Select(x => x.Trim()).Distinct());
            entity.DocumentTypesText = string.Join(", ", (request.DocumentTypes ?? new List<string>()).Where(x => !string.IsNullOrWhiteSpace(x)).Select(x => x.Trim()).Distinct());
        }

        private async Task ValidateBeforeSubmitAsync(ServiceDbContext ctx, LL_LessonLearn entity)
        {
            var detail = await BuildDetailAsync(ctx, entity);
            if (string.IsNullOrWhiteSpace(detail.LessonNo))
            {
                throw new Exception("提交审批前必须生成 LL 编号");
            }
            if (string.IsNullOrWhiteSpace(detail.TitleEn))
            {
                throw new Exception("提交审批前必须填写英文标题");
            }
            if (string.IsNullOrWhiteSpace(detail.Category))
            {
                throw new Exception("提交审批前必须选择 LL 分类");
            }
            if (!(detail.ApplicableProductLines?.Any() ?? false))
            {
                throw new Exception("提交审批前必须至少选择一个适用产品线");
            }
            if (!(detail.IssueDescription?.Any(HasTextBlockContent) ?? false))
            {
                throw new Exception("提交审批前必须填写问题描述");
            }
            if (!(detail.RootCause?.Any(HasTextBlockContent) ?? false))
            {
                throw new Exception("提交审批前必须填写根本原因");
            }
            if (!(detail.CorrectiveActions?.Any(HasTextBlockContent) ?? false))
            {
                throw new Exception("提交审批前必须填写纠正措施");
            }
            if (!(detail.GlobalLessons?.Any(HasTextBlockContent) ?? false))
            {
                throw new Exception("提交审批前必须填写全球经验教训");
            }
        }

        private async Task EnsureLessonNoUniqueAsync(ServiceDbContext ctx, string lessonNo, int currentId)
        {
            if (string.IsNullOrWhiteSpace(lessonNo))
            {
                return;
            }
            var exists = await ctx.Set<LL_LessonLearn>()
                .AnyAsync(x => x.LessonNo == lessonNo && x.LessonLearn_Id != currentId);
            if (exists)
            {
                throw new Exception($"LL 编号已存在：{lessonNo}");
            }
        }

        private int CalculateProgress(LL_LessonLearnSaveRequest request)
        {
            var total = 0;
            if (!string.IsNullOrWhiteSpace(request.LessonNo) ||
                !string.IsNullOrWhiteSpace(request.TitleEn) ||
                !string.IsNullOrWhiteSpace(request.Category))
            {
                total += 10;
            }
            if ((request.ApplicableProductLines?.Count ?? 0) > 0)
            {
                total += 10;
            }
            if ((request.Tags?.Count ?? 0) > 0)
            {
                total += 10;
            }
            if ((request.IssueDescription?.Any(HasTextBlockContent) ?? false))
            {
                total += 10;
            }
            if ((request.RootCause?.Any(HasTextBlockContent) ?? false))
            {
                total += 10;
            }
            if ((request.CorrectiveActions?.Any(HasTextBlockContent) ?? false))
            {
                total += 10;
            }
            if ((request.GlobalLessons?.Any(HasTextBlockContent) ?? false))
            {
                total += 30;
            }
            return total;
        }

        private List<string> NormalizeDistinctTextList(List<string> values)
        {
            return (values ?? new List<string>())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .Select(x => x.Trim())
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();
        }

        private List<string> ParseMultiTextValues(string text, string fallback)
        {
            var values = (text ?? string.Empty)
                .Split(new[] { ',', ';', '，', '；', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(x => x.Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();

            if (!values.Any() && !string.IsNullOrWhiteSpace(fallback))
            {
                values.Add(fallback.Trim());
            }
            return values;
        }

        private string BuildIssueUrl(string issueSource, string issueNo, string issueUrl)
        {
            if (!string.IsNullOrWhiteSpace(issueUrl))
            {
                return issueUrl.Trim();
            }
            if (string.IsNullOrWhiteSpace(issueSource) || string.IsNullOrWhiteSpace(issueNo))
            {
                return string.Empty;
            }

            var source = issueSource.Trim().ToLowerInvariant();
            var issue = Uri.EscapeDataString(issueNo.Trim());
            return source switch
            {
                "deviation" => $"https://deviation.nexteer.com/issues/{issue}",
                "efrqc" => $"https://efrqc.nexteer.com/issues/{issue}",
                "5phase" => $"https://5phase.nexteer.com/issues/{issue}",
                "eqms" => $"https://eqms.nexteer.com/issues/{issue}",
                _ => string.Empty
            };
        }

        private bool HasTextBlockContent(LL_LessonLearnTextBlock block)
        {
            return block != null &&
                   (!string.IsNullOrWhiteSpace(block.En) ||
                 !string.IsNullOrWhiteSpace(block.Zh) ||
                 (block.Images?.Any(IsValidAttachment) ?? false));
        }

        private bool HasReviewContent(LL_LessonLearnReview review)
        {
            return review != null &&
                (!string.IsNullOrWhiteSpace(review.Round) ||
                 !string.IsNullOrWhiteSpace(review.ReviewDate) ||
                 !string.IsNullOrWhiteSpace(review.Reviewer) ||
                 !string.IsNullOrWhiteSpace(review.ReviewerTitle) ||
                 !string.IsNullOrWhiteSpace(review.Result) ||
                 !string.IsNullOrWhiteSpace(review.Comments));
        }

        private bool HasTaskContent(LL_LessonLearnTask task)
        {
            return task != null &&
                (!string.IsNullOrWhiteSpace(task.Title) ||
                 !string.IsNullOrWhiteSpace(task.Owner) ||
                 !string.IsNullOrWhiteSpace(task.DueDate) ||
                 !string.IsNullOrWhiteSpace(task.Status) ||
                 !string.IsNullOrWhiteSpace(task.Notes) ||
                 task.Progress > 0);
        }

        private bool HasDocumentChangeContent(LL_LessonLearnDocumentChange item)
        {
            return item != null &&
                (!string.IsNullOrWhiteSpace(item.ChangeType) ||
                 !string.IsNullOrWhiteSpace(item.BeforeFileName) ||
                 !string.IsNullOrWhiteSpace(item.AfterFileName) ||
                 (item.BeforeFiles?.Any(IsValidAttachment) ?? false) ||
                 (item.AfterFiles?.Any(IsValidAttachment) ?? false));
        }

        private bool IsValidAttachment(LL_LessonLearnAttachment attachment)
        {
            return attachment != null &&
                (!string.IsNullOrWhiteSpace(attachment.Path) || !string.IsNullOrWhiteSpace(attachment.Name));
        }

        private DateTime? TryParseDateTime(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }
            if (DateTime.TryParse(value, out var date))
            {
                return date;
            }
            return null;
        }

        private string GetCurrentUserName()
        {
            return UserContext.Current?.UserTrueName ?? UserContext.Current?.UserName ?? "system";
        }

        private int GetCurrentUserId()
        {
            return UserContext.Current?.UserId ?? 0;
        }

        private string Serialize(object value)
        {
            return JsonConvert.SerializeObject(value ?? new object());
        }

        private string NormalizeLessonSegment(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return string.Empty;
            }
            var chars = value.Trim().ToUpperInvariant().Where(char.IsLetterOrDigit).ToArray();
            return new string(chars);
        }

        private string GetCategoryCode(string category)
        {
            var value = (category ?? string.Empty).Trim().ToUpperInvariant();
            return value switch
            {
                "DESIGN" => "D",
                "PROCESS" => "P",
                "SUPPLIER" => "S",
                "NONCONFORMANCE" => "NC",
                "NON-CONFORMANCE" => "NC",
                "NC" => "NC",
                _ => string.Empty
            };
        }

        private string GetStatusText(int? status)
        {
            return status switch
            {
                1 => "待审核",
                2 => "已驳回",
                3 => "已发布",
                _ => "编辑中"
            };
        }

        private List<string> ReadSlideTexts(ZipArchiveEntry slideEntry)
        {
            using var entryStream = slideEntry.Open();
            var doc = XDocument.Load(entryStream);
            XNamespace drawing = "http://schemas.openxmlformats.org/drawingml/2006/main";
            return doc.Descendants(drawing + "t")
                .Select(x => (x.Value ?? string.Empty).Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .ToList();
        }

        private bool IsSectionHeader(string text)
        {
            var headers = new[]
            {
                "Issue Description",
                "Root Cause",
                "Corrective Actions",
                "Global Lessons Learned",
                "Global Lessons",
                "Supplemental Information",
                "问题描述",
                "根本原因",
                "纠正措施",
                "全球经验教训",
                "补充信息"
            };
            return headers.Any(x => string.Equals(x, text, StringComparison.OrdinalIgnoreCase));
        }

        private string TryReadValue(List<string> texts, string[] headers)
        {
            if (texts == null || texts.Count == 0)
            {
                return string.Empty;
            }
            for (var i = 0; i < texts.Count; i++)
            {
                if (headers.Any(h => string.Equals(texts[i], h, StringComparison.OrdinalIgnoreCase)))
                {
                    for (var j = i + 1; j < texts.Count; j++)
                    {
                        if (!headers.Any(h => string.Equals(texts[j], h, StringComparison.OrdinalIgnoreCase)) && !IsSectionHeader(texts[j]))
                        {
                            return texts[j];
                        }
                    }
                }
            }
            return string.Empty;
        }

        private List<LL_LessonLearnTextBlock> BuildSectionBlocks(string rawText, string[] names)
        {
            var content = ExtractSection(rawText, names);
            if (string.IsNullOrWhiteSpace(content))
            {
                return new List<LL_LessonLearnTextBlock>();
            }

            var lines = content.Replace("/", " ")
                .Split('\n')
                .Select(x => x.Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .ToList();

            var blocks = new List<LL_LessonLearnTextBlock>();
            var sort = 1;
            for (var i = 0; i < lines.Count; i += 2)
            {
                blocks.Add(new LL_LessonLearnTextBlock
                {
                    Sort = sort++,
                    En = lines[i],
                    Zh = i + 1 < lines.Count ? lines[i + 1] : string.Empty
                });
            }
            return blocks;
        }

        private string ExtractSection(string rawText, string[] sectionNames)
        {
            if (string.IsNullOrWhiteSpace(rawText))
            {
                return string.Empty;
            }
            var allHeaders = new[]
            {
                "Issue Description",
                "Root Cause",
                "Corrective Actions",
                "Global Lessons Learned",
                "Global Lessons",
                "Supplemental Information",
                "问题描述",
                "根本原因",
                "纠正措施",
                "全球经验教训",
                "补充信息"
            };
            var start = -1;
            var matchedHeader = string.Empty;
            foreach (var name in sectionNames)
            {
                var index = rawText.IndexOf(name, StringComparison.OrdinalIgnoreCase);
                if (index >= 0 && (start < 0 || index < start))
                {
                    start = index;
                    matchedHeader = name;
                }
            }
            if (start < 0)
            {
                return string.Empty;
            }
            start += matchedHeader.Length;
            var end = rawText.Length;
            foreach (var header in allHeaders.Except(sectionNames))
            {
                var nextIndex = rawText.IndexOf(header, start, StringComparison.OrdinalIgnoreCase);
                if (nextIndex > start && nextIndex < end)
                {
                    end = nextIndex;
                }
            }
            return rawText[start..end].Trim();
        }

        private sealed class ContentBinding
        {
            public LL_LessonLearnContent Entity { get; set; }
            public LL_LessonLearnTextBlock Source { get; set; }
        }

        private sealed class DocumentChangeBinding
        {
            public LL_LessonLearnDocumentChangeEntity Entity { get; set; }
            public LL_LessonLearnDocumentChange Source { get; set; }
        }
    }
}
