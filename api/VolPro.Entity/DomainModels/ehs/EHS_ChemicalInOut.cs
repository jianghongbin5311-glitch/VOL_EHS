using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "出入库记录",TableName = "EHS_ChemicalInOut",DBServer = "ServiceDbContext")]
    public partial class EHS_ChemicalInOut:ServiceEntity
    {
       /// <summary>
       ///记录ID
       /// </summary>
       [Key]
       [Display(Name ="记录ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int InOut_Id { get; set; }

       /// <summary>
       ///化学品名称
       /// </summary>
       [Display(Name ="化学品名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string ChemicalName { get; set; }

       /// <summary>
       ///出入库类型
       /// </summary>
       [Display(Name ="出入库类型")]
       [MaxLength(10)]
       [Column(TypeName="nvarchar(10)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string InOutType { get; set; }

       /// <summary>
       ///数量
       /// </summary>
       [Display(Name ="数量")]
       [Column(TypeName="decimal(18,4)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
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
       ///操作人
       /// </summary>
       [Display(Name ="操作人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string OperatorName { get; set; }

       /// <summary>
       ///原因
       /// </summary>
       [Display(Name ="原因")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Reason { get; set; }

       /// <summary>
       ///批次号
       /// </summary>
       [Display(Name ="批次号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string BatchNo { get; set; }

       /// <summary>
       ///出入库日期
       /// </summary>
       [Display(Name ="出入库日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? InOutDate { get; set; }

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

    }
}
