using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "试题库",TableName = "EHS_QuestionBank",DBServer = "ServiceDbContext")]
    public partial class EHS_QuestionBank:ServiceEntity
    {
       /// <summary>
       ///试题ID
       /// </summary>
       [Key]
       [Display(Name ="试题ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Question_Id { get; set; }

       /// <summary>
       ///题型
       /// </summary>
       [Display(Name ="题型")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int? QuestionType { get; set; }

       /// <summary>
       ///分类
       /// </summary>
       [Display(Name ="分类")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string Category { get; set; }

       /// <summary>
       ///题目内容
       /// </summary>
       [Display(Name ="题目内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Content { get; set; }

       /// <summary>
       ///选项A
       /// </summary>
       [Display(Name ="选项A")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string OptionA { get; set; }

       /// <summary>
       ///选项B
       /// </summary>
       [Display(Name ="选项B")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string OptionB { get; set; }

       /// <summary>
       ///选项C
       /// </summary>
       [Display(Name ="选项C")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string OptionC { get; set; }

       /// <summary>
       ///选项D
       /// </summary>
       [Display(Name ="选项D")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string OptionD { get; set; }

       /// <summary>
       ///正确答案
       /// </summary>
       [Display(Name ="正确答案")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Answer { get; set; }

       /// <summary>
       ///分值
       /// </summary>
       [Display(Name ="分值")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Score { get; set; }

       /// <summary>
       ///难度
       /// </summary>
       [Display(Name ="难度")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Difficulty { get; set; }

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
