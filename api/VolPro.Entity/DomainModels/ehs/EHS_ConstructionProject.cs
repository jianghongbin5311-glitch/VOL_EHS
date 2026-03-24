using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "施工项目",TableName = "EHS_ConstructionProject",DBServer = "ServiceDbContext")]
    public partial class EHS_ConstructionProject:ServiceEntity
    {
       /// <summary>
       ///项目ID
       /// </summary>
       [Key]
       [Display(Name ="项目ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Project_Id { get; set; }

       /// <summary>
       ///项目编号
       /// </summary>
       [Display(Name ="项目编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ProjectNo { get; set; }

       /// <summary>
       ///项目名称
       /// </summary>
       [Display(Name ="项目名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string ProjectName { get; set; }

       /// <summary>
       ///供应商
       /// </summary>
       [Display(Name ="供应商")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string SupplierName { get; set; }

       /// <summary>
       ///项目经理
       /// </summary>
       [Display(Name ="项目经理")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ProjectManager { get; set; }

       /// <summary>
       ///施工地点
       /// </summary>
       [Display(Name ="施工地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///计划开始
       /// </summary>
       [Display(Name ="计划开始")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? PlanStartDate { get; set; }

       /// <summary>
       ///计划结束
       /// </summary>
       [Display(Name ="计划结束")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? PlanEndDate { get; set; }

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
