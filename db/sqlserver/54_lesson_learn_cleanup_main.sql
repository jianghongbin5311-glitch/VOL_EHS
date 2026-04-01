USE [vol_pro_ll_main];
GO

/*
目标：
1. 保留 Lesson Learn 菜单。
2. 禁用当前主库中残留的 EHS/MES/Demo 样板业务菜单，避免独立实例继续混用。
3. 降低旧 dashboard 对 Lesson Learn 实例的干扰。

说明：
- 本脚本只处理“明显属于样板业务”的菜单树，不删除系统基础菜单。
- 执行后请重启 API。VOL Pro 的菜单在服务端有缓存，直接改库不会自动刷新到运行中的进程。
*/

DECLARE @KeepLessonRootId INT;
DECLARE @KeepLessonMenuId INT;

SELECT @KeepLessonRootId = Menu_Id
FROM dbo.Sys_Menu
WHERE ParentId = 0
  AND MenuName = N'Lesson Learn';

SELECT @KeepLessonMenuId = Menu_Id
FROM dbo.Sys_Menu
WHERE Url = N'/LL_LessonLearn';

;WITH SeedMenus AS
(
    SELECT
        Menu_Id,
        ParentId
    FROM dbo.Sys_Menu
    WHERE MenuName LIKE N'EHS%'
       OR MenuName LIKE N'MES%'
       OR MenuName LIKE N'Demo%'
       OR TableName LIKE N'EHS[_]%'
       OR TableName LIKE N'MES[_]%'
       OR TableName LIKE N'Demo[_]%'
       OR Url LIKE N'/EHS[_]%'
       OR Url LIKE N'/MES[_]%'
       OR Url LIKE N'/Demo[_]%'
       OR Url LIKE N'/Test%'
),
AncestorChain AS
(
    SELECT
        Menu_Id,
        ParentId
    FROM SeedMenus

    UNION ALL

    SELECT
        P.Menu_Id,
        P.ParentId
    FROM dbo.Sys_Menu P
    INNER JOIN AncestorChain C ON C.ParentId = P.Menu_Id
    WHERE P.Menu_Id > 0
),
TargetRoots AS
(
    SELECT DISTINCT Menu_Id
    FROM AncestorChain
    WHERE ParentId = 0
),
TargetTree AS
(
    SELECT
        M.Menu_Id,
        M.ParentId,
        M.MenuName,
        M.Url,
        M.TableName
    FROM dbo.Sys_Menu M
    INNER JOIN TargetRoots R ON R.Menu_Id = M.Menu_Id

    UNION ALL

    SELECT
        C.Menu_Id,
        C.ParentId,
        C.MenuName,
        C.Url,
        C.TableName
    FROM dbo.Sys_Menu C
    INNER JOIN TargetTree T ON C.ParentId = T.Menu_Id
)
UPDATE M
SET
    Enable = 0,
    Modifier = N'sql',
    ModifyDate = GETDATE()
FROM dbo.Sys_Menu M
INNER JOIN
(
    SELECT DISTINCT Menu_Id
    FROM TargetTree
) T ON T.Menu_Id = M.Menu_Id
WHERE M.Menu_Id NOT IN (ISNULL(@KeepLessonRootId, -1), ISNULL(@KeepLessonMenuId, -1));

IF @KeepLessonRootId IS NOT NULL
BEGIN
    UPDATE dbo.Sys_Menu
    SET
        Enable = 1,
        OrderNo = 999999,
        Icon = N'el-icon-reading',
        Modifier = N'sql',
        ModifyDate = GETDATE()
    WHERE Menu_Id = @KeepLessonRootId;
END

IF @KeepLessonMenuId IS NOT NULL
BEGIN
    UPDATE dbo.Sys_Menu
    SET
        Enable = 1,
        OrderNo = 999998,
        Icon = N'el-icon-notebook-2',
        Modifier = N'sql',
        ModifyDate = GETDATE()
    WHERE Menu_Id = @KeepLessonMenuId;
END

UPDATE dbo.Sys_Dashboard
SET
    Enable = 0
WHERE DashboardName IN (N'产量统计', N'平台统计', N'销售信息');

PRINT N'[OK] Lesson Learn 主库样板菜单清理完成，请重启 API 并重新登录前端。';

SELECT
    Menu_Id,
    ParentId,
    MenuName,
    Url,
    TableName,
    OrderNo,
    Enable
FROM dbo.Sys_Menu
WHERE ParentId = 0
ORDER BY OrderNo DESC, Menu_Id DESC;

SELECT
    Menu_Id,
    ParentId,
    MenuName,
    Url,
    TableName,
    OrderNo,
    Enable
FROM dbo.Sys_Menu
WHERE Menu_Id IN (ISNULL(@KeepLessonRootId, -1), ISNULL(@KeepLessonMenuId, -1))
   OR ParentId = ISNULL(@KeepLessonRootId, -1)
ORDER BY OrderNo DESC, Menu_Id DESC;
GO
