using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "培训计划",TableName = "EHS_TrainingPlan",DBServer = "ServiceDbContext")]
    public partial class EHS_TrainingPlan:ServiceEntity
    {
       /// <summary>
       ///计划ID
       /// </summary>
       [Key]
       [Display(Name ="计划ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Plan_Id { get; set; }

       /// <summary>
       ///计划编号
       /// </summary>
       [Display(Name ="计划编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string PlanNo { get; set; }

       /// <summary>
       ///计划名称
       /// </summary>
       [Display(Name ="计划名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string PlanName { get; set; }

       /// <summary>
       ///培训类型
       /// </summary>
       [Display(Name ="培训类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string TrainingType { get; set; }

       /// <summary>
       ///开始日期
       /// </summary>
       [Display(Name ="开始日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? PlanStartDate { get; set; }

       /// <summary>
       ///结束日期
       /// </summary>
       [Display(Name ="结束日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? PlanEndDate { get; set; }

       /// <summary>
       ///培训方式
       /// </summary>
       [Display(Name ="培训方式")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string TrainingMode { get; set; }

       /// <summary>
       ///培训地点
       /// </summary>
       [Display(Name ="培训地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///讲师
       /// </summary>
       [Display(Name ="讲师")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string TrainerName { get; set; }

       /// <summary>
       ///目标部门
       /// </summary>
       [Display(Name ="目标部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string TargetDeptName { get; set; }

       /// <summary>
       ///目标人数
       /// </summary>
       [Display(Name ="目标人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? TargetCount { get; set; }

       /// <summary>
       ///实际人数
       /// </summary>
       [Display(Name ="实际人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? ActualCount { get; set; }

       /// <summary>
       ///通过人数
       /// </summary>
       [Display(Name ="通过人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? PassCount { get; set; }

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
