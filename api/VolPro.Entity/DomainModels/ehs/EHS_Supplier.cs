using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "供应商列表",TableName = "EHS_Supplier",DBServer = "ServiceDbContext")]
    public partial class EHS_Supplier:ServiceEntity
    {
       /// <summary>
       ///供应商ID
       /// </summary>
       [Key]
       [Display(Name ="供应商ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Supplier_Id { get; set; }

       /// <summary>
       ///供应商名称
       /// </summary>
       [Display(Name ="供应商名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string SupplierName { get; set; }

       /// <summary>
       ///供应商类型
       /// </summary>
       [Display(Name ="供应商类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string SupplierType { get; set; }

       /// <summary>
       ///联系人
       /// </summary>
       [Display(Name ="联系人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ContactPerson { get; set; }

       /// <summary>
       ///联系电话
       /// </summary>
       [Display(Name ="联系电话")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ContactPhone { get; set; }

       /// <summary>
       ///地址
       /// </summary>
       [Display(Name ="地址")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string Address { get; set; }

       /// <summary>
       ///等级
       /// </summary>
       [Display(Name ="等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Level { get; set; }

       /// <summary>
       ///评估分数
       /// </summary>
       [Display(Name ="评估分数")]
       [Column(TypeName="decimal(18,2)")]
       [Editable(true)]
       public decimal? EvaluationScore { get; set; }

       /// <summary>
       ///合同开始
       /// </summary>
       [Display(Name ="合同开始")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ContractStartDate { get; set; }

       /// <summary>
       ///合同结束
       /// </summary>
       [Display(Name ="合同结束")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ContractEndDate { get; set; }

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
