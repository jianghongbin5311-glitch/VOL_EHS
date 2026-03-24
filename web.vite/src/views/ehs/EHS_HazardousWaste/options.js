export default function(){
    const table = {
        key: 'HW_Id',
        footer: "Foots",
        cnName: '危废管理',
        name: 'EHS_HazardousWaste',
        newTabEdit: false,
        url: "/EHS_HazardousWaste/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"WasteCode":"","WasteName":"","WasteCategory":"","Quantity":"","Unit":"","StorageLocation":"","GenerateDeptName":"","GenerateDate":"","DisposalMethod":"","DisposalVendor":"","DisposalDate":"","ManifestNo":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"危废代码","field":"WasteCode"},{"title":"危废名称","field":"WasteName","required":true}],[{"title":"危废类别","field":"WasteCategory"},{"title":"数量","field":"Quantity","type":"decimal"}],[{"title":"单位","field":"Unit"},{"title":"暂存位置","field":"StorageLocation"}],[{"title":"产生部门","field":"GenerateDeptName"},{"title":"产生日期","field":"GenerateDate","type":"datetime"}],[{"title":"处置方式","field":"DisposalMethod"},{"title":"处置单位","field":"DisposalVendor"}],[{"title":"处置日期","field":"DisposalDate","type":"datetime"},{"title":"转移联单号","field":"ManifestNo"}],[{"title":"状态","field":"Status","type":"number"},{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"WasteCode":"","WasteName":"","WasteCategory":"","Quantity":"","Unit":""};
    const searchFormOptions = [[{"title":"危废代码","field":"WasteCode","type":"like"},{"title":"危废名称","field":"WasteName","type":"like"},{"title":"危废类别","field":"WasteCategory","type":"like"},{"title":"数量","field":"Quantity"},{"title":"单位","field":"Unit","type":"like"}]];
    const columns = [{field:'HW_Id',title:'危废ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'WasteCode',title:'危废代码',type:'string',width:120,align:'left'},
                       {field:'WasteName',title:'危废名称',type:'string',width:150,require:true,align:'left'},
                       {field:'WasteCategory',title:'危废类别',type:'string',width:120,align:'left'},
                       {field:'Quantity',title:'数量',type:'decimal',width:100,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
                       {field:'StorageLocation',title:'暂存位置',type:'string',width:150,align:'left'},
                       {field:'GenerateDeptName',title:'产生部门',type:'string',width:120,align:'left'},
                       {field:'GenerateDate',title:'产生日期',type:'date',width:110,align:'left'},
                       {field:'DisposalMethod',title:'处置方式',type:'string',width:120,align:'left'},
                       {field:'DisposalVendor',title:'处置单位',type:'string',width:150,align:'left'},
                       {field:'DisposalDate',title:'处置日期',type:'date',width:110,align:'left'},
                       {field:'ManifestNo',title:'转移联单号',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'Remark',title:'备注',type:'string',width:150,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'},
                       {field:'ModifyDate',title:'修改时间',type:'date',width:110,hidden:true,align:'left'},
                       {field:'Modifier',title:'修改人',type:'string',width:120,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
