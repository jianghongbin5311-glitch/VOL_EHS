using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "PPE领用记录",TableName = "EHS_PPEDistribution",DBServer = "ServiceDbContext")]
    public partial class EHS_PPEDistribution:ServiceEntity
    {
       /// <summary>
       ///领用ID
       /// </summary>
       [Key]
       [Display(Name ="领用ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Distribution_Id { get; set; }

       /// <summary>
       ///PPEID
       /// </summary>
       [Display(Name ="PPEID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int? PPE_Id { get; set; }

       /// <summary>
       ///PPE名称
       /// </summary>
       [Display(Name ="PPE名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string PPEName { get; set; }

       /// <summary>
       ///领用人
       /// </summary>
       [Display(Name ="领用人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string UserName { get; set; }

       /// <summary>
       ///所属部门
       /// </summary>
       [Display(Name ="所属部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///数量
       /// </summary>
       [Display(Name ="数量")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int? Quantity { get; set; }

       /// <summary>
       ///领用日期
       /// </summary>
       [Display(Name ="领用日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? DistributeDate { get; set; }

       /// <summary>
       ///归还日期
       /// </summary>
       [Display(Name ="归还日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ReturnDate { get; set; }

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
