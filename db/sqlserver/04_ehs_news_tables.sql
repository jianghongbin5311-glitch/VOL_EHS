-- ============================================================
-- EHS新闻通告模块 - 数据库表创建脚本
-- 目标库: nxt_ehs_biz
-- 日期: 2026-03-25
-- ============================================================

USE [nxt_ehs_biz];
GO

-- ============================================================
-- 1. EHS_NewsReport - 外部法规新闻报告表
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_NewsReport')
BEGIN
    CREATE TABLE [dbo].[EHS_NewsReport] (
        [Report_Id]       INT IDENTITY(1,1)  NOT NULL,
        [ReportNo]        NVARCHAR(50)       NULL,
        [ReportType]      NVARCHAR(20)       NOT NULL,
        [ReportDate]      DATETIME           NOT NULL,
        [Title]           NVARCHAR(200)      NOT NULL,
        [Content]         NVARCHAR(MAX)      NULL,
        [Summary]         NVARCHAR(500)      NULL,
        [Category]        NVARCHAR(50)       NULL,
        [Source]          NVARCHAR(200)      NULL,
        [SourceUrl]       NVARCHAR(500)      NULL,
        [Impact]          NVARCHAR(500)      NULL,
        [Action]          NVARCHAR(500)      NULL,
        [AiModel]         NVARCHAR(100)      NULL,
        [GenerateStatus]  INT                NULL DEFAULT 0,
        [ErrorMessage]    NVARCHAR(MAX)      NULL,
        [Status]          INT                NULL DEFAULT 1,
        [CreateDate]      DATETIME           NULL,
        [Creator]         NVARCHAR(50)       NULL,
        [CreateID]        INT                NULL,
        [ModifyDate]      DATETIME           NULL,
        [Modifier]        NVARCHAR(50)       NULL,
        CONSTRAINT [PK_EHS_NewsReport] PRIMARY KEY CLUSTERED ([Report_Id] ASC)
    );
END
GO

-- ============================================================
-- 2. EHS_GroupIncident - 集团/多工厂内部事件表
-- ============================================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_GroupIncident')
BEGIN
    CREATE TABLE [dbo].[EHS_GroupIncident] (
        [Incident_Id]       INT IDENTITY(1,1)  NOT NULL,
        [IncidentNo]        NVARCHAR(50)       NULL,
        [CompanyName]       NVARCHAR(200)      NOT NULL,
        [FactoryName]       NVARCHAR(200)      NULL,
        [IncidentType]      NVARCHAR(50)       NOT NULL,
        [IncidentLevel]     NVARCHAR(20)       NULL,
        [Title]             NVARCHAR(200)      NOT NULL,
        [OccurDate]         DATETIME           NULL,
        [OccurLocation]     NVARCHAR(200)      NULL,
        [Description]       NVARCHAR(MAX)      NULL,
        [RootCause]         NVARCHAR(MAX)      NULL,
        [CorrectiveAction]  NVARCHAR(MAX)      NULL,
        [PreventiveAction]  NVARCHAR(MAX)      NULL,
        [Injuries]          INT                NULL DEFAULT 0,
        [Fatalities]        INT                NULL DEFAULT 0,
        [EconomicLoss]      DECIMAL(18,2)      NULL,
        [ImageUrls]         NVARCHAR(MAX)      NULL,
        [AttachmentUrls]    NVARCHAR(MAX)      NULL,
        [ReferenceUrl]      NVARCHAR(500)      NULL,
        [LessonLearned]     NVARCHAR(MAX)      NULL,
        [IsExternal]        INT                NULL DEFAULT 0,
        [SourceCompany]     NVARCHAR(200)      NULL,
        [ReporterName]      NVARCHAR(50)       NULL,
        [Status]            INT                NULL DEFAULT 1,
        [CreateDate]        DATETIME           NULL,
        [Creator]           NVARCHAR(50)       NULL,
        [CreateID]          INT                NULL,
        [ModifyDate]        DATETIME           NULL,
        [Modifier]          NVARCHAR(50)       NULL,
        CONSTRAINT [PK_EHS_GroupIncident] PRIMARY KEY CLUSTERED ([Incident_Id] ASC)
    );
END
GO

-- ============================================================
-- 3. 更新菜单: 外部法规、新闻 (Menu_Id=612)
-- ============================================================

UPDATE [nxt_ehs_main].[dbo].[Sys_Menu]
SET [TableName] = N'EHS_NewsReport',
    [Url] = N'/EHS_NewsReport',
    [Auth] = N'[{"text":"查询","value":"Search"}]',
    [LinkType] = 0,
    [ModifyDate] = GETDATE()
WHERE [Menu_Id] = 612;
GO

-- ============================================================
-- 4. 更新菜单: 内部事件 (Menu_Id=613)
-- ============================================================

UPDATE [nxt_ehs_main].[dbo].[Sys_Menu]
SET [TableName] = N'EHS_GroupIncident',
    [Url] = N'/EHS_GroupIncident',
    [Auth] = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"},{"text":"导出","value":"Export"}]',
    [LinkType] = 0,
    [ModifyDate] = GETDATE()
WHERE [Menu_Id] = 613;
GO

-- ============================================================
-- 5. Quartz定时任务配置
-- ============================================================

-- 日报: 每小时整点
IF NOT EXISTS (SELECT 1 FROM [nxt_ehs_main].[dbo].[Sys_QuartzOptions] WHERE [TaskName] = N'EHS外部法规新闻-日报')
BEGIN
    INSERT INTO [nxt_ehs_main].[dbo].[Sys_QuartzOptions]
    ([Id],[TaskName],[GroupName],[Method],[TimeOut],[CronExpression],[ApiUrl],[PostData],[AuthKey],[AuthValue],[Describe],[Status],[CreateDate],[Creator])
    VALUES
    (NEWID(), N'EHS外部法规新闻-日报', N'EHS', N'POST', 120, N'0 0 * * * ?',
     N'http://localhost:9991/api/EHS_NewsReport/GenerateReport?type=日报', NULL,
     N'QuartzAccessKey', N'65EC9387355E4717899C552963CE59X1',
     N'每小时自动生成EHS外部法规新闻日报', 0, GETDATE(), N'system');
END
GO

-- 周报: 每周一08:00
IF NOT EXISTS (SELECT 1 FROM [nxt_ehs_main].[dbo].[Sys_QuartzOptions] WHERE [TaskName] = N'EHS外部法规新闻-周报')
BEGIN
    INSERT INTO [nxt_ehs_main].[dbo].[Sys_QuartzOptions]
    ([Id],[TaskName],[GroupName],[Method],[TimeOut],[CronExpression],[ApiUrl],[PostData],[AuthKey],[AuthValue],[Describe],[Status],[CreateDate],[Creator])
    VALUES
    (NEWID(), N'EHS外部法规新闻-周报', N'EHS', N'POST', 180, N'0 0 8 ? * MON',
     N'http://localhost:9991/api/EHS_NewsReport/GenerateReport?type=周报', NULL,
     N'QuartzAccessKey', N'65EC9387355E4717899C552963CE59X1',
     N'每周一8点自动生成EHS外部法规新闻周报', 0, GETDATE(), N'system');
END
GO

-- 月报: 每月1号08:00
IF NOT EXISTS (SELECT 1 FROM [nxt_ehs_main].[dbo].[Sys_QuartzOptions] WHERE [TaskName] = N'EHS外部法规新闻-月报')
BEGIN
    INSERT INTO [nxt_ehs_main].[dbo].[Sys_QuartzOptions]
    ([Id],[TaskName],[GroupName],[Method],[TimeOut],[CronExpression],[ApiUrl],[PostData],[AuthKey],[AuthValue],[Describe],[Status],[CreateDate],[Creator])
    VALUES
    (NEWID(), N'EHS外部法规新闻-月报', N'EHS', N'POST', 300, N'0 0 8 1 * ?',
     N'http://localhost:9991/api/EHS_NewsReport/GenerateReport?type=月报', NULL,
     N'QuartzAccessKey', N'65EC9387355E4717899C552963CE59X1',
     N'每月1号8点自动生成EHS外部法规新闻月报', 0, GETDATE(), N'system');
END
GO

PRINT N'EHS新闻通告模块 - 数据库脚本执行完成';
GO
