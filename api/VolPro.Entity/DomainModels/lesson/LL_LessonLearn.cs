using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;

namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "Lesson Learn", TableName = "LL_LessonLearn", DBServer = "ServiceDbContext")]
    public partial class LL_LessonLearn : ServiceEntity
    {
        [Key]
        [Display(Name = "主键")]
        [Column(TypeName = "int")]
        [Editable(true)]
        [Required(AllowEmptyStrings = false)]
        public int LessonLearn_Id { get; set; }

        [Display(Name = "LL编号")]
        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string LessonNo { get; set; }

        [Display(Name = "英文标题")]
        [MaxLength(300)]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string TitleEn { get; set; }

        [Display(Name = "中文标题")]
        [MaxLength(300)]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string TitleCn { get; set; }

        [Display(Name = "LL分类")]
        [MaxLength(30)]
        [Column(TypeName = "nvarchar(30)")]
        [Editable(true)]
        public string Category { get; set; }

        [Display(Name = "LL属性")]
        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string LessonLevel { get; set; }

        [Display(Name = "产品所属平台")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ProductPlatform { get; set; }

        [Display(Name = "LL组别")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string LlGroup { get; set; }

        [Display(Name = "Issue System")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string IssueSource { get; set; }

        [Display(Name = "问题编号")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string IssueNo { get; set; }

        [Display(Name = "问题类型")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string IssueType { get; set; }

        [Display(Name = "CPI")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string CPI { get; set; }

        [Display(Name = "客户")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Customer { get; set; }

        [Display(Name = "项目")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Program { get; set; }

        [Display(Name = "零件号")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string PartNo { get; set; }

        [Display(Name = "工厂")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Plant { get; set; }

        [Display(Name = "车间")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Workshop { get; set; }

        [Display(Name = "产线")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ProductionLine { get; set; }

        [Display(Name = "Cell")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string CellName { get; set; }

        [Display(Name = "审批责任人")]
        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ApprovalOwner { get; set; }

        [Display(Name = "分类编码")]
        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string LlCategoryCode { get; set; }

        [Display(Name = "组别说明")]
        [MaxLength(300)]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string LlGroupNote { get; set; }

        [Display(Name = "版本备注")]
        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string VersionRemark { get; set; }

        [Display(Name = "PFMEA是否启用")]
        [Column(TypeName = "bit")]
        [Editable(true)]
        public bool? PfmeaEnabled { get; set; }

        [Display(Name = "PFMEA说明")]
        [Column(TypeName = "nvarchar(max)")]
        [Editable(true)]
        public string PfmeaDescription { get; set; }

        [Display(Name = "PFMEA改进前严重度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaBeforeSeverity { get; set; }

        [Display(Name = "PFMEA改进前频度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaBeforeOccurrence { get; set; }

        [Display(Name = "PFMEA改进前探测度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaBeforeDetection { get; set; }

        [Display(Name = "PFMEA改进后严重度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaAfterSeverity { get; set; }

        [Display(Name = "PFMEA改进后频度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaAfterOccurrence { get; set; }

        [Display(Name = "PFMEA改进后探测度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? PfmeaAfterDetection { get; set; }

        [Display(Name = "适用产品线文本")]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string ApplicableProductLinesText { get; set; }

        [Display(Name = "标签文本")]
        [Column(TypeName = "nvarchar(1000)")]
        [Editable(true)]
        public string TagsText { get; set; }

        [Display(Name = "标准文件类型文本")]
        [Column(TypeName = "nvarchar(300)")]
        [Editable(true)]
        public string DocumentTypesText { get; set; }

        [Display(Name = "页面状态")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Status { get; set; }

        [Display(Name = "完成进度")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Progress { get; set; }

        [Display(Name = "分析周期")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? AnalysisCycleDays { get; set; }

        [Display(Name = "浏览次数")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? ViewCount { get; set; }

        [Display(Name = "收藏次数")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? FavoriteCount { get; set; }

        [Display(Name = "点赞次数")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? LikeCount { get; set; }

        [Display(Name = "当前版本")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? VersionNo { get; set; }

        [Display(Name = "是否锁定")]
        [Column(TypeName = "bit")]
        [Editable(true)]
        public bool? IsLocked { get; set; }

        [Display(Name = "提交时间")]
        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? SubmittedDate { get; set; }

        [Display(Name = "发布时间")]
        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? PublishedDate { get; set; }

        [Display(Name = "创建时间")]
        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? CreateDate { get; set; }

        [Display(Name = "创建人")]
        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Creator { get; set; }

        [Display(Name = "创建人ID")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? CreateID { get; set; }

        [Display(Name = "修改时间")]
        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? ModifyDate { get; set; }

        [Display(Name = "修改人")]
        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Modifier { get; set; }

        [Display(Name = "修改人ID")]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int? ModifyID { get; set; }
    }
}
