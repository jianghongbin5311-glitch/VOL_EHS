export default function(){
    const table = {
        key: 'Project_Id',
        footer: "Foots",
        cnName: '施工项目',
        name: 'EHS_ConstructionProject',
        newTabEdit: false,
        url: "/EHS_ConstructionProject/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ProjectNo":"","ProjectName":"","SupplierName":"","ProjectManager":"","Location":"","PlanStartDate":"","PlanEndDate":"","RiskLevel":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"项目编号","field":"ProjectNo"},{"title":"项目名称","field":"ProjectName","required":true}],[{"title":"供应商","field":"SupplierName"},{"title":"项目经理","field":"ProjectManager"}],[{"title":"施工地点","field":"Location"},{"title":"计划开始","field":"PlanStartDate","type":"datetime"}],[{"title":"计划结束","field":"PlanEndDate","type":"datetime"},{"title":"风险等级","field":"RiskLevel"}],[{"title":"状态","field":"Status","type":"number"},{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"ProjectNo":"","ProjectName":"","SupplierName":"","ProjectManager":"","Location":""};
    const searchFormOptions = [[{"title":"项目编号","field":"ProjectNo","type":"like"},{"title":"项目名称","field":"ProjectName","type":"like"},{"title":"供应商","field":"SupplierName","type":"like"},{"title":"项目经理","field":"ProjectManager","type":"like"},{"title":"施工地点","field":"Location","type":"like"}]];
    const columns = [{field:'Project_Id',title:'项目ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ProjectNo',title:'项目编号',type:'string',width:120,align:'left'},
                       {field:'ProjectName',title:'项目名称',type:'string',width:150,require:true,align:'left'},
                       {field:'SupplierName',title:'供应商',type:'string',width:150,align:'left'},
                       {field:'ProjectManager',title:'项目经理',type:'string',width:120,align:'left'},
                       {field:'Location',title:'施工地点',type:'string',width:150,align:'left'},
                       {field:'PlanStartDate',title:'计划开始',type:'date',width:110,align:'left'},
                       {field:'PlanEndDate',title:'计划结束',type:'date',width:110,align:'left'},
                       {field:'RiskLevel',title:'风险等级',type:'string',width:120,align:'left'},
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
