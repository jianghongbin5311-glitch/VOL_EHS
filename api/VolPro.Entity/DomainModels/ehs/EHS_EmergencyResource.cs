using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "应急资源",TableName = "EHS_EmergencyResource",DBServer = "ServiceDbContext")]
    public partial class EHS_EmergencyResource:ServiceEntity
    {
       /// <summary>
       ///资源ID
       /// </summary>
       [Key]
       [Display(Name ="资源ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Resource_Id { get; set; }

       /// <summary>
       ///资源类型
       /// </summary>
       [Display(Name ="资源类型")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string ResourceType { get; set; }

       /// <summary>
       ///资源名称
       /// </summary>
       [Display(Name ="资源名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string ResourceName { get; set; }

       /// <summary>
       ///描述
       /// </summary>
       [Display(Name ="描述")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///数量
       /// </summary>
       [Display(Name ="数量")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Quantity { get; set; }

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
       ///位置
       /// </summary>
       [Display(Name ="位置")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///有效期
       /// </summary>
       [Display(Name ="有效期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ExpiryDate { get; set; }

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
