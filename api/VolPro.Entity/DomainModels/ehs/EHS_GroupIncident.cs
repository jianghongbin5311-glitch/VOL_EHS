using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "集团内部事件",TableName = "EHS_GroupIncident",DBServer = "ServiceDbContext")]
    public partial class EHS_GroupIncident:ServiceEntity
    {
       /// <summary>
       ///事件ID
       /// </summary>
       [Key]
       [Display(Name ="事件ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Incident_Id { get; set; }

       /// <summary>
       ///事件编号
       /// </summary>
       [Display(Name ="事件编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string IncidentNo { get; set; }

       /// <summary>
       ///所属公司
       /// </summary>
       [Display(Name ="所属公司")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string CompanyName { get; set; }

       /// <summary>
       ///所属工厂
       /// </summary>
       [Display(Name ="所属工厂")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string FactoryName { get; set; }

       /// <summary>
       ///事件类型
       /// </summary>
       [Display(Name ="事件类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string IncidentType { get; set; }

       /// <summary>
       ///事件等级
       /// </summary>
       [Display(Name ="事件等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string IncidentLevel { get; set; }

       /// <summary>
       ///事件标题
       /// </summary>
       [Display(Name ="事件标题")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///发生日期
       /// </summary>
       [Display(Name ="发生日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? OccurDate { get; set; }

       /// <summary>
       ///发生地点
       /// </summary>
       [Display(Name ="发生地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string OccurLocation { get; set; }

       /// <summary>
       ///事件经过
       /// </summary>
       [Display(Name ="事件经过")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///根本原因
       /// </summary>
       [Display(Name ="根本原因")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string RootCause { get; set; }

       /// <summary>
       ///纠正措施
       /// </summary>
       [Display(Name ="纠正措施")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string CorrectiveAction { get; set; }

       /// <summary>
       ///预防措施
       /// </summary>
       [Display(Name ="预防措施")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string PreventiveAction { get; set; }

       /// <summary>
       ///受伤人数
       /// </summary>
       [Display(Name ="受伤人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Injuries { get; set; }

       /// <summary>
       ///死亡人数
       /// </summary>
       [Display(Name ="死亡人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Fatalities { get; set; }

       /// <summary>
       ///经济损失
       /// </summary>
       [Display(Name ="经济损失")]
       [Column(TypeName="decimal(18,2)")]
       [Editable(true)]
       public decimal? EconomicLoss { get; set; }

       /// <summary>
       ///现场图片
       /// </summary>
       [Display(Name ="现场图片")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string ImageUrls { get; set; }

       /// <summary>
       ///附件
       /// </summary>
       [Display(Name ="附件")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string AttachmentUrls { get; set; }

       /// <summary>
       ///参考链接
       /// </summary>
       [Display(Name ="参考链接")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string ReferenceUrl { get; set; }

       /// <summary>
       ///经验教训
       /// </summary>
       [Display(Name ="经验教训")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string LessonLearned { get; set; }

       /// <summary>
       ///是否外部事件
       /// </summary>
       [Display(Name ="是否外部事件")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? IsExternal { get; set; }

       /// <summary>
       ///来源公司
       /// </summary>
       [Display(Name ="来源公司")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string SourceCompany { get; set; }

       /// <summary>
       ///上报人
       /// </summary>
       [Display(Name ="上报人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ReporterName { get; set; }

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
