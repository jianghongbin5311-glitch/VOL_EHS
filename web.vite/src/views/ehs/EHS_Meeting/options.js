export default function(){
    const table = {
        key: 'Meeting_Id',
        footer: "Foots",
        cnName: '会议记录',
        name: 'EHS_Meeting',
        newTabEdit: false,
        url: "/EHS_Meeting/",
        sortName: "CreateDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"MeetingName":"","MeetingType":"","MeetingDate":"","Location":"","OrganizerName":"","Status":""};
    const editFormOptions = [[{"title":"会议名称","field":"MeetingName","required":true},{"title":"会议类型","field":"MeetingType"}],[{"title":"会议日期","field":"MeetingDate","type":"datetime"},{"title":"地点","field":"Location"}],[{"title":"组织者","field":"OrganizerName"},{"title":"状态","field":"Status","type":"number"}]];
    const searchFormFields = {"MeetingName":"","MeetingType":"","MeetingDate":"","Location":"","OrganizerName":""};
    const searchFormOptions = [[{"title":"会议名称","field":"MeetingName","type":"like"},{"title":"会议类型","field":"MeetingType","type":"like"},{"title":"会议日期","field":"MeetingDate","type":"datetime"},{"title":"地点","field":"Location","type":"like"},{"title":"组织者","field":"OrganizerName","type":"like"}]];
    const columns = [{field:'Meeting_Id',title:'会议ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'MeetingName',title:'会议名称',type:'string',width:150,require:true,align:'left'},
                       {field:'MeetingType',title:'会议类型',type:'string',width:120,align:'left'},
                       {field:'MeetingDate',title:'会议日期',type:'date',width:110,align:'left'},
                       {field:'Location',title:'地点',type:'string',width:150,align:'left'},
                       {field:'OrganizerName',title:'组织者',type:'string',width:120,align:'left'},
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
