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
    const editFormOptions = [[{"title":"事故编号","field":"AccidentNo"},{"title":"事故类型","field":"AccidentType","required":true}],[{"title":"事故等级","field":"AccidentLevel"},{"title":"事故标题","field":"Title","required":true}],[{"title":"发生日期","field":"OccurDate","type":"datetime"},{"title":"发生地点","field":"OccurLocation"}],[{"title":"所属部门","field":"DeptName"},{"title":"事故经过","field":"Description","type":"textarea"}],[{"title":"受伤人数","field":"Injuries","type":"number"},{"title":"死亡人数","field":"Fatalities","type":"number"}],[{"title":"经济损失","field":"EconomicLoss","type":"decimal"},{"title":"上报人","field":"ReporterName"}],[{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"AccidentNo":"","AccidentType":"","AccidentLevel":"","Title":"","OccurDate":""};
    const searchFormOptions = [[{"title":"事故编号","field":"AccidentNo","type":"like"},{"title":"事故类型","field":"AccidentType","type":"like"},{"title":"事故等级","field":"AccidentLevel","type":"like"},{"title":"事故标题","field":"Title","type":"like"},{"title":"发生日期","field":"OccurDate","type":"datetime"}]];
    const columns = [{field:'Accident_Id',title:'事故ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'AccidentNo',title:'事故编号',type:'string',width:120,align:'left'},
                       {field:'AccidentType',title:'事故类型',type:'string',width:120,require:true,align:'left'},
                       {field:'AccidentLevel',title:'事故等级',type:'string',width:120,align:'left'},
                       {field:'Title',title:'事故标题',type:'string',width:150,require:true,align:'left'},
                       {field:'OccurDate',title:'发生日期',type:'date',width:110,align:'left'},
                       {field:'OccurLocation',title:'发生地点',type:'string',width:150,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'Description',title:'事故经过',type:'string',width:120,align:'left'},
                       {field:'Injuries',title:'受伤人数',type:'int',width:80,align:'left'},
                       {field:'Fatalities',title:'死亡人数',type:'int',width:80,align:'left'},
                       {field:'EconomicLoss',title:'经济损失',type:'decimal',width:100,align:'left'},
                       {field:'ReporterName',title:'上报人',type:'string',width:120,align:'left'},
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
