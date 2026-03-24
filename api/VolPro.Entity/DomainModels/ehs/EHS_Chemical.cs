using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "化学品台账",TableName = "EHS_Chemical",DBServer = "ServiceDbContext")]
    public partial class EHS_Chemical:ServiceEntity
    {
       /// <summary>
       ///化学品ID
       /// </summary>
       [Key]
       [Display(Name ="化学品ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Chemical_Id { get; set; }

       /// <summary>
       ///化学品名称
       /// </summary>
       [Display(Name ="化学品名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string ChemicalName { get; set; }

       /// <summary>
       ///英文名
       /// </summary>
       [Display(Name ="英文名")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string ChemicalNameEN { get; set; }

       /// <summary>
       ///CAS号
       /// </summary>
       [Display(Name ="CAS号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string CASNo { get; set; }

       /// <summary>
       ///分类
       /// </summary>
       [Display(Name ="分类")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string Category { get; set; }

       /// <summary>
       ///危险等级
       /// </summary>
       [Display(Name ="危险等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string DangerLevel { get; set; }

       /// <summary>
       ///供应商
       /// </summary>
       [Display(Name ="供应商")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Supplier { get; set; }

       /// <summary>
       ///库存
       /// </summary>
       [Display(Name ="库存")]
       [Column(TypeName="decimal(18,4)")]
       [Editable(true)]
       public decimal? Stock { get; set; }

       /// <summary>
       ///单位
       /// </summary>
       [Display(Name ="单位")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Unit { get; set; }

       /// <summary>
       ///最低库存
       /// </summary>
       [Display(Name ="最低库存")]
       [Column(TypeName="decimal(18,4)")]
       [Editable(true)]
       public decimal? MinStock { get; set; }

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
