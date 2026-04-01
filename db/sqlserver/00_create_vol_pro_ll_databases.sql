IF DB_ID(N'vol_pro_ll_main') IS NULL
BEGIN
    CREATE DATABASE [vol_pro_ll_main];
END
GO

IF DB_ID(N'vol_pro_ll_service') IS NULL
BEGIN
    CREATE DATABASE [vol_pro_ll_service];
END
GO

PRINT N'[OK] vol_pro_ll_main / vol_pro_ll_service 已创建或已存在';
GO
