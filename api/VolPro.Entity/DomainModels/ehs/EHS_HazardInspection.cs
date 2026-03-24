using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "隐患排查",TableName = "EHS_HazardInspection",DBServer = "ServiceDbContext")]
    public partial class EHS_HazardInspection:ServiceEntity
    {
       /// <summary>
       ///检查ID
       /// </summary>
       [Key]
       [Display(Name ="检查ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Inspection_Id { get; set; }

       /// <summary>
       ///检查编号
       /// </summary>
       [Display(Name ="检查编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string InspectionNo { get; set; }

       /// <summary>
       ///检查类型
       /// </summary>
       [Display(Name ="检查类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string InspectionType { get; set; }

       /// <summary>
       ///检查标题
       /// </summary>
       [Display(Name ="检查标题")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///计划检查日期
       /// </summary>
       [Display(Name ="计划检查日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? PlanDate { get; set; }

       /// <summary>
       ///实际检查日期
       /// </summary>
       [Display(Name ="实际检查日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ActualDate { get; set; }

       /// <summary>
       ///检查区域
       /// </summary>
       [Display(Name ="检查区域")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string Area { get; set; }

       /// <summary>
       ///部门ID
       /// </summary>
       [Display(Name ="部门ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? DeptId { get; set; }

       /// <summary>
       ///所属部门
       /// </summary>
       [Display(Name ="所属部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///检查人ID
       /// </summary>
       [Display(Name ="检查人ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? InspectorId { get; set; }

       /// <summary>
       ///检查人
       /// </summary>
       [Display(Name ="检查人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string InspectorName { get; set; }

       /// <summary>
       ///状态
       /// </summary>
       [Display(Name ="状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Status { get; set; }

       /// <summary>
       ///检查项数
       /// </summary>
       [Display(Name ="检查项数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? TotalItems { get; set; }

       /// <summary>
       ///发现隐患数
       /// </summary>
       [Display(Name ="发现隐患数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? HazardCount { get; set; }

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
