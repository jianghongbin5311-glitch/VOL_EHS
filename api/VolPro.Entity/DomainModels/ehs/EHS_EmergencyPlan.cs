using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "应急预案",TableName = "EHS_EmergencyPlan",DBServer = "ServiceDbContext")]
    public partial class EHS_EmergencyPlan:ServiceEntity
    {
       /// <summary>
       ///预案ID
       /// </summary>
       [Key]
       [Display(Name ="预案ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Plan_Id { get; set; }

       /// <summary>
       ///预案类型
       /// </summary>
       [Display(Name ="预案类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string PlanType { get; set; }

       /// <summary>
       ///预案名称
       /// </summary>
       [Display(Name ="预案名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string PlanName { get; set; }

       /// <summary>
       ///预案编号
       /// </summary>
       [Display(Name ="预案编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string PlanNo { get; set; }

       /// <summary>
       ///版本
       /// </summary>
       [Display(Name ="版本")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Version { get; set; }

       /// <summary>
       ///描述
       /// </summary>
       [Display(Name ="描述")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///附件
       /// </summary>
       [Display(Name ="附件")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string AttachmentUrl { get; set; }

       /// <summary>
       ///批准日期
       /// </summary>
       [Display(Name ="批准日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ApprovalDate { get; set; }

       /// <summary>
       ///评审日期
       /// </summary>
       [Display(Name ="评审日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ReviewDate { get; set; }

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
