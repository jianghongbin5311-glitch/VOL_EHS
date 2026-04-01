USE [vol_pro_ll_main];
GO

/*
目标：
为 Lesson Learn 平台补齐企业级导航菜单，而不是只保留单一的录入页入口。
*/

DECLARE @RootId INT;
SELECT @RootId = Menu_Id
FROM dbo.Sys_Menu
WHERE ParentId = 0
  AND MenuName = N'Lesson Learn';

IF @RootId IS NULL
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
        N'Lesson Learn 平台一级菜单', N'el-icon-reading', 999999, N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
    );
    SET @RootId = SCOPE_IDENTITY();
END
ELSE
BEGIN
    UPDATE dbo.Sys_Menu
    SET
        TableName = N'.',
        Auth = N'[{"text":"查询","value":"Search"}]',
        Description = N'Lesson Learn 平台一级菜单',
        Icon = N'el-icon-reading',
        OrderNo = 999999,
        Enable = 1,
        MenuType = 0,
        LinkType = 0,
        Modifier = N'sql',
        ModifyDate = GETDATE()
    WHERE Menu_Id = @RootId;
END

DECLARE @Menus TABLE
(
    MenuName NVARCHAR(100),
    TableName NVARCHAR(100),
    Url NVARCHAR(100),
    Icon NVARCHAR(100),
    OrderNo INT,
    Auth NVARCHAR(MAX),
    Description NVARCHAR(300)
);

INSERT INTO @Menus (MenuName, TableName, Url, Icon, OrderNo, Auth, Description)
VALUES
(N'Dashboard', N'.', N'/LL_Dashboard', N'el-icon-data-analysis', 999998, N'[{"text":"查询","value":"Search"}]', N'Lesson Learn 工作台'),
(N'Lesson Learn Center', N'LL_LessonLearn', N'/LL_LessonLearn', N'el-icon-notebook-2', 999997, N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"上传","value":"Upload"}]', N'Lesson Learn 主业务页面'),
(N'Review Center', N'.', N'/LL_ReviewCenter', N'el-icon-finished', 999996, N'[{"text":"查询","value":"Search"}]', N'评审中心'),
(N'Task Center', N'.', N'/LL_TaskCenter', N'el-icon-collection-tag', 999995, N'[{"text":"查询","value":"Search"}]', N'任务闭环中心'),
(N'Document Center', N'.', N'/LL_DocumentCenter', N'el-icon-folder-opened', 999994, N'[{"text":"查询","value":"Search"}]', N'文件与变更中心'),
(N'Version Center', N'.', N'/LL_VersionCenter', N'el-icon-time', 999993, N'[{"text":"查询","value":"Search"}]', N'版本与审计中心'),
(N'Analytics', N'.', N'/LL_Analytics', N'el-icon-pie-chart', 999992, N'[{"text":"查询","value":"Search"}]', N'统计分析中心');

DECLARE
    @MenuName NVARCHAR(100),
    @TableName NVARCHAR(100),
    @Url NVARCHAR(100),
    @Icon NVARCHAR(100),
    @OrderNo INT,
    @Auth NVARCHAR(MAX),
    @Description NVARCHAR(300),
    @MenuId INT;

DECLARE menu_cursor CURSOR FAST_FORWARD FOR
SELECT MenuName, TableName, Url, Icon, OrderNo, Auth, Description
FROM @Menus;

OPEN menu_cursor;
FETCH NEXT FROM menu_cursor INTO @MenuName, @TableName, @Url, @Icon, @OrderNo, @Auth, @Description;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @MenuId = NULL;
    SELECT @MenuId = Menu_Id FROM dbo.Sys_Menu WHERE Url = @Url;

    IF @MenuId IS NULL
    BEGIN
        INSERT INTO dbo.Sys_Menu
        (
            ParentId, MenuName, TableName, Url, Auth, AuthData, LinkType,
            Description, Icon, OrderNo, Creator, CreateDate, Modifier, ModifyDate, Enable, MenuType
        )
        VALUES
        (
            @RootId, @MenuName, @TableName, @Url, @Auth, NULL, 0,
            @Description, @Icon, @OrderNo, N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
        );
    END
    ELSE
    BEGIN
        UPDATE dbo.Sys_Menu
        SET
            ParentId = @RootId,
            MenuName = @MenuName,
            TableName = @TableName,
            Auth = @Auth,
            Description = @Description,
            Icon = @Icon,
            OrderNo = @OrderNo,
            LinkType = 0,
            Enable = 1,
            MenuType = 0,
            Modifier = N'sql',
            ModifyDate = GETDATE()
        WHERE Menu_Id = @MenuId;
    END

    FETCH NEXT FROM menu_cursor INTO @MenuName, @TableName, @Url, @Icon, @OrderNo, @Auth, @Description;
END

CLOSE menu_cursor;
DEALLOCATE menu_cursor;

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
    CASE WHEN M.Url = N'/LL_LessonLearn' THEN N'Search,Add,Update,Upload' ELSE N'Search' END,
    NULL,
    N'sql',
    GETDATE(),
    N'sql',
    GETDATE()
FROM @AdminRoles R
INNER JOIN dbo.Sys_Menu M ON M.ParentId = @RootId OR M.Menu_Id = @RootId
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Sys_RoleAuth A
    WHERE A.Role_Id = R.Role_Id
      AND A.Menu_Id = M.Menu_Id
);

SELECT Menu_Id, ParentId, MenuName, Url, TableName, OrderNo, Enable
FROM dbo.Sys_Menu
WHERE Menu_Id = @RootId OR ParentId = @RootId
ORDER BY OrderNo DESC, Menu_Id DESC;
GO
