export default function(){
    const table = {
        key: 'PPE_Id',
        footer: "Foots",
        cnName: 'PPE标准',
        name: 'EHS_PPEStandard',
        newTabEdit: false,
        url: "/EHS_PPEStandard/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"PPEName":"","PPEType":"","Specification":"","Standard":"","Frequency":"","ApplicablePost":"","Stock":"","MinStock":"","Unit":"","Status":""};
    const editFormOptions = [[{"title":"PPE名称","field":"PPEName","required":true},{"title":"类别","field":"PPEType"}],[{"title":"规格型号","field":"Specification"},{"title":"发放标准","field":"Standard"}],[{"title":"更换周期","field":"Frequency"},{"title":"适用岗位","field":"ApplicablePost"}],[{"title":"库存数量","field":"Stock","type":"number"},{"title":"最低库存","field":"MinStock","type":"number"}],[{"title":"单位","field":"Unit"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"PPEName":"","PPEType":"","Specification":"","Standard":"","Frequency":""};
    const searchFormOptions = [[{"title":"PPE名称","field":"PPEName","type":"like"},{"title":"类别","field":"PPEType","type":"like"},{"title":"规格型号","field":"Specification","type":"like"},{"title":"发放标准","field":"Standard","type":"like"},{"title":"更换周期","field":"Frequency","type":"like"}]];
    const columns = [{field:'PPE_Id',title:'PPEID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'PPEName',title:'PPE名称',type:'string',width:150,require:true,align:'left'},
                       {field:'PPEType',title:'类别',type:'string',width:120,align:'left'},
                       {field:'Specification',title:'规格型号',type:'string',width:150,align:'left'},
                       {field:'Standard',title:'发放标准',type:'string',width:150,align:'left'},
                       {field:'Frequency',title:'更换周期',type:'string',width:120,align:'left'},
                       {field:'ApplicablePost',title:'适用岗位',type:'string',width:150,align:'left'},
                       {field:'Stock',title:'库存数量',type:'int',width:80,align:'left'},
                       {field:'MinStock',title:'最低库存',type:'int',width:80,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
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
