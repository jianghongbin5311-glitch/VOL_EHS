-- ============================================================
-- EHS 信息化平台 - 第4步：插入示例数据
-- 在 nxt_ehs_biz 数据库上执行
-- ============================================================
-- 为每张业务表插入 3-5 条真实 EHS 业务场景数据（耐世特汽车背景）
-- ============================================================
USE [nxt_ehs_biz];
GO

-- 1. 台账管理
SET IDENTITY_INSERT [EHS_SafetyLedger] ON;
INSERT INTO EHS_SafetyLedger(Ledger_Id,LedgerType,LedgerNo,Title,Amount,DeptName,OccurDate,Status,Creator,CreateDate) VALUES
(1,N'投入台账',N'TZ-2026-001',N'2026年Q1安全防护设备采购',85000.00,N'EHS部',  '2026-01-15',1,N'system','2026-01-15'),
(2,N'奖罚台账',N'TZ-2026-002',N'3月安全生产标兵奖励',5000.00,N'机加工车间', '2026-03-10',1,N'system','2026-03-10'),
(3,N'制度台账',N'TZ-2026-003',N'危险化学品管理制度更新',NULL,N'EHS部',       '2026-02-20',1,N'system','2026-02-20'),
(4,N'相关方台账',N'TZ-2026-004',N'承包商安全资质审核记录',NULL,N'采购部',    '2026-03-01',0,N'system','2026-03-01');
SET IDENTITY_INSERT [EHS_SafetyLedger] OFF;

-- 2. 隐患排查
SET IDENTITY_INSERT [EHS_HazardInspection] ON;
INSERT INTO EHS_HazardInspection(Inspection_Id,InspectionNo,InspectionType,Title,PlanDate,Area,DeptName,InspectorName,Status,TotalItems,HazardCount,Creator,CreateDate) VALUES
(1,N'PC-2026-001',N'SOT',    N'3月SOT安全巡检-机加工车间',  '2026-03-05',N'机加工车间',N'EHS部',N'张伟',2,25,3,N'system','2026-03-05'),
(2,N'PC-2026-002',N'专项',   N'消防设施专项检查',           '2026-03-10',N'全厂区',   N'EHS部',N'李明',2,18,1,N'system','2026-03-10'),
(3,N'PC-2026-003',N'综合',   N'春季综合安全大检查',         '2026-03-15',N'全厂区',   N'EHS部',N'王芳',1,40,0,N'system','2026-03-15'),
(4,N'PC-2026-004',N'节假日', N'清明节前安全检查',           '2026-03-28',N'全厂区',   N'EHS部',N'赵强',0,0,0,N'system','2026-03-20');
SET IDENTITY_INSERT [EHS_HazardInspection] OFF;

-- 3. 隐患上报
SET IDENTITY_INSERT [EHS_HazardReport] ON;
INSERT INTO EHS_HazardReport(Hazard_Id,HazardNo,HazardLevel,HazardType,Title,Location,DeptName,ReporterName,DiscoveryDate,Status,Creator,CreateDate) VALUES
(1,N'YH-2026-001',N'一般隐患',N'电气安全',N'配电箱门未关闭',             N'机加工车间B区',N'机加工车间',N'刘工','2026-03-05',4,N'system','2026-03-05'),
(2,N'YH-2026-002',N'一般隐患',N'消防安全',N'灭火器过期未更换',           N'装配车间入口',N'装配车间',  N'陈伟','2026-03-10',3,N'system','2026-03-10'),
(3,N'YH-2026-003',N'重大隐患',N'机械安全',N'冲压机安全光幕失效',         N'冲压车间C线', N'冲压车间',  N'王磊','2026-03-12',2,N'system','2026-03-12'),
(4,N'YH-2026-004',N'一般隐患',N'环境安全',N'车间地面油污未清理',         N'机加工车间A区',N'机加工车间',N'张伟','2026-03-15',1,N'system','2026-03-15'),
(5,N'YH-2026-005',N'一般隐患',N'人员行为',N'叉车司机未佩戴安全带',       N'成品仓库',   N'物流部',    N'赵敏','2026-03-18',0,N'system','2026-03-18');
SET IDENTITY_INSERT [EHS_HazardReport] OFF;

-- 4. 课程管理
SET IDENTITY_INSERT [EHS_Course] ON;
INSERT INTO EHS_Course(Course_Id,CourseNo,CourseName,CourseType,Duration,Status,Creator,CreateDate) VALUES
(1,N'KC-001',N'新员工三级安全教育',      N'入职培训',120,1,N'system','2026-01-01'),
(2,N'KC-002',N'危险化学品安全操作规程',  N'操作规程',90, 1,N'system','2026-01-01'),
(3,N'KC-003',N'消防安全与应急疏散',      N'安全教育',60, 1,N'system','2026-01-01'),
(4,N'KC-004',N'受限空间作业安全培训',    N'操作规程',90, 1,N'system','2026-02-15');
SET IDENTITY_INSERT [EHS_Course] OFF;

-- 5. 试题库
SET IDENTITY_INSERT [EHS_QuestionBank] ON;
INSERT INTO EHS_QuestionBank(Question_Id,QuestionType,Category,Content,OptionA,OptionB,OptionC,OptionD,Answer,Score,Difficulty,Status,Creator,CreateDate) VALUES
(1,1,N'消防安全',N'干粉灭火器的有效期一般为几年？',N'1年',N'2年',N'3年',N'5年',N'B',5,1,1,N'system','2026-01-01'),
(2,1,N'电气安全',N'触电急救首先应该做什么？',N'人工呼吸',N'心肺复苏',N'切断电源',N'拨打120',N'C',5,1,1,N'system','2026-01-01'),
(3,3,N'消防安全',N'发现火灾应先自行扑救，无法扑灭时再报警。',N'正确',N'错误',NULL,NULL,N'B',5,2,1,N'system','2026-01-01'),
(4,1,N'化学品',  N'MSDS的中文全称是？',N'化学品安全说明书',N'材料安全数据表',N'化学品安全技术说明书',N'危险品说明书',N'C',5,2,1,N'system','2026-01-01'),
(5,2,N'PPE',     N'以下哪些属于个人防护用品（多选）？',N'安全帽',N'防护眼镜',N'工作服',N'安全鞋',N'ABCD',5,1,1,N'system','2026-01-01');
SET IDENTITY_INSERT [EHS_QuestionBank] OFF;

-- 6. 培训计划
SET IDENTITY_INSERT [EHS_TrainingPlan] ON;
INSERT INTO EHS_TrainingPlan(Plan_Id,PlanNo,PlanName,TrainingType,PlanStartDate,PlanEndDate,TrainingMode,Location,TrainerName,TargetDeptName,TargetCount,ActualCount,PassCount,Status,Creator,CreateDate) VALUES
(1,N'PX-2026-001',N'2026年Q1新员工入职培训',N'入职培训','2026-01-10','2026-01-12',N'线下',N'培训室A',N'张伟',N'全公司',30,28,26,2,N'system','2026-01-05'),
(2,N'PX-2026-002',N'消防安全专题培训',      N'安全培训','2026-03-15','2026-03-15',N'线下',N'会议室B',N'李消防',N'全公司',100,0,0,0,N'system','2026-03-01'),
(3,N'PX-2026-003',N'化学品操作人员年度复训',N'操作规程','2026-04-01','2026-04-03',N'混合',N'培训室A',N'王化工',N'化学品库',15,0,0,0,N'system','2026-03-10');
SET IDENTITY_INSERT [EHS_TrainingPlan] OFF;

-- 7. 培训档案
SET IDENTITY_INSERT [EHS_TrainingRecord] ON;
INSERT INTO EHS_TrainingRecord(Record_Id,Plan_Id,UserId,UserName,DeptName,TrainingDate,ExamScore,IsPassed,Status,Creator,CreateDate) VALUES
(1,1,101,N'李四',N'机加工车间','2026-01-12',88.5,1,2,N'system','2026-01-12'),
(2,1,102,N'王五',N'装配车间',  '2026-01-12',72.0,1,2,N'system','2026-01-12'),
(3,1,103,N'赵六',N'物流部',    '2026-01-12',55.0,0,2,N'system','2026-01-12');
SET IDENTITY_INSERT [EHS_TrainingRecord] OFF;

-- 8. 特殊作业票
SET IDENTITY_INSERT [EHS_WorkPermit] ON;
INSERT INTO EHS_WorkPermit(Permit_Id,PermitNo,PermitType,Title,WorkLocation,DeptName,ApplicantName,ContractorName,WorkStartTime,WorkEndTime,RiskLevel,Status,Creator,CreateDate) VALUES
(1,N'ZY-2026-001',N'动火',    N'焊接维修油管接头', N'机加工车间B区', N'维修部',N'刘工',N'苏州焊接公司',  '2026-03-20 08:00','2026-03-20 17:00',N'较大',6,N'system','2026-03-18'),
(2,N'ZY-2026-002',N'高处',    N'更换厂房顶部照明', N'装配车间屋顶',  N'设施部',N'陈工',NULL,             '2026-03-22 09:00','2026-03-22 16:00',N'一般',3,N'system','2026-03-20'),
(3,N'ZY-2026-003',N'受限空间',N'清理污水处理池',   N'污水处理站',    N'环保部',N'王工',N'苏州环保服务公司','2026-03-25 08:00','2026-03-25 12:00',N'重大',1,N'system','2026-03-22');
SET IDENTITY_INSERT [EHS_WorkPermit] OFF;

-- 9. 作业过程监督
SET IDENTITY_INSERT [EHS_WorkPermitMonitor] ON;
INSERT INTO EHS_WorkPermitMonitor(Monitor_Id,Permit_Id,MonitorTime,MonitorPersonName,MonitorContent,IsNormal,IsStopped,Creator,CreateDate) VALUES
(1,1,'2026-03-20 10:00',N'张安全',N'动火区域周围可燃物已清除，灭火器到位',1,0,N'system','2026-03-20'),
(2,1,'2026-03-20 14:00',N'张安全',N'焊接作业正常，无异常火花飞溅',        1,0,N'system','2026-03-20'),
(3,2,'2026-03-22 11:00',N'李安全',N'安全绳系挂正确，作业平台稳固',        1,0,N'system','2026-03-22');
SET IDENTITY_INSERT [EHS_WorkPermitMonitor] OFF;

-- 10. 应急资源
SET IDENTITY_INSERT [EHS_EmergencyResource] ON;
INSERT INTO EHS_EmergencyResource(Resource_Id,ResourceType,ResourceName,Quantity,ContactPerson,ContactPhone,Location,ExpiryDate,Status,Creator,CreateDate) VALUES
(1,N'Supply',N'ABC干粉灭火器(4kg)',120,N'张仓管',N'13800001111',N'各车间消防柜','2027-06-30',1,N'system','2026-01-01'),
(2,N'Supply',N'正压式空气呼吸器',  8,  N'张仓管',N'13800001111',N'EHS应急物资库','2028-12-31',1,N'system','2026-01-01'),
(3,N'Team',  N'厂区义务消防队',   25, N'王队长',N'13800002222',N'EHS办公室',     NULL,         1,N'system','2026-01-01'),
(4,N'Supply',N'应急救援担架',      6,  N'张仓管',N'13800001111',N'医务室及各车间',NULL,         1,N'system','2026-01-01');
SET IDENTITY_INSERT [EHS_EmergencyResource] OFF;

-- 11. 应急预案
SET IDENTITY_INSERT [EHS_EmergencyPlan] ON;
INSERT INTO EHS_EmergencyPlan(Plan_Id,PlanType,PlanName,PlanNo,Version,ApprovalDate,ReviewDate,Status,Creator,CreateDate) VALUES
(1,N'综合预案',N'耐世特苏州工厂综合应急预案',N'YA-2026-001',N'V3.0','2026-01-01','2027-01-01',1,N'system','2026-01-01'),
(2,N'专项预案',N'火灾爆炸事故专项应急预案',  N'YA-2026-002',N'V2.0','2026-01-01','2027-01-01',1,N'system','2026-01-01'),
(3,N'处置方案',N'危险化学品泄漏处置方案',    N'YA-2026-003',N'V1.5','2026-02-01','2027-02-01',1,N'system','2026-02-01');
SET IDENTITY_INSERT [EHS_EmergencyPlan] OFF;

-- 12. 应急演练
SET IDENTITY_INSERT [EHS_EmergencyDrill] ON;
INSERT INTO EHS_EmergencyDrill(Drill_Id,DrillName,DrillDate,DrillType,Participants,Location,Status,Creator,CreateDate) VALUES
(1,N'2026年Q1消防疏散演练',      '2026-03-12',N'实战演练',200,N'全厂区',1,N'system','2026-03-01'),
(2,N'化学品泄漏应急桌面演练',    '2026-02-28',N'桌面演练',15, N'会议室A',1,N'system','2026-02-20'),
(3,N'受限空间救援综合演练',      '2026-04-15',N'综合演练',30, N'污水处理站',0,N'system','2026-03-20');
SET IDENTITY_INSERT [EHS_EmergencyDrill] OFF;

-- 13. 事故管理
SET IDENTITY_INSERT [EHS_Accident] ON;
INSERT INTO EHS_Accident(Accident_Id,AccidentNo,AccidentType,AccidentLevel,Title,OccurDate,OccurLocation,DeptName,Injuries,Fatalities,EconomicLoss,ReporterName,Status,Creator,CreateDate) VALUES
(1,N'SG-2026-001',N'工伤',N'一般',N'操作工手指轻微割伤',       '2026-02-15',N'机加工车间A区',N'机加工车间',1,0,500.00, N'张伟',3,N'system','2026-02-15'),
(2,N'SG-2026-002',N'设备',N'一般',N'叉车碰撞货架轻微变形',     '2026-03-05',N'成品仓库',     N'物流部',    0,0,3000.00,N'赵敏',2,N'system','2026-03-05'),
(3,N'SG-2026-003',N'泄漏',N'一般',N'切削液管路接头泄漏(少量)',  '2026-03-18',N'机加工车间B区',N'机加工车间',0,0,200.00, N'刘工',1,N'system','2026-03-18');
SET IDENTITY_INSERT [EHS_Accident] OFF;

-- 14. 危废管理
SET IDENTITY_INSERT [EHS_HazardousWaste] ON;
INSERT INTO EHS_HazardousWaste(HW_Id,WasteCode,WasteName,WasteCategory,Quantity,Unit,StorageLocation,GenerateDeptName,GenerateDate,DisposalMethod,DisposalVendor,Status,Creator,CreateDate) VALUES
(1,N'HW900-006-09',N'废切削液',      N'含矿物油废物',2.5000,N'吨',N'危废暂存库A区',N'机加工车间','2026-03-01',N'委托处置',N'苏州环保处置有限公司',1,N'system','2026-03-01'),
(2,N'HW900-041-49',N'废含油抹布手套',N'其他废物',    0.3000,N'吨',N'危废暂存库B区',N'全公司',    '2026-03-15',N'焚烧处置',N'苏州环保处置有限公司',0,N'system','2026-03-15'),
(3,N'HW900-005-09',N'废液压油',      N'含矿物油废物',0.8000,N'吨',N'危废暂存库A区',N'维修部',    '2026-02-28',N'委托处置',N'苏州环保处置有限公司',2,N'system','2026-02-28');
SET IDENTITY_INSERT [EHS_HazardousWaste] OFF;

-- 15. 固废管理
SET IDENTITY_INSERT [EHS_SolidWaste] ON;
INSERT INTO EHS_SolidWaste(SW_Id,WasteType,Quantity,Unit,Period,DeptName,DisposalMethod,DisposalVendor,Status,Creator,CreateDate) VALUES
(1,N'废金属边角料',  15.5000,N'吨',N'2026-03',N'机加工车间',N'回收利用',N'苏州金属回收公司',1,N'system','2026-03-20'),
(2,N'废纸板包装材料',3.2000, N'吨',N'2026-03',N'物流部',    N'回收利用',N'苏州废品回收站',  1,N'system','2026-03-20'),
(3,N'生活垃圾',      8.0000, N'吨',N'2026-03',N'全公司',    N'市政清运',N'苏州城投环卫',    1,N'system','2026-03-20');
SET IDENTITY_INSERT [EHS_SolidWaste] OFF;

-- 16. PPE标准
SET IDENTITY_INSERT [EHS_PPEStandard] ON;
INSERT INTO EHS_PPEStandard(PPE_Id,PPEName,PPEType,Specification,Standard,Frequency,ApplicablePost,Stock,MinStock,Unit,Status,Creator,CreateDate) VALUES
(1,N'安全帽',    N'头部防护',N'V型ABS',       N'每人1顶',  N'2年',  N'全员',     200,50,N'顶',1,N'system','2026-01-01'),
(2,N'防护眼镜',  N'眼面防护',N'防冲击型',     N'每人1副',  N'1年',  N'车间操作工',150,30,N'副',1,N'system','2026-01-01'),
(3,N'防切割手套',N'手部防护',N'5级防切割',    N'每人2双/月',N'1个月',N'机加工操作工',500,100,N'双',1,N'system','2026-01-01'),
(4,N'安全鞋',    N'足部防护',N'防砸防刺穿',   N'每人1双',  N'1年',  N'全员',      180,40,N'双',1,N'system','2026-01-01');
SET IDENTITY_INSERT [EHS_PPEStandard] OFF;

-- 17. PPE领用记录
SET IDENTITY_INSERT [EHS_PPEDistribution] ON;
INSERT INTO EHS_PPEDistribution(Distribution_Id,PPE_Id,PPEName,UserName,DeptName,Quantity,DistributeDate,Status,Creator,CreateDate) VALUES
(1,3,N'防切割手套',N'李四',N'机加工车间',2,'2026-03-01',0,N'system','2026-03-01'),
(2,2,N'防护眼镜',  N'王五',N'装配车间',  1,'2026-03-05',0,N'system','2026-03-05'),
(3,1,N'安全帽',    N'赵六',N'物流部',    1,'2026-03-10',0,N'system','2026-03-10');
SET IDENTITY_INSERT [EHS_PPEDistribution] OFF;

-- 18. 化学品台账
SET IDENTITY_INSERT [EHS_Chemical] ON;
INSERT INTO EHS_Chemical(Chemical_Id,ChemicalName,ChemicalNameEN,CASNo,Category,DangerLevel,Supplier,Stock,Unit,MinStock,Status,Creator,CreateDate) VALUES
(1,N'丙酮',       N'Acetone',       N'67-64-1', N'易燃液体',N'中',N'苏州化工有限公司',50.0000,N'升',10.0000,1,N'system','2026-01-01'),
(2,N'切削液CL-200',N'Cutting Fluid', N'N/A',     N'一般化学品',N'低',N'嘉实多(中国)',    200.0000,N'升',50.0000,1,N'system','2026-01-01'),
(3,N'氢氧化钠',   N'Sodium Hydroxide',N'1310-73-2',N'腐蚀品', N'高',N'苏州化工有限公司',25.0000,N'公斤',5.0000, 1,N'system','2026-01-01');
SET IDENTITY_INSERT [EHS_Chemical] OFF;

-- 19. 化学品申请
SET IDENTITY_INSERT [EHS_ChemicalApplication] ON;
INSERT INTO EHS_ChemicalApplication(Application_Id,ApplicationNo,Chemical_Id,ChemicalName,Quantity,Unit,Purpose,ApplicantName,DeptName,Status,Creator,CreateDate) VALUES
(1,N'SQ-2026-001',1,N'丙酮',       5.0000,N'升',N'设备清洗',N'刘工',N'维修部',    3,N'system','2026-03-01'),
(2,N'SQ-2026-002',2,N'切削液CL-200',50.0000,N'升',N'机加工补充',N'李工长',N'机加工车间',1,N'system','2026-03-15'),
(3,N'SQ-2026-003',3,N'氢氧化钠',   10.0000,N'公斤',N'污水处理',N'王工',N'环保部',    0,N'system','2026-03-20');
SET IDENTITY_INSERT [EHS_ChemicalApplication] OFF;

-- 20. 出入库记录
SET IDENTITY_INSERT [EHS_ChemicalInOut] ON;
INSERT INTO EHS_ChemicalInOut(InOut_Id,Chemical_Id,ChemicalName,InOutType,Quantity,Unit,OperatorName,Reason,BatchNo,InOutDate,Creator,CreateDate) VALUES
(1,1,N'丙酮',       N'Out',5.0000, N'升',  N'库管张',N'维修部领用',  N'BN-2026-001','2026-03-02',N'system','2026-03-02'),
(2,2,N'切削液CL-200',N'In', 100.0000,N'升',  N'库管张',N'采购入库',    N'BN-2026-002','2026-03-10',N'system','2026-03-10'),
(3,2,N'切削液CL-200',N'Out',50.0000, N'升',  N'库管张',N'机加工车间补充',N'BN-2026-002','2026-03-16',N'system','2026-03-16');
SET IDENTITY_INSERT [EHS_ChemicalInOut] OFF;

-- 21. 程序文件
SET IDENTITY_INSERT [EHS_Document] ON;
INSERT INTO EHS_Document(Doc_Id,DocType,DocNo,DocName,Version,IssueDate,ReviewDate,Status,Creator,CreateDate) VALUES
(1,N'程序文件',N'EHS-P-001',N'EHS管理手册',          N'V3.0','2026-01-01','2027-01-01',1,N'system','2026-01-01'),
(2,N'制度文件',N'EHS-R-001',N'危险化学品管理规定',    N'V2.0','2026-01-15','2027-01-15',1,N'system','2026-01-15'),
(3,N'标准规范',N'EHS-S-001',N'个人防护用品使用标准',  N'V1.5','2026-02-01','2027-02-01',1,N'system','2026-02-01'),
(4,N'程序文件',N'EHS-P-002',N'隐患排查治理管理程序',  N'V2.1','2026-02-20','2027-02-20',1,N'system','2026-02-20');
SET IDENTITY_INSERT [EHS_Document] OFF;

-- 22. 法规与信息
SET IDENTITY_INSERT [EHS_Information] ON;
INSERT INTO EHS_Information(Info_Id,InfoType,Title,Source,PublishDate,Status,Creator,CreateDate) VALUES
(1,N'法规更新',N'《安全生产法》2026年修订要点',      N'应急管理部','2026-01-15',1,N'system','2026-01-20'),
(2,N'政府通知',N'苏州工业园区2026年安全生产月活动通知',N'园区安监局','2026-03-01',1,N'system','2026-03-05'),
(3,N'外部事故',N'某汽车零部件企业冲压车间事故通报',    N'行业协会',  '2026-02-20',1,N'system','2026-02-25');
SET IDENTITY_INSERT [EHS_Information] OFF;

-- 23. 会议记录
SET IDENTITY_INSERT [EHS_Meeting] ON;
INSERT INTO EHS_Meeting(Meeting_Id,MeetingName,MeetingType,MeetingDate,Location,OrganizerName,Status,Creator,CreateDate) VALUES
(1,N'2026年3月安全生产例会',N'例会',  '2026-03-05',N'会议室A',N'张总',2,N'system','2026-03-01'),
(2,N'冲压车间隐患整改专题会',N'专题会','2026-03-15',N'会议室B',N'李经理',2,N'system','2026-03-12'),
(3,N'Q2安全工作部署会议',    N'例会',  '2026-04-02',N'大会议室',N'张总',0,N'system','2026-03-20');
SET IDENTITY_INSERT [EHS_Meeting] OFF;

-- 24. 会议签到
SET IDENTITY_INSERT [EHS_MeetingSignIn] ON;
INSERT INTO EHS_MeetingSignIn(SignIn_Id,Meeting_Id,UserId,UserName,DeptName,SignInTime,SignInType,Status) VALUES
(1,1,1,N'张总',  N'管理层',  '2026-03-05 09:00',N'Manual',1),
(2,1,2,N'李经理',N'EHS部',   '2026-03-05 09:02',N'QRCode',1),
(3,1,3,N'王主管',N'机加工车间','2026-03-05 09:05',N'QRCode',1),
(4,2,2,N'李经理',N'EHS部',   '2026-03-15 14:00',N'Manual',1),
(5,2,4,N'赵工长',N'冲压车间', '2026-03-15 14:01',N'Manual',1);
SET IDENTITY_INSERT [EHS_MeetingSignIn] OFF;

-- 25. 供应商列表
SET IDENTITY_INSERT [EHS_Supplier] ON;
INSERT INTO EHS_Supplier(Supplier_Id,SupplierName,SupplierType,ContactPerson,ContactPhone,Level,EvaluationScore,ContractStartDate,ContractEndDate,Status,Creator,CreateDate) VALUES
(1,N'苏州安达施工有限公司',  N'施工承包',  N'周经理',N'13900001111',N'A',92.5, '2026-01-01','2026-12-31',1,N'system','2026-01-01'),
(2,N'苏州环保处置有限公司',  N'危废处置',  N'吴经理',N'13900002222',N'A',95.0, '2026-01-01','2027-06-30',1,N'system','2026-01-01'),
(3,N'苏州化工有限公司',      N'化学品供应',N'钱经理',N'13900003333',N'B',85.0, '2026-01-01','2026-12-31',1,N'system','2026-01-01');
SET IDENTITY_INSERT [EHS_Supplier] OFF;

-- 26. 施工项目
SET IDENTITY_INSERT [EHS_ConstructionProject] ON;
INSERT INTO EHS_ConstructionProject(Project_Id,ProjectNo,ProjectName,SupplierName,ProjectManager,Location,PlanStartDate,PlanEndDate,RiskLevel,Status,Creator,CreateDate) VALUES
(1,N'GC-2026-001',N'厂房屋顶防水翻新工程',    N'苏州安达施工有限公司',N'周工',N'装配车间屋顶','2026-04-01','2026-04-30',N'较大',1,N'system','2026-03-15'),
(2,N'GC-2026-002',N'配电室扩容改造工程',      N'苏州安达施工有限公司',N'周工',N'动力站',     '2026-05-01','2026-06-15',N'重大',0,N'system','2026-03-20'),
(3,N'GC-2026-003',N'危废暂存库改建项目',      N'苏州安达施工有限公司',N'周工',N'危废库',     '2026-03-10','2026-03-25',N'一般',2,N'system','2026-03-01');
SET IDENTITY_INSERT [EHS_ConstructionProject] OFF;

PRINT N'';
PRINT N'============================================================';
PRINT N'✅ EHS 示例数据插入完成！共 26 张表';
PRINT N'============================================================';
GO
