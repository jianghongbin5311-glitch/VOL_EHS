USE [vol_pro_ll_service];
GO

/*
目标：
1. 初始化 Lesson Learn 1.0 基础数据。
2. 后续真实项目可直接在前端基础数据维护菜单中继续维护。
*/

IF OBJECT_ID('dbo.LL_MasterData', 'U') IS NULL
BEGIN
    RAISERROR(N'请先执行 60_lesson_learn_master_data_init.sql', 16, 1);
    RETURN;
END;

DELETE FROM dbo.LL_MasterData
WHERE DataType IN (N'Plant', N'Workshop', N'Line', N'ProductLine', N'Tag', N'DocumentType');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, Sort, IsEnabled, IsDefault, Remark, Creator, Modifier)
VALUES
(N'Plant', N'SZ', N'Shenzhen Plant', 10, 1, 1, N'演示工厂', N'sql', N'sql'),
(N'Plant', N'SZ-2', N'Shenzhen Steering Plant', 20, 1, 0, N'转向工厂', N'sql', N'sql'),
(N'Plant', N'SU', N'Suzhou Plant', 30, 1, 0, N'演示工厂', N'sql', N'sql');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, ParentCode, ParentName, Sort, IsEnabled, Remark, Creator, Modifier)
VALUES
(N'Workshop', N'SZ-QA', N'Quality Workshop', N'SZ', N'Shenzhen Plant', 10, 1, N'质量车间', N'sql', N'sql'),
(N'Workshop', N'SZ-HEAT', N'Heat Treatment Workshop', N'SZ', N'Shenzhen Plant', 20, 1, N'热处理车间', N'sql', N'sql'),
(N'Workshop', N'SZ-ASM', N'Assembly Workshop', N'SZ-2', N'Shenzhen Steering Plant', 30, 1, N'装配车间', N'sql', N'sql'),
(N'Workshop', N'SU-MACH', N'Machining Workshop', N'SU', N'Suzhou Plant', 40, 1, N'机加车间', N'sql', N'sql');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, ParentCode, ParentName, Sort, IsEnabled, Remark, Creator, Modifier)
VALUES
(N'Line', N'SZ-QA-01', N'Quality Line 01', N'SZ-QA', N'Quality Workshop', 10, 1, N'质量审核线', N'sql', N'sql'),
(N'Line', N'SZ-HT-01', N'Heat Treatment Line 01', N'SZ-HEAT', N'Heat Treatment Workshop', 20, 1, N'淬火线', N'sql', N'sql'),
(N'Line', N'SZ-ASM-02', N'Assembly Line 02', N'SZ-ASM', N'Assembly Workshop', 30, 1, N'转向装配线', N'sql', N'sql'),
(N'Line', N'SU-MC-01', N'Machining Line 01', N'SU-MACH', N'Machining Workshop', 40, 1, N'机加工线', N'sql', N'sql');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, Sort, IsEnabled, IsDefault, Remark, Creator, Modifier)
VALUES
(N'ProductLine', N'ALL-EPS', N'All EPS', 10, 1, 1, N'默认产品线', N'sql', N'sql'),
(N'ProductLine', N'REPS', N'REPS', 20, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'SPEPS', N'SPEPS', 30, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'DPEPS', N'DPEPS', 40, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'MG', N'Manual Gear', 50, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'RWA', N'RWA', 60, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'CEPS', N'CEPS', 70, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'BEPS', N'BEPS', 80, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'ISHAFT', N'I-Shaft', 90, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'COLUMN', N'Column', 100, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'MPP', N'MPP', 110, 1, 0, N'', N'sql', N'sql'),
(N'ProductLine', N'MOTOR', N'Motor', 120, 1, 0, N'', N'sql', N'sql');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, Sort, IsEnabled, Remark, Creator, Modifier)
VALUES
(N'Tag', N'PART', N'零件', 10, 1, N'', N'sql', N'sql'),
(N'Tag', N'FAILURE', N'失效模式', 20, 1, N'', N'sql', N'sql'),
(N'Tag', N'PROCESS', N'关键工艺', 30, 1, N'', N'sql', N'sql'),
(N'Tag', N'EP', N'EP', 40, 1, N'', N'sql', N'sql'),
(N'Tag', N'CRACK', N'淬火裂纹', 50, 1, N'', N'sql', N'sql'),
(N'Tag', N'RACK', N'rack', 60, 1, N'', N'sql', N'sql'),
(N'Tag', N'TRACE', N'traceability', 70, 1, N'', N'sql', N'sql'),
(N'Tag', N'COLDCURE', N'cold cure', 80, 1, N'', N'sql', N'sql'),
(N'Tag', N'DFMEA', N'DFMEA', 90, 1, N'', N'sql', N'sql'),
(N'Tag', N'SUPPLIER', N'supplier', 100, 1, N'', N'sql', N'sql');
GO

INSERT INTO dbo.LL_MasterData (DataType, DataCode, DataName, Sort, IsEnabled, IsDefault, Remark, Creator, Modifier)
VALUES
(N'DocumentType', N'DESIGN', N'设计文件', 10, 1, 1, N'', N'sql', N'sql'),
(N'DocumentType', N'PROCESS', N'工艺文件', 20, 1, 0, N'', N'sql', N'sql'),
(N'DocumentType', N'SUPPLIER', N'供应商文件', 30, 1, 0, N'', N'sql', N'sql');
GO
