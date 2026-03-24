export default function(){
    const table = {
        key: 'Permit_Id',
        footer: "Foots",
        cnName: '特殊作业票',
        name: 'EHS_WorkPermit',
        newTabEdit: false,
        url: "/EHS_WorkPermit/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"PermitNo":"","PermitType":"","Title":"","WorkContent":"","WorkLocation":"","DeptName":"","ApplicantName":"","ContractorName":"","WorkStartTime":"","WorkEndTime":"","RiskLevel":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"作业票编号","field":"PermitNo"},{"title":"作业类型","field":"PermitType","required":true}],[{"title":"作业名称","field":"Title","required":true},{"title":"作业内容","field":"WorkContent","type":"textarea"}],[{"title":"作业地点","field":"WorkLocation"},{"title":"申请部门","field":"DeptName"}],[{"title":"申请人","field":"ApplicantName"},{"title":"承包商","field":"ContractorName"}],[{"title":"开始时间","field":"WorkStartTime","type":"datetime"},{"title":"结束时间","field":"WorkEndTime","type":"datetime"}],[{"title":"风险等级","field":"RiskLevel"},{"title":"状态","field":"Status","type":"number"}],[{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"PermitNo":"","PermitType":"","Title":"","WorkContent":"","WorkLocation":""};
    const searchFormOptions = [[{"title":"作业票编号","field":"PermitNo","type":"like"},{"title":"作业类型","field":"PermitType","type":"like"},{"title":"作业名称","field":"Title","type":"like"},{"title":"作业内容","field":"WorkContent","type":"like"},{"title":"作业地点","field":"WorkLocation","type":"like"}]];
    const columns = [{field:'Permit_Id',title:'作业票ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'PermitNo',title:'作业票编号',type:'string',width:120,align:'left'},
                       {field:'PermitType',title:'作业类型',type:'string',width:120,require:true,align:'left'},
                       {field:'Title',title:'作业名称',type:'string',width:150,require:true,align:'left'},
                       {field:'WorkContent',title:'作业内容',type:'string',width:120,align:'left'},
                       {field:'WorkLocation',title:'作业地点',type:'string',width:150,align:'left'},
                       {field:'DeptName',title:'申请部门',type:'string',width:120,align:'left'},
                       {field:'ApplicantName',title:'申请人',type:'string',width:120,align:'left'},
                       {field:'ContractorName',title:'承包商',type:'string',width:150,align:'left'},
                       {field:'WorkStartTime',title:'开始时间',type:'date',width:110,align:'left'},
                       {field:'WorkEndTime',title:'结束时间',type:'date',width:110,align:'left'},
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
