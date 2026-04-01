USE [vol_pro_ll_service];
GO

/*
说明：
1. 本脚本用于在 Lesson Learn 专属业务库 `vol_pro_ll_service` 创建正式主从表。
2. 如果你之前已经执行过首期单表 JSON 版脚本，本脚本会保留旧 JSON 列，并补齐正式字段与子表。
3. 建议在测试库先执行，再同步到正式库。
*/

IF OBJECT_ID(N'dbo.LL_LessonLearn', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearn
    (
        LessonLearn_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonNo NVARCHAR(50) NULL,
        TitleEn NVARCHAR(300) NULL,
        TitleCn NVARCHAR(300) NULL,
        Category NVARCHAR(30) NULL,
        LessonLevel NVARCHAR(50) NULL,
        ProductPlatform NVARCHAR(100) NULL,
        LlGroup NVARCHAR(100) NULL,
        IssueSource NVARCHAR(100) NULL,
        IssueNo NVARCHAR(100) NULL,
        IssueType NVARCHAR(100) NULL,
        CPI NVARCHAR(100) NULL,
        Customer NVARCHAR(100) NULL,
        Program NVARCHAR(100) NULL,
        PartNo NVARCHAR(100) NULL,
        Plant NVARCHAR(100) NULL,
        Workshop NVARCHAR(100) NULL,
        ProductionLine NVARCHAR(100) NULL,
        CellName NVARCHAR(100) NULL,
        ApprovalOwner NVARCHAR(100) NULL,
        LlCategoryCode NVARCHAR(50) NULL,
        LlGroupNote NVARCHAR(300) NULL,
        VersionRemark NVARCHAR(500) NULL,
        PfmeaEnabled BIT NOT NULL CONSTRAINT DF_LL_LessonLearn_PfmeaEnabled DEFAULT(1),
        PfmeaDescription NVARCHAR(MAX) NULL,
        PfmeaBeforeSeverity INT NULL,
        PfmeaBeforeOccurrence INT NULL,
        PfmeaBeforeDetection INT NULL,
        PfmeaAfterSeverity INT NULL,
        PfmeaAfterOccurrence INT NULL,
        PfmeaAfterDetection INT NULL,
        ApplicableProductLinesText NVARCHAR(500) NULL,
        TagsText NVARCHAR(1000) NULL,
        DocumentTypesText NVARCHAR(300) NULL,
        Status INT NOT NULL CONSTRAINT DF_LL_LessonLearn_Status DEFAULT(0),
        Progress INT NOT NULL CONSTRAINT DF_LL_LessonLearn_Progress DEFAULT(0),
        AnalysisCycleDays INT NOT NULL CONSTRAINT DF_LL_LessonLearn_AnalysisCycleDays DEFAULT(0),
        ViewCount INT NOT NULL CONSTRAINT DF_LL_LessonLearn_ViewCount DEFAULT(0),
        FavoriteCount INT NOT NULL CONSTRAINT DF_LL_LessonLearn_FavoriteCount DEFAULT(0),
        LikeCount INT NOT NULL CONSTRAINT DF_LL_LessonLearn_LikeCount DEFAULT(0),
        VersionNo INT NOT NULL CONSTRAINT DF_LL_LessonLearn_VersionNo DEFAULT(0),
        IsLocked BIT NOT NULL CONSTRAINT DF_LL_LessonLearn_IsLocked DEFAULT(0),
        SubmittedDate DATETIME NULL,
        PublishedDate DATETIME NULL,
        CreateDate DATETIME NOT NULL CONSTRAINT DF_LL_LessonLearn_CreateDate DEFAULT(GETDATE()),
        Creator NVARCHAR(50) NULL,
        CreateID INT NULL,
        ModifyDate DATETIME NULL,
        Modifier NVARCHAR(50) NULL,
        ModifyID INT NULL
    );
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'ProductionLine') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD ProductionLine NVARCHAR(100) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'CellName') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD CellName NVARCHAR(100) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'ApprovalOwner') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD ApprovalOwner NVARCHAR(100) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'LlCategoryCode') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD LlCategoryCode NVARCHAR(50) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'LlGroupNote') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD LlGroupNote NVARCHAR(300) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'VersionRemark') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD VersionRemark NVARCHAR(500) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'DocumentTypesText') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD DocumentTypesText NVARCHAR(300) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'LessonLevel') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD LessonLevel NVARCHAR(50) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'Workshop') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD Workshop NVARCHAR(100) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaEnabled') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaEnabled BIT NOT NULL CONSTRAINT DF_LL_LessonLearn_PfmeaEnabled_Upgrade DEFAULT(1);
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaDescription') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaDescription NVARCHAR(MAX) NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaBeforeSeverity') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaBeforeSeverity INT NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaBeforeOccurrence') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaBeforeOccurrence INT NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaBeforeDetection') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaBeforeDetection INT NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaAfterSeverity') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaAfterSeverity INT NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaAfterOccurrence') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaAfterOccurrence INT NULL;
GO
IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaAfterDetection') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaAfterDetection INT NULL;
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnProductLine', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnProductLine
    (
        LessonLearnProductLine_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        ProductLine NVARCHAR(100) NOT NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnProductLine_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnTag', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnTag
    (
        LessonLearnTag_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        TagName NVARCHAR(100) NOT NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnTag_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnDocumentType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnDocumentType
    (
        LessonLearnDocumentType_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        DocumentType NVARCHAR(100) NOT NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnDocumentType_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnContent', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnContent
    (
        LessonLearnContent_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        ModuleType NVARCHAR(50) NOT NULL,
        Sort INT NULL,
        ContentEn NVARCHAR(MAX) NULL,
        ContentZh NVARCHAR(MAX) NULL,
        CONSTRAINT FK_LL_LessonLearnContent_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnDocumentChange', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnDocumentChange
    (
        LessonLearnDocumentChange_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        ChangeType NVARCHAR(100) NULL,
        BeforeFileName NVARCHAR(300) NULL,
        AfterFileName NVARCHAR(300) NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnDocumentChange_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnFile', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnFile
    (
        LessonLearnFile_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        FileType NVARCHAR(50) NOT NULL,
        ModuleType NVARCHAR(50) NULL,
        LessonLearnContent_Id INT NULL,
        LessonLearnDocumentChange_Id INT NULL,
        Category NVARCHAR(100) NULL,
        Name NVARCHAR(260) NULL,
        Path NVARCHAR(500) NULL,
        Size BIGINT NULL,
        DownloadCount INT NOT NULL CONSTRAINT DF_LL_LessonLearnFile_DownloadCount DEFAULT(0),
        UploadTime DATETIME NULL,
        CaptionEn NVARCHAR(500) NULL,
        CaptionZh NVARCHAR(500) NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnFile_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id),
        CONSTRAINT FK_LL_LessonLearnFile_Content FOREIGN KEY (LessonLearnContent_Id) REFERENCES dbo.LL_LessonLearnContent(LessonLearnContent_Id),
        CONSTRAINT FK_LL_LessonLearnFile_DocChange FOREIGN KEY (LessonLearnDocumentChange_Id) REFERENCES dbo.LL_LessonLearnDocumentChange(LessonLearnDocumentChange_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnReview', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnReview
    (
        LessonLearnReview_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        Round NVARCHAR(50) NULL,
        ReviewDate NVARCHAR(50) NULL,
        Reviewer NVARCHAR(100) NULL,
        ReviewerTitle NVARCHAR(100) NULL,
        Result NVARCHAR(50) NULL,
        Comments NVARCHAR(MAX) NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnReview_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnParticipant', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnParticipant
    (
        LessonLearnParticipant_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        Name NVARCHAR(100) NULL,
        Title NVARCHAR(100) NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnParticipant_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnTask', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnTask
    (
        LessonLearnTask_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        Title NVARCHAR(200) NULL,
        Owner NVARCHAR(100) NULL,
        DueDate NVARCHAR(50) NULL,
        Progress INT NULL,
        Status NVARCHAR(50) NULL,
        Notes NVARCHAR(MAX) NULL,
        Sort INT NULL,
        CONSTRAINT FK_LL_LessonLearnTask_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF OBJECT_ID(N'dbo.LL_LessonLearnVersion', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnVersion
    (
        LessonLearnVersion_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        VersionNo INT NULL,
        Action NVARCHAR(50) NULL,
        [Operator] NVARCHAR(100) NULL,
        StatusText NVARCHAR(50) NULL,
        Comment NVARCHAR(500) NULL,
        SnapshotJson NVARCHAR(MAX) NULL,
        ActionTime DATETIME NULL,
        CONSTRAINT FK_LL_LessonLearnVersion_Main FOREIGN KEY (LessonLearn_Id) REFERENCES dbo.LL_LessonLearn(LessonLearn_Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearn_Status' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearn'))
    CREATE INDEX IX_LL_LessonLearn_Status ON dbo.LL_LessonLearn(Status, ModifyDate DESC);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearn_LessonNo' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearn'))
    CREATE INDEX IX_LL_LessonLearn_LessonNo ON dbo.LL_LessonLearn(LessonNo);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearn_ProductLineText' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearn'))
    CREATE INDEX IX_LL_LessonLearn_ProductLineText ON dbo.LL_LessonLearn(ApplicableProductLinesText);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearnContent_Main' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearnContent'))
    CREATE INDEX IX_LL_LessonLearnContent_Main ON dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearnFile_Main' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearnFile'))
    CREATE INDEX IX_LL_LessonLearnFile_Main ON dbo.LL_LessonLearnFile(LessonLearn_Id, FileType, Sort);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LL_LessonLearnVersion_Main' AND object_id = OBJECT_ID(N'dbo.LL_LessonLearnVersion'))
    CREATE INDEX IX_LL_LessonLearnVersion_Main ON dbo.LL_LessonLearnVersion(LessonLearn_Id, VersionNo DESC, ActionTime DESC);
GO

/*
菜单模板：

USE [vol_pro_main];
GO

DECLARE @ParentId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = N'Lesson Learn');
IF @ParentId IS NULL
BEGIN
    SET @ParentId = (SELECT ISNULL(MAX(Menu_Id), 0) + 1 FROM Sys_Menu);
    INSERT INTO Sys_Menu
    (
        Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName,
        ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType, AuthData
    )
    VALUES
    (
        @ParentId, N'Lesson Learn',
        N'[{"text":"查询","value":"Search"}]',
        N'bi-journal-text', N'Lesson Learn', 1, 960, N'.',
        0, NULL, GETDATE(), N'sql', GETDATE(), N'sql', 0, 0, NULL
    );
END

DECLARE @MenuId INT = (SELECT ISNULL(MAX(Menu_Id), 0) + 1 FROM Sys_Menu);
INSERT INTO Sys_Menu
(
    Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName,
    ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType, AuthData
)
VALUES
(
    @MenuId, N'Lesson Learn Center',
    N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"上传","value":"Upload"}]',
    N'bi-bookmark-star', N'Lesson Learn Center', 1, 900, N'LL_LessonLearn',
    @ParentId, N'/LL_LessonLearn', GETDATE(), N'sql', GETDATE(), N'sql', 0, 0, NULL
);
*/
