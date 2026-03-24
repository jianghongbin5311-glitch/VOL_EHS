using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "会议签到",TableName = "EHS_MeetingSignIn",DBServer = "ServiceDbContext")]
    public partial class EHS_MeetingSignIn:ServiceEntity
    {
       /// <summary>
       ///签到ID
       /// </summary>
       [Key]
       [Display(Name ="签到ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int SignIn_Id { get; set; }

       /// <summary>
       ///会议ID
       /// </summary>
       [Display(Name ="会议ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int? Meeting_Id { get; set; }

       /// <summary>
       ///姓名
       /// </summary>
       [Display(Name ="姓名")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string UserName { get; set; }

       /// <summary>
       ///部门
       /// </summary>
       [Display(Name ="部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///签到时间
       /// </summary>
       [Display(Name ="签到时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? SignInTime { get; set; }

       /// <summary>
       ///签到方式
       /// </summary>
       [Display(Name ="签到方式")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string SignInType { get; set; }

       /// <summary>
       ///状态
       /// </summary>
       [Display(Name ="状态")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Status { get; set; }

    }
}
