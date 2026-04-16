SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [vol_pro_ll_service];
GO

PRINT 'Start upgrade: lesson learn slide 1-34 changes'
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'ProductPlatformsText') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD ProductPlatformsText NVARCHAR(500) NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'IssueUrl') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD IssueUrl NVARCHAR(500) NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'CpiProgram') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD CpiProgram NVARCHAR(300) NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'PartVersion') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD PartVersion NVARCHAR(50) NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaEnabled') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaEnabled BIT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaDescription') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaDescription NVARCHAR(MAX) NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaBeforeSeverity') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaBeforeSeverity INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaBeforeOccurrence') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaBeforeOccurrence INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaBeforeDetection') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaBeforeDetection INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaAfterSeverity') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaAfterSeverity INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaAfterOccurrence') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaAfterOccurrence INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'DfmeaAfterDetection') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD DfmeaAfterDetection INT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'IsActive') IS NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ADD IsActive BIT NULL
END
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'ProductPlatform') IS NOT NULL
BEGIN
    ALTER TABLE dbo.LL_LessonLearn ALTER COLUMN ProductPlatform NVARCHAR(500) NULL
END
GO

UPDATE dbo.LL_LessonLearn
SET
    ProductPlatformsText = ISNULL(NULLIF(ProductPlatformsText, ''), ProductPlatform),
    IsActive = ISNULL(IsActive, 1),
    ApprovalOwner = CASE
        WHEN ApprovalOwner IS NULL OR LTRIM(RTRIM(ApprovalOwner)) = '' OR ApprovalOwner = 'PL APQP' THEN 'Nexteer Issue Owner'
        ELSE ApprovalOwner
    END
WHERE 1 = 1
GO

IF OBJECT_ID('dbo.LL_LessonLearnUserMetric', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_LessonLearnUserMetric
    (
        LessonLearnUserMetric_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        LessonLearn_Id INT NOT NULL,
        MetricType NVARCHAR(30) NOT NULL,
        UserId INT NULL,
        UserName NVARCHAR(100) NULL,
        CreateDate DATETIME NULL
    )
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_LL_LessonLearnUserMetric_Lesson_Metric_User' AND object_id = OBJECT_ID('dbo.LL_LessonLearnUserMetric'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX IX_LL_LessonLearnUserMetric_Lesson_Metric_User
        ON dbo.LL_LessonLearnUserMetric (LessonLearn_Id, MetricType, UserId, UserName)
END
GO

PRINT 'Done upgrade: lesson learn slide 1-34 changes'
GO
