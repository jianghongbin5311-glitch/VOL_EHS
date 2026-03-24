-- ============================================================
-- EHS 信息化平台 - 第2步：创建 EHS 业务表
-- 在 nxt_ehs_biz 数据库上执行
-- ============================================================
-- 版本：v1.0
-- 说明：覆盖 EHS 需求表全部 9 大类 / 31+ 子功能所需的业务表
-- 策略：先建核心表，后续迭代扩展字段
-- ============================================================

USE [nxt_ehs_biz];
GO

-- ============================================================
-- 0. 公共字典表
-- ============================================================

-- 数据字典主表
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Dictionary')
CREATE TABLE [dbo].[EHS_Dictionary](
    [Dict_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [DictType]      NVARCHAR(50)  NOT NULL,   -- 字典类型编码
    [DictTypeName]  NVARCHAR(100) NULL,        -- 字典类型名称
    [DictCode]      NVARCHAR(50)  NOT NULL,   -- 字典值编码
    [DictName]      NVARCHAR(200) NOT NULL,   -- 字典值名称
    [DictValue]     NVARCHAR(500) NULL,        -- 扩展值
    [OrderNo]       INT DEFAULT 0,
    [Enable]        INT DEFAULT 1,             -- 1=启用 0=禁用
    [Remark]        NVARCHAR(500) NULL,
    [CreateDate]    DATETIME DEFAULT GETDATE(),
    [Creator]       NVARCHAR(50) NULL,
    [ModifyDate]    DATETIME NULL,
    [Modifier]      NVARCHAR(50) NULL
);
GO

-- 部门/区域映射表（用于隐患归属、作业票归属等）
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Department')
CREATE TABLE [dbo].[EHS_Department](
    [Dept_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [DeptCode]      NVARCHAR(50) NOT NULL,
    [DeptName]      NVARCHAR(100) NOT NULL,
    [ParentId]      INT DEFAULT 0,
    [Area]          NVARCHAR(100) NULL,        -- 所属区域/车间
    [OrderNo]       INT DEFAULT 0,
    [Enable]        INT DEFAULT 1,
    [CreateDate]    DATETIME DEFAULT GETDATE(),
    [Creator]       NVARCHAR(50) NULL,
    [ModifyDate]    DATETIME NULL,
    [Modifier]      NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 1. 安全 - 台账管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_SafetyLedger')
CREATE TABLE [dbo].[EHS_SafetyLedger](
    [Ledger_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [LedgerType]      NVARCHAR(50)  NOT NULL,   -- 投入台账/制度台账/奖罚台账/相关方台账
    [LedgerNo]        NVARCHAR(50)  NULL,        -- 台账编号
    [Title]           NVARCHAR(200) NOT NULL,    -- 台账标题
    [Content]         NVARCHAR(MAX) NULL,        -- 详细内容
    [Amount]          DECIMAL(18,2) NULL,        -- 金额（投入/奖罚等）
    [DeptId]          INT NULL,                  -- 所属部门
    [DeptName]        NVARCHAR(100) NULL,
    [OccurDate]       DATETIME NULL,             -- 发生日期
    [Status]          INT DEFAULT 0,             -- 0=草稿 1=已确认
    [AttachmentUrl]   NVARCHAR(500) NULL,        -- 附件路径
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 2. 安全 - 隐患排查
-- ============================================================

-- 隐患排查任务/计划
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_HazardInspection')
CREATE TABLE [dbo].[EHS_HazardInspection](
    [Inspection_Id]   INT IDENTITY(1,1) PRIMARY KEY,
    [InspectionNo]    NVARCHAR(50) NULL,         -- 检查编号
    [InspectionType]  NVARCHAR(50) NOT NULL,     -- SOT/专项/节假日/综合
    [Title]           NVARCHAR(200) NOT NULL,
    [PlanDate]        DATETIME NULL,             -- 计划检查日期
    [ActualDate]      DATETIME NULL,             -- 实际检查日期
    [Area]            NVARCHAR(100) NULL,        -- 检查区域
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [InspectorId]     INT NULL,                  -- 检查人ID
    [InspectorName]   NVARCHAR(50) NULL,
    [Status]          INT DEFAULT 0,             -- 0=计划 1=进行中 2=已完成
    [TotalItems]      INT DEFAULT 0,             -- 检查项数
    [HazardCount]     INT DEFAULT 0,             -- 发现隐患数
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 隐患排查检查项明细（主从表-从表）
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_HazardInspectionItem')
CREATE TABLE [dbo].[EHS_HazardInspectionItem](
    [Item_Id]         INT IDENTITY(1,1) PRIMARY KEY,
    [Inspection_Id]   INT NOT NULL,              -- 外键→主表
    [CheckItem]       NVARCHAR(200) NOT NULL,    -- 检查项内容
    [Standard]        NVARCHAR(500) NULL,        -- 检查标准
    [Result]          INT NULL,                  -- 0=合格 1=不合格 2=不适用
    [Description]     NVARCHAR(500) NULL,        -- 检查描述
    [PhotoUrl]        NVARCHAR(500) NULL,        -- 现场照片
    [OrderNo]         INT DEFAULT 0,
    [CreateDate]      DATETIME DEFAULT GETDATE()
);
GO

-- 隐患上报主表（含闭环管理状态）
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_HazardReport')
CREATE TABLE [dbo].[EHS_HazardReport](
    [Hazard_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [HazardNo]        NVARCHAR(50) NULL,         -- 隐患编号（自动生成）
    [Inspection_Id]   INT NULL,                  -- 关联排查任务（可空，手动上报不关联）
    [HazardLevel]     NVARCHAR(20) NOT NULL,     -- 一般隐患/重大隐患
    [HazardType]      NVARCHAR(50) NULL,         -- 隐患类别
    [Title]           NVARCHAR(200) NOT NULL,    -- 隐患描述
    [Description]     NVARCHAR(MAX) NULL,        -- 详细描述
    [Location]        NVARCHAR(200) NULL,        -- 发现位置
    [DeptId]          INT NULL,                  -- 责任部门ID
    [DeptName]        NVARCHAR(100) NULL,
    [DiscoveryDate]   DATETIME NULL,             -- 发现日期
    [ReporterId]      INT NULL,                  -- 上报人ID
    [ReporterName]    NVARCHAR(50) NULL,
    [PhotoUrl1]       NVARCHAR(500) NULL,        -- 现场照片1
    [PhotoUrl2]       NVARCHAR(500) NULL,        -- 现场照片2
    [PhotoUrl3]       NVARCHAR(500) NULL,        -- 现场照片3
    -- 闭环管理字段
    [Status]          INT DEFAULT 0,             -- 0=待核查 1=已确认 2=整改中 3=待验收 4=已关闭
    [VerifierId]      INT NULL,                  -- 核查人ID
    [VerifierName]    NVARCHAR(50) NULL,
    [VerifyDate]      DATETIME NULL,
    [VerifyRemark]    NVARCHAR(500) NULL,
    -- 整改信息
    [RectifyDeptId]   INT NULL,                  -- 整改责任部门
    [RectifyDeptName] NVARCHAR(100) NULL,
    [RectifyPersonId] INT NULL,                  -- 整改责任人
    [RectifyPersonName] NVARCHAR(50) NULL,
    [RectifyDeadline] DATETIME NULL,             -- 整改期限
    [RectifyPlan]     NVARCHAR(MAX) NULL,        -- 整改方案
    [RectifyResult]   NVARCHAR(MAX) NULL,        -- 整改结果
    [RectifyDate]     DATETIME NULL,             -- 整改完成日期
    [RectifyPhotoUrl] NVARCHAR(500) NULL,        -- 整改后照片
    -- 验收信息
    [AccepterId]      INT NULL,                  -- 验收人ID
    [AccepterName]    NVARCHAR(50) NULL,
    [AcceptDate]      DATETIME NULL,
    [AcceptResult]    INT NULL,                  -- 0=验收不通过 1=验收通过
    [AcceptRemark]    NVARCHAR(500) NULL,
    -- 关闭
    [CloseDate]       DATETIME NULL,
    [CloseRemark]     NVARCHAR(500) NULL,
    --
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 3. 安全 - 教育培训
-- ============================================================

-- 课程库
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Course')
CREATE TABLE [dbo].[EHS_Course](
    [Course_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [CourseNo]        NVARCHAR(50) NULL,
    [CourseName]      NVARCHAR(200) NOT NULL,
    [CourseType]      NVARCHAR(50) NULL,         -- 安全教育/操作规程/应急培训/入职培训等
    [Description]     NVARCHAR(MAX) NULL,
    [Duration]        INT NULL,                  -- 课时（分钟）
    [AttachmentUrl]   NVARCHAR(500) NULL,        -- 课件/视频路径
    [Status]          INT DEFAULT 1,             -- 1=启用 0=禁用
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 试题库
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_QuestionBank')
CREATE TABLE [dbo].[EHS_QuestionBank](
    [Question_Id]     INT IDENTITY(1,1) PRIMARY KEY,
    [QuestionType]    INT NOT NULL,              -- 1=单选 2=多选 3=判断
    [Category]        NVARCHAR(50) NULL,         -- 题目分类
    [Content]         NVARCHAR(MAX) NOT NULL,    -- 题目内容
    [OptionA]         NVARCHAR(500) NULL,
    [OptionB]         NVARCHAR(500) NULL,
    [OptionC]         NVARCHAR(500) NULL,
    [OptionD]         NVARCHAR(500) NULL,
    [Answer]          NVARCHAR(50) NOT NULL,     -- 正确答案
    [Score]           INT DEFAULT 1,             -- 分值
    [Difficulty]      INT DEFAULT 1,             -- 1=简单 2=中等 3=困难
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 试卷模板
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_ExamPaper')
CREATE TABLE [dbo].[EHS_ExamPaper](
    [Paper_Id]        INT IDENTITY(1,1) PRIMARY KEY,
    [PaperName]       NVARCHAR(200) NOT NULL,
    [PaperType]       NVARCHAR(50) NULL,         -- 随机组卷/固定试卷
    [TotalScore]      INT DEFAULT 100,
    [PassScore]       INT DEFAULT 60,
    [TimeLimit]       INT DEFAULT 60,            -- 考试时长（分钟）
    [QuestionCount]   INT NULL,                  -- 题目数量
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 试卷-试题关联
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_ExamPaperQuestion')
CREATE TABLE [dbo].[EHS_ExamPaperQuestion](
    [Id]              INT IDENTITY(1,1) PRIMARY KEY,
    [Paper_Id]        INT NOT NULL,
    [Question_Id]     INT NOT NULL,
    [OrderNo]         INT DEFAULT 0,
    [Score]           INT DEFAULT 1
);
GO

-- 培训计划
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_TrainingPlan')
CREATE TABLE [dbo].[EHS_TrainingPlan](
    [Plan_Id]         INT IDENTITY(1,1) PRIMARY KEY,
    [PlanNo]          NVARCHAR(50) NULL,
    [PlanName]        NVARCHAR(200) NOT NULL,
    [TrainingType]    NVARCHAR(50) NULL,         -- 安全培训/入职培训/三级安全教育等
    [Course_Id]       INT NULL,                  -- 关联课程
    [Paper_Id]        INT NULL,                  -- 关联试卷
    [PlanStartDate]   DATETIME NULL,
    [PlanEndDate]     DATETIME NULL,
    [TrainingMode]    NVARCHAR(20) NULL,         -- 线上/线下/混合
    [Location]        NVARCHAR(200) NULL,        -- 培训地点
    [TrainerId]       INT NULL,                  -- 培训讲师ID
    [TrainerName]     NVARCHAR(50) NULL,
    [TargetDeptId]    INT NULL,                  -- 目标部门
    [TargetDeptName]  NVARCHAR(100) NULL,
    [TargetCount]     INT NULL,                  -- 目标人数
    [ActualCount]     INT NULL,                  -- 实际参训人数
    [PassCount]       INT NULL,                  -- 通过人数
    [Status]          INT DEFAULT 0,             -- 0=计划 1=进行中 2=已完成
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 培训记录 / 考试成绩
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_TrainingRecord')
CREATE TABLE [dbo].[EHS_TrainingRecord](
    [Record_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [Plan_Id]         INT NULL,                  -- 关联培训计划
    [UserId]          INT NOT NULL,              -- 参训人
    [UserName]        NVARCHAR(50) NULL,
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [TrainingDate]    DATETIME NULL,             -- 培训日期
    [ExamScore]       DECIMAL(5,1) NULL,         -- 考试成绩
    [IsPassed]        INT NULL,                  -- 0=未通过 1=通过
    [CertificateNo]   NVARCHAR(50) NULL,         -- 证书编号
    [SignUrl]         NVARCHAR(500) NULL,        -- 签到凭证
    [Status]          INT DEFAULT 0,             -- 0=待培训 1=已培训 2=已考试
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 4. 安全 - 特殊作业票
-- ============================================================

-- 作业票主表
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_WorkPermit')
CREATE TABLE [dbo].[EHS_WorkPermit](
    [Permit_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [PermitNo]        NVARCHAR(50) NULL,         -- 作业票编号
    [PermitType]      NVARCHAR(50) NOT NULL,     -- 动火/高处/受限空间/临时用电/吊装/断路/动土/盲板
    [Title]           NVARCHAR(200) NOT NULL,
    [WorkContent]     NVARCHAR(MAX) NULL,        -- 作业内容
    [WorkLocation]    NVARCHAR(200) NULL,        -- 作业地点
    [DeptId]          INT NULL,                  -- 申请部门
    [DeptName]        NVARCHAR(100) NULL,
    [ApplicantId]     INT NULL,                  -- 申请人
    [ApplicantName]   NVARCHAR(50) NULL,
    [ContractorName]  NVARCHAR(200) NULL,        -- 承包商名称
    [WorkStartTime]   DATETIME NULL,             -- 计划开始时间
    [WorkEndTime]     DATETIME NULL,             -- 计划结束时间
    [RiskLevel]       NVARCHAR(20) NULL,         -- 风险等级：低/一般/较大/重大
    -- 审批信息
    [Status]          INT DEFAULT 0,             -- 0=草稿 1=待审批 2=审批中 3=已批准 4=作业中 5=待关闭 6=已关闭 7=已驳回
    [ApproverIds]     NVARCHAR(500) NULL,        -- 审批人ID列表
    [ApprovalDate]    DATETIME NULL,
    [WorkFlowId]      INT NULL,                  -- 关联内建流程
    -- 签名
    [ApplicantSign]   NVARCHAR(500) NULL,        -- 申请人签名图片URL
    [ApproverSign]    NVARCHAR(500) NULL,        -- 审批人签名图片URL
    -- 关闭
    [ActualEndTime]   DATETIME NULL,
    [CloseRemark]     NVARCHAR(500) NULL,
    --
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 作业票安全措施
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_WorkPermitMeasure')
CREATE TABLE [dbo].[EHS_WorkPermitMeasure](
    [Measure_Id]      INT IDENTITY(1,1) PRIMARY KEY,
    [Permit_Id]       INT NOT NULL,
    [MeasureContent]  NVARCHAR(500) NOT NULL,    -- 安全措施内容
    [IsConfirmed]     INT DEFAULT 0,             -- 0=未确认 1=已确认
    [ConfirmerId]     INT NULL,
    [ConfirmerName]   NVARCHAR(50) NULL,
    [ConfirmDate]     DATETIME NULL,
    [OrderNo]         INT DEFAULT 0,
    [CreateDate]      DATETIME DEFAULT GETDATE()
);
GO

-- 作业过程监督记录
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_WorkPermitMonitor')
CREATE TABLE [dbo].[EHS_WorkPermitMonitor](
    [Monitor_Id]      INT IDENTITY(1,1) PRIMARY KEY,
    [Permit_Id]       INT NOT NULL,
    [MonitorTime]     DATETIME NOT NULL,         -- 监督时间
    [MonitorPersonId] INT NULL,
    [MonitorPersonName] NVARCHAR(50) NULL,
    [MonitorContent]  NVARCHAR(MAX) NULL,        -- 监督内容
    [GasTestResult]   NVARCHAR(500) NULL,        -- 气体分析结果
    [IsNormal]        INT DEFAULT 1,             -- 1=正常 0=异常
    [AbnormalAction]  NVARCHAR(500) NULL,        -- 异常处理措施
    [IsStopped]       INT DEFAULT 0,             -- 是否中止作业
    [PhotoUrl]        NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL
);
GO

-- ============================================================
-- 5. 安全 - 应急管理
-- ============================================================

-- 应急资源（队伍+物资统一管理）
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_EmergencyResource')
CREATE TABLE [dbo].[EHS_EmergencyResource](
    [Resource_Id]     INT IDENTITY(1,1) PRIMARY KEY,
    [ResourceType]    NVARCHAR(20) NOT NULL,     -- Team=队伍 Supply=物资
    [ResourceName]    NVARCHAR(200) NOT NULL,
    [Description]     NVARCHAR(MAX) NULL,
    [Quantity]        INT NULL,                  -- 数量（物资）
    [ContactPerson]   NVARCHAR(50) NULL,         -- 联系人（队伍）
    [ContactPhone]    NVARCHAR(50) NULL,
    [Location]        NVARCHAR(200) NULL,        -- 存放位置/集合位置
    [ExpiryDate]      DATETIME NULL,             -- 有效期（物资）
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 应急预案
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_EmergencyPlan')
CREATE TABLE [dbo].[EHS_EmergencyPlan](
    [Plan_Id]         INT IDENTITY(1,1) PRIMARY KEY,
    [PlanType]        NVARCHAR(50) NOT NULL,     -- 综合预案/专项预案/处置方案
    [PlanName]        NVARCHAR(200) NOT NULL,
    [PlanNo]          NVARCHAR(50) NULL,
    [Version]         NVARCHAR(20) NULL,
    [Description]     NVARCHAR(MAX) NULL,
    [AttachmentUrl]   NVARCHAR(500) NULL,
    [ApprovalDate]    DATETIME NULL,
    [ReviewDate]      DATETIME NULL,             -- 下次评审日期
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 应急演练
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_EmergencyDrill')
CREATE TABLE [dbo].[EHS_EmergencyDrill](
    [Drill_Id]        INT IDENTITY(1,1) PRIMARY KEY,
    [Plan_Id]         INT NULL,                  -- 关联预案
    [DrillName]       NVARCHAR(200) NOT NULL,
    [DrillDate]       DATETIME NULL,
    [DrillType]       NVARCHAR(50) NULL,         -- 桌面演练/实战演练/综合演练
    [Participants]    INT NULL,                  -- 参与人数
    [Location]        NVARCHAR(200) NULL,
    [Content]         NVARCHAR(MAX) NULL,        -- 演练内容
    [Evaluation]      NVARCHAR(MAX) NULL,        -- 演练评估
    [ImprovePlan]     NVARCHAR(MAX) NULL,        -- 改进计划
    [PhotoUrl]        NVARCHAR(500) NULL,
    [Status]          INT DEFAULT 0,             -- 0=计划 1=已完成
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 6. 安全 - 事故管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Accident')
CREATE TABLE [dbo].[EHS_Accident](
    [Accident_Id]     INT IDENTITY(1,1) PRIMARY KEY,
    [AccidentNo]      NVARCHAR(50) NULL,
    [AccidentType]    NVARCHAR(50) NOT NULL,     -- 工伤/火灾/泄漏/设备/交通/其他
    [AccidentLevel]   NVARCHAR(20) NULL,         -- 一般/较大/重大/特别重大
    [Title]           NVARCHAR(200) NOT NULL,
    [OccurDate]       DATETIME NULL,
    [OccurLocation]   NVARCHAR(200) NULL,
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [Description]     NVARCHAR(MAX) NULL,        -- 事故经过
    [DirectCause]     NVARCHAR(MAX) NULL,        -- 直接原因
    [RootCause]       NVARCHAR(MAX) NULL,        -- 根本原因
    [Injuries]        INT DEFAULT 0,             -- 受伤人数
    [Fatalities]      INT DEFAULT 0,             -- 死亡人数
    [EconomicLoss]    DECIMAL(18,2) NULL,        -- 经济损失
    [ReporterId]      INT NULL,
    [ReporterName]    NVARCHAR(50) NULL,
    [PhotoUrl]        NVARCHAR(500) NULL,
    -- 调查处理
    [InvestigatorId]  INT NULL,
    [InvestigatorName] NVARCHAR(50) NULL,
    [InvestigationReport] NVARCHAR(MAX) NULL,    -- 调查报告
    [CorrectiveAction] NVARCHAR(MAX) NULL,       -- 纠正措施
    [PreventiveAction] NVARCHAR(MAX) NULL,       -- 预防措施
    -- 闭环状态
    [Status]          INT DEFAULT 0,             -- 0=已上报 1=待审核 2=调查中 3=已结案
    [CloseDate]       DATETIME NULL,
    [WorkFlowId]      INT NULL,
    --
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 7. 环境 - 危废管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_HazardousWaste')
CREATE TABLE [dbo].[EHS_HazardousWaste](
    [HW_Id]           INT IDENTITY(1,1) PRIMARY KEY,
    [WasteCode]       NVARCHAR(50) NULL,         -- 危废代码
    [WasteName]       NVARCHAR(200) NOT NULL,    -- 危废名称
    [WasteCategory]   NVARCHAR(100) NULL,        -- 危废类别
    [Quantity]        DECIMAL(18,4) NULL,         -- 数量
    [Unit]            NVARCHAR(20) NULL,          -- 单位（kg/吨/桶等）
    [StorageLocation] NVARCHAR(200) NULL,         -- 暂存位置
    [GenerateDeptId]  INT NULL,                   -- 产生部门
    [GenerateDeptName] NVARCHAR(100) NULL,
    [GenerateDate]    DATETIME NULL,              -- 产生日期
    [DisposalMethod]  NVARCHAR(100) NULL,         -- 处置方式
    [DisposalVendor]  NVARCHAR(200) NULL,         -- 处置单位
    [DisposalDate]    DATETIME NULL,              -- 处置日期
    [ManifestNo]      NVARCHAR(100) NULL,         -- 转移联单号
    [Status]          INT DEFAULT 0,             -- 0=暂存 1=已转移 2=已处置
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 8. 环境 - 一般固废管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_SolidWaste')
CREATE TABLE [dbo].[EHS_SolidWaste](
    [SW_Id]           INT IDENTITY(1,1) PRIMARY KEY,
    [WasteType]       NVARCHAR(100) NOT NULL,    -- 固废种类
    [Quantity]        DECIMAL(18,4) NULL,
    [Unit]            NVARCHAR(20) NULL,
    [Period]          NVARCHAR(20) NULL,          -- 月份：2026-04 等
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [DisposalMethod]  NVARCHAR(100) NULL,
    [DisposalVendor]  NVARCHAR(200) NULL,
    [DisposalDate]    DATETIME NULL,
    [Status]          INT DEFAULT 0,
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 9. 职业健康 - PPE管理
-- ============================================================

-- PPE 标准/清单
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_PPEStandard')
CREATE TABLE [dbo].[EHS_PPEStandard](
    [PPE_Id]          INT IDENTITY(1,1) PRIMARY KEY,
    [PPEName]         NVARCHAR(200) NOT NULL,    -- PPE名称
    [PPEType]         NVARCHAR(50) NULL,         -- 类别
    [Specification]   NVARCHAR(200) NULL,        -- 规格型号
    [Standard]        NVARCHAR(200) NULL,        -- 发放标准
    [Frequency]       NVARCHAR(50) NULL,         -- 更换周期
    [ApplicablePost]  NVARCHAR(200) NULL,        -- 适用岗位
    [Stock]           INT DEFAULT 0,             -- 库存数量
    [MinStock]        INT DEFAULT 0,             -- 最低库存预警
    [Unit]            NVARCHAR(20) NULL,
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- PPE 领用记录
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_PPEDistribution')
CREATE TABLE [dbo].[EHS_PPEDistribution](
    [Distribution_Id] INT IDENTITY(1,1) PRIMARY KEY,
    [PPE_Id]          INT NOT NULL,
    [PPEName]         NVARCHAR(200) NULL,
    [UserId]          INT NULL,
    [UserName]        NVARCHAR(50) NULL,
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [Quantity]        INT NOT NULL,
    [DistributeDate]  DATETIME DEFAULT GETDATE(),
    [ReturnDate]      DATETIME NULL,             -- 归还日期
    [Status]          INT DEFAULT 0,             -- 0=已领用 1=已归还
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 10. 化学品管理
-- ============================================================

-- 化学品主数据
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Chemical')
CREATE TABLE [dbo].[EHS_Chemical](
    [Chemical_Id]     INT IDENTITY(1,1) PRIMARY KEY,
    [ChemicalName]    NVARCHAR(200) NOT NULL,
    [ChemicalNameEN]  NVARCHAR(200) NULL,        -- 英文名
    [CASNo]           NVARCHAR(50) NULL,         -- CAS号
    [Category]        NVARCHAR(100) NULL,        -- 分类
    [DangerLevel]     NVARCHAR(20) NULL,         -- 危险等级
    [MSDSUrl]         NVARCHAR(500) NULL,        -- MSDS文件
    [StorageRequire]  NVARCHAR(500) NULL,        -- 存储要求
    [Supplier]        NVARCHAR(200) NULL,
    [Stock]           DECIMAL(18,4) DEFAULT 0,
    [Unit]            NVARCHAR(20) NULL,
    [MinStock]        DECIMAL(18,4) DEFAULT 0,
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 化学品申请审批
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_ChemicalApplication')
CREATE TABLE [dbo].[EHS_ChemicalApplication](
    [Application_Id]  INT IDENTITY(1,1) PRIMARY KEY,
    [ApplicationNo]   NVARCHAR(50) NULL,
    [Chemical_Id]     INT NOT NULL,
    [ChemicalName]    NVARCHAR(200) NULL,
    [Quantity]        DECIMAL(18,4) NOT NULL,
    [Unit]            NVARCHAR(20) NULL,
    [Purpose]         NVARCHAR(500) NULL,        -- 用途
    [ApplicantId]     INT NULL,
    [ApplicantName]   NVARCHAR(50) NULL,
    [DeptId]          INT NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [Status]          INT DEFAULT 0,             -- 0=申请中 1=已批准 2=已驳回 3=已领取
    [ApproverRemark]  NVARCHAR(500) NULL,
    [WorkFlowId]      INT NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 化学品出入库记录
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_ChemicalInOut')
CREATE TABLE [dbo].[EHS_ChemicalInOut](
    [InOut_Id]        INT IDENTITY(1,1) PRIMARY KEY,
    [Chemical_Id]     INT NOT NULL,
    [ChemicalName]    NVARCHAR(200) NULL,
    [InOutType]       NVARCHAR(10) NOT NULL,     -- In=入库 Out=出库
    [Quantity]        DECIMAL(18,4) NOT NULL,
    [Unit]            NVARCHAR(20) NULL,
    [OperatorId]      INT NULL,
    [OperatorName]    NVARCHAR(50) NULL,
    [Reason]          NVARCHAR(500) NULL,        -- 出入库原因
    [BatchNo]         NVARCHAR(50) NULL,         -- 批次号
    [InOutDate]       DATETIME DEFAULT GETDATE(),
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL
);
GO

-- ============================================================
-- 11. 文件管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Document')
CREATE TABLE [dbo].[EHS_Document](
    [Doc_Id]          INT IDENTITY(1,1) PRIMARY KEY,
    [DocType]         NVARCHAR(50) NOT NULL,     -- 程序文件/制度文件/标准规范等
    [DocNo]           NVARCHAR(50) NULL,         -- 文件编号
    [DocName]         NVARCHAR(200) NOT NULL,
    [Version]         NVARCHAR(20) NULL,
    [Description]     NVARCHAR(MAX) NULL,
    [AttachmentUrl]   NVARCHAR(500) NULL,
    [IssueDate]       DATETIME NULL,             -- 发布日期
    [ReviewDate]      DATETIME NULL,             -- 下次评审日期
    [Status]          INT DEFAULT 1,             -- 1=有效 0=作废
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 12. 信息管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Information')
CREATE TABLE [dbo].[EHS_Information](
    [Info_Id]         INT IDENTITY(1,1) PRIMARY KEY,
    [InfoType]        NVARCHAR(50) NOT NULL,     -- 法规更新/外部事故/政府通知
    [Title]           NVARCHAR(200) NOT NULL,
    [Content]         NVARCHAR(MAX) NULL,
    [Source]          NVARCHAR(200) NULL,         -- 来源
    [PublishDate]     DATETIME NULL,
    [EffectiveDate]   DATETIME NULL,
    [AttachmentUrl]   NVARCHAR(500) NULL,
    [IsRead]          INT DEFAULT 0,
    [Status]          INT DEFAULT 1,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 13. 会议管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Meeting')
CREATE TABLE [dbo].[EHS_Meeting](
    [Meeting_Id]      INT IDENTITY(1,1) PRIMARY KEY,
    [MeetingName]     NVARCHAR(200) NOT NULL,
    [MeetingType]     NVARCHAR(50) NULL,         -- 例会/专题会/应急会
    [MeetingDate]     DATETIME NULL,
    [Location]        NVARCHAR(200) NULL,
    [OrganizerId]     INT NULL,
    [OrganizerName]   NVARCHAR(50) NULL,
    [Agenda]          NVARCHAR(MAX) NULL,        -- 会议议程
    [Minutes]         NVARCHAR(MAX) NULL,        -- 会议纪要
    [AttachmentUrl]   NVARCHAR(500) NULL,
    [Status]          INT DEFAULT 0,             -- 0=计划 1=进行中 2=已结束
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- 会议签到
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_MeetingSignIn')
CREATE TABLE [dbo].[EHS_MeetingSignIn](
    [SignIn_Id]       INT IDENTITY(1,1) PRIMARY KEY,
    [Meeting_Id]      INT NOT NULL,
    [UserId]          INT NOT NULL,
    [UserName]        NVARCHAR(50) NULL,
    [DeptName]        NVARCHAR(100) NULL,
    [SignInTime]      DATETIME NULL,
    [SignInType]      NVARCHAR(20) NULL,         -- Manual=手动 QRCode=扫码 Location=定位
    [LocationInfo]    NVARCHAR(200) NULL,        -- 定位信息
    [Status]          INT DEFAULT 0              -- 0=未签到 1=已签到
);
GO

-- ============================================================
-- 14. 供应商管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_Supplier')
CREATE TABLE [dbo].[EHS_Supplier](
    [Supplier_Id]     INT IDENTITY(1,1) PRIMARY KEY,
    [SupplierName]    NVARCHAR(200) NOT NULL,
    [SupplierType]    NVARCHAR(50) NULL,         -- 施工承包/劳务/化学品/危废处置等
    [ContactPerson]   NVARCHAR(50) NULL,
    [ContactPhone]    NVARCHAR(50) NULL,
    [Address]         NVARCHAR(500) NULL,
    [Qualification]   NVARCHAR(500) NULL,        -- 资质信息
    [QualificationUrl] NVARCHAR(500) NULL,       -- 资质文件
    [Level]           NVARCHAR(20) NULL,         -- A/B/C 等级
    [EvaluationScore] DECIMAL(5,1) NULL,         -- 评估分数
    [ContractStartDate] DATETIME NULL,
    [ContractEndDate] DATETIME NULL,
    [Status]          INT DEFAULT 0,             -- 0=待审批 1=已批准 2=已禁用
    [WorkFlowId]      INT NULL,
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO

-- ============================================================
-- 15. 施工项目管理
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_ConstructionProject')
CREATE TABLE [dbo].[EHS_ConstructionProject](
    [Project_Id]      INT IDENTITY(1,1) PRIMARY KEY,
    [ProjectNo]       NVARCHAR(50) NULL,
    [ProjectName]     NVARCHAR(200) NOT NULL,
    [Supplier_Id]     INT NULL,                  -- 关联供应商
    [SupplierName]    NVARCHAR(200) NULL,
    [ProjectManager]  NVARCHAR(50) NULL,
    [ProjectManagerPhone] NVARCHAR(50) NULL,
    [Location]        NVARCHAR(200) NULL,
    [PlanStartDate]   DATETIME NULL,
    [PlanEndDate]     DATETIME NULL,
    [ActualStartDate] DATETIME NULL,
    [ActualEndDate]   DATETIME NULL,
    [Description]     NVARCHAR(MAX) NULL,
    [RiskLevel]       NVARCHAR(20) NULL,         -- 风险等级
    [Status]          INT DEFAULT 0,             -- 0=待审批 1=已批准 2=施工中 3=已完工 4=已验收
    [WorkFlowId]      INT NULL,
    [Remark]          NVARCHAR(500) NULL,
    [CreateDate]      DATETIME DEFAULT GETDATE(),
    [Creator]         NVARCHAR(50) NULL,
    [CreateID]        INT NULL,
    [ModifyDate]      DATETIME NULL,
    [Modifier]        NVARCHAR(50) NULL
);
GO


PRINT N'';
PRINT N'============================================================';
PRINT N'✅ EHS 业务表创建完成！共 28 张表';
PRINT N'';
PRINT N'  公共表：EHS_Dictionary, EHS_Department';
PRINT N'  安全-台账：EHS_SafetyLedger';
PRINT N'  安全-隐患：EHS_HazardInspection, EHS_HazardInspectionItem, EHS_HazardReport';
PRINT N'  安全-培训：EHS_Course, EHS_QuestionBank, EHS_ExamPaper,';
PRINT N'             EHS_ExamPaperQuestion, EHS_TrainingPlan, EHS_TrainingRecord';
PRINT N'  安全-作业票：EHS_WorkPermit, EHS_WorkPermitMeasure, EHS_WorkPermitMonitor';
PRINT N'  安全-应急：EHS_EmergencyResource, EHS_EmergencyPlan, EHS_EmergencyDrill';
PRINT N'  安全-事故：EHS_Accident';
PRINT N'  环境-危废：EHS_HazardousWaste';
PRINT N'  环境-固废：EHS_SolidWaste';
PRINT N'  健康-PPE：EHS_PPEStandard, EHS_PPEDistribution';
PRINT N'  化学品：EHS_Chemical, EHS_ChemicalApplication, EHS_ChemicalInOut';
PRINT N'  文件：EHS_Document';
PRINT N'  信息：EHS_Information';
PRINT N'  会议：EHS_Meeting, EHS_MeetingSignIn';
PRINT N'  供应商：EHS_Supplier';
PRINT N'  施工项目：EHS_ConstructionProject';
PRINT N'============================================================';
GO
