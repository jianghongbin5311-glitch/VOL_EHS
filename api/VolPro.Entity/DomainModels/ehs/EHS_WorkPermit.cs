using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "特殊作业票",TableName = "EHS_WorkPermit",DBServer = "ServiceDbContext")]
    public partial class EHS_WorkPermit:ServiceEntity
    {
       /// <summary>
       ///作业票ID
       /// </summary>
       [Key]
       [Display(Name ="作业票ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Permit_Id { get; set; }

       /// <summary>
       ///作业票编号
       /// </summary>
       [Display(Name ="作业票编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string PermitNo { get; set; }

       /// <summary>
       ///作业类型
       /// </summary>
       [Display(Name ="作业类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string PermitType { get; set; }

       /// <summary>
       ///作业名称
       /// </summary>
       [Display(Name ="作业名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///作业内容
       /// </summary>
       [Display(Name ="作业内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string WorkContent { get; set; }

       /// <summary>
       ///作业地点
       /// </summary>
       [Display(Name ="作业地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string WorkLocation { get; set; }

       /// <summary>
       ///申请部门
       /// </summary>
       [Display(Name ="申请部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///申请人
       /// </summary>
       [Display(Name ="申请人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ApplicantName { get; set; }

       /// <summary>
       ///承包商
       /// </summary>
       [Display(Name ="承包商")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string ContractorName { get; set; }

       /// <summary>
       ///开始时间
       /// </summary>
       [Display(Name ="开始时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? WorkStartTime { get; set; }

       /// <summary>
       ///结束时间
       /// </summary>
       [Display(Name ="结束时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? WorkEndTime { get; set; }

       /// <summary>
       ///风险等级
       /// </summary>
       [Display(Name ="风险等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string RiskLevel { get; set; }

       /// <summary>
       ///状态
       /// </summary>
       [Display(Name ="状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Status { get; set; }

       /// <summary>
       ///备注
       /// </summary>
       [Display(Name ="备注")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Remark { get; set; }

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
