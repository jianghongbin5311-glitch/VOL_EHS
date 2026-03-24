$root = "C:\Users\FZP28D\Desktop\AI Created\VOL_Pro_Antigravity"
function WF($p,$c){$d=Split-Path $p -Parent;if(!(Test-Path $d)){New-Item $d -ItemType Directory -Force|Out-Null};[IO.File]::WriteAllText($p,$c,[Text.UTF8Encoding]::new($false))}
function Prop($n,$t,$ml,$dn,$flags){
    $s=""
    $s+="       /// <summary>`r`n       ///$dn`r`n       /// </summary>`r`n"
    if($flags-match'K'){$s+="       [Key]`r`n"}
    $s+="       [Display(Name =`"$dn`")]`r`n"
    if($t-eq'string'-and$ml-gt0){$s+="       [MaxLength($ml)]`r`n       [Column(TypeName=`"nvarchar($ml)`")]`r`n"}
    elseif($t-eq'string'){$s+="       [Column(TypeName=`"nvarchar(max)`")]`r`n"}
    elseif($t-eq'int'){$s+="       [Column(TypeName=`"int`")]`r`n"}
    elseif($t-eq'decimal'){$s+="       [Column(TypeName=`"decimal(18,2)`")]`r`n"}
    elseif($t-eq'decimal4'){$s+="       [Column(TypeName=`"decimal(18,4)`")]`r`n"}
    elseif($t-match'date'){$s+="       [Column(TypeName=`"datetime`")]`r`n"}
    $s+="       [Editable(true)]`r`n"
    if($flags-match'R'){$s+="       [Required(AllowEmptyStrings=false)]`r`n"}
    $csType=$t
    if($t-eq'int'-and$flags-match'K'){$csType='int'}
    elseif($t-eq'int'){$csType='int?'}
    elseif($t-eq'decimal'-or$t-eq'decimal4'){$csType='decimal?'}
    elseif($t-match'date'){$csType='DateTime?'}
    $s+="       public $csType $n { get; set; }`r`n"
    return $s
}
function Entity($name,$cn,$cols){
    $props=$cols|ForEach-Object{$p=$_.Split('|');Prop $p[0] $p[1] ([int]$p[2]) $p[3] $p[4]}
    $body=$props-join"`r`n"
    WF "$root\api\VolPro.Entity\DomainModels\ehs\$name.cs" @"
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VolPro.Entity.SystemModels;
namespace VolPro.Entity.DomainModels
{
    [Entity(TableCnName = "$cn",TableName = "$name",DBServer = "ServiceDbContext")]
    public partial class ${name}:ServiceEntity
    {
$body
    }
}
"@
    Write-Host "[OK] Entity: $name"
}

# 1. EHS_SafetyLedger
Entity 'EHS_SafetyLedger' '台账管理' @(
'Ledger_Id|int|0|台账ID|KR','LedgerType|string|50|台账类型|R','LedgerNo|string|50|台账编号|',
'Title|string|200|台账标题|R','Content|string|0|详细内容|','Amount|decimal|0|金额|',
'DeptId|int|0|所属部门ID|','DeptName|string|100|所属部门|','OccurDate|date|0|发生日期|',
'Status|int|0|状态|','AttachmentUrl|string|500|附件路径|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 2. EHS_HazardInspection
Entity 'EHS_HazardInspection' '隐患排查' @(
'Inspection_Id|int|0|检查ID|KR','InspectionNo|string|50|检查编号|','InspectionType|string|50|检查类型|R',
'Title|string|200|检查标题|R','PlanDate|date|0|计划检查日期|','ActualDate|date|0|实际检查日期|',
'Area|string|100|检查区域|','DeptId|int|0|部门ID|','DeptName|string|100|所属部门|',
'InspectorId|int|0|检查人ID|','InspectorName|string|50|检查人|','Status|int|0|状态|',
'TotalItems|int|0|检查项数|','HazardCount|int|0|发现隐患数|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 3. EHS_HazardReport
Entity 'EHS_HazardReport' '隐患上报' @(
'Hazard_Id|int|0|隐患ID|KR','HazardNo|string|50|隐患编号|','Inspection_Id|int|0|关联排查任务|',
'HazardLevel|string|20|隐患等级|R','HazardType|string|50|隐患类别|','Title|string|200|隐患描述|R',
'Description|string|0|详细描述|','Location|string|200|发现位置|',
'DeptId|int|0|责任部门ID|','DeptName|string|100|责任部门|',
'DiscoveryDate|date|0|发现日期|','ReporterId|int|0|上报人ID|','ReporterName|string|50|上报人|',
'PhotoUrl1|string|500|现场照片1|','PhotoUrl2|string|500|现场照片2|','PhotoUrl3|string|500|现场照片3|',
'Status|int|0|状态|','VerifierId|int|0|核查人ID|','VerifierName|string|50|核查人|',
'VerifyDate|date|0|核查日期|','VerifyRemark|string|500|核查备注|',
'RectifyDeptId|int|0|整改部门ID|','RectifyDeptName|string|100|整改部门|',
'RectifyPersonId|int|0|整改责任人ID|','RectifyPersonName|string|50|整改责任人|',
'RectifyDeadline|date|0|整改期限|','RectifyPlan|string|0|整改方案|','RectifyResult|string|0|整改结果|',
'RectifyDate|date|0|整改完成日期|','RectifyPhotoUrl|string|500|整改后照片|',
'AccepterId|int|0|验收人ID|','AccepterName|string|50|验收人|','AcceptDate|date|0|验收日期|',
'AcceptResult|int|0|验收结果|','AcceptRemark|string|500|验收备注|',
'CloseDate|date|0|关闭日期|','CloseRemark|string|500|关闭备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 4. EHS_Course
Entity 'EHS_Course' '课程管理' @(
'Course_Id|int|0|课程ID|KR','CourseNo|string|50|课程编号|','CourseName|string|200|课程名称|R',
'CourseType|string|50|课程类型|','Description|string|0|课程描述|','Duration|int|0|课时(分钟)|',
'AttachmentUrl|string|500|课件路径|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 5. EHS_QuestionBank
Entity 'EHS_QuestionBank' '试题库' @(
'Question_Id|int|0|试题ID|KR','QuestionType|int|0|题型|R','Category|string|50|分类|',
'Content|string|0|题目内容|R','OptionA|string|500|选项A|','OptionB|string|500|选项B|',
'OptionC|string|500|选项C|','OptionD|string|500|选项D|','Answer|string|50|正确答案|R',
'Score|int|0|分值|','Difficulty|int|0|难度|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 6. EHS_TrainingPlan
Entity 'EHS_TrainingPlan' '培训计划' @(
'Plan_Id|int|0|计划ID|KR','PlanNo|string|50|计划编号|','PlanName|string|200|计划名称|R',
'TrainingType|string|50|培训类型|','Course_Id|int|0|关联课程|','Paper_Id|int|0|关联试卷|',
'PlanStartDate|date|0|开始日期|','PlanEndDate|date|0|结束日期|',
'TrainingMode|string|20|培训方式|','Location|string|200|培训地点|',
'TrainerId|int|0|讲师ID|','TrainerName|string|50|讲师|',
'TargetDeptId|int|0|目标部门ID|','TargetDeptName|string|100|目标部门|',
'TargetCount|int|0|目标人数|','ActualCount|int|0|实际人数|','PassCount|int|0|通过人数|',
'Status|int|0|状态|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 7. EHS_TrainingRecord
Entity 'EHS_TrainingRecord' '培训档案' @(
'Record_Id|int|0|记录ID|KR','Plan_Id|int|0|关联计划|','UserId|int|0|参训人ID|R',
'UserName|string|50|参训人|','DeptId|int|0|部门ID|','DeptName|string|100|所属部门|',
'TrainingDate|date|0|培训日期|','ExamScore|decimal|0|考试成绩|','IsPassed|int|0|是否通过|',
'CertificateNo|string|50|证书编号|','SignUrl|string|500|签到凭证|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 8. EHS_WorkPermit
Entity 'EHS_WorkPermit' '特殊作业票' @(
'Permit_Id|int|0|作业票ID|KR','PermitNo|string|50|作业票编号|','PermitType|string|50|作业类型|R',
'Title|string|200|作业名称|R','WorkContent|string|0|作业内容|','WorkLocation|string|200|作业地点|',
'DeptId|int|0|申请部门ID|','DeptName|string|100|申请部门|',
'ApplicantId|int|0|申请人ID|','ApplicantName|string|50|申请人|',
'ContractorName|string|200|承包商|','WorkStartTime|date|0|开始时间|','WorkEndTime|date|0|结束时间|',
'RiskLevel|string|20|风险等级|','Status|int|0|状态|',
'ApproverIds|string|500|审批人列表|','ApprovalDate|date|0|审批日期|',
'ActualEndTime|date|0|实际结束|','CloseRemark|string|500|关闭备注|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 9. EHS_WorkPermitMonitor
Entity 'EHS_WorkPermitMonitor' '作业过程监督' @(
'Monitor_Id|int|0|监督ID|KR','Permit_Id|int|0|作业票ID|R','MonitorTime|date|0|监督时间|R',
'MonitorPersonId|int|0|监督人ID|','MonitorPersonName|string|50|监督人|',
'MonitorContent|string|0|监督内容|','GasTestResult|string|500|气体分析|',
'IsNormal|int|0|是否正常|','AbnormalAction|string|500|异常处理|',
'IsStopped|int|0|是否中止|','PhotoUrl|string|500|照片|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|')

# 10. EHS_EmergencyResource
Entity 'EHS_EmergencyResource' '应急资源' @(
'Resource_Id|int|0|资源ID|KR','ResourceType|string|20|资源类型|R','ResourceName|string|200|资源名称|R',
'Description|string|0|描述|','Quantity|int|0|数量|','ContactPerson|string|50|联系人|',
'ContactPhone|string|50|联系电话|','Location|string|200|位置|','ExpiryDate|date|0|有效期|',
'Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 11. EHS_EmergencyPlan
Entity 'EHS_EmergencyPlan' '应急预案' @(
'Plan_Id|int|0|预案ID|KR','PlanType|string|50|预案类型|R','PlanName|string|200|预案名称|R',
'PlanNo|string|50|预案编号|','Version|string|20|版本|','Description|string|0|描述|',
'AttachmentUrl|string|500|附件|','ApprovalDate|date|0|批准日期|','ReviewDate|date|0|评审日期|',
'Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 12. EHS_EmergencyDrill
Entity 'EHS_EmergencyDrill' '应急演练' @(
'Drill_Id|int|0|演练ID|KR','Plan_Id|int|0|关联预案|','DrillName|string|200|演练名称|R',
'DrillDate|date|0|演练日期|','DrillType|string|50|演练类型|','Participants|int|0|参与人数|',
'Location|string|200|地点|','Content|string|0|演练内容|','Evaluation|string|0|演练评估|',
'ImprovePlan|string|0|改进计划|','PhotoUrl|string|500|照片|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 13. EHS_Accident
Entity 'EHS_Accident' '事故管理' @(
'Accident_Id|int|0|事故ID|KR','AccidentNo|string|50|事故编号|','AccidentType|string|50|事故类型|R',
'AccidentLevel|string|20|事故等级|','Title|string|200|事故标题|R',
'OccurDate|date|0|发生日期|','OccurLocation|string|200|发生地点|',
'DeptId|int|0|部门ID|','DeptName|string|100|所属部门|','Description|string|0|事故经过|',
'DirectCause|string|0|直接原因|','RootCause|string|0|根本原因|',
'Injuries|int|0|受伤人数|','Fatalities|int|0|死亡人数|','EconomicLoss|decimal|0|经济损失|',
'ReporterId|int|0|上报人ID|','ReporterName|string|50|上报人|',
'InvestigatorName|string|50|调查人|','InvestigationReport|string|0|调查报告|',
'CorrectiveAction|string|0|纠正措施|','PreventiveAction|string|0|预防措施|',
'Status|int|0|状态|','CloseDate|date|0|结案日期|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 14. EHS_HazardousWaste
Entity 'EHS_HazardousWaste' '危废管理' @(
'HW_Id|int|0|危废ID|KR','WasteCode|string|50|危废代码|','WasteName|string|200|危废名称|R',
'WasteCategory|string|100|危废类别|','Quantity|decimal4|0|数量|','Unit|string|20|单位|',
'StorageLocation|string|200|暂存位置|','GenerateDeptId|int|0|产生部门ID|',
'GenerateDeptName|string|100|产生部门|','GenerateDate|date|0|产生日期|',
'DisposalMethod|string|100|处置方式|','DisposalVendor|string|200|处置单位|',
'DisposalDate|date|0|处置日期|','ManifestNo|string|100|转移联单号|','Status|int|0|状态|',
'Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 15. EHS_SolidWaste
Entity 'EHS_SolidWaste' '固废管理' @(
'SW_Id|int|0|固废ID|KR','WasteType|string|100|固废种类|R','Quantity|decimal4|0|数量|',
'Unit|string|20|单位|','Period|string|20|月份|','DeptId|int|0|部门ID|','DeptName|string|100|所属部门|',
'DisposalMethod|string|100|处置方式|','DisposalVendor|string|200|处置单位|',
'DisposalDate|date|0|处置日期|','Status|int|0|状态|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 16. EHS_PPEStandard
Entity 'EHS_PPEStandard' 'PPE标准' @(
'PPE_Id|int|0|PPEID|KR','PPEName|string|200|PPE名称|R','PPEType|string|50|类别|',
'Specification|string|200|规格型号|','Standard|string|200|发放标准|',
'Frequency|string|50|更换周期|','ApplicablePost|string|200|适用岗位|',
'Stock|int|0|库存数量|','MinStock|int|0|最低库存|','Unit|string|20|单位|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 17. EHS_PPEDistribution
Entity 'EHS_PPEDistribution' 'PPE领用记录' @(
'Distribution_Id|int|0|领用ID|KR','PPE_Id|int|0|PPEID|R','PPEName|string|200|PPE名称|',
'UserId|int|0|领用人ID|','UserName|string|50|领用人|','DeptId|int|0|部门ID|',
'DeptName|string|100|所属部门|','Quantity|int|0|数量|R',
'DistributeDate|date|0|领用日期|','ReturnDate|date|0|归还日期|','Status|int|0|状态|',
'Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 18. EHS_Chemical
Entity 'EHS_Chemical' '化学品台账' @(
'Chemical_Id|int|0|化学品ID|KR','ChemicalName|string|200|化学品名称|R',
'ChemicalNameEN|string|200|英文名|','CASNo|string|50|CAS号|','Category|string|100|分类|',
'DangerLevel|string|20|危险等级|','MSDSUrl|string|500|MSDS文件|',
'StorageRequire|string|500|存储要求|','Supplier|string|200|供应商|',
'Stock|decimal4|0|库存|','Unit|string|20|单位|','MinStock|decimal4|0|最低库存|','Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 19. EHS_ChemicalApplication
Entity 'EHS_ChemicalApplication' '化学品申请' @(
'Application_Id|int|0|申请ID|KR','ApplicationNo|string|50|申请编号|',
'Chemical_Id|int|0|化学品ID|R','ChemicalName|string|200|化学品名称|',
'Quantity|decimal4|0|数量|R','Unit|string|20|单位|','Purpose|string|500|用途|',
'ApplicantId|int|0|申请人ID|','ApplicantName|string|50|申请人|',
'DeptId|int|0|部门ID|','DeptName|string|100|所属部门|',
'Status|int|0|状态|','ApproverRemark|string|500|审批备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 20. EHS_ChemicalInOut
Entity 'EHS_ChemicalInOut' '出入库记录' @(
'InOut_Id|int|0|记录ID|KR','Chemical_Id|int|0|化学品ID|R','ChemicalName|string|200|化学品名称|',
'InOutType|string|10|出入库类型|R','Quantity|decimal4|0|数量|R','Unit|string|20|单位|',
'OperatorId|int|0|操作人ID|','OperatorName|string|50|操作人|','Reason|string|500|原因|',
'BatchNo|string|50|批次号|','InOutDate|date|0|出入库日期|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|')

# 21. EHS_Document
Entity 'EHS_Document' '程序文件' @(
'Doc_Id|int|0|文件ID|KR','DocType|string|50|文件类型|R','DocNo|string|50|文件编号|',
'DocName|string|200|文件名称|R','Version|string|20|版本|','Description|string|0|描述|',
'AttachmentUrl|string|500|附件|','IssueDate|date|0|发布日期|','ReviewDate|date|0|评审日期|',
'Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 22. EHS_Information
Entity 'EHS_Information' '法规与信息' @(
'Info_Id|int|0|信息ID|KR','InfoType|string|50|信息类型|R','Title|string|200|标题|R',
'Content|string|0|内容|','Source|string|200|来源|','PublishDate|date|0|发布日期|',
'EffectiveDate|date|0|生效日期|','AttachmentUrl|string|500|附件|','IsRead|int|0|是否已读|',
'Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 23. EHS_Meeting
Entity 'EHS_Meeting' '会议记录' @(
'Meeting_Id|int|0|会议ID|KR','MeetingName|string|200|会议名称|R','MeetingType|string|50|会议类型|',
'MeetingDate|date|0|会议日期|','Location|string|200|地点|',
'OrganizerId|int|0|组织者ID|','OrganizerName|string|50|组织者|',
'Agenda|string|0|会议议程|','Minutes|string|0|会议纪要|','AttachmentUrl|string|500|附件|',
'Status|int|0|状态|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 24. EHS_MeetingSignIn
Entity 'EHS_MeetingSignIn' '会议签到' @(
'SignIn_Id|int|0|签到ID|KR','Meeting_Id|int|0|会议ID|R','UserId|int|0|用户ID|R',
'UserName|string|50|姓名|','DeptName|string|100|部门|',
'SignInTime|date|0|签到时间|','SignInType|string|20|签到方式|',
'LocationInfo|string|200|定位信息|','Status|int|0|状态|')

# 25. EHS_Supplier
Entity 'EHS_Supplier' '供应商列表' @(
'Supplier_Id|int|0|供应商ID|KR','SupplierName|string|200|供应商名称|R',
'SupplierType|string|50|供应商类型|','ContactPerson|string|50|联系人|',
'ContactPhone|string|50|联系电话|','Address|string|500|地址|',
'Qualification|string|500|资质信息|','Level|string|20|等级|',
'EvaluationScore|decimal|0|评估分数|','ContractStartDate|date|0|合同开始|',
'ContractEndDate|date|0|合同结束|','Status|int|0|状态|','Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

# 26. EHS_ConstructionProject
Entity 'EHS_ConstructionProject' '施工项目' @(
'Project_Id|int|0|项目ID|KR','ProjectNo|string|50|项目编号|','ProjectName|string|200|项目名称|R',
'Supplier_Id|int|0|供应商ID|','SupplierName|string|200|供应商|',
'ProjectManager|string|50|项目经理|','ProjectManagerPhone|string|50|经理电话|',
'Location|string|200|施工地点|','PlanStartDate|date|0|计划开始|','PlanEndDate|date|0|计划结束|',
'ActualStartDate|date|0|实际开始|','ActualEndDate|date|0|实际结束|',
'Description|string|0|项目描述|','RiskLevel|string|20|风险等级|','Status|int|0|状态|',
'Remark|string|500|备注|',
'CreateDate|date|0|创建时间|','Creator|string|50|创建人|','CreateID|int|0|创建人ID|',
'ModifyDate|date|0|修改时间|','Modifier|string|50|修改人|')

Write-Host "`n=== Done: 26 Entity files generated ==="
