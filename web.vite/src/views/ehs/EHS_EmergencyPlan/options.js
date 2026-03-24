export default function(){
    const table = {
        key: 'Plan_Id',
        footer: "Foots",
        cnName: '应急预案',
        name: 'EHS_EmergencyPlan',
        newTabEdit: false,
        url: "/EHS_EmergencyPlan/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"PlanType":"","PlanName":"","PlanNo":"","Version":"","Description":"","AttachmentUrl":"","ApprovalDate":"","ReviewDate":"","Status":""};
    const editFormOptions = [[{"title":"预案类型","field":"PlanType","required":true},{"title":"预案名称","field":"PlanName","required":true}],[{"title":"预案编号","field":"PlanNo"},{"title":"版本","field":"Version"}],[{"title":"描述","field":"Description","type":"textarea"},{"title":"附件","field":"AttachmentUrl"}],[{"title":"批准日期","field":"ApprovalDate","type":"datetime"},{"title":"评审日期","field":"ReviewDate","type":"datetime"}],[{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"PlanType":"","PlanName":"","PlanNo":"","Version":"","Description":""};
    const searchFormOptions = [[{"title":"预案类型","field":"PlanType","type":"like"},{"title":"预案名称","field":"PlanName","type":"like"},{"title":"预案编号","field":"PlanNo","type":"like"},{"title":"版本","field":"Version","type":"like"},{"title":"描述","field":"Description","type":"like"}]];
    const columns = [{field:'Plan_Id',title:'预案ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'PlanType',title:'预案类型',type:'string',width:120,require:true,align:'left'},
                       {field:'PlanName',title:'预案名称',type:'string',width:150,require:true,align:'left'},
                       {field:'PlanNo',title:'预案编号',type:'string',width:120,align:'left'},
                       {field:'Version',title:'版本',type:'string',width:120,align:'left'},
                       {field:'Description',title:'描述',type:'string',width:120,align:'left'},
                       {field:'AttachmentUrl',title:'附件',type:'string',width:150,align:'left'},
                       {field:'ApprovalDate',title:'批准日期',type:'date',width:110,align:'left'},
                       {field:'ReviewDate',title:'评审日期',type:'date',width:110,align:'left'},
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
