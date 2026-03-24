export default function(){
    const table = {
        key: 'Course_Id',
        footer: "Foots",
        cnName: '课程管理',
        name: 'EHS_Course',
        newTabEdit: false,
        url: "/EHS_Course/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"CourseNo":"","CourseName":"","CourseType":"","Description":"","Duration":"","AttachmentUrl":"","Status":""};
    const editFormOptions = [[{"title":"课程编号","field":"CourseNo"},{"title":"课程名称","field":"CourseName","required":true}],[{"title":"课程类型","field":"CourseType"},{"title":"课程描述","field":"Description","type":"textarea"}],[{"title":"课时(分钟)","field":"Duration","type":"number"},{"title":"课件路径","field":"AttachmentUrl"}],[{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"CourseNo":"","CourseName":"","CourseType":"","Description":"","Duration":""};
    const searchFormOptions = [[{"title":"课程编号","field":"CourseNo","type":"like"},{"title":"课程名称","field":"CourseName","type":"like"},{"title":"课程类型","field":"CourseType","type":"like"},{"title":"课程描述","field":"Description","type":"like"},{"title":"课时(分钟)","field":"Duration"}]];
    const columns = [{field:'Course_Id',title:'课程ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'CourseNo',title:'课程编号',type:'string',width:120,align:'left'},
                       {field:'CourseName',title:'课程名称',type:'string',width:150,require:true,align:'left'},
                       {field:'CourseType',title:'课程类型',type:'string',width:120,align:'left'},
                       {field:'Description',title:'课程描述',type:'string',width:120,align:'left'},
                       {field:'Duration',title:'课时(分钟)',type:'int',width:80,align:'left'},
                       {field:'AttachmentUrl',title:'课件路径',type:'string',width:150,align:'left'},
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
