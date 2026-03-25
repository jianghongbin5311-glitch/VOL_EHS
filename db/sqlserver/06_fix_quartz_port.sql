-- =================================================================
-- 06_fix_quartz_port.sql
-- 修复Quartz定时任务的URL端口 (9991 → 9100)
-- 执行库: nxt_ehs_main (系统主库)
-- =================================================================
USE nxt_ehs_main;
GO

-- 修复：Quartz任务URL端口错误 (后端实际运行在9100端口)
UPDATE Sys_QuartzOptions
SET ApiUrl = REPLACE(ApiUrl, 'localhost:9991', 'localhost:9100')
WHERE ApiUrl LIKE '%localhost:9991%';
GO

-- 验证修复结果
SELECT TaskName, ApiUrl, Status FROM Sys_QuartzOptions WHERE TaskName LIKE '%EHS%';
GO

PRINT N'Quartz任务端口已修复: 9991 → 9100'
GO
