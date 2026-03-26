export default function(){
    const table = {
        key: 'Accident_Id',
        footer: "Foots",
        cnName: '事故管理',
        name: 'EHS_Accident',
        newTabEdit: false,
        url: "/EHS_Accident/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"AccidentNo":"","AccidentType":"","AccidentLevel":"","Title":"","OccurDate":"","OccurLocation":"","DeptName":"","Description":"","Injuries":"","Fatalities":"","EconomicLoss":"","ReporterName":"","Status":""};
    const editFormOptions = [
        [{"title":"事故编号","field":"AccidentNo"},{"title":"事故标题","field":"Title","required":true,"colSize":8}],
        [{"title":"事故类型","field":"AccidentType","required":true,"type":"select","data":[{"key":"工伤","value":"工伤"},{"key":"设备","value":"设备"},{"key":"火灾","value":"火灾"},{"key":"化学品","value":"化学品"},{"key":"触电","value":"触电"},{"key":"高处坠落","value":"高处坠落"},{"key":"机械伤害","value":"机械伤害"},{"key":"环境","value":"环境"},{"key":"其他","value":"其他"}]},{"title":"事故等级","field":"AccidentLevel","type":"select","data":[{"key":"未遂事件","value":"未遂事件"},{"key":"一般","value":"一般"},{"key":"较大","value":"较大"},{"key":"重大","value":"重大"},{"key":"特别重大","value":"特别重大"}]},{"title":"所属部门","field":"DeptName"}],
        [{"title":"发生日期","field":"OccurDate","type":"datetime"},{"title":"发生地点","field":"OccurLocation"},{"title":"上报人","field":"ReporterName"}],
        [{"title":"受伤人数","field":"Injuries","type":"number"},{"title":"死亡人数","field":"Fatalities","type":"number"},{"title":"经济损失(元)","field":"EconomicLoss","type":"decimal"}],
        [{"title":"事故经过","field":"Description","type":"textarea","colSize":12}],
        [{"title":"状态","field":"Status","type":"select","data":[{"key":"0","value":"待处理"},{"key":"1","value":"处理中"},{"key":"2","value":"已关闭"}]}]
    ];
    const searchFormFields = {"AccidentNo":"","AccidentType":"","AccidentLevel":"","Title":"","OccurDate":""};
    const searchFormOptions = [[{"title":"事故编号","field":"AccidentNo","type":"like"},{"title":"事故类型","field":"AccidentType","type":"select","data":[{"key":"工伤","value":"工伤"},{"key":"设备","value":"设备"},{"key":"火灾","value":"火灾"},{"key":"化学品","value":"化学品"},{"key":"触电","value":"触电"},{"key":"高处坠落","value":"高处坠落"},{"key":"机械伤害","value":"机械伤害"},{"key":"环境","value":"环境"},{"key":"其他","value":"其他"}]},{"title":"事故等级","field":"AccidentLevel","type":"select","data":[{"key":"未遂事件","value":"未遂事件"},{"key":"一般","value":"一般"},{"key":"较大","value":"较大"},{"key":"重大","value":"重大"},{"key":"特别重大","value":"特别重大"}]},{"title":"事故标题","field":"Title","type":"like"},{"title":"发生日期","field":"OccurDate","type":"datetime"}]];
    const columns = [{field:'Accident_Id',title:'事故ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'AccidentNo',title:'事故编号',type:'string',width:120,align:'left'},
                       {field:'AccidentType',title:'事故类型',type:'string',width:100,require:true,align:'center'},
                       {field:'AccidentLevel',title:'事故等级',type:'string',width:90,align:'center',bind:{key:"未遂事件",data:[{"key":"未遂事件","value":"未遂事件"},{"key":"一般","value":"一般"},{"key":"较大","value":"较大"},{"key":"重大","value":"重大"},{"key":"特别重大","value":"特别重大"}]}},
                       {field:'Title',title:'事故标题',type:'string',width:200,require:true,align:'left'},
                       {field:'OccurDate',title:'发生日期',type:'date',width:110,align:'left'},
                       {field:'OccurLocation',title:'发生地点',type:'string',width:130,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:100,align:'left'},
                       {field:'Injuries',title:'受伤人数',type:'int',width:80,align:'center'},
                       {field:'Fatalities',title:'死亡人数',type:'int',width:80,align:'center'},
                       {field:'EconomicLoss',title:'经济损失',type:'decimal',width:100,align:'right'},
                       {field:'ReporterName',title:'上报人',type:'string',width:80,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:70,align:'center',bind:{key:"0",data:[{"key":"0","value":"待处理"},{"key":"1","value":"处理中"},{"key":"2","value":"已关闭"}]}},
                       {field:'CreateDate',title:'创建时间',type:'datetime',width:150,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:80,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
