export default function(){
    const table = {
        key: 'Monitor_Id',
        footer: "Foots",
        cnName: '作业过程监督',
        name: 'EHS_WorkPermitMonitor',
        newTabEdit: false,
        url: "/EHS_WorkPermitMonitor/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"Permit_Id":"","MonitorTime":"","MonitorPersonName":"","MonitorContent":"","GasTestResult":"","IsNormal":"","IsStopped":""};
    const editFormOptions = [[{"title":"作业票ID","field":"Permit_Id","required":true,"type":"number"},{"title":"监督时间","field":"MonitorTime","required":true,"type":"datetime"}],[{"title":"监督人","field":"MonitorPersonName"},{"title":"监督内容","field":"MonitorContent","type":"textarea"}],[{"title":"气体分析","field":"GasTestResult"},{"title":"是否正常","field":"IsNormal","type":"number"}],[{"title":"是否中止","field":"IsStopped","type":"number"}]];
    const searchFormFields = {"MonitorTime":"","MonitorPersonName":"","MonitorContent":"","GasTestResult":"","IsNormal":""};
    const searchFormOptions = [[{"title":"监督时间","field":"MonitorTime","type":"datetime"},{"title":"监督人","field":"MonitorPersonName","type":"like"},{"title":"监督内容","field":"MonitorContent","type":"like"},{"title":"气体分析","field":"GasTestResult","type":"like"},{"title":"是否正常","field":"IsNormal"}]];
    const columns = [{field:'Monitor_Id',title:'监督ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'Permit_Id',title:'作业票ID',type:'int',width:80,require:true,align:'left'},
                       {field:'MonitorTime',title:'监督时间',type:'date',width:110,require:true,align:'left'},
                       {field:'MonitorPersonName',title:'监督人',type:'string',width:120,align:'left'},
                       {field:'MonitorContent',title:'监督内容',type:'string',width:120,align:'left'},
                       {field:'GasTestResult',title:'气体分析',type:'string',width:150,align:'left'},
                       {field:'IsNormal',title:'是否正常',type:'int',width:80,align:'left'},
                       {field:'IsStopped',title:'是否中止',type:'int',width:80,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
