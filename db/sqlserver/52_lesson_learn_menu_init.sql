USE [vol_pro_ll_main];
GO

/*
说明：
1. 本脚本用于在 Lesson Learn 专属主库 `vol_pro_ll_main` 创建 Lesson Learn 一级菜单与二级页面菜单。
2. 如果菜单已存在，则只更新关键字段，不重复插入。
3. 同时为常见管理员角色补充菜单授权，避免菜单创建成功但前端不可见。
4. 脚本结尾会输出菜单与授权结果，便于执行后立即核对。
*/

DECLARE @ParentId INT;
DECLARE @MenuId INT;

SELECT @ParentId = Menu_Id
FROM dbo.Sys_Menu
WHERE MenuName = N'Lesson Learn'
  AND ParentId = 0;

IF @ParentId IS NULL
BEGIN
    INSERT INTO dbo.Sys_Menu
    (
        ParentId, MenuName, TableName, Url, Auth, AuthData, LinkType,
        Description, Icon, OrderNo, Creator, CreateDate, Modifier, ModifyDate, Enable, MenuType
    )
    VALUES
    (
        0, N'Lesson Learn', N'.', NULL,
        N'[{"text":"查询","value":"Search"}]', NULL, 0,
        N'Lesson Learn 一级菜单', N'el-icon-reading', 9500, N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
    );
    SET @ParentId = SCOPE_IDENTITY();
END
ELSE
BEGIN
    UPDATE dbo.Sys_Menu
    SET
        TableName = N'.',
        Url = NULL,
        Auth = N'[{"text":"查询","value":"Search"}]',
        LinkType = 0,
        Description = N'Lesson Learn 一级菜单',
        Icon = N'el-icon-reading',
        OrderNo = 9500,
        Enable = 1,
        MenuType = 0,
        Modifier = N'sql',
        ModifyDate = GETDATE()
    WHERE Menu_Id = @ParentId;
END

SELECT @MenuId = Menu_Id
FROM dbo.Sys_Menu
WHERE Url = N'/LL_LessonLearn';

IF @MenuId IS NULL
BEGIN
    INSERT INTO dbo.Sys_Menu
    (
        ParentId, MenuName, TableName, Url, Auth, AuthData, LinkType,
        Description, Icon, OrderNo, Creator, CreateDate, Modifier, ModifyDate, Enable, MenuType
    )
    VALUES
    (
        @ParentId, N'Lesson Learn Center', N'LL_LessonLearn', N'/LL_LessonLearn',
        N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"上传","value":"Upload"}]', NULL, 0,
        N'Lesson Learn 业务中心', N'el-icon-notebook-2', 9490, N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
    );
    SET @MenuId = SCOPE_IDENTITY();
END
ELSE
BEGIN
    UPDATE dbo.Sys_Menu
    SET
        ParentId = @ParentId,
        MenuName = N'Lesson Learn Center',
        TableName = N'LL_LessonLearn',
        Url = N'/LL_LessonLearn',
        Auth = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"上传","value":"Upload"}]',
        LinkType = 0,
        Description = N'Lesson Learn 业务中心',
        Icon = N'el-icon-notebook-2',
        OrderNo = 9490,
        Enable = 1,
        MenuType = 0,
        Modifier = N'sql',
        ModifyDate = GETDATE()
    WHERE Menu_Id = @MenuId;
END

DECLARE @AdminRoles TABLE (Role_Id INT PRIMARY KEY);

INSERT INTO @AdminRoles (Role_Id)
SELECT DISTINCT Role_Id
FROM dbo.Sys_Role
WHERE Role_Id IN (1, 2)
   OR RoleName IN (N'超级管理员', N'系统管理员', N'管理员', N'开发管理员', N'admin', N'Admin');

INSERT INTO dbo.Sys_RoleAuth
(
    Role_Id, User_Id, Menu_Id, AuthValue, AuthMenuData, Creator, CreateDate, Modifier, ModifyDate
)
SELECT
    R.Role_Id,
    NULL,
    M.Menu_Id,
    CASE
        WHEN M.Menu_Id = @MenuId THEN N'Search,Add,Update,Upload'
        ELSE N'Search'
    END,
    NULL,
    N'sql',
    GETDATE(),
    N'sql',
    GETDATE()
FROM @AdminRoles R
INNER JOIN dbo.Sys_Menu M
    ON M.Menu_Id IN (@ParentId, @MenuId)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Sys_RoleAuth A
    WHERE A.Role_Id = R.Role_Id
      AND A.Menu_Id = M.Menu_Id
);
GO

PRINT N'[OK] Lesson Learn 菜单修复完成';

SELECT
    Menu_Id,
    ParentId,
    MenuName,
    Url,
    TableName,
    Enable,
    OrderNo,
    Icon,
    MenuType,
    LinkType
FROM dbo.Sys_Menu
WHERE MenuName = N'Lesson Learn'
   OR Url = N'/LL_LessonLearn'
ORDER BY ParentId, OrderNo DESC, Menu_Id;

SELECT
    R.RoleName,
    A.Menu_Id,
    M.MenuName,
    A.AuthValue
FROM dbo.Sys_RoleAuth A
INNER JOIN dbo.Sys_Role R ON R.Role_Id = A.Role_Id
INNER JOIN dbo.Sys_Menu M ON M.Menu_Id = A.Menu_Id
WHERE M.MenuName = N'Lesson Learn'
   OR M.Url = N'/LL_LessonLearn'
ORDER BY R.RoleName, A.Menu_Id;
GO

/*
普通角色授权模板：

USE [vol_pro_ll_main];
GO

DECLARE @RoleId INT = 2;
DECLARE @MenuId INT = (SELECT Menu_Id FROM dbo.Sys_Menu WHERE Url = N'/LL_LessonLearn');

IF @MenuId IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dbo.Sys_RoleAuth WHERE Role_Id = @RoleId AND Menu_Id = @MenuId)
BEGIN
    INSERT INTO dbo.Sys_RoleAuth
    (
        Role_Id, User_Id, Menu_Id, AuthValue, AuthMenuData, Creator, CreateDate, Modifier, ModifyDate
    )
    VALUES
    (
        @RoleId, NULL, @MenuId,
        N'Search,Add,Update,Upload', NULL, N'sql', GETDATE(), N'sql', GETDATE()
    );
END
*/
