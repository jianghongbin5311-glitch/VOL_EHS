using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "危废管理",TableName = "EHS_HazardousWaste",DBServer = "ServiceDbContext")]
    public partial class EHS_HazardousWaste:ServiceEntity
    {
       /// <summary>
       ///危废ID
       /// </summary>
       [Key]
       [Display(Name ="危废ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int HW_Id { get; set; }

       /// <summary>
       ///危废代码
       /// </summary>
       [Display(Name ="危废代码")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string WasteCode { get; set; }

       /// <summary>
       ///危废名称
       /// </summary>
       [Display(Name ="危废名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string WasteName { get; set; }

       /// <summary>
       ///危废类别
       /// </summary>
       [Display(Name ="危废类别")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string WasteCategory { get; set; }

       /// <summary>
       ///数量
       /// </summary>
       [Display(Name ="数量")]
       [Column(TypeName="decimal(18,4)")]
       [Editable(true)]
       public decimal? Quantity { get; set; }

       /// <summary>
       ///单位
       /// </summary>
       [Display(Name ="单位")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Unit { get; set; }

       /// <summary>
       ///暂存位置
       /// </summary>
       [Display(Name ="暂存位置")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string StorageLocation { get; set; }

       /// <summary>
       ///产生部门
       /// </summary>
       [Display(Name ="产生部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string GenerateDeptName { get; set; }

       /// <summary>
       ///产生日期
       /// </summary>
       [Display(Name ="产生日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? GenerateDate { get; set; }

       /// <summary>
       ///处置方式
       /// </summary>
       [Display(Name ="处置方式")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DisposalMethod { get; set; }

       /// <summary>
       ///处置单位
       /// </summary>
       [Display(Name ="处置单位")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string DisposalVendor { get; set; }

       /// <summary>
       ///处置日期
       /// </summary>
       [Display(Name ="处置日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? DisposalDate { get; set; }

       /// <summary>
       ///转移联单号
       /// </summary>
       [Display(Name ="转移联单号")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string ManifestNo { get; set; }

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
