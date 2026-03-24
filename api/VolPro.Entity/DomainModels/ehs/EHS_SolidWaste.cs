using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "固废管理",TableName = "EHS_SolidWaste",DBServer = "ServiceDbContext")]
    public partial class EHS_SolidWaste:ServiceEntity
    {
       /// <summary>
       ///固废ID
       /// </summary>
       [Key]
       [Display(Name ="固废ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int SW_Id { get; set; }

       /// <summary>
       ///固废种类
       /// </summary>
       [Display(Name ="固废种类")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string WasteType { get; set; }

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
       ///月份
       /// </summary>
       [Display(Name ="月份")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Period { get; set; }

       /// <summary>
       ///所属部门
       /// </summary>
       [Display(Name ="所属部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

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
