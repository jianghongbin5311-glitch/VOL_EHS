# Lesson Learn 在 VOL Pro 的正式落地方案

## 1. 总体判断

Lesson Learn 已经不是单纯的案例录入页，而是下面四类能力的组合：

- 知识沉淀：双语经验教训、结构化内容、标签、产品线复用
- 流程闭环：提交审批、驳回、发布锁定、解锁重编
- 文件协同：标准文件变更、附件中心、下载统计、图片说明
- 审计追溯：多轮评审、任务、参与人员、版本快照、操作记录

因此不建议继续沿用旧系统 `LL_System_Final_V5` 的 `data.json` 结构，也不建议把复杂集合全部塞进 VOL Pro 单表 JSON 字段。

## 2. 数据库建议

### 2.1 运行库

- `vol_pro_main`
  - 存菜单、权限、工作流配置
- `vol_pro_service`
  - 存 Lesson Learn 业务表

### 2.2 迁移源

- 旧系统 `LL_System_Final_V5/data.json`
  - 仅作为一次性迁移输入源
  - 不再作为运行态数据源

## 3. 正式数据模型

### 3.1 主表

`LL_LessonLearn`

职责：

- 存放可检索、可审批、可统计的核心字段
- 存放状态、进度、锁定、浏览/收藏/点赞、版本号
- 存放汇总页需要直接筛选的文本汇总字段

关键字段：

- `LessonNo`
- `TitleEn` / `TitleCn`
- `Category`
- `ProductPlatform`
- `LlGroup`
- `IssueSource`
- `IssueNo`
- `IssueType`
- `CPI`
- `Customer`
- `Program`
- `PartNo`
- `Plant`
- `ProductionLine`
- `CellName`
- `ApprovalOwner`
- `LlCategoryCode`
- `LlGroupNote`
- `VersionRemark`
- `ApplicableProductLinesText`
- `TagsText`
- `DocumentTypesText`
- `Status`
- `Progress`
- `AnalysisCycleDays`
- `ViewCount`
- `FavoriteCount`
- `LikeCount`
- `VersionNo`
- `IsLocked`

### 3.2 子表

`LL_LessonLearnProductLine`

- 适用产品线，多选

`LL_LessonLearnTag`

- 标签，多值检索

`LL_LessonLearnDocumentType`

- 标准文件类型

`LL_LessonLearnContent`

- 四大内容模块及补充说明
- `ModuleType`：`IssueDescription / RootCause / CorrectiveActions / GlobalLessons / SupplementalNotes`

`LL_LessonLearnDocumentChange`

- 文件变更主记录
- 存放变更类型、更改前文件名、更改后文件名

`LL_LessonLearnFile`

- 通用文件中心
- 同时承载：
  - 通用附件
  - 内容图片
  - 文件变更前附件
  - 文件变更后附件

`LL_LessonLearnReview`

- 多轮评审

`LL_LessonLearnParticipant`

- 参与人员

`LL_LessonLearnTask`

- 文件更新任务 / 闭环任务

`LL_LessonLearnVersion`

- 版本审计记录
- 包含动作、操作人、状态、快照 JSON

## 4. 为什么采用“主表 + 子表 + 版本快照”

这个方案比“单表 JSON”更适合 VOL Pro 后续扩展：

- 汇总页可以直接按标签、产品线、状态、编号检索
- 文件、任务、评审、参与人可以单独统计
- 版本记录可以作为审计依据
- 后续接 VOL 工作流时，主表不会被 JSON 结构拖累
- 后面做导出、版本比对、审批工作台时，数据关系更清晰

## 5. 当前代码落点

后端：

- `api/VolPro.Entity/DomainModels/lesson/LL_LessonLearn.cs`
- `api/VolPro.Entity/DomainModels/lesson/LL_LessonLearnChildren.cs`
- `api/VolPro.Entity/DomainModels/lesson/LL_LessonLearnDtos.cs`
- `api/VolPro.MES/Services/lesson/Partial/LL_LessonLearnService.cs`
- `api/VolPro.WebApi/Controllers/Lesson/Partial/LL_LessonLearnController.cs`

前端：

- `web.vite/src/views/lesson/LL_LessonLearn.vue`
- `web.vite/src/router/viewGird.js`

脚本：

- `db/sqlserver/50_lesson_learn_init.sql`

## 6. 已经落地的能力

- Lesson Learn 自定义列表页与详情页
- 按编号/标题/标签/产品线查询
- 标题双语、四段内容双语、图片说明
- 浏览/收藏/点赞统计
- 自动保存
- 提交审批 / 驳回 / 发布 / 解锁
- 附件与文件下载次数
- 多轮评审、参与人员、任务分配
- PPTX 首张幻灯片文本导入
- 版本历史记录

## 7. 二期建议

优先级从高到低建议如下：

1. 接入 VOL 原生工作流，替代当前轻量状态流转
2. 增加编号自动生成与校验服务
3. 做汇总页高级筛选与统计看板
4. 增加导出 PDF/PPT/A3/A4/水印
5. 做版本差异比对页
6. 增加标签指导词典和知识推荐

## 8. 迁移策略

### 8.1 从旧 Flask 原型迁移

建议由后端做一次性迁移：

- 主信息映射到 `LL_LessonLearn`
- 标签映射到 `LL_LessonLearnTag`
- 内容块映射到 `LL_LessonLearnContent`
- 图片与附件映射到 `LL_LessonLearnFile`
- 评审映射到 `LL_LessonLearnReview`
- 任务映射到 `LL_LessonLearnTask`

### 8.2 从首期 VOL 单表 JSON 版迁移

如果数据库里已经有 `LL_LessonLearn` 首期记录：

- 本次 SQL 会保留旧 JSON 列
- 新代码只读写正式主从表
- 如需迁旧数据，可补一支迁移脚本把旧 JSON 拆到子表

## 9. 菜单建议

建议菜单结构：

- 一级：`Lesson Learn`
- 二级：`Lesson Learn Center`
- 路由：`/LL_LessonLearn`
- 业务表：`LL_LessonLearn`

建议权限：

- `Search`
- `Add`
- `Update`
- `Upload`

审批角色建议先按需求写死为 `PL APQP`，后续再切到正式流程角色配置。
