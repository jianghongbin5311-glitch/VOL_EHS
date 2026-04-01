using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;

namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "Lesson Learn 产品线", TableName = "LL_LessonLearnProductLine", DBServer = "ServiceDbContext")]
    public class LL_LessonLearnProductLine : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnProductLine_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ProductLine { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 标签", TableName = "LL_LessonLearnTag", DBServer = "ServiceDbContext")]
    public class LL_LessonLearnTag : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnTag_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string TagName { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 文件类型", TableName = "LL_LessonLearnDocumentType", DBServer = "ServiceDbContext")]
    public class LL_LessonLearnDocumentType : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnDocumentType_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string DocumentType { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 内容条目", TableName = "LL_LessonLearnContent", DBServer = "ServiceDbContext")]
    public class LL_LessonLearnContent : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnContent_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string ModuleType { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string ContentEn { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string ContentZh { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 文件变更", TableName = "LL_LessonLearnDocumentChange", DBServer = "ServiceDbContext")]
    [Table("LL_LessonLearnDocumentChange")]
    public class LL_LessonLearnDocumentChangeEntity : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnDocumentChange_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ChangeType { get; set; }

        [MaxLength(300)]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string BeforeFileName { get; set; }

        [MaxLength(300)]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string AfterFileName { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 文件", TableName = "LL_LessonLearnFile", DBServer = "ServiceDbContext")]
    public class LL_LessonLearnFile : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnFile_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string FileType { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string ModuleType { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? LessonLearnContent_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? LessonLearnDocumentChange_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Category { get; set; }

        [MaxLength(260)]
        [Column(TypeName = "nvarchar(260)")]
        [Editable(true)]
        public string Name { get; set; }

        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string Path { get; set; }

        [Column(TypeName = "bigint")]
        [Editable(true)]
        public long? Size { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? DownloadCount { get; set; }

        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? UploadTime { get; set; }

        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string CaptionEn { get; set; }

        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string CaptionZh { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 评审记录", TableName = "LL_LessonLearnReview", DBServer = "ServiceDbContext")]
    [Table("LL_LessonLearnReview")]
    public class LL_LessonLearnReviewEntity : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnReview_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Round { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string ReviewDate { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Reviewer { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ReviewerTitle { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Result { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string Comments { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 参与人员", TableName = "LL_LessonLearnParticipant", DBServer = "ServiceDbContext")]
    [Table("LL_LessonLearnParticipant")]
    public class LL_LessonLearnParticipantEntity : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnParticipant_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Name { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Title { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 任务", TableName = "LL_LessonLearnTask", DBServer = "ServiceDbContext")]
    [Table("LL_LessonLearnTask")]
    public class LL_LessonLearnTaskEntity : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnTask_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [MaxLength(200)]
        [Column(TypeName = "nvarchar(200)")]
        [Editable(true)]
        public string Title { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Owner { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string DueDate { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Progress { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Status { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string Notes { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }
    }

    [Entity(TableCnName = "Lesson Learn 版本记录", TableName = "LL_LessonLearnVersion", DBServer = "ServiceDbContext")]
    [Table("LL_LessonLearnVersion")]
    public class LL_LessonLearnVersionEntity : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearnVersion_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int LessonLearn_Id { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? VersionNo { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Action { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Operator { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string StatusText { get; set; }

        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string Comment { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string SnapshotJson { get; set; }

        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? ActionTime { get; set; }
    }
}
