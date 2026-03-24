export default function(){
    const table = {
        key: 'Distribution_Id',
        footer: "Foots",
        cnName: 'PPE领用记录',
        name: 'EHS_PPEDistribution',
        newTabEdit: false,
        url: "/EHS_PPEDistribution/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"PPE_Id":"","PPEName":"","UserName":"","DeptName":"","Quantity":"","DistributeDate":"","ReturnDate":"","Status":"","Remark":""};
    const editFormOptions = [[{"title":"PPEID","field":"PPE_Id","required":true,"type":"number"},{"title":"PPE名称","field":"PPEName"}],[{"title":"领用人","field":"UserName"},{"title":"所属部门","field":"DeptName"}],[{"title":"数量","field":"Quantity","required":true,"type":"number"},{"title":"领用日期","field":"DistributeDate","type":"datetime"}],[{"title":"归还日期","field":"ReturnDate","type":"datetime"},{"title":"状态","field":"Status","type":"number"}],[{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"PPEName":"","UserName":"","DeptName":"","Quantity":"","DistributeDate":""};
    const searchFormOptions = [[{"title":"PPE名称","field":"PPEName","type":"like"},{"title":"领用人","field":"UserName","type":"like"},{"title":"所属部门","field":"DeptName","type":"like"},{"title":"数量","field":"Quantity"},{"title":"领用日期","field":"DistributeDate","type":"datetime"}]];
    const columns = [{field:'Distribution_Id',title:'领用ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'PPE_Id',title:'PPEID',type:'int',width:80,require:true,align:'left'},
                       {field:'PPEName',title:'PPE名称',type:'string',width:150,align:'left'},
                       {field:'UserName',title:'领用人',type:'string',width:120,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'Quantity',title:'数量',type:'int',width:80,require:true,align:'left'},
                       {field:'DistributeDate',title:'领用日期',type:'date',width:110,align:'left'},
                       {field:'ReturnDate',title:'归还日期',type:'date',width:110,align:'left'},
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
