using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "程序文件",TableName = "EHS_Document",DBServer = "ServiceDbContext")]
    public partial class EHS_Document:ServiceEntity
    {
       /// <summary>
       ///文件ID
       /// </summary>
       [Key]
       [Display(Name ="文件ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Doc_Id { get; set; }

       /// <summary>
       ///文件类型
       /// </summary>
       [Display(Name ="文件类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string DocType { get; set; }

       /// <summary>
       ///文件编号
       /// </summary>
       [Display(Name ="文件编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string DocNo { get; set; }

       /// <summary>
       ///文件名称
       /// </summary>
       [Display(Name ="文件名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string DocName { get; set; }

       /// <summary>
       ///版本
       /// </summary>
       [Display(Name ="版本")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string Version { get; set; }

       /// <summary>
       ///描述
       /// </summary>
       [Display(Name ="描述")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///发布日期
       /// </summary>
       [Display(Name ="发布日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? IssueDate { get; set; }

       /// <summary>
       ///评审日期
       /// </summary>
       [Display(Name ="评审日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? ReviewDate { get; set; }

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
