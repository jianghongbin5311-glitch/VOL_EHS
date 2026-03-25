-- =================================================================
-- 09_update_kb_menu.sql  
-- 将"EHS知识问答-AI助理"菜单从外部URL改为内部路由
-- =================================================================

-- Sys_Menu 表在系统主库 nxt_ehs_main 中
USE nxt_ehs_main;
GO

-- 更新菜单：从外部链接改为内部页面路由
-- 关键字段: MenuType=0(PC菜单), LinkType=0(内部路由,非外部链接)
UPDATE Sys_Menu
SET Url = '/EHS_KnowledgeChat',
    MenuType = 0,
    LinkType = 0,
    Auth = '/EHS_KnowledgeChat',
    TableName = 'EHS_KnowledgeChat'
WHERE Menu_Id = 610;

PRINT N'[OK] 菜单已更新: EHS知识问答-AI助理 → /EHS_KnowledgeChat (内部路由)'
GO

-- 验证
SELECT Menu_Id, MenuName, Url, MenuType, LinkType, Auth, ParentId
FROM Sys_Menu
WHERE Menu_Id = 610;
GO
