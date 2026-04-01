USE [vol_pro_ll_service];
GO

IF OBJECT_ID('dbo.LL_MasterData', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.LL_MasterData
    (
        MasterData_Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        DataType NVARCHAR(50) NOT NULL,
        DataCode NVARCHAR(100) NOT NULL,
        DataName NVARCHAR(200) NOT NULL,
        ParentCode NVARCHAR(100) NULL,
        ParentName NVARCHAR(200) NULL,
        Sort INT NULL CONSTRAINT DF_LL_MasterData_Sort DEFAULT(0),
        IsEnabled BIT NOT NULL CONSTRAINT DF_LL_MasterData_IsEnabled DEFAULT(1),
        IsDefault BIT NOT NULL CONSTRAINT DF_LL_MasterData_IsDefault DEFAULT(0),
        Ext1 NVARCHAR(50) NULL,
        Ext2 NVARCHAR(100) NULL,
        Remark NVARCHAR(500) NULL,
        CreateDate DATETIME NULL CONSTRAINT DF_LL_MasterData_CreateDate DEFAULT(GETDATE()),
        Creator NVARCHAR(100) NULL,
        ModifyDate DATETIME NULL CONSTRAINT DF_LL_MasterData_ModifyDate DEFAULT(GETDATE()),
        Modifier NVARCHAR(100) NULL
    );

    CREATE UNIQUE INDEX IX_LL_MasterData_DataType_DataCode
        ON dbo.LL_MasterData(DataType, DataCode);
END;
GO
