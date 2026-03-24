export default function(){
    const table = {
        key: 'Record_Id',
        footer: "Foots",
        cnName: '培训档案',
        name: 'EHS_TrainingRecord',
        newTabEdit: false,
        url: "/EHS_TrainingRecord/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"Plan_Id":"","UserName":"","DeptName":"","TrainingDate":"","ExamScore":"","IsPassed":"","CertificateNo":"","Status":""};
    const editFormOptions = [[{"title":"关联计划","field":"Plan_Id","type":"number"},{"title":"参训人","field":"UserName"}],[{"title":"所属部门","field":"DeptName"},{"title":"培训日期","field":"TrainingDate","type":"datetime"}],[{"title":"考试成绩","field":"ExamScore","type":"decimal"},{"title":"是否通过","field":"IsPassed","type":"number"}],[{"title":"证书编号","field":"CertificateNo"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"UserName":"","DeptName":"","TrainingDate":"","ExamScore":"","IsPassed":""};
    const searchFormOptions = [[{"title":"参训人","field":"UserName","type":"like"},{"title":"所属部门","field":"DeptName","type":"like"},{"title":"培训日期","field":"TrainingDate","type":"datetime"},{"title":"考试成绩","field":"ExamScore"},{"title":"是否通过","field":"IsPassed"}]];
    const columns = [{field:'Record_Id',title:'记录ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'Plan_Id',title:'关联计划',type:'int',width:80,align:'left'},
                       {field:'UserName',title:'参训人',type:'string',width:120,align:'left'},
                       {field:'DeptName',title:'所属部门',type:'string',width:120,align:'left'},
                       {field:'TrainingDate',title:'培训日期',type:'date',width:110,align:'left'},
                       {field:'ExamScore',title:'考试成绩',type:'decimal',width:100,align:'left'},
                       {field:'IsPassed',title:'是否通过',type:'int',width:80,align:'left'},
                       {field:'CertificateNo',title:'证书编号',type:'string',width:120,align:'left'},
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
