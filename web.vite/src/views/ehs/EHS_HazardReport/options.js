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
    const editFormOptions = [
        [{"title":"隐患编号","field":"HazardNo"},{"title":"关联排查任务","field":"Inspection_Id","type":"number"}],
        [{"title":"隐患等级","field":"HazardLevel","required":true,"type":"select","data":[{"key":"低风险","value":"低风险"},{"key":"一般风险","value":"一般风险"},{"key":"较大风险","value":"较大风险"},{"key":"重大隐患","value":"重大隐患"},{"key":"特别重大隐患","value":"特别重大隐患"}]},{"title":"隐患类别","field":"HazardType","type":"select","data":[{"key":"机械安全","value":"机械安全"},{"key":"电气安全","value":"电气安全"},{"key":"消防安全","value":"消防安全"},{"key":"化学品","value":"化学品"},{"key":"高处作业","value":"高处作业"},{"key":"密闭空间","value":"密闭空间"},{"key":"人因工程","value":"人因工程"},{"key":"环境保护","value":"环境保护"},{"key":"其他","value":"其他"}]}],
        [{"title":"隐患描述","field":"Title","required":true,"colSize":12}],
        [{"title":"详细描述","field":"Description","type":"textarea","colSize":12}],
        [{"title":"发现位置","field":"Location"},{"title":"发现日期","field":"DiscoveryDate","type":"datetime"}],
        [{"title":"责任部门","field":"DeptName"},{"title":"上报人","field":"ReporterName"}],
        [{"title":"整改责任人","field":"RectifyPersonName"},{"title":"整改期限","field":"RectifyDeadline","type":"datetime"}],
        [{"title":"状态","field":"Status","type":"select","data":[{"key":"0","value":"待整改"},{"key":"1","value":"整改中"},{"key":"2","value":"待验收"},{"key":"3","value":"已关闭"}]}]
    ];
    const searchFormFields = {"HazardNo":"","HazardLevel":"","HazardType":"","Title":"","DiscoveryDate":""};
    const searchFormOptions = [[{"title":"隐患编号","field":"HazardNo","type":"like"},{"title":"隐患等级","field":"HazardLevel","type":"select","data":[{"key":"低风险","value":"低风险"},{"key":"一般风险","value":"一般风险"},{"key":"较大风险","value":"较大风险"},{"key":"重大隐患","value":"重大隐患"},{"key":"特别重大隐患","value":"特别重大隐患"}]},{"title":"隐患类别","field":"HazardType","type":"select","data":[{"key":"机械安全","value":"机械安全"},{"key":"电气安全","value":"电气安全"},{"key":"消防安全","value":"消防安全"},{"key":"化学品","value":"化学品"},{"key":"高处作业","value":"高处作业"},{"key":"密闭空间","value":"密闭空间"},{"key":"环境保护","value":"环境保护"},{"key":"其他","value":"其他"}]},{"title":"隐患描述","field":"Title","type":"like"},{"title":"发现日期","field":"DiscoveryDate","type":"datetime"}]];
    const columns = [{field:'Hazard_Id',title:'隐患ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'HazardNo',title:'隐患编号',type:'string',width:120,align:'left'},
                       {field:'HazardLevel',title:'隐患等级',type:'string',width:110,require:true,align:'center',bind:{key:"低风险",data:[{"key":"低风险","value":"低风险"},{"key":"一般风险","value":"一般风险"},{"key":"较大风险","value":"较大风险"},{"key":"重大隐患","value":"重大隐患"},{"key":"特别重大隐患","value":"特别重大隐患"}]}},
                       {field:'HazardType',title:'隐患类别',type:'string',width:100,align:'center'},
                       {field:'Title',title:'隐患描述',type:'string',width:200,require:true,align:'left'},
                       {field:'Location',title:'发现位置',type:'string',width:130,align:'left'},
                       {field:'DeptName',title:'责任部门',type:'string',width:100,align:'left'},
                       {field:'DiscoveryDate',title:'发现日期',type:'date',width:110,align:'left'},
                       {field:'ReporterName',title:'上报人',type:'string',width:80,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'center',bind:{key:"0",data:[{"key":"0","value":"待整改"},{"key":"1","value":"整改中"},{"key":"2","value":"待验收"},{"key":"3","value":"已关闭"}]}},
                       {field:'RectifyPersonName',title:'整改责任人',type:'string',width:100,align:'left'},
                       {field:'RectifyDeadline',title:'整改期限',type:'date',width:110,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'datetime',width:150,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:80,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
