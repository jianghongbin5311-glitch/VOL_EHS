-- =================================================================
-- 08_fix_failed_reports.sql
-- 诊断并修复失败的AI报告记录
-- =================================================================

USE nxt_ehs_biz;
GO

-- 第1步：查看失败记录的错误信息
PRINT N'========== 失败记录诊断 =========='
SELECT Report_Id, ReportType, Title, GenerateStatus, ErrorMessage, CreateDate
FROM EHS_NewsReport
WHERE GenerateStatus = 3
ORDER BY CreateDate DESC;
GO

-- 第2步：删除所有失败的记录（GenerateStatus = 3 表示失败）
PRINT N'========== 删除失败记录 =========='
DELETE FROM EHS_NewsReport WHERE GenerateStatus = 3;
PRINT N'[OK] 已删除所有失败记录'
GO

-- 第3步：确认剩余数据
PRINT N'========== 当前数据汇总 =========='
SELECT ReportType, COUNT(*) AS [数量], 
    SUM(CASE WHEN GenerateStatus = 2 THEN 1 ELSE 0 END) AS [成功],
    SUM(CASE WHEN GenerateStatus = 3 THEN 1 ELSE 0 END) AS [失败]
FROM EHS_NewsReport
GROUP BY ReportType;
GO

SELECT N'外部法规新闻' AS [模块], COUNT(*) AS [总记录数] FROM EHS_NewsReport
UNION ALL
SELECT N'内部事件' AS [模块], COUNT(*) AS [总记录数] FROM EHS_GroupIncident;
GO

PRINT N'=========================================='
PRINT N'修复完成！失败记录已清除。'
PRINT N'=========================================='
GO
