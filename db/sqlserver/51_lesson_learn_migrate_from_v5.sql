USE [vol_pro_ll_service];
GO

/*
由 tools/lessonlearn_export_v5_to_sql.py 自动生成。
来源：LL_System_Final_V5/data.json
说明：
0. 本脚本面向 Lesson Learn 专属业务库 `vol_pro_ll_service`。
1. 旧系统 status 不等于新系统审批状态，因此统一迁移为新系统 Status=0（编辑中）。
2. 旧系统 status 会保存在 VersionRemark 和标签 LegacyStatus:* 中。
3. 再次执行本脚本时，会按 LessonNo 覆盖对应记录的子表数据。
*/

-- V5记录ID: 1, LL编号: 1
BEGIN TRY
    BEGIN TRAN;
    DECLARE @LessonLearn_Id INT;

    IF EXISTS (SELECT 1 FROM dbo.LL_LessonLearn WHERE LessonNo = N'1')
    BEGIN
        SELECT @LessonLearn_Id = LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'1';
        DELETE FROM dbo.LL_LessonLearnFile WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnDocumentType WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnReview WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnParticipant WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnTask WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnContent WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnProductLine WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnTag WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnVersion WHERE LessonLearn_Id = @LessonLearn_Id;

        UPDATE dbo.LL_LessonLearn
        SET
            TitleEn = N'Test Title 01',
            TitleCn = NULL,
            Category = N'Process',
            ProductPlatform = NULL,
            LlGroup = NULL,
            IssueSource = N'1',
            IssueNo = N'11',
            IssueType = N'Internal',
            CPI = N'111',
            Customer = N'111',
            Program = N'11',
            PartNo = N'11',
            Plant = N'11',
            ProductionLine = N'1',
            CellName = NULL,
            ApprovalOwner = N'PL APQP',
            LlCategoryCode = NULL,
            LlGroupNote = NULL,
            VersionRemark = N'迁移自 V5；旧系统状态：Optional',
            ApplicableProductLinesText = N'REPS',
            TagsText = N'Supplier, LegacyStatus:Optional',
            DocumentTypesText = NULL,
            Status = 0,
            Progress = 90,
            AnalysisCycleDays = 0,
            IsLocked = 0,
            CreateDate = COALESCE(CreateDate, TRY_CONVERT(DATETIME, N'2025-12-10')),
            ModifyDate = GETDATE(),
            Modifier = N'migration',
            ModifyID = 0,
            VersionNo = 1
        WHERE LessonLearn_Id = @LessonLearn_Id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.LL_LessonLearn
        (
            LessonNo, TitleEn, TitleCn, Category, ProductPlatform, LlGroup,
            IssueSource, IssueNo, IssueType, CPI, Customer, Program, PartNo, Plant,
            ProductionLine, CellName, ApprovalOwner, LlCategoryCode, LlGroupNote, VersionRemark,
            ApplicableProductLinesText, TagsText, DocumentTypesText,
            Status, Progress, AnalysisCycleDays, ViewCount, FavoriteCount, LikeCount, VersionNo, IsLocked,
            CreateDate, Creator, CreateID, ModifyDate, Modifier, ModifyID
        )
        VALUES
        (
            N'1', N'Test Title 01', NULL, N'Process', NULL, NULL,
            N'1', N'11', N'Internal', N'111', N'111', N'11', N'11', N'11',
            N'1', NULL, N'PL APQP', NULL, NULL, N'迁移自 V5；旧系统状态：Optional',
            N'REPS', N'Supplier, LegacyStatus:Optional', NULL,
            0, 90, 0, 0, 0, 0, 1, 0,
            TRY_CONVERT(DATETIME, N'2025-12-10'), N'migration', 0, GETDATE(), N'migration', 0
        );
        SET @LessonLearn_Id = SCOPE_IDENTITY();
    END

    INSERT INTO dbo.LL_LessonLearnProductLine(LessonLearn_Id, ProductLine, Sort) VALUES(@LessonLearn_Id, N'REPS', 1);
    INSERT INTO dbo.LL_LessonLearnTag(LessonLearn_Id, TagName, Sort) VALUES(@LessonLearn_Id, N'Supplier', 1);
    INSERT INTO dbo.LL_LessonLearnTag(LessonLearn_Id, TagName, Sort) VALUES(@LessonLearn_Id, N'LegacyStatus:Optional', 2);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'IssueDescription', 1, N'111', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'RootCause', 1, N'11', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'CorrectiveActions', 1, N'1', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'GlobalLessons', 1, N'1', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'SupplementalNotes', 1, N'1', NULL);
    INSERT INTO dbo.LL_LessonLearnVersion(LessonLearn_Id, VersionNo, Action, [Operator], StatusText, Comment, SnapshotJson, ActionTime) VALUES(@LessonLearn_Id, 1, N'数据迁移', N'migration', N'编辑中', N'迁移自 V5；旧系统状态：Optional', N'{"LegacyId": 1, "Source": "LL_System_Final_V5", "Title": "Test Title 01", "LessonNo": "1"}', GETDATE());
    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    THROW;
END CATCH
GO

-- V5记录ID: 5, LL编号: 666
BEGIN TRY
    BEGIN TRAN;
    DECLARE @LessonLearn_Id INT;

    IF EXISTS (SELECT 1 FROM dbo.LL_LessonLearn WHERE LessonNo = N'666')
    BEGIN
        SELECT @LessonLearn_Id = LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = N'666';
        DELETE FROM dbo.LL_LessonLearnFile WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnDocumentType WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnReview WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnParticipant WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnTask WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnContent WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnProductLine WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnTag WHERE LessonLearn_Id = @LessonLearn_Id;
        DELETE FROM dbo.LL_LessonLearnVersion WHERE LessonLearn_Id = @LessonLearn_Id;

        UPDATE dbo.LL_LessonLearn
        SET
            TitleEn = N'Test Title 6',
            TitleCn = NULL,
            Category = N'Process',
            ProductPlatform = NULL,
            LlGroup = NULL,
            IssueSource = N'',
            IssueNo = N'',
            IssueType = N'Internal',
            CPI = N'',
            Customer = N'',
            Program = N'',
            PartNo = N'',
            Plant = N'',
            ProductionLine = N'',
            CellName = NULL,
            ApprovalOwner = N'PL APQP',
            LlCategoryCode = NULL,
            LlGroupNote = NULL,
            VersionRemark = N'迁移自 V5；旧系统状态：Standardized',
            ApplicableProductLinesText = N'SPEPS',
            TagsText = N'Process, LegacyStatus:Standardized',
            DocumentTypesText = NULL,
            Status = 0,
            Progress = 90,
            AnalysisCycleDays = 0,
            IsLocked = 0,
            CreateDate = COALESCE(CreateDate, TRY_CONVERT(DATETIME, N'2025-12-10')),
            ModifyDate = GETDATE(),
            Modifier = N'migration',
            ModifyID = 0,
            VersionNo = 1
        WHERE LessonLearn_Id = @LessonLearn_Id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.LL_LessonLearn
        (
            LessonNo, TitleEn, TitleCn, Category, ProductPlatform, LlGroup,
            IssueSource, IssueNo, IssueType, CPI, Customer, Program, PartNo, Plant,
            ProductionLine, CellName, ApprovalOwner, LlCategoryCode, LlGroupNote, VersionRemark,
            ApplicableProductLinesText, TagsText, DocumentTypesText,
            Status, Progress, AnalysisCycleDays, ViewCount, FavoriteCount, LikeCount, VersionNo, IsLocked,
            CreateDate, Creator, CreateID, ModifyDate, Modifier, ModifyID
        )
        VALUES
        (
            N'666', N'Test Title 6', NULL, N'Process', NULL, NULL,
            N'', N'', N'Internal', N'', N'', N'', N'', N'',
            N'', NULL, N'PL APQP', NULL, NULL, N'迁移自 V5；旧系统状态：Standardized',
            N'SPEPS', N'Process, LegacyStatus:Standardized', NULL,
            0, 90, 0, 0, 0, 0, 1, 0,
            TRY_CONVERT(DATETIME, N'2025-12-10'), N'migration', 0, GETDATE(), N'migration', 0
        );
        SET @LessonLearn_Id = SCOPE_IDENTITY();
    END

    INSERT INTO dbo.LL_LessonLearnProductLine(LessonLearn_Id, ProductLine, Sort) VALUES(@LessonLearn_Id, N'SPEPS', 1);
    INSERT INTO dbo.LL_LessonLearnTag(LessonLearn_Id, TagName, Sort) VALUES(@LessonLearn_Id, N'Process', 1);
    INSERT INTO dbo.LL_LessonLearnTag(LessonLearn_Id, TagName, Sort) VALUES(@LessonLearn_Id, N'LegacyStatus:Standardized', 2);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'IssueDescription', 1, N'66', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'RootCause', 1, N'66', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'CorrectiveActions', 1, N'66', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'GlobalLessons', 1, N'6', NULL);
    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'SupplementalNotes', 1, N'6', NULL);
    INSERT INTO dbo.LL_LessonLearnReview(LessonLearn_Id, Round, ReviewDate, Reviewer, ReviewerTitle, Result, Comments, Sort) VALUES(@LessonLearn_Id, N'', N'2025-12-10', N'', N'', N'Pass', N'6', 1);
    INSERT INTO dbo.LL_LessonLearnVersion(LessonLearn_Id, VersionNo, Action, [Operator], StatusText, Comment, SnapshotJson, ActionTime) VALUES(@LessonLearn_Id, 1, N'数据迁移', N'migration', N'编辑中', N'迁移自 V5；旧系统状态：Standardized', N'{"LegacyId": 5, "Source": "LL_System_Final_V5", "Title": "Test Title 6", "LessonNo": "666"}', GETDATE());
    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    THROW;
END CATCH
GO
