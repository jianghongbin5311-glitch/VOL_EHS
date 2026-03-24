export default function(){
    const table = {
        key: 'Drill_Id',
        footer: "Foots",
        cnName: '应急演练',
        name: 'EHS_EmergencyDrill',
        newTabEdit: false,
        url: "/EHS_EmergencyDrill/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"DrillName":"","DrillDate":"","DrillType":"","Participants":"","Location":"","Content":"","Evaluation":"","Status":""};
    const editFormOptions = [[{"title":"演练名称","field":"DrillName","required":true},{"title":"演练日期","field":"DrillDate","type":"datetime"}],[{"title":"演练类型","field":"DrillType"},{"title":"参与人数","field":"Participants","type":"number"}],[{"title":"地点","field":"Location"},{"title":"演练内容","field":"Content","type":"textarea"}],[{"title":"演练评估","field":"Evaluation","type":"textarea"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"DrillName":"","DrillDate":"","DrillType":"","Participants":"","Location":""};
    const searchFormOptions = [[{"title":"演练名称","field":"DrillName","type":"like"},{"title":"演练日期","field":"DrillDate","type":"datetime"},{"title":"演练类型","field":"DrillType","type":"like"},{"title":"参与人数","field":"Participants"},{"title":"地点","field":"Location","type":"like"}]];
    const columns = [{field:'Drill_Id',title:'演练ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'DrillName',title:'演练名称',type:'string',width:150,require:true,align:'left'},
                       {field:'DrillDate',title:'演练日期',type:'date',width:110,align:'left'},
                       {field:'DrillType',title:'演练类型',type:'string',width:120,align:'left'},
                       {field:'Participants',title:'参与人数',type:'int',width:80,align:'left'},
                       {field:'Location',title:'地点',type:'string',width:150,align:'left'},
                       {field:'Content',title:'演练内容',type:'string',width:120,align:'left'},
                       {field:'Evaluation',title:'演练评估',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'},
                       {field:'ModifyDate',title:'修改时间',type:'date',width:110,hidden:true,align:'left'},
                       {field:'Modifier',title:'修改人',type:'string',width:120,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
