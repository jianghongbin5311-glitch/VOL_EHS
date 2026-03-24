export default function(){
    const table = {
        key: 'Info_Id',
        footer: "Foots",
        cnName: '法规与信息',
        name: 'EHS_Information',
        newTabEdit: false,
        url: "/EHS_Information/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"InfoType":"","Title":"","Content":"","Source":"","PublishDate":"","Status":""};
    const editFormOptions = [[{"title":"信息类型","field":"InfoType","required":true},{"title":"标题","field":"Title","required":true}],[{"title":"内容","field":"Content","type":"textarea"},{"title":"来源","field":"Source"}],[{"title":"发布日期","field":"PublishDate","type":"datetime"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"InfoType":"","Title":"","Content":"","Source":"","PublishDate":""};
    const searchFormOptions = [[{"title":"信息类型","field":"InfoType","type":"like"},{"title":"标题","field":"Title","type":"like"},{"title":"内容","field":"Content","type":"like"},{"title":"来源","field":"Source","type":"like"},{"title":"发布日期","field":"PublishDate","type":"datetime"}]];
    const columns = [{field:'Info_Id',title:'信息ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'InfoType',title:'信息类型',type:'string',width:120,require:true,align:'left'},
                       {field:'Title',title:'标题',type:'string',width:150,require:true,align:'left'},
                       {field:'Content',title:'内容',type:'string',width:120,align:'left'},
                       {field:'Source',title:'来源',type:'string',width:150,align:'left'},
                       {field:'PublishDate',title:'发布日期',type:'date',width:110,align:'left'},
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
