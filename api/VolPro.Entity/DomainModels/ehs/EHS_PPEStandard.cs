using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "PPE标准",TableName = "EHS_PPEStandard",DBServer = "ServiceDbContext")]
    public partial class EHS_PPEStandard:ServiceEntity
    {
       /// <summary>
       ///PPEID
       /// </summary>
       [Key]
       [Display(Name ="PPEID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int PPE_Id { get; set; }

       /// <summary>
       ///PPE名称
       /// </summary>
       [Display(Name ="PPE名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string PPEName { get; set; }

       /// <summary>
       ///类别
       /// </summary>
       [Display(Name ="类别")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string PPEType { get; set; }

       /// <summary>
       ///规格型号
       /// </summary>
       [Display(Name ="规格型号")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Specification { get; set; }

       /// <summary>
       ///发放标准
       /// </summary>
       [Display(Name ="发放标准")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Standard { get; set; }

       /// <summary>
       ///更换周期
       /// </summary>
       [Display(Name ="更换周期")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string Frequency { get; set; }

       /// <summary>
       ///适用岗位
       /// </summary>
       [Display(Name ="适用岗位")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string ApplicablePost { get; set; }

       /// <summary>
       ///库存数量
       /// </summary>
       [Display(Name ="库存数量")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Stock { get; set; }

       /// <summary>
       ///最低库存
       /// </summary>
       [Display(Name ="最低库存")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? MinStock { get; set; }

       /// <summary>
       ///单位
       /// </summary>
       [Display(Name ="单位")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Unit { get; set; }

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
