export default function(){
    const table = {
        key: 'Resource_Id',
        footer: "Foots",
        cnName: '应急资源',
        name: 'EHS_EmergencyResource',
        newTabEdit: false,
        url: "/EHS_EmergencyResource/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ResourceType":"","ResourceName":"","Description":"","Quantity":"","ContactPerson":"","ContactPhone":"","Location":"","ExpiryDate":"","Status":""};
    const editFormOptions = [[{"title":"资源类型","field":"ResourceType","required":true},{"title":"资源名称","field":"ResourceName","required":true}],[{"title":"描述","field":"Description","type":"textarea"},{"title":"数量","field":"Quantity","type":"number"}],[{"title":"联系人","field":"ContactPerson"},{"title":"联系电话","field":"ContactPhone"}],[{"title":"位置","field":"Location"},{"title":"有效期","field":"ExpiryDate","type":"datetime"}],[{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"ResourceType":"","ResourceName":"","Description":"","Quantity":"","ContactPerson":""};
    const searchFormOptions = [[{"title":"资源类型","field":"ResourceType","type":"like"},{"title":"资源名称","field":"ResourceName","type":"like"},{"title":"描述","field":"Description","type":"like"},{"title":"数量","field":"Quantity"},{"title":"联系人","field":"ContactPerson","type":"like"}]];
    const columns = [{field:'Resource_Id',title:'资源ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ResourceType',title:'资源类型',type:'string',width:120,require:true,align:'left'},
                       {field:'ResourceName',title:'资源名称',type:'string',width:150,require:true,align:'left'},
                       {field:'Description',title:'描述',type:'string',width:120,align:'left'},
                       {field:'Quantity',title:'数量',type:'int',width:80,align:'left'},
                       {field:'ContactPerson',title:'联系人',type:'string',width:120,align:'left'},
                       {field:'ContactPhone',title:'联系电话',type:'string',width:120,align:'left'},
                       {field:'Location',title:'位置',type:'string',width:150,align:'left'},
                       {field:'ExpiryDate',title:'有效期',type:'date',width:110,align:'left'},
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
