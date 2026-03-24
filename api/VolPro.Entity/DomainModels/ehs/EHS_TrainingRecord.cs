using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "培训档案",TableName = "EHS_TrainingRecord",DBServer = "ServiceDbContext")]
    public partial class EHS_TrainingRecord:ServiceEntity
    {
       /// <summary>
       ///记录ID
       /// </summary>
       [Key]
       [Display(Name ="记录ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Record_Id { get; set; }

       /// <summary>
       ///关联计划
       /// </summary>
       [Display(Name ="关联计划")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Plan_Id { get; set; }

       /// <summary>
       ///参训人
       /// </summary>
       [Display(Name ="参训人")]
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
       ///培训日期
       /// </summary>
       [Display(Name ="培训日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? TrainingDate { get; set; }

       /// <summary>
       ///考试成绩
       /// </summary>
       [Display(Name ="考试成绩")]
       [Column(TypeName="decimal(18,2)")]
       [Editable(true)]
       public decimal? ExamScore { get; set; }

       /// <summary>
       ///是否通过
       /// </summary>
       [Display(Name ="是否通过")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? IsPassed { get; set; }

       /// <summary>
       ///证书编号
       /// </summary>
       [Display(Name ="证书编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string CertificateNo { get; set; }

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
