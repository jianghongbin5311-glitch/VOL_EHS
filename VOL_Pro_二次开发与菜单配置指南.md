# VOL Pro 二次开发与菜单配置指南

## 1. 文档目的

本文档面向后续接手本项目的开发者或其它大模型，目标是让接手方在尽量短时间内建立对 VOL Pro 的完整心智模型，并能独立完成以下工作：

- 理解 VOL Pro 的前后端架构与数据库分层。
- 理解“页面、路由、菜单、权限、角色”之间的关系。
- 新建一级菜单、二级菜单、外链菜单、内部页面菜单。
- 通过代码生成器快速生成标准 CRUD 页面。
- 基于已有模块开发自定义页面、自定义接口、自定义业务逻辑。
- 将新功能挂到现有菜单树下，或新建新的一级业务入口。
- 正确处理普通角色与超级管理员在菜单权限上的差异。

本文档基于当前仓库和当前数据库结构整理，重点覆盖以下对象：

- 菜单表：`Sys_Menu`
- 角色菜单权限表：`Sys_RoleAuth`
- 用户角色表：`Sys_UserRole`
- 用户表：`Sys_User`

参考代码位置：

- [Sys_Menu.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Entity/DomainModels/System/Sys_Menu.cs)
- [Sys_RoleAuth.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Entity/DomainModels/System/Sys_RoleAuth.cs)
- [Sys_User.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Entity/DomainModels/System/Sys_User.cs)
- [Sys_MenuService.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Sys/Services/System/Partial/Sys_MenuService.cs)
- [UserContext.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Core/UserManager/UserContext.cs)
- [viewGird.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/router/viewGird.js)
- [VolElementMenu.vue](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/components/basic/VolElementMenu.vue)
- [Demo_Order/options.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/views/dbtest/order/Demo_Order/options.js)
- [Demo_OrderController.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.WebApi/Controllers/DbTest/Partial/Demo_OrderController.cs)
- [Demo_OrderService.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.DbTest/Services/Order/Partial/Demo_OrderService.cs)
- [Demo_Order.jsx](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/extension/dbtest/order/Demo_Order.jsx)
- [BuilderController.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.WebApi/Controllers/Builder/BuilderController.cs)
- [http.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/api/http.js)

---

## 2. 项目总体架构

### 2.1 前后端形态

当前项目是典型的 VOL Pro 前后端分离架构：

- 后端：`.NET 8 + EF Core + Dapper + JWT + 缓存 + 业务服务层`
- 前端：`Vue 3 + Vite + Element Plus`
- 菜单、权限、代码生成、流程、通知、MES 等都已经集成在统一平台中

### 2.2 目录结构心智模型

核心目录大致可以按下面理解：

- `api/VolPro.WebApi`
  对外 API、控制器入口。
- `api/VolPro.Entity`
  实体定义、数据库表映射。
- `api/VolPro.Sys`
  系统域业务逻辑，例如菜单、权限、组织等。
- `api/VolPro.DbTest`
  示例业务域，适合作为标准开发样例参考。
- `api/VolPro.MES`
  MES 业务域。
- `web.vite/src/views`
  前端页面目录。
- `web.vite/src/router/viewGird.js`
  页面路由映射表。
- `web.vite/src/extension`
  页面自定义扩展逻辑。
- `db/sqlserver/vol_pro_main.sql`
  主库初始化脚本。

### 2.3 数据库分层

当前仓库默认采用 SQL Server，并至少分成：

- `vol_pro_main`
  系统主库，存菜单、权限、流程、通知、代码生成配置、工作台等。
- `vol_pro_service`
  业务库，存 MES/示例业务表。
- `vol_pro_test`
  测试库，可选。

---

## 3. 菜单、路由、权限的核心关系

### 3.1 菜单树只在一张表里：`Sys_Menu`

菜单树不是“父菜单一张表、子菜单一张表”，而是单表树形结构。

表结构关键字段如下：

- `Menu_Id`
  菜单主键，`int`，当前是手动分配型。
- `ParentId`
  父菜单 ID。
  - `0` 表示一级菜单。
  - 非 `0` 表示子菜单。
- `MenuName`
  菜单名称。
- `TableName`
  页面标识。
  - 生成型标准页面一般填真实表名或视图名。
  - 分类菜单、外链菜单、纯占位菜单通常填 `.`。
- `Url`
  路由地址或外链地址。
- `Icon`
  菜单图标。
- `Enable`
  菜单启用状态。
- `MenuType`
  菜单类型。
  - `0`：PC 菜单
  - `1`：移动端菜单
- `LinkType`
  跳转类型。
  - `0` 或 `NULL`：普通内部页面
  - `1`：外部 URL 链接
  - `3/4`：大屏相关
- `OrderNo`
  排序号，数字越大越靠前。
- `Auth`
  按钮权限定义，JSON 格式。
- `AuthData`
  数据权限扩展字段。

实体定义见：
[Sys_Menu.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Entity/DomainModels/System/Sys_Menu.cs)

### 3.2 当前项目中的真实菜单示例

当前数据库里已经存在一个人工配置的一级菜单：

- `Menu_Id = 291`
- `ParentId = 0`
- `MenuName = 流程测试`

其下已有子菜单：

- `292` 我的审批
- `293` 流程配置
- `294` 发起流程
- `295` Elsa流程设计
- `296` Elsa流程实例

这证明未来新增一级/二级菜单时，完全可以直接由 SQL 或系统界面写入 `Sys_Menu`。

### 3.3 页面路由并不自动等于菜单

内部页面菜单需要同时满足两层：

1. 前端存在页面路由
2. 菜单表 `Sys_Menu.Url` 指向该路由

例如：

- 路由定义在 [viewGird.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/router/viewGird.js)
- 页面文件在 `web.vite/src/views/...`
- 菜单里 `Url=/Demo_Order`

### 3.4 菜单点击后的跳转逻辑

菜单点击行为由前端组件控制：
[VolElementMenu.vue](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/components/basic/VolElementMenu.vue)

关键规则如下：

- 当 `LinkType == 1`
  走外链，执行 `window.open(url, "_blank")`
- 当 `LinkType == 3` 或 `4`
  走大屏逻辑
- 其他情况
  走内部路由 `router.push({ path: _item.path || "" })`

结论：

- 外链菜单不需要额外路由，只要 `Sys_Menu.Url` 是完整 URL，`LinkType=1` 即可。
- 内部菜单必须先有前端路由，再配置菜单。

---

## 4. 权限模型的真实实现

### 4.1 超级管理员与普通角色是两套逻辑

权限获取逻辑在：
[UserContext.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Core/UserManager/UserContext.cs)

关键点：

- 角色 ID 为 `1` 的默认视为超级管理员。
- 超级管理员查看菜单时，不依赖 `Sys_RoleAuth`，直接看到所有启用菜单。
- 普通角色查看菜单时，依赖 `Sys_RoleAuth`。

也就是说：

- `Sys_RoleAuth` 里没有数据，不影响超级管理员看到菜单。
- 但普通角色看不到这些菜单。

当前你的查询里 Elsa 菜单在 `Sys_RoleAuth` 中没有记录，这和系统表现一致：你现在用的是超级管理员，所以仍然能看到。

### 4.2 普通角色菜单权限依赖 `Sys_RoleAuth.AuthValue`

普通角色权限查询核心条件是：

- `Sys_Menu.Menu_Id = Sys_RoleAuth.Menu_Id`
- `Sys_RoleAuth.Role_Id = 当前角色`
- `Sys_RoleAuth.AuthValue != ""`

这意味着：

- 仅有菜单记录，不够。
- 仅有 `Role_Id`/`Menu_Id` 记录也不够。
- 必须给 `AuthValue` 一个非空值，例如 `Search`。

### 4.3 用户角色并不只看 `Sys_UserRole`

这里有一个很重要的实现细节：

当前登录用户的角色信息，`UserContext` 优先从 `Sys_User.RoleIds` 字符串读出。

参考：
[Sys_User.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Entity/DomainModels/System/Sys_User.cs)
[UserContext.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Core/UserManager/UserContext.cs)

这意味着：

- `Sys_UserRole` 是重要的关系表，但并不是唯一来源。
- 如果后续手工调整角色，最好保持：
  - `Sys_User.RoleIds`
  - `Sys_UserRole`
  两者一致。

否则可能出现：

- 数据关系看起来已赋权
- 但当前登录上下文没有按预期获取角色

---

## 5. 当前菜单字段的经验结论

结合当前数据库和代码，可以得出以下稳定结论。

### 5.1 一级菜单

一级菜单通常：

- `ParentId = 0`
- `TableName = '.'`
- `Url` 可以为空或不作为页面跳转使用
- 主要作用是做左侧导航分组或业务域入口

示例：

- `291 流程测试`

### 5.2 二级内部页面菜单

内部页面菜单通常：

- `ParentId = 某一级菜单ID`
- `Url = /某个路由`
- `LinkType = 0`
- `MenuType = 0`
- `Enable = 1`
- `TableName = 真实表名` 或 `.`

示例：

- `292 我的审批`，`Url=/Sys_WorkFlowTable`
- `293 流程配置`，`Url=Sys_WorkFlow`
- `294 发起流程`，`Url=/flowList`

### 5.3 二级外链菜单

外链菜单通常：

- `ParentId = 某一级菜单ID`
- `Url = 完整HTTP地址`
- `LinkType = 1`
- `MenuType = 0`
- `Enable = 1`
- `TableName = '.'`

示例：

- `295 Elsa流程设计`
- `296 Elsa流程实例`

---

## 6. 新功能开发的四种主路径

后续新增功能，不要一律按“从零硬写”处理。要先判断属于哪一类。

### 路径 A：代码生成器生成标准 CRUD

适用场景：

- 标准主表或主从表
- 典型增删改查
- 有明确数据库表
- 优先追求交付速度

核心入口：
[BuilderController.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.WebApi/Controllers/Builder/BuilderController.cs)

标准产物通常包括：

- 后端实体
- Repository
- Service
- Controller
- 前端页面
- `options.js`

优点：

- 最快
- 结构统一
- 符合 VOL 原生风格

风险：

- 生成后的页面如果需要大量自定义交互，后期还是要扩展

### 路径 B：在生成页面基础上做业务增强

适用场景：

- 页面主体还是 CRUD
- 但需要自定义查询、汇总、明细、审批、联动逻辑

典型参考：

- [Demo_Order/options.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/views/dbtest/order/Demo_Order/options.js)
- [Demo_OrderController.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.WebApi/Controllers/DbTest/Partial/Demo_OrderController.cs)
- [Demo_OrderService.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.DbTest/Services/Order/Partial/Demo_OrderService.cs)
- [Demo_Order.jsx](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/extension/dbtest/order/Demo_Order.jsx)

这是最推荐的业务开发方式。

### 路径 C：开发纯自定义内部页面

适用场景：

- 页面不是标准 CRUD
- 需要完全自定义交互
- 需要自己写 Vue 页面和接口

典型方式：

1. 在 `web.vite/src/views/...` 新建页面
2. 在 [viewGird.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/router/viewGird.js) 注册路由
3. 后端按需要新增 Controller / Service
4. 在 `Sys_Menu` 中添加菜单，`Url` 指向新路由

### 路径 D：接入外部系统并作为菜单挂载

适用场景：

- 外部流程平台
- 外部 BI / DataView
- 外部门户
- 外部报表系统

做法：

- `LinkType = 1`
- `Url = 完整外链地址`
- `TableName = '.'`

Elsa 当前就是这个模式。

---

## 7. 标准 CRUD 页面是怎么组织的

### 7.1 前端页面元数据：`options.js`

标准页面的核心配置通常都集中在 `options.js`。

例如：
[Demo_Order/options.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/views/dbtest/order/Demo_Order/options.js)

里面通常定义：

- 主键
- 表名
- 中文名
- URL
- 编辑表单字段
- 查询表单字段
- 列表列定义
- 明细表定义

可以理解为：

- `options.js` 决定了这个页面怎么渲染
- 后台接口决定数据怎么查、怎么存

### 7.2 页面增强扩展：`src/extension`

如果只是想在生成页面上做一些增强，不要急着重写整个页面。

优先看：
[Demo_Order.jsx](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/extension/dbtest/order/Demo_Order.jsx)

它可扩展：

- 查询区组件
- 列表区组件
- 弹窗区组件
- 自定义按钮
- 初始化逻辑
- 保存前确认逻辑

这条路线对“低成本增强”特别有效。

### 7.3 后端控制器与服务扩展

业务接口扩展通常在 `Partial` 控制器和服务里做。

示例：

- [Demo_OrderController.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.WebApi/Controllers/DbTest/Partial/Demo_OrderController.cs)
- [Demo_OrderService.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.DbTest/Services/Order/Partial/Demo_OrderService.cs)

常见扩展点：

- 自定义分页过滤
- 汇总数据
- 明细查询
- 提交流程
- 自定义统计

---

## 8. 如何建立一个新页面

建议按下面决策顺序。

### 8.1 先判断页面类型

先问自己：

1. 这是标准 CRUD 吗？
2. 这是主从表吗？
3. 这是统计页吗？
4. 这是外部系统入口吗？
5. 这是纯自定义业务页吗？

不同答案决定不同开发路径。

### 8.2 标准 CRUD 页面建立流程

推荐步骤：

1. 建数据库表
2. 用代码生成器读取表结构
3. 生成前后端骨架
4. 调整 `options.js`
5. 调整 Service / Controller
6. 在 `Sys_Menu` 加菜单
7. 给普通角色分配 `Sys_RoleAuth`

### 8.3 自定义内部页面建立流程

推荐步骤：

1. 在 `web.vite/src/views/<业务域>/...` 新建 Vue 页面
2. 在 [viewGird.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/router/viewGird.js) 增加路由
3. 如果需要接口，在 `api/VolPro.WebApi/Controllers/.../Partial` 新建控制器动作
4. 在对应 Service 中增加业务逻辑
5. 菜单中写：
   - `Url = /你的路由`
   - `LinkType = 0`
6. 给普通角色写 `Sys_RoleAuth`

### 8.4 外部页面建立流程

推荐步骤：

1. 先确认外部系统可访问地址
2. 再在 `Sys_Menu` 新建外链菜单
3. 关键字段：
   - `LinkType = 1`
   - `Url = http://...`
   - `TableName = '.'`
   - `MenuType = 0`
4. 如果不是超级管理员使用，还要补 `Sys_RoleAuth`

Elsa 就是这条路径。

---

## 9. 如何把页面挂到别的菜单下面

### 9.1 挂到现有一级菜单下面

本质就是：

- 找到目标一级菜单的 `Menu_Id`
- 新增一条记录，`ParentId = 目标Menu_Id`

例如当前：

- `流程测试` 的 `Menu_Id = 291`

那么挂到它下面的所有二级菜单都写：

- `ParentId = 291`

### 9.2 新建一级菜单

一级菜单的基本模式：

- `ParentId = 0`
- `TableName = '.'`
- `MenuType = 0`
- `Enable = 1`
- `OrderNo = 合适排序`

### 9.3 当前项目中的排序规则

菜单按 `OrderNo` 倒序排。

所以：

- 数字越大，越靠前

当前 `流程测试` 下：

- 900 我的审批
- 800 流程配置
- 700 发起流程
- 600 Elsa流程设计
- 500 Elsa流程实例

这符合菜单显示顺序。

---

## 10. `Sys_Menu` 字段的实际开发准则

下面给出最实用的配置规则。

### 10.1 `TableName`

规则：

- 标准 CRUD 页：填真实表名或视图名
- 外链菜单：填 `.`
- 一级分类菜单：填 `.`

为什么：

在 [Sys_MenuService.cs](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/api/VolPro.Sys/Services/System/Partial/Sys_MenuService.cs) 里，系统会检查 `TableName` 的唯一性；但 `.` 和 `/` 是特殊值，通常用于非业务表菜单。

### 10.2 `Url`

规则：

- 内部页：写前端路由，如 `/Demo_Order`
- 外链页：写完整 URL，如 `http://10.243.154.36:13000/workflows/definitions`

### 10.3 `LinkType`

规则：

- 内部页：`0` 或空
- 外部页：`1`
- 大屏设计器：按现有系统逻辑使用 `3/4`

### 10.4 `Enable`

经验规则：

- `1`：正常显示
- `2`：菜单不显示但可参与权限分配

### 10.5 `Auth`

这是按钮权限定义，存 JSON。

示例：

```json
[{"text":"查询","value":"Search"}]
```

标准 CRUD 常见值会更多，例如：

- `Search`
- `Add`
- `Update`
- `Delete`
- `Import`
- `Export`
- `Audit`
- `AntiAudit`
- `Print`

注意：

- `Auth` 决定菜单有哪些“可授予按钮”
- 角色真正拥有哪个按钮，还要看 `Sys_RoleAuth.AuthValue`

---

## 11. 当前权限配置的关键注意事项

### 11.1 当前 Elsa 菜单只有超级管理员可见的概率很高

你查询 `Sys_RoleAuth` 时结果为空，这意味着：

- Elsa 菜单当前没有角色权限记录
- 超级管理员能看到是因为其绕过了 `Sys_RoleAuth`
- 普通角色大概率看不到

### 11.2 给普通角色授权的最低要求

给普通角色看菜单，至少要有一条 `Sys_RoleAuth`：

- `Role_Id = 目标角色`
- `Menu_Id = 菜单ID`
- `AuthValue = 'Search'`

如果没有这条记录，普通角色可能无法看到这个菜单。

### 11.3 用户角色同步问题

如果后续手工做 SQL 调整，需确保：

- `Sys_User.RoleIds`
- `Sys_UserRole`

不要长期不一致。

---

## 12. 建新功能的推荐标准流程

这是推荐给其它大模型的默认开发流程。

### 12.1 如果是业务表页面

1. 先确认数据库表结构
2. 判断能否直接走代码生成器
3. 生成基础页面
4. 看是否需要扩展：
   - 页面扩展
   - 接口扩展
   - 流程扩展
5. 最后配置菜单与权限

### 12.2 如果是外部系统接入

1. 先把外部系统本身跑通
2. 确认最终 URL
3. 再加 `Sys_Menu`
4. 如需普通角色可见，再写 `Sys_RoleAuth`

不要反过来，先写菜单再猜 URL。

### 12.3 如果是纯自定义新功能

1. 新建前端页面
2. 注册路由
3. 写后端接口
4. 写业务服务
5. 加菜单
6. 加权限

---

## 13. 菜单 SQL 的推荐写法

后续可以按“先查、再插、再授权”的顺序做。

### 13.1 先查当前最大菜单 ID

```sql
USE [vol_pro_main];
GO

SELECT MAX(Menu_Id) AS MaxMenuId
FROM Sys_Menu;
```

### 13.2 新增一级菜单模板

```sql
USE [vol_pro_main];
GO

DECLARE @MenuId INT = (SELECT ISNULL(MAX(Menu_Id), 0) + 1 FROM Sys_Menu);

INSERT INTO Sys_Menu
(
    Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName,
    ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType, AuthData
)
VALUES
(
    @MenuId,
    N'新一级菜单',
    N'[{"text":"查询","value":"Search"}]',
    N'bi-list',
    N'新一级菜单',
    1,
    1000,
    N'.',
    0,
    NULL,
    GETDATE(),
    N'sql',
    GETDATE(),
    N'sql',
    0,
    0,
    NULL
);
```

### 13.3 在某一级菜单下新增二级内部页面模板

```sql
USE [vol_pro_main];
GO

DECLARE @ParentId INT = 291;
DECLARE @MenuId INT = (SELECT ISNULL(MAX(Menu_Id), 0) + 1 FROM Sys_Menu);

INSERT INTO Sys_Menu
(
    Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName,
    ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType, AuthData
)
VALUES
(
    @MenuId,
    N'新二级页面',
    N'[{"text":"查询","value":"Search"},{"text":"新增","value":"Add"},{"text":"编辑","value":"Update"},{"text":"删除","value":"Delete"}]',
    N'el-icon-document',
    N'新二级页面',
    1,
    600,
    N'你的表名',
    @ParentId,
    N'/你的路由',
    GETDATE(),
    N'sql',
    GETDATE(),
    N'sql',
    0,
    0,
    NULL
);
```

### 13.4 新增外链菜单模板

```sql
USE [vol_pro_main];
GO

DECLARE @ParentId INT = 291;
DECLARE @MenuId INT = (SELECT ISNULL(MAX(Menu_Id), 0) + 1 FROM Sys_Menu);

INSERT INTO Sys_Menu
(
    Menu_Id, MenuName, Auth, Icon, Description, Enable, OrderNo, TableName,
    ParentId, Url, CreateDate, Creator, ModifyDate, Modifier, MenuType, LinkType, AuthData
)
VALUES
(
    @MenuId,
    N'外链菜单',
    N'[{"text":"查询","value":"Search"}]',
    N'el-icon-link',
    N'外链菜单',
    1,
    500,
    N'.',
    @ParentId,
    N'http://你的地址',
    GETDATE(),
    N'sql',
    GETDATE(),
    N'sql',
    0,
    1,
    NULL
);
```

### 13.5 给普通角色授权模板

前提：确认目标角色不是超级管理员，而是普通角色。

```sql
USE [vol_pro_main];
GO

DECLARE @AuthId INT = (SELECT ISNULL(MAX(Auth_Id), 0) + 1 FROM Sys_RoleAuth);
DECLARE @RoleId INT = 2;
DECLARE @MenuId INT = 295;

INSERT INTO Sys_RoleAuth
(
    Auth_Id, AuthValue, CreateDate, Creator, Menu_Id, ModifyDate, Modifier, Role_Id, User_Id, AuthMenuData
)
VALUES
(
    @AuthId,
    N'Search',
    GETDATE(),
    N'sql',
    @MenuId,
    GETDATE(),
    N'sql',
    @RoleId,
    NULL,
    NULL
);
```

如果要授权多个按钮，例如：

```sql
N'Search,Add,Update,Delete'
```

---

## 14. 其它大模型接手时的标准提问顺序

这是给后续模型最实用的一段。

接手新需求时，不要先写代码，先问自己：

1. 这是标准 CRUD、增强 CRUD、纯自定义页，还是外部系统？
2. 目标菜单是挂到已有一级菜单下，还是新建一级菜单？
3. 页面是内部路由还是外部 URL？
4. 普通角色是否也要可见？
5. 是否需要同步按钮权限？
6. 是否需要同步 `Sys_User.RoleIds` / `Sys_UserRole` / `Sys_RoleAuth`？

如果这些问题不先想清楚，就容易出现：

- 菜单有了但点不开
- 超级管理员能看，普通角色看不到
- 有页面没有菜单
- 有菜单没有路由
- 外链地址使用了 `localhost`，导致别人电脑打不开

---

## 15. 当前项目最重要的结论

这部分是给后续模型的“速记版”。

1. 菜单树主表只有一张：`Sys_Menu`
2. 父子关系靠 `ParentId`
3. 一级菜单：`ParentId = 0`
4. 外链菜单：`LinkType = 1`
5. 内部页面菜单：`Url` 必须能在 [viewGird.js](/C:/Users/FZP28D/Desktop/AI%20Created/VOL_Pro_Codex/web.vite/src/router/viewGird.js) 找到对应路由
6. 超级管理员不依赖 `Sys_RoleAuth`
7. 普通角色依赖 `Sys_RoleAuth.AuthValue != ''`
8. 当前登录角色来源不只看 `Sys_UserRole`，还看 `Sys_User.RoleIds`
9. `TableName='.'` 是分类菜单/外链菜单/非标准业务页的安全写法
10. 标准开发优先走“代码生成器 + 扩展”，不要默认从零手写

---

## 16. 推荐的后续动作

基于当前系统，下一步最推荐做两件事：

1. 整理一份“菜单新增 SQL 模板库”
   目标是形成可复用脚本，后续由大模型直接套模板生成。
2. 整理一份“标准业务模块开发模板”
   目标是固定：
   - 前端目录结构
   - 后端控制器位置
   - 服务扩展方式
   - 菜单配置方式
   - 权限授权方式

如果继续扩展 Elsa、流程中心、MES 自定义能力，这两份模板会极大降低后续模型的误判概率。

