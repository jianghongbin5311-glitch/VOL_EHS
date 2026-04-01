USE [vol_pro_ll_service];
GO

/*
目标：
为 Lesson Learn 工作台、评审中心、任务中心、版本中心提供可直接展示的演示数据。
执行前会仅清理本脚本管理的 4 条演示记录。
*/

DECLARE @LessonNos TABLE (LessonNo NVARCHAR(50) PRIMARY KEY);
INSERT INTO @LessonNos (LessonNo)
VALUES
(N'LL-CEPS-D-001'),
(N'LL-REPS-P-002'),
(N'LL-MOTOR-S-003'),
(N'LL-MPP-P-004');

DECLARE @TargetIds TABLE (LessonLearn_Id INT PRIMARY KEY);
INSERT INTO @TargetIds (LessonLearn_Id)
SELECT LessonLearn_Id
FROM dbo.LL_LessonLearn
WHERE LessonNo IN (SELECT LessonNo FROM @LessonNos);

DELETE FROM dbo.LL_LessonLearnVersion WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnTask WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnParticipant WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnReview WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnFile WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnContent WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnDocumentType WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnTag WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearnProductLine WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);
DELETE FROM dbo.LL_LessonLearn WHERE LessonLearn_Id IN (SELECT LessonLearn_Id FROM @TargetIds);

INSERT INTO dbo.LL_LessonLearn
(
    LessonNo, TitleEn, TitleCn, Category, ProductPlatform, LlGroup, IssueSource, IssueNo, IssueType,
    CPI, Customer, Program, PartNo, Plant, ProductionLine, CellName, ApprovalOwner, LlCategoryCode,
    LlGroupNote, VersionRemark, ApplicableProductLinesText, TagsText, DocumentTypesText, Status, Progress,
    AnalysisCycleDays, ViewCount, FavoriteCount, LikeCount, VersionNo, IsLocked, SubmittedDate, PublishedDate,
    CreateDate, Creator, CreateID, ModifyDate, Modifier, ModifyID
)
VALUES
(N'LL-CEPS-D-001', N'Cold cure risk on structural adhesive for ND1193S', N'ND1193S 结构胶低温固化风险', N'Design', N'CEPS', N'CIS / Software', N'Idea Portal', N'IDEA-2026-001', N'Quality Escape', N'CPI-001', N'GM', N'ND1193S', N'PN-8891', N'Shenzhen', N'Line-01', N'Cell-A', N'PL APQP', N'D', N'CEPS Design Stream', N'首次发布版本', N'CEPS,All EPS', N'adhesive,low-temp,cure,design', N'Design,Process', 3, 100, 21, 48, 8, 13, 4, 1, DATEADD(DAY,-12,GETDATE()), DATEADD(DAY,-5,GETDATE()), DATEADD(DAY,-21,GETDATE()), N'demo', 1, DATEADD(DAY,-2,GETDATE()), N'demo', 1),
(N'LL-REPS-P-002', N'Bearing preload variation on REPS line', N'REPS 产线轴承预紧力波动', N'Process', N'REPS', N'AM / Process', N'TAP', N'TAP-2026-118', N'Process Deviation', N'CPI-014', N'Ford', N'REPS GEN5', N'PN-5512', N'Suzhou', N'Line-08', N'Cell-C', N'PL APQP', N'P', N'REPS Process Stream', N'待审批版本', N'REPS', N'preload,bearing,torque,process', N'Process', 1, 80, 14, 23, 5, 4, 3, 0, DATEADD(DAY,-1,GETDATE()), NULL, DATEADD(DAY,-14,GETDATE()), N'demo', 1, DATEADD(HOUR,-6,GETDATE()), N'demo', 1),
(N'LL-MOTOR-S-003', N'Supplier resin batch traceability gap', N'供应商树脂批次追溯缺口', N'Supplier', N'Motor', N'Supplier Quality', N'Architecture Review', N'AR-2026-007', N'Supplier Risk', N'CPI-032', N'Stellantis', N'Motor Core', N'PN-7128', N'Wuxi', N'Line-12', N'Cell-D', N'PL APQP', N'S', N'Motor Supplier Stream', N'驳回后待补充', N'Motor,RWA', N'supplier,resin,traceability,8d', N'Supplier,Process', 2, 70, 9, 12, 2, 1, 2, 0, DATEADD(DAY,-7,GETDATE()), NULL, DATEADD(DAY,-9,GETDATE()), N'demo', 1, DATEADD(DAY,-1,GETDATE()), N'demo', 1),
(N'LL-MPP-P-004', N'Fixture pin wear causing MPP offset trend', N'MPP 工装定位销磨损导致偏移趋势', N'Process', N'MPP', N'MPP / Manufacturing', N'Warranty', N'WAR-2026-020', N'Field Failure', N'CPI-044', N'VW', N'MPP Compact', N'PN-6005', N'Chongqing', N'Line-03', N'Cell-B', N'PL APQP', N'P', N'MPP Improvement Team', N'草稿整理中', N'MPP,Manual Gear', N'fixture,wear,offset,warranty', N'Process,Design', 0, 60, 6, 5, 0, 0, 1, 0, NULL, NULL, DATEADD(DAY,-6,GETDATE()), N'demo', 1, DATEADD(HOUR,-2,GETDATE()), N'demo', 1);

DECLARE @LL1 INT = (SELECT LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'LL-CEPS-D-001');
DECLARE @LL2 INT = (SELECT LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'LL-REPS-P-002');
DECLARE @LL3 INT = (SELECT LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'LL-MOTOR-S-003');
DECLARE @LL4 INT = (SELECT LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'LL-MPP-P-004');

IF COL_LENGTH('dbo.LL_LessonLearn', 'LessonLevel') IS NOT NULL
BEGIN
    UPDATE dbo.LL_LessonLearn
    SET LessonLevel = CASE LessonNo
        WHEN N'LL-CEPS-D-001' THEN N'Mandatory'
        WHEN N'LL-REPS-P-002' THEN N'Standardized'
        WHEN N'LL-MOTOR-S-003' THEN N'Optional'
        WHEN N'LL-MPP-P-004' THEN N'Other'
        ELSE LessonLevel
    END,
    Workshop = CASE LessonNo
        WHEN N'LL-CEPS-D-001' THEN N'Adhesive Workshop'
        WHEN N'LL-REPS-P-002' THEN N'Assembly Workshop'
        WHEN N'LL-MOTOR-S-003' THEN N'Supplier Incoming Workshop'
        WHEN N'LL-MPP-P-004' THEN N'Fixture Maintenance Workshop'
        ELSE Workshop
    END,
    PfmeaEnabled = 1,
    PfmeaDescription = CASE LessonNo
        WHEN N'LL-CEPS-D-001' THEN N'将低温固化失效纳入 DFMEA 与验证矩阵，强化发布门评审。'
        WHEN N'LL-REPS-P-002' THEN N'用扭矩顺序防错和线体验证，降低预紧力波动风险。'
        WHEN N'LL-MOTOR-S-003' THEN N'把批次谱系接口和供应商审核作为关键控制项。'
        WHEN N'LL-MPP-P-004' THEN N'根据磨损数据定义工装寿命阈值和预防更换策略。'
        ELSE PfmeaDescription
    END,
    PfmeaBeforeSeverity = CASE LessonNo WHEN N'LL-MPP-P-004' THEN 8 ELSE 9 END,
    PfmeaBeforeOccurrence = CASE LessonNo WHEN N'LL-REPS-P-002' THEN 6 ELSE 5 END,
    PfmeaBeforeDetection = 5,
    PfmeaAfterSeverity = CASE LessonNo WHEN N'LL-MPP-P-004' THEN 7 ELSE 8 END,
    PfmeaAfterOccurrence = 2,
    PfmeaAfterDetection = 3
    WHERE LessonNo IN (SELECT LessonNo FROM @LessonNos);
END;

INSERT INTO dbo.LL_LessonLearnProductLine (LessonLearn_Id, ProductLine, Sort)
VALUES
(@LL1, N'CEPS', 1), (@LL1, N'All EPS', 2),
(@LL2, N'REPS', 1),
(@LL3, N'Motor', 1), (@LL3, N'RWA', 2),
(@LL4, N'MPP', 1), (@LL4, N'Manual Gear', 2);

INSERT INTO dbo.LL_LessonLearnTag (LessonLearn_Id, TagName, Sort)
VALUES
(@LL1, N'adhesive', 1), (@LL1, N'low-temp', 2), (@LL1, N'cure', 3),
(@LL2, N'preload', 1), (@LL2, N'torque', 2),
(@LL3, N'supplier', 1), (@LL3, N'traceability', 2),
(@LL4, N'fixture', 1), (@LL4, N'wear', 2), (@LL4, N'warranty', 3);

INSERT INTO dbo.LL_LessonLearnDocumentType (LessonLearn_Id, DocumentType, Sort)
VALUES
(@LL1, N'Design', 1), (@LL1, N'Process', 2),
(@LL2, N'Process', 1),
(@LL3, N'Supplier', 1), (@LL3, N'Process', 2),
(@LL4, N'Process', 1), (@LL4, N'Design', 2);

INSERT INTO dbo.LL_LessonLearnContent (LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh)
VALUES
(@LL1, N'IssueDescription', 1, N'Adhesive cure time drifted under 5°C transport condition.', N'胶水在 5°C 运输条件下固化时间漂移。'),
(@LL1, N'RootCause', 1, N'Design release did not define low-temperature validation window.', N'设计发布时未定义低温验证窗口。'),
(@LL1, N'CorrectiveActions', 1, N'Update DFMEA, validation matrix and adhesive spec.', N'更新 DFMEA、验证矩阵和胶水规范。'),
(@LL1, N'GlobalLessons', 1, N'Cold-cure validation must be part of release gate for all CEPS programs.', N'所有 CEPS 项目在发布门前必须做低温固化验证。'),
(@LL2, N'IssueDescription', 1, N'Preload values fluctuated after fixture maintenance handoff.', N'治具保养交接后预紧力出现波动。'),
(@LL2, N'RootCause', 1, N'Work instruction lacked torque sequence control.', N'作业指导书缺少拧紧顺序控制。'),
(@LL2, N'CorrectiveActions', 1, N'Add poka-yoke torque sequence and layered audit.', N'增加防错拧紧顺序和分层审核。'),
(@LL2, N'GlobalLessons', 1, N'Any fixture maintenance must trigger process revalidation.', N'任何治具保养都必须触发工艺再验证。'),
(@LL3, N'IssueDescription', 1, N'Supplier resin lots could not be traced to final assembly VIN.', N'供应商树脂批次无法追溯到最终总成 VIN。'),
(@LL3, N'RootCause', 1, N'Supplier 8D missed batch mapping field in ERP export.', N'供应商 8D 未在 ERP 导出中维护批次映射字段。'),
(@LL3, N'CorrectiveActions', 1, N'Add lot genealogy interface and enforce monthly audit.', N'增加批次谱系接口并执行月度审核。'),
(@LL3, N'GlobalLessons', 1, N'Supplier traceability must be checked before PPAP closure.', N'供应商追溯性必须在 PPAP 关闭前检查。'),
(@LL4, N'IssueDescription', 1, N'Fixture pin wear shifted datum and created offset trend on MPP line.', N'MPP 产线定位销磨损导致基准偏移趋势。'),
(@LL4, N'RootCause', 1, N'Preventive replacement interval was not defined by actual wear data.', N'预防更换周期未基于真实磨损数据定义。'),
(@LL4, N'CorrectiveActions', 1, N'Create wear threshold board and spare pin kanban.', N'建立磨损阈值看板和备件看板。'),
(@LL4, N'GlobalLessons', 1, N'Fixture life management should be part of warranty containment.', N'工装寿命管理应纳入保修遏制策略。');

INSERT INTO dbo.LL_LessonLearnDocumentChange (LessonLearn_Id, ChangeType, BeforeFileName, AfterFileName, Sort)
VALUES
(@LL1, N'Design', N'DFMEA_v1.xlsx', N'DFMEA_v2.xlsx', 1),
(@LL1, N'Process', N'ValidationPlan_v1.pptx', N'ValidationPlan_v2.pptx', 2),
(@LL2, N'Process', N'WI_Torque_v3.pdf', N'WI_Torque_v4.pdf', 1),
(@LL3, N'Supplier', N'SupplierTraceMatrix_v1.xlsx', N'SupplierTraceMatrix_v2.xlsx', 1),
(@LL4, N'Process', N'FixtureCheckSheet_v1.xlsx', N'FixtureCheckSheet_v2.xlsx', 1);

DECLARE @DC1 INT = (SELECT TOP 1 LessonLearnDocumentChange_Id FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LL1 AND Sort = 1);
DECLARE @DC2 INT = (SELECT TOP 1 LessonLearnDocumentChange_Id FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LL1 AND Sort = 2);
DECLARE @DC3 INT = (SELECT TOP 1 LessonLearnDocumentChange_Id FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LL2 AND Sort = 1);
DECLARE @DC4 INT = (SELECT TOP 1 LessonLearnDocumentChange_Id FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LL3 AND Sort = 1);
DECLARE @DC5 INT = (SELECT TOP 1 LessonLearnDocumentChange_Id FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LL4 AND Sort = 1);

INSERT INTO dbo.LL_LessonLearnFile
(
    LessonLearn_Id, FileType, ModuleType, LessonLearnContent_Id, LessonLearnDocumentChange_Id,
    Category, Name, Path, Size, DownloadCount, UploadTime, CaptionEn, CaptionZh, Sort
)
VALUES
(@LL1, N'General', NULL, NULL, NULL, N'Related', N'RootCauseWorkshop.pdf', N'upload/ll/demo/RootCauseWorkshop.pdf', 356812, 11, DATEADD(DAY,-4,GETDATE()), N'Workshop notes', N'研讨记录', 1),
(@LL1, N'DocumentBefore', NULL, NULL, @DC1, N'Design', N'DFMEA_v1.xlsx', N'upload/ll/demo/DFMEA_v1.xlsx', 125312, 3, DATEADD(DAY,-10,GETDATE()), N'Before update', N'变更前版本', 1),
(@LL1, N'DocumentAfter', NULL, NULL, @DC1, N'Design', N'DFMEA_v2.xlsx', N'upload/ll/demo/DFMEA_v2.xlsx', 138420, 5, DATEADD(DAY,-5,GETDATE()), N'After update', N'变更后版本', 1),
(@LL1, N'DocumentBefore', NULL, NULL, @DC2, N'Process', N'ValidationPlan_v1.pptx', N'upload/ll/demo/ValidationPlan_v1.pptx', 425331, 2, DATEADD(DAY,-9,GETDATE()), N'Old validation deck', N'旧验证方案', 1),
(@LL1, N'DocumentAfter', NULL, NULL, @DC2, N'Process', N'ValidationPlan_v2.pptx', N'upload/ll/demo/ValidationPlan_v2.pptx', 492774, 4, DATEADD(DAY,-5,GETDATE()), N'New validation deck', N'新验证方案', 1),
(@LL2, N'DocumentBefore', NULL, NULL, @DC3, N'Process', N'WI_Torque_v3.pdf', N'upload/ll/demo/WI_Torque_v3.pdf', 98211, 1, DATEADD(DAY,-7,GETDATE()), N'Old WI', N'旧版作业指导书', 1),
(@LL2, N'DocumentAfter', NULL, NULL, @DC3, N'Process', N'WI_Torque_v4.pdf', N'upload/ll/demo/WI_Torque_v4.pdf', 116842, 2, DATEADD(DAY,-2,GETDATE()), N'New WI', N'新版作业指导书', 1),
(@LL3, N'DocumentBefore', NULL, NULL, @DC4, N'Supplier', N'SupplierTraceMatrix_v1.xlsx', N'upload/ll/demo/SupplierTraceMatrix_v1.xlsx', 144205, 0, DATEADD(DAY,-6,GETDATE()), N'Original trace matrix', N'原追溯矩阵', 1),
(@LL3, N'DocumentAfter', NULL, NULL, @DC4, N'Supplier', N'SupplierTraceMatrix_v2.xlsx', N'upload/ll/demo/SupplierTraceMatrix_v2.xlsx', 171905, 1, DATEADD(DAY,-1,GETDATE()), N'Updated trace matrix', N'更新后追溯矩阵', 1),
(@LL4, N'DocumentBefore', NULL, NULL, @DC5, N'Process', N'FixtureCheckSheet_v1.xlsx', N'upload/ll/demo/FixtureCheckSheet_v1.xlsx', 107020, 0, DATEADD(DAY,-5,GETDATE()), N'Original checksheet', N'原点检表', 1),
(@LL4, N'DocumentAfter', NULL, NULL, @DC5, N'Process', N'FixtureCheckSheet_v2.xlsx', N'upload/ll/demo/FixtureCheckSheet_v2.xlsx', 133812, 0, DATEADD(HOUR,-8,GETDATE()), N'Updated checksheet', N'更新点检表', 1);

INSERT INTO dbo.LL_LessonLearnReview (LessonLearn_Id, Round, ReviewDate, Reviewer, ReviewerTitle, Result, Comments, Sort)
VALUES
(@LL1, N'Round 1', CONVERT(NVARCHAR(10), DATEADD(DAY,-12,GETDATE()), 23), N'Lucy Zhang', N'PL APQP', N'Approved', N'Need to replicate to all CEPS programs.', 1),
(@LL1, N'Round 2', CONVERT(NVARCHAR(10), DATEADD(DAY,-6,GETDATE()), 23), N'Eric Liu', N'Chief Engineer', N'Published', N'Design and process documents updated.', 2),
(@LL2, N'Round 1', CONVERT(NVARCHAR(10), DATEADD(DAY,-1,GETDATE()), 23), N'Emma Chen', N'PL APQP', N'Pending', N'Need evidence of line revalidation.', 1),
(@LL3, N'Round 1', CONVERT(NVARCHAR(10), DATEADD(DAY,-2,GETDATE()), 23), N'Kevin Wu', N'Supplier Quality Manager', N'Rejected', N'Please add supplier ERP field mapping and audit plan.', 1),
(@LL4, N'Round 1', CONVERT(NVARCHAR(10), GETDATE(), 23), N'Ivy He', N'Operations Manager', N'Draft', N'Collect more fixture wear trend data.', 1);

INSERT INTO dbo.LL_LessonLearnParticipant (LessonLearn_Id, Name, Title, Sort)
VALUES
(@LL1, N'Michael Sun', N'Design Lead', 1), (@LL1, N'Nina Gao', N'Quality Engineer', 2),
(@LL2, N'David Xu', N'Process Engineer', 1), (@LL2, N'Fiona Li', N'Manufacturing Supervisor', 2),
(@LL3, N'Chris Pan', N'Supplier Quality Engineer', 1), (@LL3, N'Annie Hou', N'Commodity Manager', 2),
(@LL4, N'Robin Tang', N'Warranty Engineer', 1), (@LL4, N'Sally Jiang', N'Plant Quality Lead', 2);

INSERT INTO dbo.LL_LessonLearnTask (LessonLearn_Id, Title, Owner, DueDate, Progress, Status, Notes, Sort)
VALUES
(@LL1, N'Update DFMEA low-temperature cure criteria', N'Lucy Zhang', CONVERT(NVARCHAR(10), DATEADD(DAY,5,GETDATE()), 23), 100, N'审批完成', N'已纳入设计发布门。', 1),
(@LL1, N'Issue CEPS design alert to global teams', N'Eric Liu', CONVERT(NVARCHAR(10), DATEADD(DAY,10,GETDATE()), 23), 50, N'上传完成', N'待上传培训记录。', 2),
(@LL2, N'Revalidate torque sequence after fixture maintenance', N'David Xu', CONVERT(NVARCHAR(10), DATEADD(DAY,3,GETDATE()), 23), 50, N'上传完成', N'等待 APQP 审批结果。', 1),
(@LL3, N'Close supplier lot traceability gap in ERP export', N'Chris Pan', CONVERT(NVARCHAR(10), DATEADD(DAY,7,GETDATE()), 23), 0, N'已发布', N'因评审驳回需重提方案。', 1),
(@LL4, N'Define pin wear replacement threshold', N'Robin Tang', CONVERT(NVARCHAR(10), DATEADD(DAY,14,GETDATE()), 23), 0, N'已发布', N'草稿阶段，等待更多数据。', 1);

INSERT INTO dbo.LL_LessonLearnVersion (LessonLearn_Id, VersionNo, Action, [Operator], StatusText, Comment, SnapshotJson, ActionTime)
VALUES
(@LL1, 1, N'保存草稿', N'demo', N'编辑中', N'创建初稿', N'{}', DATEADD(DAY,-20,GETDATE())),
(@LL1, 2, N'提交审批', N'demo', N'待审核', N'提交 PL APQP', N'{}', DATEADD(DAY,-12,GETDATE())),
(@LL1, 3, N'审批发布', N'Lucy Zhang', N'已发布', N'发布并锁定', N'{}', DATEADD(DAY,-5,GETDATE())),
(@LL2, 1, N'保存草稿', N'demo', N'编辑中', N'首版整理', N'{}', DATEADD(DAY,-14,GETDATE())),
(@LL2, 2, N'提交审批', N'demo', N'待审核', N'等待线体验证', N'{}', DATEADD(DAY,-1,GETDATE())),
(@LL3, 1, N'保存草稿', N'demo', N'编辑中', N'供应商问题建档', N'{}', DATEADD(DAY,-9,GETDATE())),
(@LL3, 2, N'审批驳回', N'Kevin Wu', N'已驳回', N'要求补充 ERP 接口方案', N'{}', DATEADD(DAY,-2,GETDATE())),
(@LL4, 1, N'保存草稿', N'demo', N'编辑中', N'保修场景草稿', N'{}', DATEADD(DAY,-6,GETDATE()));

SELECT LessonLearn_Id, LessonNo, TitleEn, Category, Status, Progress, VersionNo, ModifyDate
FROM dbo.LL_LessonLearn
WHERE LessonNo IN (SELECT LessonNo FROM @LessonNos)
ORDER BY LessonNo;
GO
