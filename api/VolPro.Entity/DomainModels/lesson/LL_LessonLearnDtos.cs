using System;
using System.Collections.Generic;

namespace VolPro.Entity.DomainModels
{
    public class LL_LessonLearnSearchRequest
    {
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 10;
        public string Keyword { get; set; }
        public string Category { get; set; }
        public string LessonLevel { get; set; }
        public int? Status { get; set; }
        public string ProductLine { get; set; }
        public string Tag { get; set; }
        public string Plant { get; set; }
        public bool? IsActive { get; set; }
    }

    public class LL_LessonLearnPageResult
    {
        public int Total { get; set; }
        public List<LL_LessonLearnListItem> Items { get; set; } = new List<LL_LessonLearnListItem>();
    }

    public class LL_LessonLearnListItem
    {
        public int LessonLearn_Id { get; set; }
        public string LessonNo { get; set; }
        public string TitleEn { get; set; }
        public string TitleCn { get; set; }
        public string Category { get; set; }
        public string LessonLevel { get; set; }
        public int? Status { get; set; }
        public int? Progress { get; set; }
        public string ProductPlatform { get; set; }
        public string ProductPlatformsText { get; set; }
        public string LlGroup { get; set; }
        public string Plant { get; set; }
        public string Workshop { get; set; }
        public string PartVersion { get; set; }
        public string ApplicableProductLinesText { get; set; }
        public string TagsText { get; set; }
        public int? ViewCount { get; set; }
        public int? FavoriteCount { get; set; }
        public int? LikeCount { get; set; }
        public int? VersionNo { get; set; }
        public bool? IsLocked { get; set; }
        public bool? IsActive { get; set; }
        public string DocumentTypesText { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? ModifyDate { get; set; }
        public string Creator { get; set; }
        public string Modifier { get; set; }
    }

    public class LL_LessonLearnSaveRequest
    {
        public int LessonLearn_Id { get; set; }
        public string LessonNo { get; set; }
        public string TitleEn { get; set; }
        public string TitleCn { get; set; }
        public string Category { get; set; }
        public string LessonLevel { get; set; }
        public string ProductPlatform { get; set; }
        public List<string> ProductPlatforms { get; set; } = new List<string>();
        public string LlGroup { get; set; }
        public string IssueSource { get; set; }
        public string IssueNo { get; set; }
        public string IssueUrl { get; set; }
        public string IssueType { get; set; }
        public string CPI { get; set; }
        public string CpiProgram { get; set; }
        public string Customer { get; set; }
        public string Program { get; set; }
        public string PartNo { get; set; }
        public string PartVersion { get; set; }
        public string Plant { get; set; }
        public string Workshop { get; set; }
        public string ProductionLine { get; set; }
        public string CellName { get; set; }
        public string ApprovalOwner { get; set; }
        public bool? IsLocked { get; set; }
        public bool? IsActive { get; set; }
        public bool? PfmeaEnabled { get; set; }
        public string PfmeaDescription { get; set; }
        public LL_LessonLearnPfmeaScore PfmeaBefore { get; set; } = new LL_LessonLearnPfmeaScore();
        public LL_LessonLearnPfmeaScore PfmeaAfter { get; set; } = new LL_LessonLearnPfmeaScore();
        public bool? DfmeaEnabled { get; set; }
        public string DfmeaDescription { get; set; }
        public LL_LessonLearnPfmeaScore DfmeaBefore { get; set; } = new LL_LessonLearnPfmeaScore();
        public LL_LessonLearnPfmeaScore DfmeaAfter { get; set; } = new LL_LessonLearnPfmeaScore();
        public LL_LessonLearnBasicInfo BasicInfo { get; set; } = new LL_LessonLearnBasicInfo();
        public List<string> ApplicableProductLines { get; set; } = new List<string>();
        public List<string> Tags { get; set; } = new List<string>();
        public List<LL_LessonLearnTextBlock> IssueDescription { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> RootCause { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> CorrectiveActions { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> GlobalLessons { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> SupplementalNotes { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<string> DocumentTypes { get; set; } = new List<string>();
        public List<LL_LessonLearnDocumentChange> DocumentChanges { get; set; } = new List<LL_LessonLearnDocumentChange>();
        public List<LL_LessonLearnAttachment> Attachments { get; set; } = new List<LL_LessonLearnAttachment>();
        public List<LL_LessonLearnReview> ReviewRecords { get; set; } = new List<LL_LessonLearnReview>();
        public List<LL_LessonLearnParticipant> Participants { get; set; } = new List<LL_LessonLearnParticipant>();
        public List<LL_LessonLearnTask> Tasks { get; set; } = new List<LL_LessonLearnTask>();
        public List<LL_LessonLearnHistory> HistoryRecords { get; set; } = new List<LL_LessonLearnHistory>();
    }

    public class LL_LessonLearnDetailDto : LL_LessonLearnSaveRequest
    {
        public int? Status { get; set; }
        public int? Progress { get; set; }
        public int? AnalysisCycleDays { get; set; }
        public int? ViewCount { get; set; }
        public int? FavoriteCount { get; set; }
        public int? LikeCount { get; set; }
        public int? VersionNo { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? ModifyDate { get; set; }
        public DateTime? SubmittedDate { get; set; }
        public DateTime? PublishedDate { get; set; }
        public string Creator { get; set; }
        public string Modifier { get; set; }
    }

    public class LL_LessonLearnBasicInfo
    {
        public string LlCategoryCode { get; set; }
        public string LlGroupNote { get; set; }
        public string VersionRemark { get; set; }
    }

    public class LL_LessonLearnPfmeaScore
    {
        public int Severity { get; set; }
        public int Occurrence { get; set; }
        public int Detection { get; set; }
    }

    public class LL_LessonLearnTextBlock
    {
        public int Sort { get; set; }
        public string En { get; set; }
        public string Zh { get; set; }
        public List<LL_LessonLearnAttachment> Images { get; set; } = new List<LL_LessonLearnAttachment>();
    }

    public class LL_LessonLearnAttachment
    {
        public string Category { get; set; }
        public string Name { get; set; }
        public string Path { get; set; }
        public long Size { get; set; }
        public int DownloadCount { get; set; }
        public string UploadTime { get; set; }
        public string CaptionEn { get; set; }
        public string CaptionZh { get; set; }
    }

    public class LL_LessonLearnDocumentChange
    {
        public string ChangeType { get; set; }
        public string BeforeFileName { get; set; }
        public string AfterFileName { get; set; }
        public List<LL_LessonLearnAttachment> BeforeFiles { get; set; } = new List<LL_LessonLearnAttachment>();
        public List<LL_LessonLearnAttachment> AfterFiles { get; set; } = new List<LL_LessonLearnAttachment>();
    }

    public class LL_LessonLearnReview
    {
        public string Round { get; set; }
        public string ReviewDate { get; set; }
        public string Reviewer { get; set; }
        public string ReviewerTitle { get; set; }
        public string Result { get; set; }
        public string Comments { get; set; }
    }

    public class LL_LessonLearnParticipant
    {
        public string Name { get; set; }
        public string Title { get; set; }
    }

    public class LL_LessonLearnTask
    {
        public string Title { get; set; }
        public string Owner { get; set; }
        public string DueDate { get; set; }
        public int Progress { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
    }

    public class LL_LessonLearnHistory
    {
        public int VersionNo { get; set; }
        public string Action { get; set; }
        public string Operator { get; set; }
        public string Time { get; set; }
        public string StatusText { get; set; }
        public string Comment { get; set; }
    }

    public class LL_LessonLearnImportResult
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string LessonNo { get; set; }
        public string TitleEn { get; set; }
        public string Category { get; set; }
        public string LessonLevel { get; set; }
        public string ProductLine { get; set; }
        public string IssueSource { get; set; }
        public string IssueNo { get; set; }
        public string IssueType { get; set; }
        public string CPI { get; set; }
        public string Customer { get; set; }
        public string Program { get; set; }
        public string PartNo { get; set; }
        public string Plant { get; set; }
        public List<LL_LessonLearnTextBlock> IssueDescription { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> RootCause { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> CorrectiveActions { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> GlobalLessons { get; set; } = new List<LL_LessonLearnTextBlock>();
        public List<LL_LessonLearnTextBlock> SupplementalNotes { get; set; } = new List<LL_LessonLearnTextBlock>();
        public string RawText { get; set; }
    }

    public class LL_LessonLearnNumberRequest
    {
        public int LessonLearn_Id { get; set; }
        public string ProductLine { get; set; }
        public string ProductPlatform { get; set; }
        public string Category { get; set; }
    }

    public class LL_LessonLearnNumberResult
    {
        public string ProductLine { get; set; }
        public string Category { get; set; }
        public string Prefix { get; set; }
        public string LessonNo { get; set; }
    }
}
