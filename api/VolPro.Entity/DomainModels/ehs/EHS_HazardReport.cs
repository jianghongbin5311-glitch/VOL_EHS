using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "隐患上报",TableName = "EHS_HazardReport",DBServer = "ServiceDbContext")]
    public partial class EHS_HazardReport:ServiceEntity
    {
       /// <summary>
       ///隐患ID
       /// </summary>
       [Key]
       [Display(Name ="隐患ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Hazard_Id { get; set; }

       /// <summary>
       ///隐患编号
       /// </summary>
       [Display(Name ="隐患编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string HazardNo { get; set; }

       /// <summary>
       ///关联排查任务
       /// </summary>
       [Display(Name ="关联排查任务")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Inspection_Id { get; set; }

       /// <summary>
       ///隐患等级
       /// </summary>
       [Display(Name ="隐患等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string HazardLevel { get; set; }

       /// <summary>
       ///隐患类别
       /// </summary>
       [Display(Name ="隐患类别")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string HazardType { get; set; }

       /// <summary>
       ///隐患描述
       /// </summary>
       [Display(Name ="隐患描述")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///详细描述
       /// </summary>
       [Display(Name ="详细描述")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///发现位置
       /// </summary>
       [Display(Name ="发现位置")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///责任部门ID
       /// </summary>
       [Display(Name ="责任部门ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? DeptId { get; set; }

       /// <summary>
       ///责任部门
       /// </summary>
       [Display(Name ="责任部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///发现日期
       /// </summary>
       [Display(Name ="发现日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? DiscoveryDate { get; set; }

       /// <summary>
       ///上报人ID
       /// </summary>
       [Display(Name ="上报人ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? ReporterId { get; set; }

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
       ///整改责任人
       /// </summary>
       [Display(Name ="整改责任人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string RectifyPersonName { get; set; }

       /// <summary>
       ///整改期限
       /// </summary>
       [Display(Name ="整改期限")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? RectifyDeadline { get; set; }

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
