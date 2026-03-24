using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "台账管理",TableName = "EHS_SafetyLedger",DBServer = "ServiceDbContext")]
    public partial class EHS_SafetyLedger:ServiceEntity
    {
       /// <summary>
       ///台账ID
       /// </summary>
       [Key]
       [Display(Name ="台账ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Ledger_Id { get; set; }

       /// <summary>
       ///台账类型
       /// </summary>
       [Display(Name ="台账类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string LedgerType { get; set; }

       /// <summary>
       ///台账编号
       /// </summary>
       [Display(Name ="台账编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string LedgerNo { get; set; }

       /// <summary>
       ///台账标题
       /// </summary>
       [Display(Name ="台账标题")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///详细内容
       /// </summary>
       [Display(Name ="详细内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Content { get; set; }

       /// <summary>
       ///金额
       /// </summary>
       [Display(Name ="金额")]
       [Column(TypeName="decimal(18,2)")]
       [Editable(true)]
       public decimal? Amount { get; set; }

       /// <summary>
       ///所属部门ID
       /// </summary>
       [Display(Name ="所属部门ID")]
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
       ///发生日期
       /// </summary>
       [Display(Name ="发生日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? OccurDate { get; set; }

       /// <summary>
       ///状态
       /// </summary>
       [Display(Name ="状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Status { get; set; }

       /// <summary>
       ///附件路径
       /// </summary>
       [Display(Name ="附件路径")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string AttachmentUrl { get; set; }

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
