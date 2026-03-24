export default function(){
    const table = {
        key: 'Application_Id',
        footer: "Foots",
        cnName: '化学品申请',
        name: 'EHS_ChemicalApplication',
        newTabEdit: false,
        url: "/EHS_ChemicalApplication/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ApplicationNo":"","ChemicalName":"","Quantity":"","Unit":"","Purpose":"","ApplicantName":"","DeptName":"","Status":"","ApproverRemark":""};
    const editFormOptions = [[{"title":"申请编号","field":"ApplicationNo"},{"title":"化学品名称","field":"ChemicalName"}],[{"title":"数量","field":"Quantity","required":true,"type":"decimal"},{"title":"单位","field":"Unit"}],[{"title":"用途","field":"Purpose"},{"title":"申请人","field":"ApplicantName"}],[{"title":"所属部门","field":"DeptName"},{"title":"状态","field":"Status","type":"number"}],[{"title":"审批备注","field":"ApproverRemark"}]];
    const searchFormFields = {"ApplicationNo":"","ChemicalName":"","Quantity":"","Unit":"","Purpose":""};
    const searchFormOptions = [[{"title":"申请编号","field":"ApplicationNo","type":"like"},{"title":"化学品名称","field":"ChemicalName","type":"like"},{"title":"数量","field":"Quantity"},{"title":"单位","field":"Unit","type":"like"},{"title":"用途","field":"Purpose","type":"like"}]];
    const columns = [{field:'Application_Id',title:'申请ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ApplicationNo',title:'申请编号',type:'string',width:120,align:'left'},
                       {field:'ChemicalName',title:'化学品名称',type:'string',width:150,align:'left'},
                       {field:'Quantity',title:'数量',type:'decimal',width:100,require:true,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
                       {field:'Purpose',title:'用途',type:'string',width:150,align:'left'},
                       {field:'ApplicantName',title:'申请人',type:'string',width:120,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'ApproverRemark',title:'审批备注',type:'string',width:150,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'},
                       {field:'ModifyDate',title:'修改时间',type:'date',width:110,hidden:true,align:'left'},
                       {field:'Modifier',title:'修改人',type:'string',width:120,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
