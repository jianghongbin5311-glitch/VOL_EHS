export default function(){
    const table = {
        key: 'Plan_Id',
        footer: "Foots",
        cnName: '培训计划',
        name: 'EHS_TrainingPlan',
        newTabEdit: false,
        url: "/EHS_TrainingPlan/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"PlanNo":"","PlanName":"","TrainingType":"","PlanStartDate":"","PlanEndDate":"","TrainingMode":"","Location":"","TrainerName":"","TargetDeptName":"","TargetCount":"","ActualCount":"","PassCount":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"计划编号","field":"PlanNo"},{"title":"计划名称","field":"PlanName","required":true}],[{"title":"培训类型","field":"TrainingType"},{"title":"开始日期","field":"PlanStartDate","type":"datetime"}],[{"title":"结束日期","field":"PlanEndDate","type":"datetime"},{"title":"培训方式","field":"TrainingMode"}],[{"title":"培训地点","field":"Location"},{"title":"讲师","field":"TrainerName"}],[{"title":"目标部门","field":"TargetDeptName"},{"title":"目标人数","field":"TargetCount","type":"number"}],[{"title":"实际人数","field":"ActualCount","type":"number"},{"title":"通过人数","field":"PassCount","type":"number"}],[{"title":"状态","field":"Status","type":"number"},{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"PlanNo":"","PlanName":"","TrainingType":"","PlanStartDate":"","PlanEndDate":""};
    const searchFormOptions = [[{"title":"计划编号","field":"PlanNo","type":"like"},{"title":"计划名称","field":"PlanName","type":"like"},{"title":"培训类型","field":"TrainingType","type":"like"},{"title":"开始日期","field":"PlanStartDate","type":"datetime"},{"title":"结束日期","field":"PlanEndDate","type":"datetime"}]];
    const columns = [{field:'Plan_Id',title:'计划ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'PlanNo',title:'计划编号',type:'string',width:120,align:'left'},
                       {field:'PlanName',title:'计划名称',type:'string',width:150,require:true,align:'left'},
                       {field:'TrainingType',title:'培训类型',type:'string',width:120,align:'left'},
                       {field:'PlanStartDate',title:'开始日期',type:'date',width:110,align:'left'},
                       {field:'PlanEndDate',title:'结束日期',type:'date',width:110,align:'left'},
                       {field:'TrainingMode',title:'培训方式',type:'string',width:120,align:'left'},
                       {field:'Location',title:'培训地点',type:'string',width:150,align:'left'},
                       {field:'TrainerName',title:'讲师',type:'string',width:120,align:'left'},
                       {field:'TargetDeptName',title:'目标部门',type:'string',width:120,align:'left'},
                       {field:'TargetCount',title:'目标人数',type:'int',width:80,align:'left'},
                       {field:'ActualCount',title:'实际人数',type:'int',width:80,align:'left'},
                       {field:'PassCount',title:'通过人数',type:'int',width:80,align:'left'},
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
