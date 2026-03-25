using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "外部法规新闻",TableName = "EHS_NewsReport",DBServer = "ServiceDbContext")]
    public partial class EHS_NewsReport:ServiceEntity
    {
       /// <summary>
       ///报告ID
       /// </summary>
       [Key]
       [Display(Name ="报告ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Report_Id { get; set; }

       /// <summary>
       ///报告编号
       /// </summary>
       [Display(Name ="报告编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ReportNo { get; set; }

       /// <summary>
       ///报告类型
       /// </summary>
       [Display(Name ="报告类型")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string ReportType { get; set; }

       /// <summary>
       ///报告日期
       /// </summary>
       [Display(Name ="报告日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public DateTime ReportDate { get; set; }

       /// <summary>
       ///标题
       /// </summary>
       [Display(Name ="标题")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///内容
       /// </summary>
       [Display(Name ="内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Content { get; set; }

       /// <summary>
       ///摘要
       /// </summary>
       [Display(Name ="摘要")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Summary { get; set; }

       /// <summary>
       ///分类
       /// </summary>
       [Display(Name ="分类")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string Category { get; set; }

       /// <summary>
       ///来源
       /// </summary>
       [Display(Name ="来源")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Source { get; set; }

       /// <summary>
       ///来源链接
       /// </summary>
       [Display(Name ="来源链接")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string SourceUrl { get; set; }

       /// <summary>
       ///对工厂EHS影响
       /// </summary>
       [Display(Name ="对工厂EHS影响")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Impact { get; set; }

       /// <summary>
       ///建议动作
       /// </summary>
       [Display(Name ="建议动作")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Action { get; set; }

       /// <summary>
       ///AI模型
       /// </summary>
       [Display(Name ="AI模型")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string AiModel { get; set; }

       /// <summary>
       ///生成状态
       /// </summary>
       [Display(Name ="生成状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? GenerateStatus { get; set; }

       /// <summary>
       ///失败原因
       /// </summary>
       [Display(Name ="失败原因")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string ErrorMessage { get; set; }

       /// <summary>
       ///状态
       /// </summary>
       [Display(Name ="状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Status { get; set; }

       /// <summary>
       ///创建时间
       /// </summary>
       [Display(Name ="创建时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? CreateDate { get; set; }

       /// <summary>
       ///创建人
       /// </summary>
       [Display(Name ="创建人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string Creator { get; set; }

       /// <summary>
       ///创建人ID
       /// </summary>
       [Display(Name ="创建人ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? CreateID { get; set; }

       /// <summary>
       ///修改时间
       /// </summary>
       [Display(Name ="修改时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ModifyDate { get; set; }

       /// <summary>
       ///修改人
       /// </summary>
       [Display(Name ="修改人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string Modifier { get; set; }

    }
}
