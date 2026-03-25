-- =================================================================
-- 07_ehs_complete_seed_data.sql
-- EHS完整种子数据（带检查，安全重复执行）
-- 
-- 使用方式：在 SSMS 中一次性执行整个脚本
-- 注意：此脚本包含两个数据库的操作
-- =================================================================

-- =========================================
-- 第一部分：在 nxt_ehs_biz 业务库中插入数据
-- =========================================
USE nxt_ehs_biz;
GO

-- 检查表是否存在
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_NewsReport')
BEGIN
    PRINT N'[ERROR] EHS_NewsReport 表不存在！请先执行 04_ehs_news_tables.sql'
END
ELSE
BEGIN
    -- 清空旧数据（种子数据可重复执行）
    IF NOT EXISTS (SELECT TOP 1 1 FROM EHS_NewsReport)
    BEGIN
        PRINT N'[INFO] 正在插入外部法规新闻种子数据...'

        -- 日报数据 x 5
        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source, SourceUrl,
            Summary, Impact, [Action], Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-20250325-001', N'日报', GETDATE(), N'苏州市应急管理局发布2025年第一季度安全生产形势分析', N'法规',
         N'苏州市应急管理局', N'https://yjglj.suzhou.gov.cn',
         N'苏州市应急管理局发布2025年第一季度安全生产形势分析报告，重点关注工贸领域安全生产。',
         N'工厂需关注季度安全生产重点领域，对照检查自身安全管理体系',
         N'开展第一季度安全生产自查自纠，重点检查特种设备、危化品管理',
         N'## 苏州市应急管理局：2025年Q1安全生产形势分析

**日期**: 2025-03-25 | **来源**: 苏州市应急管理局 | **类别**: 法规

### 摘要
苏州市应急管理局发布2025年第一季度安全生产形势分析报告，全市安全生产形势总体平稳，工贸领域需重点关注有限空间作业、粉尘涉爆等高风险环节。

### 对工厂EHS的影响
- 工厂需按照季度报告要求，开展重点领域安全隐患排查
- 有限空间作业许可制度需进一步完善
- 粉尘涉爆场所需定期检测维护

### 建议动作
1. 开展第一季度安全生产自查自纠
2. 重点检查特种设备年检情况
3. 完善有限空间作业管理制度
4. 加强粉尘涉爆场所的日常巡检',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source, SourceUrl,
            Summary, Impact, [Action], Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-20250325-002', N'日报', GETDATE(), N'江苏省应急管理厅：3月份危化品专项整治行动通知', N'检查',
         N'江苏省应急管理厅', N'https://yjglt.jiangsu.gov.cn',
         N'江苏省应急管理厅部署3月份危化品和非煤矿山安全专项整治行动。',
         N'危化品使用管理标准将趋严',
         N'检查工厂危化品存储和使用是否符合最新标准',
         N'## 江苏省应急管理厅：3月份专项整治行动

**日期**: 2025-03-24 | **来源**: 江苏省应急管理厅 | **类别**: 检查

### 摘要
江苏省应急管理厅在全省范围内开展危化品和非煤矿山专项整治行动。

### 对工厂EHS的影响
- 危化品使用企业将面临更严格的监管检查
- 需确保危化品台账完善、SDS齐全

### 建议动作
1. 核查危化品存储合规性
2. 更新化学品安全数据表(SDS)
3. 检查危化品应急处置预案',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source, SourceUrl,
            Summary, Impact, [Action], Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-20250325-003', N'日报', GETDATE(), N'苏州市生态环境局：VOCs排放超标企业被处行政处罚', N'处罚',
         N'苏州市生态环境局', N'https://sthjj.suzhou.gov.cn',
         N'苏州某制造企业因VOCs排放超标被处以罚款并责令整改。',
         N'涉及VOCs排放的工厂必须确保废气处理设施正常运行',
         N'检查VOCs处理设施运行状态，确保在线监测数据达标',
         N'## 苏州市生态环境局：VOCs排放超标企业被罚

**日期**: 2025-03-23 | **来源**: 苏州市生态环境局 | **类别**: 处罚

### 摘要
苏州某制造业企业因VOCs排放浓度超过国家标准被处以15万元罚款并责令限期整改。

### 建议动作
1. 检查RTO/RCO等废气处理设施运行记录
2. 核实VOCs在线监测设备校准情况',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source, SourceUrl,
            Summary, Impact, [Action], Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-20250325-004', N'日报', GETDATE(), N'苏州市政府：某企业有限空间作业事故调查报告公布', N'事故',
         N'苏州市政府', N'https://www.suzhou.gov.cn',
         N'某企业有限空间作业中毒窒息事故调查报告，2人死亡1人受伤。',
         N'有限空间作业必须严格执行作业审批、通风检测、应急救援',
         N'全面排查有限空间作业点位，完善作业许可和应急预案',
         N'## 有限空间作业事故调查报告

**日期**: 2025-03-22 | **来源**: 苏州市政府 | **类别**: 事故

### 摘要
苏州某化工企业发生有限空间中毒窒息事故，造成2人死亡、1人受伤。

### 建议动作
1. 开展有限空间专项安全培训
2. 排查所有有限空间作业点位清单
3. 完善有限空间作业许可制度',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source, SourceUrl,
            Summary, Impact, [Action], Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-20250325-005', N'日报', GETDATE(), N'江苏省发布《工业企业粉尘防爆安全规定》新标准', N'法规',
         N'江苏省应急管理厅', N'https://yjglt.jiangsu.gov.cn',
         N'江苏省出台新版工业企业粉尘防爆安全规定，6月1日起施行。',
         N'涉及粉尘作业的车间需按新标准进行改造升级',
         N'组织学习新标准，评估现有粉尘防爆措施是否符合新规',
         N'## 江苏省《工业企业粉尘防爆安全规定》新标准

**日期**: 2025-03-21 | **来源**: 江苏省应急管理厅 | **类别**: 法规

### 摘要
江苏省应急管理厅发布新版粉尘防爆安全规定，2025年6月1日起施行。

### 建议动作
1. 组织EHS团队学习新标准
2. 评估粉尘涉爆车间现状
3. 制定整改计划和时间表',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        -- 周报数据
        INSERT INTO EHS_NewsReport (ReportNo, ReportType, ReportDate, Title, Category, Source,
            Summary, Content, AiModel, GenerateStatus, [Status], CreateDate, Creator, CreateID) VALUES
        (N'RPT-W-20250324-001', N'周报', DATEADD(DAY,-1,GETDATE()), N'EHS外部法规新闻周报（2025-03-17至2025-03-23）', N'综合',
         N'AI综合分析',
         N'本周苏州/江苏EHS领域5条重要动态',
         N'# EHS外部法规新闻周报
## 2025-03-17 至 2025-03-23

### 本周概况
本周共监测到EHS重要动态 **5** 条：
- 🔴 事故通报：1条
- 🟡 行政处罚：1条
- 🔵 政策法规：2条
- 🟢 执法检查：1条

### 重点关注
| 序号 | 标题 | 类别 | 来源 |
|------|------|------|------|
| 1 | 有限空间作业事故调查报告 | 事故 | 苏州市政府 |
| 2 | VOCs排放超标企业被罚 | 处罚 | 苏州市生态环境局 |
| 3 | Q1安全生产形势分析 | 法规 | 苏州市应急管理局 |
| 4 | 粉尘防爆安全新标准 | 法规 | 江苏省应急管理厅 |
| 5 | 危化品专项整治行动 | 检查 | 江苏省应急管理厅 |

### 本周建议优先动作
1. ⚠️ 有限空间作业专项排查
2. 🏭 检查VOCs排放治理设施
3. 📋 开展Q1安全生产自查
4. ⚗️ 核查危化品存储合规性',
         N'Internal_ChatGPT4o', 2, 1, GETDATE(), N'AI_System', 1);

        PRINT N'[OK] 外部法规新闻种子数据插入完成: 日报5条 + 周报1条'
    END
    ELSE
    BEGIN
        PRINT N'[SKIP] EHS_NewsReport 表已有数据，跳过插入'
    END
END
GO

-- 内部事件种子数据
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EHS_GroupIncident')
BEGIN
    PRINT N'[ERROR] EHS_GroupIncident 表不存在！请先执行 04_ehs_news_tables.sql'
END
ELSE
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM EHS_GroupIncident)
    BEGIN
        PRINT N'[INFO] 正在插入内部事件种子数据...'

        INSERT INTO EHS_GroupIncident (IncidentNo, CompanyName, FactoryName, IncidentType, IncidentLevel,
            Title, OccurDate, OccurLocation, [Description], RootCause, CorrectiveAction, PreventiveAction,
            Injuries, Fatalities, EconomicLoss, IsExternal, SourceCompany, ReporterName,
            LessonLearned, [Status], CreateDate, Creator, CreateID) VALUES
        (N'INC-SZ-2025-001', N'耐世特苏州', N'苏州工厂', N'机械伤害', N'一般',
         N'注塑车间操作员手指受伤事件', DATEADD(DAY,-3,GETDATE()), N'注塑车间B区',
         N'操作员在更换模具过程中，未按照LOTO程序关闭设备电源，在清理模具残料时设备突然启动，导致右手食指被夹伤。',
         N'直接原因：操作员未执行LOTO程序；根本原因：LOTO制度执行力度不足',
         N'对注塑车间全员重新进行LOTO培训，在每台注塑机旁张贴LOTO操作步骤标识',
         N'建立换模作业前LOTO检查表制度，班组长必须在场监督换模全过程',
         1, 0, 5000.00, 0, NULL, N'张伟',
         N'LOTO程序是保护员工生命安全的最后一道防线，任何情况下都不能省略。',
         1, GETDATE(), N'admin', 1);

        INSERT INTO EHS_GroupIncident (IncidentNo, CompanyName, FactoryName, IncidentType, IncidentLevel,
            Title, OccurDate, OccurLocation, [Description], RootCause, CorrectiveAction, PreventiveAction,
            Injuries, Fatalities, EconomicLoss, IsExternal, SourceCompany, ReporterName,
            LessonLearned, [Status], CreateDate, Creator, CreateID) VALUES
        (N'INC-LZ-2025-001', N'耐世特柳州', N'柳州工厂', N'化学品泄漏', N'一般',
         N'切削液泄漏导致地面湿滑事件', DATEADD(DAY,-7,GETDATE()), N'机加工车间C线',
         N'CNC加工中心的切削液管路接头松动，导致约50升切削液泄漏到地面。',
         N'直接原因：切削液管路接头老化松动；根本原因：PM计划不完善',
         N'更换损坏的管路接头，清理泄漏区域并放置防滑警示标识',
         N'将液路接头检查纳入PM计划（每月），在所有CNC设备区域增设接油盘',
         0, 0, 2000.00, 0, NULL, N'李明',
         N'设备液路管路的日常检查不能忽视，预防性维护计划需要持续完善。',
         1, GETDATE(), N'admin', 1);

        INSERT INTO EHS_GroupIncident (IncidentNo, CompanyName, FactoryName, IncidentType, IncidentLevel,
            Title, OccurDate, OccurLocation, [Description], RootCause, CorrectiveAction, PreventiveAction,
            Injuries, Fatalities, EconomicLoss, IsExternal, SourceCompany, ReporterName,
            LessonLearned, [Status], CreateDate, Creator, CreateID) VALUES
        (N'INC-WH-2025-001', N'耐世特芜湖', N'芜湖工厂', N'火灾', N'较大',
         N'焊接火花引燃包装材料事件', DATEADD(DAY,-14,GETDATE()), N'焊接车间',
         N'焊接工在进行维修焊接作业时，焊接火花飞溅到5米外的纸箱包装材料堆上，引燃了约20个空纸箱。',
         N'直接原因：动火作业区域内存有可燃物；根本原因：动火作业许可制度执行不严格',
         N'清理焊接区域所有可燃物，设置永久性防火隔离屏',
         N'严格执行动火作业许可制度，动火前必须清理10米范围内可燃物',
         0, 0, 8000.00, 0, NULL, N'王芳',
         N'动火作业是工厂常见高风险作业，必须严格执行动火许可制度。',
         1, GETDATE(), N'admin', 1);

        INSERT INTO EHS_GroupIncident (IncidentNo, CompanyName, FactoryName, IncidentType, IncidentLevel,
            Title, OccurDate, OccurLocation, [Description], RootCause, CorrectiveAction, PreventiveAction,
            Injuries, Fatalities, EconomicLoss, IsExternal, SourceCompany, ReporterName,
            LessonLearned, [Status], CreateDate, Creator, CreateID) VALUES
        (N'INC-EXT-2025-001', N'集团其他公司', N'全球某工厂', N'工伤', N'重大',
         N'【集团通报】某海外工厂叉车撞人致重伤事件', DATEADD(DAY,-10,GETDATE()), N'成品仓库',
         N'某海外工厂成品仓库内，叉车在转弯时与步行的仓库管理员发生碰撞，导致腿部骨折。',
         N'直接原因：叉车转弯时视线盲区；根本原因：仓库交通安全管理体系缺失',
         N'仓库内划设人车分离通道，叉车安装蓝灯和倒车蜂鸣器',
         N'所有工厂开展人车分离专项检查，安装行人检测报警系统',
         1, 0, 50000.00, 1, N'Global Plant', N'集团EHS部',
         N'人车分离是仓库安全管理的基本要求。所有工厂必须对照检查自身仓库的人车分离措施。',
         1, GETDATE(), N'admin', 1);

        INSERT INTO EHS_GroupIncident (IncidentNo, CompanyName, FactoryName, IncidentType, IncidentLevel,
            Title, OccurDate, OccurLocation, [Description], RootCause, CorrectiveAction, PreventiveAction,
            Injuries, Fatalities, EconomicLoss, IsExternal, SourceCompany, ReporterName,
            LessonLearned, [Status], CreateDate, Creator, CreateID) VALUES
        (N'INC-YT-2025-001', N'耐世特烟台', N'烟台工厂', N'环境违规', N'一般',
         N'危废暂存间超期存放整改通知', DATEADD(DAY,-5,GETDATE()), N'危废暂存间',
         N'内部EHS审核发现危废暂存间内有3桶废切削液存放超过90天未转移处置。',
         N'直接原因：危废处置单位排期延迟；根本原因：危废管理台账缺少超期预警机制',
         N'立即联系危废处置单位安排转移，完善危废管理台账',
         N'建立危废存放时间预警机制（60天预警、80天告警），增加备选处置单位',
         0, 0, 0.00, 0, NULL, N'刘强',
         N'危废超期存放是常见环保合规风险。必须建立有效的预警机制。',
         1, GETDATE(), N'admin', 1);

        PRINT N'[OK] 内部事件种子数据插入完成: 5条记录'
    END
    ELSE
    BEGIN
        PRINT N'[SKIP] EHS_GroupIncident 表已有数据，跳过插入'
    END
END
GO

-- =========================================
-- 第二部分：修复 Quartz 端口（在主库执行）
-- =========================================
USE nxt_ehs_main;
GO

UPDATE Sys_QuartzOptions
SET ApiUrl = REPLACE(ApiUrl, 'localhost:9991', 'localhost:9100')
WHERE ApiUrl LIKE '%localhost:9991%';
GO

SELECT TaskName, ApiUrl FROM Sys_QuartzOptions WHERE TaskName LIKE '%EHS%';
GO

PRINT N'=========================================='
PRINT N'全部完成！'
PRINT N'- 外部法规新闻: 日报5条 + 周报1条'
PRINT N'- 内部事件: 5条'
PRINT N'- Quartz端口: 已修复为9100'
PRINT N'=========================================='
GO
