# Lesson Learn 数据库隔离方案说明

## 背景

当前仓库最初运行配置曾指向：

- `nxt_ehs_main`
- `nxt_ehs_biz`

这会导致 Lesson Learn 菜单、权限、业务表与其它项目混在一起。

你已经明确提出：

- 不允许把 Lesson Learn 数据混入其它项目库
- 项目之间必须分开

这个要求是合理的，而且从 VOL Pro 的实现机制看，应该按独立实例思路处理。

## VOL Pro 下的三个可选方案

### 方案 A：共享主库 + 共享业务库

特点：

- 开发最快
- 所有菜单、角色、业务数据混在一起

结论：

- 不符合当前要求

### 方案 B：共享主库 + 独立业务库

特点：

- 业务表可隔离
- 但 `Sys_Menu`、`Sys_RoleAuth`、流程配置、角色配置仍在同一主库

结论：

- 只能做到“业务数据部分隔离”
- 仍然不是真正项目隔离

### 方案 C：独立主库 + 独立业务库

特点：

- `Sys_Menu`、`Sys_RoleAuth`、系统配置、业务表全部隔离
- 是最符合项目独立运行的方式

结论：

- 这是 Lesson Learn 当前应采用的方案

## 本次选定方案

本项目改为使用专属数据库：

- 主库：`vol_pro_ll_main`
- 业务库：`vol_pro_ll_service`

## 已完成的修复

### 1. 运行连接已切换为独立库

文件：

- [appsettings.json](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/api/VolPro.WebApi/appsettings.json)

当前连接已改为：

- `DbConnectionString -> vol_pro_ll_main`
- `ServiceDbContext -> vol_pro_ll_service`

### 2. 初始化脚本已切换为独立库

- [00_create_vol_pro_ll_databases.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/00_create_vol_pro_ll_databases.sql)
- [vol_pro_ll_main.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/vol_pro_ll_main.sql)
- [vol_pro_ll_service.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/vol_pro_ll_service.sql)
- [50_lesson_learn_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/50_lesson_learn_init.sql)
- [51_lesson_learn_migrate_from_v5.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/51_lesson_learn_migrate_from_v5.sql)
- [52_lesson_learn_menu_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/52_lesson_learn_menu_init.sql)

## 你现在应该怎么执行

按这个顺序在 SSMS 中运行：

1. [00_create_vol_pro_ll_databases.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/00_create_vol_pro_ll_databases.sql)
2. [vol_pro_ll_main.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/vol_pro_ll_main.sql)
3. [vol_pro_ll_service.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/vol_pro_ll_service.sql)
4. [50_lesson_learn_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/50_lesson_learn_init.sql)
5. [51_lesson_learn_migrate_from_v5.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/51_lesson_learn_migrate_from_v5.sql)
6. [52_lesson_learn_menu_init.sql](/C:/Users/FZP28D/Desktop/AI%20Created/Kevin_LessonLearn/VOL_Pro_LL/db/sqlserver/52_lesson_learn_menu_init.sql)

然后：

7. 重启 API
8. 重新登录前端

## 重要影响

切到独立主库后，这个运行实例会变成 Lesson Learn 自己的平台实例。

这意味着：

- 之前 `nxt_ehs_main` 里的 EHS 菜单不会自动出现在这个实例里
- 只有 `vol_pro_ll_main` 里初始化和配置过的菜单才会显示

这不是问题，而是“项目隔离”本身的结果。

## 架构建议

后续如果你继续把 Lesson Learn 作为独立产品迭代，建议坚持下面原则：

- 主库独立
- 业务库独立
- 启动端口独立
- 菜单、权限、工作流配置独立

这样未来无论接审批、消息、导出、知识库扩展，都会比共享 EHS 库更稳。
