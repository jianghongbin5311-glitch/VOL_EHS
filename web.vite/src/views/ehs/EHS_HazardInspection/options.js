export default function(){
    const table = {
        key: 'Inspection_Id',
        footer: "Foots",
        cnName: '隐患排查',
        name: 'EHS_HazardInspection',
        newTabEdit: false,
        url: "/EHS_HazardInspection/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"InspectionNo":"","InspectionType":"","Title":"","PlanDate":"","ActualDate":"","Area":"","DeptId":"","DeptName":"","InspectorId":"","InspectorName":"","Status":"","TotalItems":"","HazardCount":"","Remark":""};
    const editFormOptions = [[{"title":"检查编号","field":"InspectionNo"},{"title":"检查类型","field":"InspectionType","required":true}],[{"title":"检查标题","field":"Title","required":true},{"title":"计划检查日期","field":"PlanDate","type":"datetime"}],[{"title":"实际检查日期","field":"ActualDate","type":"datetime"},{"title":"检查区域","field":"Area"}],[{"title":"部门ID","field":"DeptId","type":"number"},{"title":"所属部门","field":"DeptName"}],[{"title":"检查人ID","field":"InspectorId","type":"number"},{"title":"检查人","field":"InspectorName"}],[{"title":"状态","field":"Status","type":"number"},{"title":"检查项数","field":"TotalItems","type":"number"}],[{"title":"发现隐患数","field":"HazardCount","type":"number"},{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"InspectionNo":"","InspectionType":"","Title":"","PlanDate":"","ActualDate":""};
    const searchFormOptions = [[{"title":"检查编号","field":"InspectionNo","type":"like"},{"title":"检查类型","field":"InspectionType","type":"like"},{"title":"检查标题","field":"Title","type":"like"},{"title":"计划检查日期","field":"PlanDate","type":"datetime"},{"title":"实际检查日期","field":"ActualDate","type":"datetime"}]];
    const columns = [{field:'Inspection_Id',title:'检查ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'InspectionNo',title:'检查编号',type:'string',width:120,align:'left'},
                       {field:'InspectionType',title:'检查类型',type:'string',width:120,require:true,align:'left'},
                       {field:'Title',title:'检查标题',type:'string',width:150,require:true,align:'left'},
                       {field:'PlanDate',title:'计划检查日期',type:'date',width:110,align:'left'},
                       {field:'ActualDate',title:'实际检查日期',type:'date',width:110,align:'left'},
                       {field:'Area',title:'检查区域',type:'string',width:120,align:'left'},
                       {field:'DeptId',title:'部门ID',type:'int',width:80,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'InspectorId',title:'检查人ID',type:'int',width:80,align:'left'},
                       {field:'InspectorName',title:'检查人',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'TotalItems',title:'检查项数',type:'int',width:80,align:'left'},
                       {field:'HazardCount',title:'发现隐患数',type:'int',width:80,align:'left'},
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
