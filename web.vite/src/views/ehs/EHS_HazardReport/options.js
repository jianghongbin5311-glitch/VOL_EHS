export default function(){
    const table = {
        key: 'Hazard_Id',
        footer: "Foots",
        cnName: '隐患上报',
        name: 'EHS_HazardReport',
        newTabEdit: false,
        url: "/EHS_HazardReport/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"HazardNo":"","Inspection_Id":"","HazardLevel":"","HazardType":"","Title":"","Description":"","Location":"","DeptId":"","DeptName":"","DiscoveryDate":"","ReporterId":"","ReporterName":"","Status":"","RectifyPersonName":"","RectifyDeadline":""};
    const editFormOptions = [[{"title":"隐患编号","field":"HazardNo"},{"title":"关联排查任务","field":"Inspection_Id","type":"number"}],[{"title":"隐患等级","field":"HazardLevel","required":true},{"title":"隐患类别","field":"HazardType"}],[{"title":"隐患描述","field":"Title","required":true},{"title":"详细描述","field":"Description","type":"textarea"}],[{"title":"发现位置","field":"Location"},{"title":"责任部门ID","field":"DeptId","type":"number"}],[{"title":"责任部门","field":"DeptName"},{"title":"发现日期","field":"DiscoveryDate","type":"datetime"}],[{"title":"上报人ID","field":"ReporterId","type":"number"},{"title":"上报人","field":"ReporterName"}],[{"title":"状态","field":"Status","type":"number"},{"title":"整改责任人","field":"RectifyPersonName"}],[{"title":"整改期限","field":"RectifyDeadline","type":"datetime"}]];
    const searchFormFields = {"HazardNo":"","HazardLevel":"","HazardType":"","Title":"","Description":""};
    const searchFormOptions = [[{"title":"隐患编号","field":"HazardNo","type":"like"},{"title":"隐患等级","field":"HazardLevel","type":"like"},{"title":"隐患类别","field":"HazardType","type":"like"},{"title":"隐患描述","field":"Title","type":"like"},{"title":"详细描述","field":"Description","type":"like"}]];
    const columns = [{field:'Hazard_Id',title:'隐患ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'HazardNo',title:'隐患编号',type:'string',width:120,align:'left'},
                       {field:'Inspection_Id',title:'关联排查任务',type:'int',width:80,align:'left'},
                       {field:'HazardLevel',title:'隐患等级',type:'string',width:120,require:true,align:'left'},
                       {field:'HazardType',title:'隐患类别',type:'string',width:120,align:'left'},
                       {field:'Title',title:'隐患描述',type:'string',width:150,require:true,align:'left'},
                       {field:'Description',title:'详细描述',type:'string',width:120,align:'left'},
                       {field:'Location',title:'发现位置',type:'string',width:150,align:'left'},
                       {field:'DeptId',title:'责任部门ID',type:'int',width:80,align:'left'},
                       {field:'DeptName',title:'责任部门',type:'string',width:120,align:'left'},
                       {field:'DiscoveryDate',title:'发现日期',type:'date',width:110,align:'left'},
                       {field:'ReporterId',title:'上报人ID',type:'int',width:80,align:'left'},
                       {field:'ReporterName',title:'上报人',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'RectifyPersonName',title:'整改责任人',type:'string',width:120,align:'left'},
                       {field:'RectifyDeadline',title:'整改期限',type:'date',width:110,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'},
                       {field:'ModifyDate',title:'修改时间',type:'date',width:110,hidden:true,align:'left'},
                       {field:'Modifier',title:'修改人',type:'string',width:120,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
