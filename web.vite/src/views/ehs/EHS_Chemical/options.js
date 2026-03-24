export default function(){
    const table = {
        key: 'Chemical_Id',
        footer: "Foots",
        cnName: '化学品台账',
        name: 'EHS_Chemical',
        newTabEdit: false,
        url: "/EHS_Chemical/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"ChemicalName":"","ChemicalNameEN":"","CASNo":"","Category":"","DangerLevel":"","Supplier":"","Stock":"","Unit":"","MinStock":"","Status":""};
    const editFormOptions = [[{"title":"化学品名称","field":"ChemicalName","required":true},{"title":"英文名","field":"ChemicalNameEN"}],[{"title":"CAS号","field":"CASNo"},{"title":"分类","field":"Category"}],[{"title":"危险等级","field":"DangerLevel"},{"title":"供应商","field":"Supplier"}],[{"title":"库存","field":"Stock","type":"decimal"},{"title":"单位","field":"Unit"}],[{"title":"最低库存","field":"MinStock","type":"decimal"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"ChemicalName":"","ChemicalNameEN":"","CASNo":"","Category":"","DangerLevel":""};
    const searchFormOptions = [[{"title":"化学品名称","field":"ChemicalName","type":"like"},{"title":"英文名","field":"ChemicalNameEN","type":"like"},{"title":"CAS号","field":"CASNo","type":"like"},{"title":"分类","field":"Category","type":"like"},{"title":"危险等级","field":"DangerLevel","type":"like"}]];
    const columns = [{field:'Chemical_Id',title:'化学品ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'ChemicalName',title:'化学品名称',type:'string',width:150,require:true,align:'left'},
                       {field:'ChemicalNameEN',title:'英文名',type:'string',width:150,align:'left'},
                       {field:'CASNo',title:'CAS号',type:'string',width:120,align:'left'},
                       {field:'Category',title:'分类',type:'string',width:120,align:'left'},
                       {field:'DangerLevel',title:'危险等级',type:'string',width:120,align:'left'},
                       {field:'Supplier',title:'供应商',type:'string',width:150,align:'left'},
                       {field:'Stock',title:'库存',type:'decimal',width:100,align:'left'},
                       {field:'Unit',title:'单位',type:'string',width:120,align:'left'},
                       {field:'MinStock',title:'最低库存',type:'decimal',width:100,align:'left'},
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
