export default function(){
    const table = {
        key: 'Doc_Id',
        footer: "Foots",
        cnName: '程序文件',
        name: 'EHS_Document',
        newTabEdit: false,
        url: "/EHS_Document/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"DocType":"","DocNo":"","DocName":"","Version":"","Description":"","IssueDate":"","ReviewDate":"","Status":""};
    const editFormOptions = [[{"title":"文件类型","field":"DocType","required":true},{"title":"文件编号","field":"DocNo"}],[{"title":"文件名称","field":"DocName","required":true},{"title":"版本","field":"Version"}],[{"title":"描述","field":"Description","type":"textarea"},{"title":"发布日期","field":"IssueDate","type":"datetime"}],[{"title":"评审日期","field":"ReviewDate","type":"datetime"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"DocType":"","DocNo":"","DocName":"","Version":"","Description":""};
    const searchFormOptions = [[{"title":"文件类型","field":"DocType","type":"like"},{"title":"文件编号","field":"DocNo","type":"like"},{"title":"文件名称","field":"DocName","type":"like"},{"title":"版本","field":"Version","type":"like"},{"title":"描述","field":"Description","type":"like"}]];
    const columns = [{field:'Doc_Id',title:'文件ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'DocType',title:'文件类型',type:'string',width:120,require:true,align:'left'},
                       {field:'DocNo',title:'文件编号',type:'string',width:120,align:'left'},
                       {field:'DocName',title:'文件名称',type:'string',width:150,require:true,align:'left'},
                       {field:'Version',title:'版本',type:'string',width:120,align:'left'},
                       {field:'Description',title:'描述',type:'string',width:120,align:'left'},
                       {field:'IssueDate',title:'发布日期',type:'date',width:110,align:'left'},
                       {field:'ReviewDate',title:'评审日期',type:'date',width:110,align:'left'},
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
