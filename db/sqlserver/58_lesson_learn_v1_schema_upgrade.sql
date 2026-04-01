USE [vol_pro_ll_service];
GO

/*
目标：
1. 为 Lesson Learn 1.0 两菜单版补充正式字段。
2. 不清理现有数据，只做增量升级。
3. 升级后需重启 API。
*/

IF COL_LENGTH('dbo.LL_LessonLearn', 'LessonLevel') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD LessonLevel NVARCHAR(50) NULL;
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'Workshop') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD Workshop NVARCHAR(100) NULL;
GO

IF COL_LENGTH('dbo.LL_LessonLearn', 'PfmeaEnabled') IS NULL
    ALTER TABLE dbo.LL_LessonLearn ADD PfmeaEnabled BIT NOT NULL CONSTRAINT DF_LL_LessonLearn_PfmeaEnabled_V1 DEFAULT(1);
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

UPDATE dbo.LL_LessonLearn
SET LessonLevel = ISNULL(NULLIF(LessonLevel, ''), 'Standardized'),
    PfmeaEnabled = ISNULL(PfmeaEnabled, 1),
    PfmeaBeforeSeverity = ISNULL(PfmeaBeforeSeverity, 10),
    PfmeaBeforeOccurrence = ISNULL(PfmeaBeforeOccurrence, 1),
    PfmeaBeforeDetection = ISNULL(PfmeaBeforeDetection, 1),
    PfmeaAfterSeverity = ISNULL(PfmeaAfterSeverity, 10),
    PfmeaAfterOccurrence = ISNULL(PfmeaAfterOccurrence, 1),
    PfmeaAfterDetection = ISNULL(PfmeaAfterDetection, 1)
WHERE 1 = 1;
GO
