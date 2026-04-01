# Lesson Learn 运行步骤

## 1. SQL 执行顺序

在 SSMS 中按下面顺序执行：

1. [50_lesson_learn_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/50_lesson_learn_init.sql)
   作用：创建 Lesson Learn 正式主从表
2. [51_lesson_learn_migrate_from_v5.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/51_lesson_learn_migrate_from_v5.sql)
   作用：把 `LL_System_Final_V5/data.json` 的旧样例导入新库
3. [52_lesson_learn_menu_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/52_lesson_learn_menu_init.sql)
   作用：创建 VOL Pro 菜单入口
4. [58_lesson_learn_v1_schema_upgrade.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/58_lesson_learn_v1_schema_upgrade.sql)
   作用：为 1.0 两菜单版补充 `LessonLevel`、`Workshop`、PFMEA 正式字段
5. [59_lesson_learn_case_menus.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/59_lesson_learn_case_menus.sql)
   作用：把一级业务入口固定为 `Search Case` 与 `Case Detail`
6. [60_lesson_learn_master_data_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/60_lesson_learn_master_data_init.sql)
   作用：创建 Lesson Learn 统一基础数据表
7. [61_lesson_learn_master_data_seed.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/61_lesson_learn_master_data_seed.sql)
   作用：写入工厂、车间、线体、产品线、标签建议、文件类别演示数据
8. [62_lesson_learn_master_data_menu_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/62_lesson_learn_master_data_menu_init.sql)
   作用：创建基础数据维护菜单和管理员权限

## 2. 菜单与权限

脚本 `52_lesson_learn_menu_init.sql` 只负责创建菜单。

如果你使用超级管理员登录：

- 执行完菜单脚本后通常就能看到菜单

如果你使用普通角色：

- 需要给角色分配 `Lesson Learn Center`
- 可通过系统角色权限页面授权
- 也可使用脚本底部的 `Sys_RoleAuth` 模板

## 3. 前端路由

前端路由已经配置：

- 路径：`/LL_LessonLearn`
- 文件：[LL_LessonLearn.vue](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/web.vite/src/views/lesson/LL_LessonLearn.vue)
- 路径：`/LL_CaseDetail`
- 文件：[LL_CaseDetail.vue](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/web.vite/src/views/lesson/LL_CaseDetail.vue)

## 4. 旧数据迁移工具

迁移 SQL 由下面脚本生成：

- [lessonlearn_export_v5_to_sql.py](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/tools/lessonlearn_export_v5_to_sql.py)

如果 `LL_System_Final_V5/data.json` 后续还有变化，可在仓库根目录重新执行：

```powershell
$env:PYTHONUTF8='1'
python .\tools\lessonlearn_export_v5_to_sql.py
```

重新生成后，再执行：

- [51_lesson_learn_migrate_from_v5.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/51_lesson_learn_migrate_from_v5.sql)

## 5. 当前已知限制

- 编号已支持按 `LL-产品线-分类-顺序号` 自动生成，提交审批前会强制校验必填内容
- 当前审批仍是轻量状态流转，还没有切到 VOL 原生工作流
- 导出 PDF/PPT/A3/A4/水印尚未实现
- 本地环境 `dotnet build` 仍存在 restore/build 链异常，当前无法在这个环境里得到可靠编译结果
