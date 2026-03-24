using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "会议记录",TableName = "EHS_Meeting",DBServer = "ServiceDbContext")]
    public partial class EHS_Meeting:ServiceEntity
    {
       /// <summary>
       ///会议ID
       /// </summary>
       [Key]
       [Display(Name ="会议ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Meeting_Id { get; set; }

       /// <summary>
       ///会议名称
       /// </summary>
       [Display(Name ="会议名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string MeetingName { get; set; }

       /// <summary>
       ///会议类型
       /// </summary>
       [Display(Name ="会议类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string MeetingType { get; set; }

       /// <summary>
       ///会议日期
       /// </summary>
       [Display(Name ="会议日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? MeetingDate { get; set; }

       /// <summary>
       ///地点
       /// </summary>
       [Display(Name ="地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///组织者
       /// </summary>
       [Display(Name ="组织者")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string OrganizerName { get; set; }

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
