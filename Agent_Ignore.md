# ==========================================
# ignore文件
# 适用于 VOL 框架 (.NET Core + Vue) 的 AI 屏蔽配置
# ==========================================

# 1. 核心依赖与包管理 (绝对禁止扫描，否则必死机)
**/node_modules/**
**/jspm_packages/**
**/packages/**

# 2. 前端构建产物 (无业务逻辑，干扰 AI)
**/dist/**
**/build/**
**/wwwroot/dist/**
**/wwwroot/css/**
**/wwwroot/js/**
# VOL 框架特有的压缩后资源
**/chunk-*.js
**/app.*.js

# 3. .NET 后端编译与中间文件 (二进制文件，AI 读不懂)
**/bin/**
**/obj/**
**/.vs/**
**/artifacts/**

# 4. 运行时产生的文件 (日志、上传文件、缓存)
**/*.log
**/logs/**
**/Log/**
**/wwwroot/Upload/**
**/wwwroot/excel/**
**/.cache/**
**/.history/**

# 5. IDE 与 版本控制元数据
**/.git/**
**/.svn/**
**/.idea/**
**/.vscode/**
**/.windsurf/**

# 6. 敏感配置 (建议屏蔽，防止 AI 泄露密码或误改生产库连接)
# 如果你需要 AI 帮你改配置，可以临时把这一行注释掉
**/appsettings.Production.json**
**/appsettings.json**

# 7. 二进制大文件
**/*.dll
**/*.pdb
**/*.exe
**/*.suo
**/*.user
**/*.zip
**/*.rar
**/*.pdf
**/*.xls
**/*.xlsx
**/*.doc
**/*.docx