export default function(){
    const table = {
        key: 'Report_Id',
        footer: "Foots",
        cnName: '外部法规新闻',
        name: 'EHS_NewsReport',
        newTabEdit: false,
        url: "/EHS_NewsReport/",
        sortName: "ReportDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ReportType":"","Title":"","Content":"","Summary":"","Category":"","Source":"","SourceUrl":"","Impact":"","Action":""};
    const editFormOptions = [[{"title":"报告类型","field":"ReportType","required":true,"type":"select","data":[{"key":"日报","value":"日报"},{"key":"周报","value":"周报"},{"key":"月报","value":"月报"}]},{"title":"标题","field":"Title","required":true}],[{"title":"摘要","field":"Summary"},{"title":"分类","field":"Category","type":"select","data":[{"key":"事故","value":"事故"},{"key":"处罚","value":"处罚"},{"key":"法规","value":"法规"},{"key":"检查","value":"检查"},{"key":"预警","value":"预警"},{"key":"培训","value":"培训"}]}],[{"title":"来源","field":"Source"},{"title":"来源链接","field":"SourceUrl"}],[{"title":"对工厂EHS影响","field":"Impact","type":"textarea","colSize":12},{"title":"建议动作","field":"Action","type":"textarea","colSize":12}],[{"title":"内容","field":"Content","colSize":12,"type":"textarea"}]];
    const searchFormFields = {"ReportType":"","Title":"","Category":"","ReportDate":""};
    const searchFormOptions = [[{"title":"报告类型","field":"ReportType","type":"select","data":[{"key":"日报","value":"日报"},{"key":"周报","value":"周报"},{"key":"月报","value":"月报"}]},{"title":"标题","field":"Title","type":"like"},{"title":"分类","field":"Category","type":"select","data":[{"key":"事故","value":"事故"},{"key":"处罚","value":"处罚"},{"key":"法规","value":"法规"},{"key":"检查","value":"检查"},{"key":"预警","value":"预警"},{"key":"培训","value":"培训"}]},{"title":"报告日期","field":"ReportDate","type":"datetime"}]];
    const columns = [{field:'Report_Id',title:'报告ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ReportNo',title:'报告编号',type:'string',width:140,align:'left'},
                       {field:'ReportType',title:'报告类型',type:'string',width:80,align:'center'},
                       {field:'ReportDate',title:'报告日期',type:'date',width:110,align:'left'},
                       {field:'Title',title:'标题',type:'string',width:200,require:true,align:'left'},
                       {field:'Category',title:'分类',type:'string',width:80,align:'center'},
                       {field:'Source',title:'来源',type:'string',width:140,align:'left'},
                       {field:'Summary',title:'摘要',type:'string',width:200,align:'left'},
                       {field:'Impact',title:'EHS影响',type:'string',width:150,align:'left'},
                       {field:'Action',title:'建议动作',type:'string',width:150,align:'left'},
                       {field:'GenerateStatus',title:'生成状态',type:'int',width:90,align:'center'},
                       {field:'AiModel',title:'AI模型',type:'string',width:120,hidden:true,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'datetime',width:150,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:100,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
