export default function(){
    const table = {
        key: 'SW_Id',
        footer: "Foots",
        cnName: '固废管理',
        name: 'EHS_SolidWaste',
        newTabEdit: false,
        url: "/EHS_SolidWaste/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"WasteType":"","Quantity":"","Unit":"","Period":"","DeptName":"","DisposalMethod":"","DisposalVendor":"","DisposalDate":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"固废种类","field":"WasteType","required":true},{"title":"数量","field":"Quantity","type":"decimal"}],[{"title":"单位","field":"Unit"},{"title":"月份","field":"Period"}],[{"title":"所属部门","field":"DeptName"},{"title":"处置方式","field":"DisposalMethod"}],[{"title":"处置单位","field":"DisposalVendor"},{"title":"处置日期","field":"DisposalDate","type":"datetime"}],[{"title":"状态","field":"Status","type":"number"},{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"WasteType":"","Quantity":"","Unit":"","Period":"","DeptName":""};
    const searchFormOptions = [[{"title":"固废种类","field":"WasteType","type":"like"},{"title":"数量","field":"Quantity"},{"title":"单位","field":"Unit","type":"like"},{"title":"月份","field":"Period","type":"like"},{"title":"所属部门","field":"DeptName","type":"like"}]];
    const columns = [{field:'SW_Id',title:'固废ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'WasteType',title:'固废种类',type:'string',width:120,require:true,align:'left'},
                       {field:'Quantity',title:'数量',type:'decimal',width:100,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
                       {field:'Period',title:'月份',type:'string',width:120,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'DisposalMethod',title:'处置方式',type:'string',width:120,align:'left'},
                       {field:'DisposalVendor',title:'处置单位',type:'string',width:150,align:'left'},
                       {field:'DisposalDate',title:'处置日期',type:'date',width:110,align:'left'},
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
