-- ============================================================
-- EHS 信息化平台 - 第3步：初始化 EHS 菜单 + 角色 + 权限
-- 在 nxt_ehs_main 数据库上执行
-- ============================================================
-- 修复版：已添加 SET IDENTITY_INSERT ON/OFF
-- ============================================================

USE [nxt_ehs_main];
GO

-- ============================================================
-- 1. 清理旧 EHS 菜单（安全重复执行）
-- ============================================================
DELETE FROM Sys_RoleAuth WHERE Menu_Id >= 500;
DELETE FROM Sys_Menu WHERE Menu_Id >= 500;
DELETE FROM Sys_Role WHERE RoleName LIKE N'EHS%';
PRINT N'已清理旧 EHS 数据';
GO

-- ============================================================
-- 2. 插入 EHS 一级菜单（9大模块）
-- ============================================================
SET IDENTITY_INSERT [dbo].[Sys_Menu] ON;
GO

-- 安全管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (500, N'安全管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-warning-outline', N'EHS_Safety', 1, 9000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 环境管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (530, N'环境管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-cloudy', N'EHS_Environment', 1, 8000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 职业健康
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (540, N'职业健康', N'[{"text":"查询","value":"Search"}]', N'el-icon-first-aid-kit', N'EHS_Health', 1, 7000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 化学品管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (550, N'化学品管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-goblet-square', N'EHS_Chemical', 1, 6000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 文件管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (560, N'文件管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-folder-opened', N'EHS_Document', 1, 5000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 信息管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (570, N'信息管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-bell', N'EHS_Information', 1, 4000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 会议管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (580, N'会议管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-date', N'EHS_Meeting', 1, 3000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 供应商管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (590, N'供应商管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-office-building', N'EHS_Supplier', 1, 2000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

-- 施工项目管理
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (600, N'施工项目管理', N'[{"text":"查询","value":"Search"}]', N'el-icon-cpu', N'EHS_Construction', 1, 1000, N'.', 0, NULL, GETDATE(), N'system', GETDATE(), N'system', 0, 0);

PRINT N'✅ 9个一级菜单已创建';
GO

-- ============================================================
-- 3. 安全管理 (ParentId=500) 子菜单
-- ============================================================
DECLARE @AuthCRUD NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导入","value":"Import"},{"text":"导出","value":"Export"}]';
DECLARE @AuthAudit NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"编辑","value":"Update"},{"text":"审批","value":"Audit"},{"text":"导出","value":"Export"}]';
DECLARE @AuthFull NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"审批","value":"Audit"},{"text":"导出","value":"Export"}]';

INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType) VALUES
(501, N'台账管理',     @AuthCRUD, N'el-icon-notebook-2',   N'EHS_SafetyLedger',       1, 900, N'EHS_SafetyLedger',       500, N'/EHS_SafetyLedger',       GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(502, N'隐患排查',     @AuthCRUD, N'el-icon-search',       N'EHS_HazardInspection',   1, 880, N'EHS_HazardInspection',   500, N'/EHS_HazardInspection',   GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(503, N'隐患上报',     @AuthCRUD, N'el-icon-camera',       N'EHS_HazardReport',       1, 860, N'EHS_HazardReport',       500, N'/EHS_HazardReport',       GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(504, N'隐患闭环管理', @AuthAudit, N'el-icon-refresh',     N'EHS_HazardRectify',      1, 840, N'.',                      500, N'/EHS_HazardRectify',      GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(505, N'隐患分析',     N'[{"text":"查询","value":"Search"}]', N'el-icon-data-analysis', N'EHS_HazardAnalysis', 1, 820, N'.', 500, N'/EHS_HazardAnalysis', GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(506, N'课程管理',     @AuthCRUD, N'el-icon-reading',      N'EHS_Course',             1, 800, N'EHS_Course',             500, N'/EHS_Course',             GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(507, N'试题库',       @AuthCRUD, N'el-icon-edit-outline', N'EHS_QuestionBank',       1, 780, N'EHS_QuestionBank',       500, N'/EHS_QuestionBank',       GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(508, N'培训计划',     @AuthCRUD, N'el-icon-calendar',     N'EHS_TrainingPlan',       1, 760, N'EHS_TrainingPlan',       500, N'/EHS_TrainingPlan',       GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(509, N'培训档案',     N'[{"text":"查询","value":"Search"},{"text":"导出","value":"Export"}]', N'el-icon-user', N'EHS_TrainingRecord', 1, 740, N'EHS_TrainingRecord', 500, N'/EHS_TrainingRecord', GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(510, N'特殊作业票',   @AuthFull, N'el-icon-tickets',      N'EHS_WorkPermit',         1, 720, N'EHS_WorkPermit',         500, N'/EHS_WorkPermit',         GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(511, N'作业过程监督', @AuthCRUD, N'el-icon-view',         N'EHS_WorkPermitMonitor',  1, 700, N'EHS_WorkPermitMonitor',  500, N'/EHS_WorkPermitMonitor',  GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(512, N'应急资源',     @AuthCRUD, N'el-icon-connection',   N'EHS_EmergencyResource',  1, 680, N'EHS_EmergencyResource',  500, N'/EHS_EmergencyResource',  GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(513, N'应急预案',     @AuthCRUD, N'el-icon-document',     N'EHS_EmergencyPlan',      1, 660, N'EHS_EmergencyPlan',      500, N'/EHS_EmergencyPlan',      GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(514, N'应急演练',     @AuthCRUD, N'el-icon-video-camera', N'EHS_EmergencyDrill',     1, 640, N'EHS_EmergencyDrill',     500, N'/EHS_EmergencyDrill',     GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(515, N'事故管理',     @AuthFull, N'el-icon-warning',      N'EHS_Accident',           1, 620, N'EHS_Accident',           500, N'/EHS_Accident',           GETDATE(), N'system', GETDATE(), N'system', 0, 0);

PRINT N'✅ 安全管理 15个二级菜单已创建';
GO

-- ============================================================
-- 4. 环境管理 (ParentId=530) 子菜单
-- ============================================================
DECLARE @AuthCRUD2 NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导入","value":"Import"},{"text":"导出","value":"Export"}]';

INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType) VALUES
(531, N'危废管理', @AuthCRUD2, N'el-icon-delete', N'EHS_HazardousWaste', 1, 900, N'EHS_HazardousWaste', 530, N'/EHS_HazardousWaste', GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(532, N'固废管理', @AuthCRUD2, N'el-icon-box',    N'EHS_SolidWaste',     1, 800, N'EHS_SolidWaste',     530, N'/EHS_SolidWaste',     GETDATE(), N'system', GETDATE(), N'system', 0, 0);

PRINT N'✅ 环境管理 2个二级菜单已创建';
GO

-- ============================================================
-- 5. 职业健康 (ParentId=540) 子菜单
-- ============================================================
DECLARE @AuthCRUD3 NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导入","value":"Import"},{"text":"导出","value":"Export"}]';

INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType) VALUES
(541, N'PPE标准',     @AuthCRUD3, N'el-icon-s-check', N'EHS_PPEStandard',      1, 900, N'EHS_PPEStandard',      540, N'/EHS_PPEStandard',      GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(542, N'PPE领用记录', @AuthCRUD3, N'el-icon-goods',   N'EHS_PPEDistribution',  1, 800, N'EHS_PPEDistribution',  540, N'/EHS_PPEDistribution',  GETDATE(), N'system', GETDATE(), N'system', 0, 0);

PRINT N'✅ 职业健康 2个二级菜单已创建';
GO

-- ============================================================
-- 6. 化学品管理 (ParentId=550) 子菜单
-- ============================================================
DECLARE @AuthCRUD4 NVARCHAR(500) = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导入","value":"Import"},{"text":"导出","value":"Export"}]';

INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType) VALUES
(551, N'化学品台账', @AuthCRUD4, N'el-icon-goblet',        N'EHS_Chemical',            1, 900, N'EHS_Chemical',            550, N'/EHS_Chemical',            GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(552, N'化学品申请', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"审批","value":"Audit"},{"text":"导出","value":"Export"}]', N'el-icon-document-add', N'EHS_ChemicalApplication', 1, 800, N'EHS_ChemicalApplication', 550, N'/EHS_ChemicalApplication', GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(553, N'出入库记录', @AuthCRUD4, N'el-icon-sort',          N'EHS_ChemicalInOut',       1, 700, N'EHS_ChemicalInOut',       550, N'/EHS_ChemicalInOut',       GETDATE(), N'system', GETDATE(), N'system', 0, 0);

PRINT N'✅ 化学品管理 3个二级菜单已创建';
GO

-- ============================================================
-- 7. 文件管理 (ParentId=560)
-- ============================================================
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (561, N'程序文件', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导出","value":"Export"}]', N'el-icon-document', N'EHS_Document', 1, 900, N'EHS_Document', 560, N'/EHS_Document', GETDATE(), N'system', GETDATE(), N'system', 0, 0);
PRINT N'✅ 文件管理 1个二级菜单已创建';
GO

-- ============================================================
-- 8. 信息管理 (ParentId=570)
-- ============================================================
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (571, N'法规与信息', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导出","value":"Export"}]', N'el-icon-news', N'EHS_Information', 1, 900, N'EHS_Information', 570, N'/EHS_Information', GETDATE(), N'system', GETDATE(), N'system', 0, 0);
PRINT N'✅ 信息管理 1个二级菜单已创建';
GO

-- ============================================================
-- 9. 会议管理 (ParentId=580)
-- ============================================================
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType) VALUES
(581, N'会议记录', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导出","value":"Export"}]', N'el-icon-chat-dot-round', N'EHS_Meeting', 1, 900, N'EHS_Meeting', 580, N'/EHS_Meeting', GETDATE(), N'system', GETDATE(), N'system', 0, 0),
(582, N'会议签到', N'[{"text":"查询","value":"Search"}]', N'el-icon-location', N'EHS_MeetingSignIn', 1, 800, N'EHS_MeetingSignIn', 580, N'/EHS_MeetingSignIn', GETDATE(), N'system', GETDATE(), N'system', 0, 0);
PRINT N'✅ 会议管理 2个二级菜单已创建';
GO

-- ============================================================
-- 10. 供应商管理 (ParentId=590)
-- ============================================================
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (591, N'供应商列表', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"审批","value":"Audit"},{"text":"导出","value":"Export"}]', N'el-icon-office-building', N'EHS_Supplier', 1, 900, N'EHS_Supplier', 590, N'/EHS_Supplier', GETDATE(), N'system', GETDATE(), N'system', 0, 0);
PRINT N'✅ 供应商管理 1个二级菜单已创建';
GO

-- ============================================================
-- 11. 施工项目管理 (ParentId=600)
-- ============================================================
INSERT INTO Sys_Menu (Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName, ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType)
VALUES (601, N'施工项目', N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"审批","value":"Audit"},{"text":"导出","value":"Export"}]', N'el-icon-setting', N'EHS_ConstructionProject', 1, 900, N'EHS_ConstructionProject', 600, N'/EHS_ConstructionProject', GETDATE(), N'system', GETDATE(), N'system', 0, 0);
PRINT N'✅ 施工项目管理 1个二级菜单已创建';
GO

SET IDENTITY_INSERT [dbo].[Sys_Menu] OFF;
GO

-- ============================================================
-- 12. 创建 EHS 角色
-- ============================================================
SET IDENTITY_INSERT [dbo].[Sys_Role] ON;
GO

DECLARE @MaxRoleId INT;
SELECT @MaxRoleId = ISNULL(MAX(Role_Id), 0) FROM Sys_Role WHERE RoleName NOT LIKE N'EHS%';

INSERT INTO Sys_Role (Role_Id, ParentId, RoleName, Dept_Id, DeptName, OrderNo, Enable, CreateDate, Creator, ModifyDate, Modifier)
VALUES
    (@MaxRoleId + 1, 0, N'EHS经理',       0, NULL, 100, 1, GETDATE(), N'system', GETDATE(), N'system'),
    (@MaxRoleId + 2, 0, N'EHS安全管理员',  0, NULL, 90,  1, GETDATE(), N'system', GETDATE(), N'system'),
    (@MaxRoleId + 3, 0, N'EHS部门负责人',  0, NULL, 80,  1, GETDATE(), N'system', GETDATE(), N'system'),
    (@MaxRoleId + 4, 0, N'EHS分管领导',    0, NULL, 70,  1, GETDATE(), N'system', GETDATE(), N'system'),
    (@MaxRoleId + 5, 0, N'EHS一线员工',    0, NULL, 60,  1, GETDATE(), N'system', GETDATE(), N'system');

PRINT N'✅ 5个 EHS 角色已创建';
GO

SET IDENTITY_INSERT [dbo].[Sys_Role] OFF;
GO

-- ============================================================
-- 13. 为 EHS安全管理员 授权所有 EHS 菜单
-- ============================================================
DECLARE @EHSAdminRoleId INT;
SELECT @EHSAdminRoleId = Role_Id FROM Sys_Role WHERE RoleName = N'EHS安全管理员';

IF @EHSAdminRoleId IS NOT NULL
BEGIN
    DECLARE @MaxAuthId INT;
    SELECT @MaxAuthId = ISNULL(MAX(Auth_Id), 0) FROM Sys_RoleAuth;

    INSERT INTO Sys_RoleAuth (AuthValue, CreateDate, Creator, Menu_Id, ModifyDate, Modifier, Role_Id, User_Id, AuthMenuData)
    SELECT
        CASE
            WHEN Auth LIKE N'%Add%' THEN N'Search,Add,Update,Delete,Import,Export'
            WHEN Auth LIKE N'%Audit%' THEN N'Search,Update,Audit,Export'
            ELSE N'Search'
        END,
        GETDATE(), N'system', Menu_Id, GETDATE(), N'system', @EHSAdminRoleId, NULL, NULL
    FROM Sys_Menu
    WHERE Menu_Id >= 500 AND Description LIKE N'EHS_%';

    PRINT N'✅ EHS安全管理员 权限已配置';
END
GO

-- ============================================================
-- 14. 为 EHS一线员工 授权基本权限
-- ============================================================
DECLARE @EHSWorkerRoleId INT;
SELECT @EHSWorkerRoleId = Role_Id FROM Sys_Role WHERE RoleName = N'EHS一线员工';

IF @EHSWorkerRoleId IS NOT NULL
BEGIN
    INSERT INTO Sys_RoleAuth (AuthValue, CreateDate, Creator, Menu_Id, ModifyDate, Modifier, Role_Id, User_Id, AuthMenuData)
    VALUES
        (N'Search',     GETDATE(), N'system', 500, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL),
        (N'Search,Add', GETDATE(), N'system', 503, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL),
        (N'Search',     GETDATE(), N'system', 508, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL),
        (N'Search',     GETDATE(), N'system', 509, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL),
        (N'Search',     GETDATE(), N'system', 540, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL),
        (N'Search',     GETDATE(), N'system', 542, GETDATE(), N'system', @EHSWorkerRoleId, NULL, NULL);

    PRINT N'✅ EHS一线员工 权限已配置';
END
GO


PRINT N'';
PRINT N'============================================================';
PRINT N'✅ EHS 菜单/角色/权限 初始化完成！';
PRINT N'  一级菜单：9 个  |  二级菜单：28 个';
PRINT N'  角色：5 个  |  已配置权限：安全管理员 + 一线员工';
PRINT N'============================================================';
GO
