USE [vol_pro_ll_service];
GO

/*
仅限测试环境使用

目标：
1. 清空 Lesson Learn 全部业务数据，去掉历史测试记录干扰。
2. 保留表结构、索引、主外键，不影响代码和菜单。
3. 执行完成后，再运行 55_lesson_learn_demo_seed.sql 重新灌入标准演示数据。

注意：
- 本脚本不会删除表。
- 本脚本不会影响 vol_pro_ll_main 中的菜单、角色、权限。
- 生产环境禁止直接执行。
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY
    BEGIN TRAN;

    DELETE FROM dbo.LL_LessonLearnVersion;
    DELETE FROM dbo.LL_LessonLearnTask;
    DELETE FROM dbo.LL_LessonLearnParticipant;
    DELETE FROM dbo.LL_LessonLearnReview;
    DELETE FROM dbo.LL_LessonLearnFile;
    DELETE FROM dbo.LL_LessonLearnDocumentChange;
    DELETE FROM dbo.LL_LessonLearnContent;
    DELETE FROM dbo.LL_LessonLearnDocumentType;
    DELETE FROM dbo.LL_LessonLearnTag;
    DELETE FROM dbo.LL_LessonLearnProductLine;
    DELETE FROM dbo.LL_LessonLearn;

    DBCC CHECKIDENT ('dbo.LL_LessonLearnVersion', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnTask', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnParticipant', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnReview', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnFile', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnDocumentChange', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnContent', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnDocumentType', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnTag', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearnProductLine', RESEED, 0);
    DBCC CHECKIDENT ('dbo.LL_LessonLearn', RESEED, 0);

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN;

    THROW;
END CATCH;
GO

PRINT N'[OK] Lesson Learn 测试环境业务数据已清空。';
PRINT N'[NEXT] 请继续执行 55_lesson_learn_demo_seed.sql 重新导入演示数据。';

SELECT 'LL_LessonLearn' AS TableName, COUNT(1) AS [Rows] FROM dbo.LL_LessonLearn
UNION ALL SELECT 'LL_LessonLearnProductLine', COUNT(1) FROM dbo.LL_LessonLearnProductLine
UNION ALL SELECT 'LL_LessonLearnTag', COUNT(1) FROM dbo.LL_LessonLearnTag
UNION ALL SELECT 'LL_LessonLearnDocumentType', COUNT(1) FROM dbo.LL_LessonLearnDocumentType
UNION ALL SELECT 'LL_LessonLearnContent', COUNT(1) FROM dbo.LL_LessonLearnContent
UNION ALL SELECT 'LL_LessonLearnDocumentChange', COUNT(1) FROM dbo.LL_LessonLearnDocumentChange
UNION ALL SELECT 'LL_LessonLearnFile', COUNT(1) FROM dbo.LL_LessonLearnFile
UNION ALL SELECT 'LL_LessonLearnReview', COUNT(1) FROM dbo.LL_LessonLearnReview
UNION ALL SELECT 'LL_LessonLearnParticipant', COUNT(1) FROM dbo.LL_LessonLearnParticipant
UNION ALL SELECT 'LL_LessonLearnTask', COUNT(1) FROM dbo.LL_LessonLearnTask
UNION ALL SELECT 'LL_LessonLearnVersion', COUNT(1) FROM dbo.LL_LessonLearnVersion;
GO
