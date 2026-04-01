@echo off
setlocal EnableExtensions

rem
rem 用法：
rem 1. 把本文件复制到 Windows 桌面
rem 2. 双击运行
rem 3. 如果项目目录以后变化，只改 PROJECT_ROOT 这一行
rem

set "PROJECT_ROOT=C:\Users\FZP28D\Desktop\AI Created\Kevin_LessonLearn\VOL_Pro_LL"
set "PROJECT_SCRIPT=%PROJECT_ROOT%\start_all.bat"
set "PROJECT_ROOT_OVERRIDE=%PROJECT_ROOT%\"

if /I "%~1"=="dataview" (
  set "START_ARG=dataview"
) else (
  set "START_ARG="
)

if not exist "%PROJECT_SCRIPT%" (
  echo [ERROR] Project launcher not found:
  echo         %PROJECT_SCRIPT%
  echo.
  echo [TIP] Please update PROJECT_ROOT in this desktop launcher.
  pause
  exit /b 1
)

echo [INFO] Launching Lesson Learn from:
echo        %PROJECT_ROOT%
echo.

call "%PROJECT_SCRIPT%" %START_ARG%
exit /b %errorlevel%
