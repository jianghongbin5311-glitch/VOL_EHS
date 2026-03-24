using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "事故管理",TableName = "EHS_Accident",DBServer = "ServiceDbContext")]
    public partial class EHS_Accident:ServiceEntity
    {
       /// <summary>
       ///事故ID
       /// </summary>
       [Key]
       [Display(Name ="事故ID")]
       [Column(TypeName="int")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public int Accident_Id { get; set; }

       /// <summary>
       ///事故编号
       /// </summary>
       [Display(Name ="事故编号")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string AccidentNo { get; set; }

       /// <summary>
       ///事故类型
       /// </summary>
       [Display(Name ="事故类型")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string AccidentType { get; set; }

       /// <summary>
       ///事故等级
       /// </summary>
       [Display(Name ="事故等级")]
       [MaxLength(20)]
       [Column(TypeName="nvarchar(20)")]
       [Editable(true)]
       public string AccidentLevel { get; set; }

       /// <summary>
       ///事故标题
       /// </summary>
       [Display(Name ="事故标题")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       [Required(AllowEmptyStrings=false)]
       public string Title { get; set; }

       /// <summary>
       ///发生日期
       /// </summary>
       [Display(Name ="发生日期")]
       [Column(TypeName="datetime")]
       [Editable(true)]
       public DateTime? OccurDate { get; set; }

       /// <summary>
       ///发生地点
       /// </summary>
       [Display(Name ="发生地点")]
       [MaxLength(200)]
       [Column(TypeName="nvarchar(200)")]
       [Editable(true)]
       public string OccurLocation { get; set; }

       /// <summary>
       ///所属部门
       /// </summary>
       [Display(Name ="所属部门")]
       [MaxLength(100)]
       [Column(TypeName="nvarchar(100)")]
       [Editable(true)]
       public string DeptName { get; set; }

       /// <summary>
       ///事故经过
       /// </summary>
       [Display(Name ="事故经过")]
       [Column(TypeName="nvarchar(max)")]
       [Editable(true)]
       public string Description { get; set; }

       /// <summary>
       ///受伤人数
       /// </summary>
       [Display(Name ="受伤人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Injuries { get; set; }

       /// <summary>
       ///死亡人数
       /// </summary>
       [Display(Name ="死亡人数")]
       [Column(TypeName="int")]
       [Editable(true)]
       public int? Fatalities { get; set; }

       /// <summary>
       ///经济损失
       /// </summary>
       [Display(Name ="经济损失")]
       [Column(TypeName="decimal(18,2)")]
       [Editable(true)]
       public decimal? EconomicLoss { get; set; }

       /// <summary>
       ///上报人
       /// </summary>
       [Display(Name ="上报人")]
       [MaxLength(50)]
       [Column(TypeName="nvarchar(50)")]
       [Editable(true)]
       public string ReporterName { get; set; }

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
