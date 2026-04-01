using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;

namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "Lesson Learn 主数据", TableName = "LL_MasterData", DBServer = "ServiceDbContext")]
    [Table("LL_MasterData")]
    public class LL_MasterData : ServiceEntity
    {
        [Key]
        [Column(TypeName = "int")]
        [Editable(true)]
        public int MasterData_Id { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string DataType { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string DataCode { get; set; }

        [MaxLength(200)]
        [Column(TypeName = "nvarchar(200)")]
        [Editable(true)]
        public string DataName { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string ParentCode { get; set; }

        [MaxLength(200)]
        [Column(TypeName = "nvarchar(200)")]
        [Editable(true)]
        public string ParentName { get; set; }

        [Column(TypeName = "int")]
        [Editable(true)]
        public int? Sort { get; set; }

        [Column(TypeName = "bit")]
        [Editable(true)]
        public bool? IsEnabled { get; set; }

        [Column(TypeName = "bit")]
        [Editable(true)]
        public bool? IsDefault { get; set; }

        [MaxLength(50)]
        [Column(TypeName = "nvarchar(50)")]
        [Editable(true)]
        public string Ext1 { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Ext2 { get; set; }

        [MaxLength(500)]
        [Column(TypeName = "nvarchar(500)")]
        [Editable(true)]
        public string Remark { get; set; }

        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? CreateDate { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Creator { get; set; }

        [Column(TypeName = "datetime")]
        [Editable(true)]
        public DateTime? ModifyDate { get; set; }

        [MaxLength(100)]
        [Column(TypeName = "nvarchar(100)")]
        [Editable(true)]
        public string Modifier { get; set; }
    }
}
