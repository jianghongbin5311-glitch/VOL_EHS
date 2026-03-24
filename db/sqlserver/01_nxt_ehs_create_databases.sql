-- ============================================================
-- EHS 信息化平台 - 第1步：创建数据库
-- 在 CNJSCS-DB01 (10.243.98.117) 上执行
-- ============================================================

USE [master];
GO

-- 创建 EHS 系统主库（菜单/权限/流程/系统配置）
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'nxt_ehs_main')
BEGIN
    CREATE DATABASE [nxt_ehs_main];
    PRINT N'✅ 数据库 [nxt_ehs_main] 创建成功';
END
ELSE
BEGIN
    PRINT N'⚠️ 数据库 [nxt_ehs_main] 已存在，跳过创建';
END
GO

-- 创建 EHS 业务库（所有 EHS 业务表）
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'nxt_ehs_biz')
BEGIN
    CREATE DATABASE [nxt_ehs_biz];
    PRINT N'✅ 数据库 [nxt_ehs_biz] 创建成功';
END
ELSE
BEGIN
    PRINT N'⚠️ 数据库 [nxt_ehs_biz] 已存在，跳过创建';
END
GO

PRINT N'';
PRINT N'============================================================';
PRINT N'数据库创建完成！';
PRINT N'';
PRINT N'下一步：';
PRINT N'  1. 将 vol_pro_main.sql 的内容执行到 [nxt_ehs_main]';
PRINT N'     （请先将文件中的 USE [vol_pro_main] 替换为 USE [nxt_ehs_main]）';
PRINT N'  2. 将 vol_pro_service.sql 的内容执行到 [nxt_ehs_biz]';
PRINT N'     （请先将文件中的 USE [vol_pro_service] 替换为 USE [nxt_ehs_biz]）';
PRINT N'  3. 执行 02_nxt_ehs_biz_tables.sql（创建EHS业务表）';
PRINT N'  4. 执行 03_nxt_ehs_menus_roles.sql（创建菜单和角色权限）';
PRINT N'============================================================';
GO
