using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "作业过程监督",TableName = "EHS_WorkPermitMonitor",DBServer = "ServiceDbContext")]
    public partial class EHS_WorkPermitMonitor:ServiceEntity
    {
       /// <summary>
       ///监督ID
       /// </summary>
       [Key]
       [Display(Name ="监督ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Monitor_Id { get; set; }

       /// <summary>
       ///作业票ID
       /// </summary>
       [Display(Name ="作业票ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int? Permit_Id { get; set; }

       /// <summary>
       ///监督时间
       /// </summary>
       [Display(Name ="监督时间")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public DateTime? MonitorTime { get; set; }

       /// <summary>
       ///监督人
       /// </summary>
       [Display(Name ="监督人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string MonitorPersonName { get; set; }

       /// <summary>
       ///监督内容
       /// </summary>
       [Display(Name ="监督内容")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string MonitorContent { get; set; }

       /// <summary>
       ///气体分析
       /// </summary>
       [Display(Name ="气体分析")]
       [MaxLength(500)]
       [Column(TypeName="nvarchar(500)")]
       [Editable(true)]
       public string GasTestResult { get; set; }

       /// <summary>
       ///是否正常
       /// </summary>
       [Display(Name ="是否正常")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? IsNormal { get; set; }

       /// <summary>
       ///是否中止
       /// </summary>
       [Display(Name ="是否中止")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? IsStopped { get; set; }

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

    }
}
