export default function(){
    const table = {
        key: 'Incident_Id',
        footer: "Foots",
        cnName: '集团内部事件',
        name: 'EHS_GroupIncident',
        newTabEdit: false,
        url: "/EHS_GroupIncident/",
        sortName: "OccurDate"
    };
    const tableName = table.name;
    const tableCNName = table.cnName;
    const newTabEdit = false;
    const key = table.key;
    const editFormFields = {"IncidentNo":"","CompanyName":"","FactoryName":"","IncidentType":"","IncidentLevel":"","Title":"","OccurDate":"","OccurLocation":"","Description":"","RootCause":"","CorrectiveAction":"","PreventiveAction":"","Injuries":"","Fatalities":"","EconomicLoss":"","ImageUrls":"","AttachmentUrls":"","ReferenceUrl":"","LessonLearned":"","IsExternal":"","SourceCompany":"","ReporterName":"","Status":""};
    const editFormOptions = [
        [{"title":"事件编号","field":"IncidentNo"},{"title":"事件标题","field":"Title","required":true,"colSize":8}],
        [{"title":"所属公司","field":"CompanyName","required":true,"type":"select","data":[{"key":"耐世特苏州","value":"耐世特苏州"},{"key":"耐世特柳州","value":"耐世特柳州"},{"key":"耐世特芜湖","value":"耐世特芜湖"},{"key":"耐世特烟台","value":"耐世特烟台"},{"key":"其它集团公司","value":"其它集团公司"}]},{"title":"所属工厂","field":"FactoryName"},{"title":"来源公司","field":"SourceCompany"}],
        [{"title":"事件类型","field":"IncidentType","required":true,"type":"select","data":[{"key":"工伤","value":"工伤"},{"key":"设备","value":"设备"},{"key":"环境","value":"环境"},{"key":"火灾","value":"火灾"},{"key":"化学品","value":"化学品"},{"key":"高处坠落","value":"高处坠落"},{"key":"机械伤害","value":"机械伤害"},{"key":"触电","value":"触电"},{"key":"其他","value":"其他"}]},{"title":"事件等级","field":"IncidentLevel","type":"select","data":[{"key":"一般","value":"一般"},{"key":"较大","value":"较大"},{"key":"重大","value":"重大"},{"key":"特别重大","value":"特别重大"},{"key":"未遂","value":"未遂"}]},{"title":"是否外部事件","field":"IsExternal","type":"select","data":[{"key":"0","value":"否"},{"key":"1","value":"是"}]}],
        [{"title":"发生日期","field":"OccurDate","type":"datetime"},{"title":"发生地点","field":"OccurLocation"},{"title":"上报人","field":"ReporterName"}],
        [{"title":"受伤人数","field":"Injuries","type":"number"},{"title":"死亡人数","field":"Fatalities","type":"number"},{"title":"经济损失(元)","field":"EconomicLoss","type":"number"}],
        [{"title":"事件经过","field":"Description","type":"textarea","colSize":12}],
        [{"title":"根本原因","field":"RootCause","type":"textarea","colSize":12}],
        [{"title":"纠正措施","field":"CorrectiveAction","type":"textarea","colSize":12}],
        [{"title":"预防措施","field":"PreventiveAction","type":"textarea","colSize":12}],
        [{"title":"经验教训","field":"LessonLearned","type":"textarea","colSize":12}],
        [{"title":"现场图片","field":"ImageUrls","type":"img","colSize":12}],
        [{"title":"附件","field":"AttachmentUrls","type":"file","colSize":12}],
        [{"title":"参考链接","field":"ReferenceUrl","colSize":12}],
        [{"title":"状态","field":"Status","type":"select","data":[{"key":"1","value":"有效"},{"key":"0","value":"无效"},{"key":"2","value":"处理中"},{"key":"3","value":"已关闭"}]}]
    ];
    const searchFormFields = {"CompanyName":"","IncidentType":"","IncidentLevel":"","Title":"","OccurDate":"","IsExternal":""};
    const searchFormOptions = [[{"title":"所属公司","field":"CompanyName","type":"select","data":[{"key":"耐世特苏州","value":"耐世特苏州"},{"key":"耐世特柳州","value":"耐世特柳州"},{"key":"耐世特芜湖","value":"耐世特芜湖"},{"key":"耐世特烟台","value":"耐世特烟台"},{"key":"其它集团公司","value":"其它集团公司"}]},{"title":"事件类型","field":"IncidentType","type":"select","data":[{"key":"工伤","value":"工伤"},{"key":"设备","value":"设备"},{"key":"环境","value":"环境"},{"key":"火灾","value":"火灾"},{"key":"化学品","value":"化学品"},{"key":"其他","value":"其他"}]},{"title":"事件等级","field":"IncidentLevel","type":"select","data":[{"key":"一般","value":"一般"},{"key":"较大","value":"较大"},{"key":"重大","value":"重大"},{"key":"特别重大","value":"特别重大"},{"key":"未遂","value":"未遂"}]},{"title":"事件标题","field":"Title","type":"like"},{"title":"发生日期","field":"OccurDate","type":"datetime"},{"title":"外部事件","field":"IsExternal","type":"select","data":[{"key":"0","value":"否"},{"key":"1","value":"是"}]}]];
    const columns = [{field:'Incident_Id',title:'事件ID',type:'int',width:80,hidden:true,readonly:true,require:true,align:'left'},
                       {field:'IncidentNo',title:'事件编号',type:'string',width:130,align:'left'},
                       {field:'CompanyName',title:'所属公司',type:'string',width:120,require:true,align:'left'},
                       {field:'FactoryName',title:'所属工厂',type:'string',width:100,align:'left'},
                       {field:'IncidentType',title:'事件类型',type:'string',width:90,require:true,align:'center'},
                       {field:'IncidentLevel',title:'事件等级',type:'string',width:80,align:'center'},
                       {field:'Title',title:'事件标题',type:'string',width:200,require:true,align:'left'},
                       {field:'OccurDate',title:'发生日期',type:'date',width:110,align:'left'},
                       {field:'OccurLocation',title:'发生地点',type:'string',width:130,align:'left'},
                       {field:'Injuries',title:'受伤人数',type:'int',width:80,align:'center'},
                       {field:'Fatalities',title:'死亡人数',type:'int',width:80,align:'center'},
                       {field:'EconomicLoss',title:'经济损失',type:'decimal',width:100,align:'right'},
                       {field:'IsExternal',title:'外部事件',type:'int',width:80,align:'center',bind:{key:"0",data:[{key:"0",value:"否"},{key:"1",value:"是"}]}},
                       {field:'SourceCompany',title:'来源公司',type:'string',width:120,align:'left'},
                       {field:'ReporterName',title:'上报人',type:'string',width:80,align:'left'},
                       {field:'Status',title:'状态',type:'int',width:70,align:'center',bind:{key:"1",data:[{key:"1",value:"有效"},{key:"0",value:"无效"},{key:"2",value:"处理中"},{key:"3",value:"已关闭"}]}},
                       {field:'CreateDate',title:'创建时间',type:'datetime',width:150,align:'left'},
                       {field:'Creator',title:'创建人',type:'string',width:80,align:'left'}];
    const detail = {columns:[]};
    const details = [];
    return { table, key, tableName, tableCNName, newTabEdit, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details };
}
