using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "应急演练",TableName = "EHS_EmergencyDrill",DBServer = "ServiceDbContext")]
    public partial class EHS_EmergencyDrill:ServiceEntity
    {
       /// <summary>
       ///演练ID
       /// </summary>
       [Key]
       [Display(Name ="演练ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Drill_Id { get; set; }

       /// <summary>
       ///演练名称
       /// </summary>
       [Display(Name ="演练名称")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string DrillName { get; set; }

       /// <summary>
       ///演练日期
       /// </summary>
       [Display(Name ="演练日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? DrillDate { get; set; }

       /// <summary>
       ///演练类型
       /// </summary>
       [Display(Name ="演练类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string DrillType { get; set; }

       /// <summary>
       ///参与人数
       /// </summary>
       [Display(Name ="参与人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Participants { get; set; }

       /// <summary>
       ///地点
       /// </summary>
       [Display(Name ="地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string Location { get; set; }

       /// <summary>
       ///演练内容
       /// </summary>
       [Display(Name ="演练内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Content { get; set; }

       /// <summary>
       ///演练评估
       /// </summary>
       [Display(Name ="演练评估")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Evaluation { get; set; }

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
