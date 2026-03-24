export default function(){
    const table = {
        key: 'Ledger_Id',
        footer: "Foots",
        cnName: '台账管理',
        name: 'EHS_SafetyLedger',
        newTabEdit: false,
        url: "/EHS_SafetyLedger/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"LedgerType":"","LedgerNo":"","Title":"","Content":"","Amount":"","DeptId":"","DeptName":"","OccurDate":"","Status":"","AttachmentUrl":"","Remark":""};
    const editFormOptions = [[{"title":"台账类型","field":"LedgerType","required":true},{"title":"台账编号","field":"LedgerNo"}],[{"title":"台账标题","field":"Title","required":true},{"title":"详细内容","field":"Content","type":"textarea"}],[{"title":"金额","field":"Amount","type":"decimal"},{"title":"所属部门ID","field":"DeptId","type":"number"}],[{"title":"所属部门","field":"DeptName"},{"title":"发生日期","field":"OccurDate","type":"datetime"}],[{"title":"状态","field":"Status","type":"number"},{"title":"附件路径","field":"AttachmentUrl"}],[{"title":"备注","field":"Remark"}]];
    const searchFormFields = {"LedgerType":"","LedgerNo":"","Title":"","Content":"","Amount":""};
    const searchFormOptions = [[{"title":"台账类型","field":"LedgerType","type":"like"},{"title":"台账编号","field":"LedgerNo","type":"like"},{"title":"台账标题","field":"Title","type":"like"},{"title":"详细内容","field":"Content","type":"like"},{"title":"金额","field":"Amount"}]];
    const columns = [{field:'Ledger_Id',title:'台账ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'LedgerType',title:'台账类型',type:'string',width:120,require:true,align:'left'},
                       {field:'LedgerNo',title:'台账编号',type:'string',width:120,align:'left'},
                       {field:'Title',title:'台账标题',type:'string',width:150,require:true,align:'left'},
                       {field:'Content',title:'详细内容',type:'string',width:120,align:'left'},
                       {field:'Amount',title:'金额',type:'decimal',width:100,align:'left'},
                       {field:'DeptId',title:'所属部门ID',type:'int',width:80,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'OccurDate',title:'发生日期',type:'date',width:110,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'},
                       {field:'AttachmentUrl',title:'附件路径',type:'string',width:150,align:'left'},
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
