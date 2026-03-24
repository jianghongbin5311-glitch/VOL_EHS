export default function(){
    const table = {
        key: 'Supplier_Id',
        footer: "Foots",
        cnName: '供应商列表',
        name: 'EHS_Supplier',
        newTabEdit: false,
        url: "/EHS_Supplier/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"SupplierName":"","SupplierType":"","ContactPerson":"","ContactPhone":"","Address":"","Level":"","EvaluationScore":"","ContractStartDate":"","ContractEndDate":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"供应商名称","field":"SupplierName","required":true},{"title":"供应商类型","field":"SupplierType"}],[{"title":"联系人","field":"ContactPerson"},{"title":"联系电话","field":"ContactPhone"}],[{"title":"地址","field":"Address"},{"title":"等级","field":"Level"}],[{"title":"评估分数","field":"EvaluationScore","type":"decimal"},{"title":"合同开始","field":"ContractStartDate","type":"datetime"}],[{"title":"合同结束","field":"ContractEndDate","type":"datetime"},{"title":"状态","field":"Status","type":"number"}],[{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"SupplierName":"","SupplierType":"","ContactPerson":"","ContactPhone":"","Address":""};
    const searchFormOptions = [[{"title":"供应商名称","field":"SupplierName","type":"like"},{"title":"供应商类型","field":"SupplierType","type":"like"},{"title":"联系人","field":"ContactPerson","type":"like"},{"title":"联系电话","field":"ContactPhone","type":"like"},{"title":"地址","field":"Address","type":"like"}]];
    const columns = [{field:'Supplier_Id',title:'供应商ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'SupplierName',title:'供应商名称',type:'string',width:150,require:true,align:'left'},
                       {field:'SupplierType',title:'供应商类型',type:'string',width:120,align:'left'},
                       {field:'ContactPerson',title:'联系人',type:'string',width:120,align:'left'},
                       {field:'ContactPhone',title:'联系电话',type:'string',width:120,align:'left'},
                       {field:'Address',title:'地址',type:'string',width:150,align:'left'},
                       {field:'Level',title:'等级',type:'string',width:120,align:'left'},
                       {field:'EvaluationScore',title:'评估分数',type:'decimal',width:100,align:'left'},
                       {field:'ContractStartDate',title:'合同开始',type:'date',width:110,align:'left'},
                       {field:'ContractEndDate',title:'合同结束',type:'date',width:110,align:'left'},
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
