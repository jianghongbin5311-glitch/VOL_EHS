USE [vol_pro_ll_main];
GO

DECLARE @LessonRootId INT;
SELECT @LessonRootId = Menu_Id
FROM dbo.Sys_Menu
WHERE ParentId = 0 AND MenuName = N'Lesson Learn';

IF @LessonRootId IS NULL
BEGIN
    RAISERROR(N'请先执行 Lesson Learn 菜单初始化脚本', 16, 1);
    RETURN;
END;

DECLARE @BaseRootId INT;
SELECT @BaseRootId = Menu_Id
FROM dbo.Sys_Menu
WHERE ParentId = @LessonRootId AND MenuName = N'基础数据维护';

IF @BaseRootId IS NULL
BEGIN
    INSERT INTO dbo.Sys_Menu
    (
        ParentId, MenuName, TableName, Url, Auth, AuthData, LinkType,
        Description, Icon, OrderNo, Creator, CreateDate, Modifier, ModifyDate, Enable, MenuType
    )
    VALUES
    (
        @LessonRootId, N'基础数据维护', N'.', NULL,
        N'[{"text":"查询","value":"Search"}]', NULL, 0,
        N'Lesson Learn 基础数据统一维护入口', N'el-icon-setting', 999990, N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
    );
    SET @BaseRootId = SCOPE_IDENTITY();
END;

DECLARE @Menus TABLE
(
    MenuName NVARCHAR(100),
    Url NVARCHAR(100),
    OrderNo INT
);

INSERT INTO @Menus (MenuName, Url, OrderNo)
VALUES
(N'工厂维护', N'/LL_MasterDataPlant', 999989),
(N'车间维护', N'/LL_MasterDataWorkshop', 999988),
(N'线体维护', N'/LL_MasterDataLine', 999987),
(N'产品线维护', N'/LL_MasterDataProductLine', 999986),
(N'标签建议维护', N'/LL_MasterDataTag', 999985),
(N'文件类别维护', N'/LL_MasterDataDocumentType', 999984);

DECLARE @MenuName NVARCHAR(100), @Url NVARCHAR(100), @OrderNo INT, @MenuId INT;
DECLARE menu_cursor CURSOR FAST_FORWARD FOR
SELECT MenuName, Url, OrderNo FROM @Menus;

OPEN menu_cursor;
FETCH NEXT FROM menu_cursor INTO @MenuName, @Url, @OrderNo;

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
            @BaseRootId, @MenuName, N'.', @Url,
            N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"}]',
            NULL, 0, @MenuName, N'el-icon-folder-opened', @OrderNo,
            N'sql', GETDATE(), N'sql', GETDATE(), 1, 0
        );
    END
    ELSE
    BEGIN
        UPDATE dbo.Sys_Menu
        SET ParentId = @BaseRootId,
            MenuName = @MenuName,
            Auth = N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"}]',
            Icon = N'el-icon-folder-opened',
            OrderNo = @OrderNo,
            Enable = 1,
            Modifier = N'sql',
            ModifyDate = GETDATE()
        WHERE Menu_Id = @MenuId;
    END;

    FETCH NEXT FROM menu_cursor INTO @MenuName, @Url, @OrderNo;
END;

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
    CASE WHEN M.Menu_Id = @BaseRootId THEN N'Search' ELSE N'Search,Add,Update,Delete' END,
    NULL,
    N'sql',
    GETDATE(),
    N'sql',
    GETDATE()
FROM @AdminRoles R
INNER JOIN dbo.Sys_Menu M ON M.ParentId = @BaseRootId OR M.Menu_Id = @BaseRootId
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Sys_RoleAuth A
    WHERE A.Role_Id = R.Role_Id
      AND A.Menu_Id = M.Menu_Id
);
GO
