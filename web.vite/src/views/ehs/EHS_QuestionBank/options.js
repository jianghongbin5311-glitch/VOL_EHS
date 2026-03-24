export default function(){
    const table = {
        key: 'Question_Id',
        footer: "Foots",
        cnName: '试题库',
        name: 'EHS_QuestionBank',
        newTabEdit: false,
        url: "/EHS_QuestionBank/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"QuestionType":"","Category":"","Content":"","OptionA":"","OptionB":"","OptionC":"","OptionD":"","Answer":"","Score":"","Difficulty":"","Status":""};
    const editFormOptions = [[{"title":"题型","field":"QuestionType","required":true,"type":"number"},{"title":"分类","field":"Category"}],[{"title":"题目内容","field":"Content","required":true,"type":"textarea"},{"title":"选项A","field":"OptionA"}],[{"title":"选项B","field":"OptionB"},{"title":"选项C","field":"OptionC"}],[{"title":"选项D","field":"OptionD"},{"title":"正确答案","field":"Answer","required":true}],[{"title":"分值","field":"Score","type":"number"},{"title":"难度","field":"Difficulty","type":"number"}],[{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"QuestionType":"","Category":"","Content":"","OptionA":"","OptionB":""};
    const searchFormOptions = [[{"title":"题型","field":"QuestionType"},{"title":"分类","field":"Category","type":"like"},{"title":"题目内容","field":"Content","type":"like"},{"title":"选项A","field":"OptionA","type":"like"},{"title":"选项B","field":"OptionB","type":"like"}]];
    const columns = [{field:'Question_Id',title:'试题ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'QuestionType',title:'题型',type:'int',width:80,require:true,align:'left'},
                       {field:'Category',title:'分类',type:'string',width:120,align:'left'},
                       {field:'Content',title:'题目内容',type:'string',width:120,require:true,align:'left'},
                       {field:'OptionA',title:'选项A',type:'string',width:150,align:'left'},
                       {field:'OptionB',title:'选项B',type:'string',width:150,align:'left'},
                       {field:'OptionC',title:'选项C',type:'string',width:150,align:'left'},
                       {field:'OptionD',title:'选项D',type:'string',width:150,align:'left'},
                       {field:'Answer',title:'正确答案',type:'string',width:120,require:true,align:'left'},
                       {field:'Score',title:'分值',type:'int',width:80,align:'left'},
                       {field:'Difficulty',title:'难度',type:'int',width:80,align:'left'},
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
