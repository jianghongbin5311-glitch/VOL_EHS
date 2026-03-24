export default function(){
    const table = {
        key: 'InOut_Id',
        footer: "Foots",
        cnName: '出入库记录',
        name: 'EHS_ChemicalInOut',
        newTabEdit: false,
        url: "/EHS_ChemicalInOut/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ChemicalName":"","InOutType":"","Quantity":"","Unit":"","OperatorName":"","Reason":"","BatchNo":"","InOutDate":""};
    const editFormOptions = [[{"title":"化学品名称","field":"ChemicalName"},{"title":"出入库类型","field":"InOutType","required":true}],[{"title":"数量","field":"Quantity","required":true,"type":"decimal"},{"title":"单位","field":"Unit"}],[{"title":"操作人","field":"OperatorName"},{"title":"原因","field":"Reason"}],[{"title":"批次号","field":"BatchNo"},{"title":"出入库日期","field":"InOutDate","type":"datetime"}]];
    const searchFormFields = {"ChemicalName":"","InOutType":"","Quantity":"","Unit":"","OperatorName":""};
    const searchFormOptions = [[{"title":"化学品名称","field":"ChemicalName","type":"like"},{"title":"出入库类型","field":"InOutType","type":"like"},{"title":"数量","field":"Quantity"},{"title":"单位","field":"Unit","type":"like"},{"title":"操作人","field":"OperatorName","type":"like"}]];
    const columns = [{field:'InOut_Id',title:'记录ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ChemicalName',title:'化学品名称',type:'string',width:150,align:'left'},
                       {field:'InOutType',title:'出入库类型',type:'string',width:120,require:true,align:'left'},
                       {field:'Quantity',title:'数量',type:'decimal',width:100,require:true,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
                       {field:'OperatorName',title:'操作人',type:'string',width:120,align:'left'},
                       {field:'Reason',title:'原因',type:'string',width:150,align:'left'},
                       {field:'BatchNo',title:'批次号',type:'string',width:120,align:'left'},
                       {field:'InOutDate',title:'出入库日期',type:'date',width:110,align:'left'},
                       {field:'CreateDate',title:'创建时间',type:'date',width:110,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:120,align:'left'},
                       {field:'CreateID',title:'创建人ID',type:'int',width:80,hidden:true,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
