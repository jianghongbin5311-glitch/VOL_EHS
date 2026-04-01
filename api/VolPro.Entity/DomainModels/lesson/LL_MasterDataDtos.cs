using System.Collections.Generic;

namespace VolPro.Entity.DomainModels
{
    public class LL_MasterDataSearchRequest
    {
        public string DataType { get; set; }
        public string Keyword { get; set; }
        public bool? IsEnabled { get; set; }
    }

    public class LL_MasterDataSaveRequest
    {
        public int MasterData_Id { get; set; }
        public string DataType { get; set; }
        public string DataCode { get; set; }
        public string DataName { get; set; }
        public string ParentCode { get; set; }
        public string ParentName { get; set; }
        public int? Sort { get; set; }
        public bool? IsEnabled { get; set; }
        public bool? IsDefault { get; set; }
        public string Ext1 { get; set; }
        public string Ext2 { get; set; }
        public string Remark { get; set; }
    }

    public class LL_MasterDataRow
    {
        public int MasterData_Id { get; set; }
        public string DataType { get; set; }
        public string DataCode { get; set; }
        public string DataName { get; set; }
        public string ParentCode { get; set; }
        public string ParentName { get; set; }
        public int Sort { get; set; }
        public bool IsEnabled { get; set; }
        public bool IsDefault { get; set; }
        public string Ext1 { get; set; }
        public string Ext2 { get; set; }
        public string Remark { get; set; }
        public string CreateDate { get; set; }
        public string ModifyDate { get; set; }
    }

    public class LL_MasterDataBundle
    {
        public List<LL_MasterDataRow> Plants { get; set; } = new();
        public List<LL_MasterDataRow> Workshops { get; set; } = new();
        public List<LL_MasterDataRow> Lines { get; set; } = new();
        public List<LL_MasterDataRow> ProductLines { get; set; } = new();
        public List<LL_MasterDataRow> TagSuggestions { get; set; } = new();
        public List<LL_MasterDataRow> DocumentTypes { get; set; } = new();
    }
}
