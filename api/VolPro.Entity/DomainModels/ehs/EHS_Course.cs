using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "课程管理",TableName = "EHS_Course",DBServer = "ServiceDbContext")]
    public partial class EHS_Course:ServiceEntity
    {
       /// <summary>
       ///课程ID
       /// </summary>
       [Key]
       [Display(Name ="课程ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Course_Id { get; set; }

       /// <summary>
       ///课程编号
       /// </summary>
       [Display(Name ="课程编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string CourseNo { get; set; }

       /// <summary>
       ///课程名称
       /// </summary>
       [Display(Name ="课程名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string CourseName { get; set; }

       /// <summary>
       ///课程类型
       /// </summary>
       [Display(Name ="课程类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string CourseType { get; set; }

       /// <summary>
       ///课程描述
       /// </summary>
       [Display(Name ="课程描述")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///课时(分钟)
       /// </summary>
       [Display(Name ="课时(分钟)")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Duration { get; set; }

       /// <summary>
       ///课件路径
       /// </summary>
       [Display(Name ="课件路径")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string AttachmentUrl { get; set; }

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
