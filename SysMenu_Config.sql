-- ==========================================
-- Lesson Learn 模块：二级菜单与展示数据配置脚本
-- ==========================================

-- 1. 查找左侧已建好的一级菜单 ID
DECLARE @LessonLearnId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = 'Lesson Learn');
DECLARE @ProblemCenterId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = '问题中心' OR MenuName = 'Problem Center');
DECLARE @MyFavoriteId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = '我的收藏');
DECLARE @MyTaskId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = '我的任务');
DECLARE @ExplodedViewId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = '爆炸图');
DECLARE @DashboardId INT = (SELECT TOP 1 Menu_Id FROM Sys_Menu WHERE MenuName = '大屏数据');

-- 2. 插入 Lesson Learn 的二级菜单
IF @LessonLearnId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @LessonLearnId AND Url = '/LL_LessonLearn')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@LessonLearnId, '知识与经验台账', '', '/LL_LessonLearn', '', 'el-icon-notebook-1', 1, GETDATE());
    
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @LessonLearnId AND Url = '/LL_ReviewCenter')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@LessonLearnId, '评审与审批中心', '', '/LL_ReviewCenter', '', 'el-icon-medal', 1, GETDATE());
        
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @LessonLearnId AND Url = '/LL_MasterDataPlant')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@LessonLearnId, '基础数据管理', '', '/LL_MasterDataPlant', '', 'el-icon-s-operation', 1, GETDATE());
END

-- 3. 插入 问题中心 的二级菜单
IF @ProblemCenterId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @ProblemCenterId AND Url = '/LL_ProblemCenter')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@ProblemCenterId, '问题追踪池', '', '/LL_ProblemCenter', '', 'el-icon-warning-outline', 1, GETDATE());
END

-- 4. 插入 我的任务 的二级菜单
IF @MyTaskId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @MyTaskId AND Url = '/LL_TaskCenter')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@MyTaskId, '所有待办任务', '', '/LL_TaskCenter', '', 'el-icon-s-claim', 1, GETDATE());
END

-- 5. 插入 爆炸图 的二级菜单
IF @ExplodedViewId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @ExplodedViewId AND Url = '/LL_ExplodedView')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@ExplodedViewId, '2D/3D 爆炸图库', '', '/LL_ExplodedView', '', 'el-icon-picture', 1, GETDATE());
END

-- 6. 插入 大屏数据 的二级菜单
IF @DashboardId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @DashboardId AND Url = '/LL_Dashboard')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@DashboardId, '全局统计驾驶舱', '', '/LL_Dashboard', '', 'el-icon-s-data', 1, GETDATE());
        
    IF NOT EXISTS (SELECT 1 FROM Sys_Menu WHERE ParentId = @DashboardId AND Url = '/LL_Analytics')
        INSERT INTO Sys_Menu (ParentId, MenuName, TableName, Url, Auth, Icon, Enable, CreateDate)
        VALUES (@DashboardId, '维保与报表分析', '', '/LL_Analytics', '', 'el-icon-pie-chart', 1, GETDATE());
END

PRINT '===== 二级菜单插入完成 =====';

-- ==========================================
-- 测试数据部分：
-- 由于业务表字段较多，建议在前端 Vue 页面中拦截空数据并渲染精美的静态 Mock 卡片！
-- 本脚本重点解决菜单路由的导航问题。
-- ==========================================
