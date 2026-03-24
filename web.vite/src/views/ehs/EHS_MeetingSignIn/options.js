export default function(){
    const table = {
        key: 'SignIn_Id',
        footer: "Foots",
        cnName: '会议签到',
        name: 'EHS_MeetingSignIn',
        newTabEdit: false,
        url: "/EHS_MeetingSignIn/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"Meeting_Id":"","UserName":"","DeptName":"","SignInTime":"","SignInType":"","Status":""};
    const editFormOptions = [[{"title":"会议ID","field":"Meeting_Id","required":true,"type":"number"},{"title":"姓名","field":"UserName"}],[{"title":"部门","field":"DeptName"},{"title":"签到时间","field":"SignInTime","type":"datetime"}],[{"title":"签到方式","field":"SignInType"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"UserName":"","DeptName":"","SignInTime":"","SignInType":"","Status":""};
    const searchFormOptions = [[{"title":"姓名","field":"UserName","type":"like"},{"title":"部门","field":"DeptName","type":"like"},{"title":"签到时间","field":"SignInTime","type":"datetime"},{"title":"签到方式","field":"SignInType","type":"like"},{"title":"状态","field":"Status"}]];
    const columns = [{field:'SignIn_Id',title:'签到ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'Meeting_Id',title:'会议ID',type:'int',width:80,require:true,align:'left'},
                       {field:'UserName',title:'姓名',type:'string',width:120,align:'left'},
                       {field:'DeptName',title:'部门',type:'string',width:120,align:'left'},
                       {field:'SignInTime',title:'签到时间',type:'date',width:110,align:'left'},
                       {field:'SignInType',title:'签到方式',type:'string',width:120,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:80,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
