@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT="
set "WORK_ROOT="
set "SUBST_DRIVE="
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT_OVERRIDE="
set "FALLBACK_ROOT=C:\Users\FZP28D\Desktop\AI Created\Kevin_LessonLearn\VOL_Pro_LL\"
set "API_DIR="
set "WEB_DIR="
set "DV_DIR="
set "WEB_ESBUILD="
set "DV_ESBUILD="
set "START_DATAVIEW=0"
set "API_PORT=9100"
set "WEB_PORT="
set "DV_PORT=9200"
set "WAIT_SECONDS=180"
set "API_READY=0"
set "WEB_READY=0"
set "DV_READY=0"

if defined PROJECT_ROOT_OVERRIDE call :TryRoot "%PROJECT_ROOT_OVERRIDE%"
if not defined ROOT call :TryRoot "%SCRIPT_DIR%"
if not defined ROOT call :TryRoot "%CD%\"
if not defined ROOT call :TryRoot "%FALLBACK_ROOT%"

if not defined ROOT (
  for %%D in (
    "%USERPROFILE%\Desktop\AI Created\Kevin_LessonLearn\VOL_Pro_LL\"
    "%USERPROFILE%\Desktop\Kevin_LessonLearn\VOL_Pro_LL\"
    "%USERPROFILE%\Documents\Kevin_LessonLearn\VOL_Pro_LL\"
  ) do (
    if not defined ROOT call :TryRoot "%%~fD"
  )
)

if not defined ROOT (
  for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $roots=@('%USERPROFILE%\Desktop','%USERPROFILE%\Documents'); $found = Get-ChildItem -Path $roots -Filter VolPro.WebApi.csproj -File -Recurse | Where-Object { $_.FullName -like '*\VOL_Pro_LL\api\VolPro.WebApi\VolPro.WebApi.csproj' } | Select-Object -First 1; if($found){ Split-Path (Split-Path $found.FullName -Parent) -Parent }"`) do (
    if not defined ROOT call :TryRoot "%%D\"
  )
)

if defined ROOT (
  set "WORK_ROOT=%ROOT%"
  call :SetupWorkRoot
  set "API_DIR=!WORK_ROOT!api\VolPro.WebApi"
  set "WEB_DIR=!WORK_ROOT!web.vite"
  set "DV_DIR=!WORK_ROOT!dataview"
)

if /I "%~1"=="dataview" set "START_DATAVIEW=1"
if /I "%START_DATAVIEW%"=="1" (
  echo [INFO] DataView startup is enabled.
) else (
  echo [INFO] DataView startup is disabled by default.
  echo [INFO] Reason: current machine blocks Node child-process spawn for esbuild in DataView.
)

where dotnet >nul 2>&1
if errorlevel 1 (
  echo [ERROR] dotnet command not found.
  pause
  exit /b 1
)

where npm >nul 2>&1
if errorlevel 1 (
  echo [ERROR] npm command not found.
  pause
  exit /b 1
)

if not exist "%API_DIR%\VolPro.WebApi.csproj" (
  echo [ERROR] API project not found: %API_DIR%
  echo [TIP] Script directory: %SCRIPT_DIR%
  echo [TIP] Current directory: %CD%
  echo [TIP] Preferred file location:
  echo       %FALLBACK_ROOT%start_all.bat
  pause
  exit /b 1
)

if not exist "%WEB_DIR%\package.json" (
  echo [ERROR] Web project not found: %WEB_DIR%
  pause
  exit /b 1
)

if not exist "%WEB_DIR%\node_modules" (
  echo [INFO] WEB node_modules not found, running npm install...
  echo [INFO] This may take a few minutes on first run...
  pushd "%WEB_DIR%"
  call npm install
  if errorlevel 1 (
    echo [ERROR] npm install failed for WEB. Please check your network and try again.
    popd
    pause
    exit /b 1
  )
  popd
  echo [OK] WEB npm install completed.
)

if "%START_DATAVIEW%"=="1" if exist "%DV_DIR%\package.json" (
  if not exist "%DV_DIR%\node_modules" (
    echo [INFO] DataView node_modules not found, running npm install...
    echo [INFO] This may take a few minutes on first run...
    pushd "%DV_DIR%"
    set "HUSKY=0"
    call npm install --ignore-scripts
    if errorlevel 1 (
      echo [WARN] npm install failed for DataView. Dashboard may not work.
      popd
    ) else (
      popd
      echo [OK] DataView npm install completed.
    )
  )
)

if exist "%WEB_DIR%\node_modules\@esbuild\win32-x64\esbuild.exe" (
  set "WEB_ESBUILD=%WEB_DIR%\node_modules\@esbuild\win32-x64\esbuild.exe"
)

if "%START_DATAVIEW%"=="1" if defined DV_DIR if exist "%DV_DIR%\node_modules\@esbuild\win32-x64\esbuild.exe" (
  set "DV_ESBUILD=%DV_DIR%\node_modules\@esbuild\win32-x64\esbuild.exe"
)

for /L %%P in (9000,1,9010) do (
  powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %%P -ErrorAction SilentlyContinue; if ($listener) { exit 1 } else { exit 0 }" >nul 2>&1
  if not errorlevel 1 (
    set "WEB_PORT=%%P"
    goto :WEB_PORT_FOUND
  )
)

echo [ERROR] No available web port found between 9000 and 9010.
pause
exit /b 1

:WEB_PORT_FOUND
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %API_PORT% -ErrorAction SilentlyContinue | Select-Object -First 1; if($listener){ $proc = Get-Process -Id $listener.OwningProcess -ErrorAction SilentlyContinue; if($proc){ Write-Output ($proc.ProcessName + ' (PID ' + $proc.Id + ')') } else { Write-Output ('PID ' + $listener.OwningProcess) } }"`) do (
  set "API_PORT_OWNER=%%I"
)

if defined API_PORT_OWNER (
  echo [ERROR] API port %API_PORT% is already in use by %API_PORT_OWNER%.
  echo [TIP] This script uses a fixed API port, and reusing an old process can make the web app connect to the wrong project or stale menu cache.
  echo [TIP] Close the existing API process listening on %API_PORT%, then rerun start_all.bat.
  pause
  exit /b 1
)

if "%START_DATAVIEW%"=="1" if exist "%DV_DIR%\package.json" (
  powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %DV_PORT% -ErrorAction SilentlyContinue; if ($listener) { exit 1 } else { exit 0 }" >nul 2>&1
  if errorlevel 1 (
    echo [WARN] DataView port %DV_PORT% is already in use. DataView will not be started.
    set "DV_DIR="
  )
)

echo [INFO] Starting VOL API window...
start "VOL API" cmd /k "cd /d ""%API_DIR%"" && set ASPNETCORE_URLS=http://localhost:%API_PORT% && dotnet run --no-launch-profile"

echo [INFO] Starting VOL WEB window...
start "VOL WEB" cmd /k "cd /d ""%WEB_DIR%"" && npm run dev -- --port !WEB_PORT! --strictPort"

if "%START_DATAVIEW%"=="1" if defined DV_DIR if exist "%DV_DIR%\package.json" (
  echo [INFO] Starting DataView window...
  if defined DV_ESBUILD (
    start "VOL DataView" cmd /k "cd /d ""%DV_DIR%"" && set ""ESBUILD_BINARY_PATH=%DV_ESBUILD%"" && npm run dev -- --port %DV_PORT% --strictPort"
  ) else (
    start "VOL DataView" cmd /k "cd /d ""%DV_DIR%"" && npm run dev -- --port %DV_PORT% --strictPort"
  )
)

echo [INFO] Waiting for API on http://localhost:%API_PORT% ...
call :WaitForPort %API_PORT% %WAIT_SECONDS%
if errorlevel 1 (
  echo [WARN] API did not become ready within %WAIT_SECONDS% seconds.
) else (
  echo [OK] API is ready.
  set "API_READY=1"
)

echo [INFO] Waiting for WEB on http://localhost:!WEB_PORT! ...
call :WaitForPort !WEB_PORT! %WAIT_SECONDS%
if errorlevel 1 (
  echo [WARN] WEB did not become ready within %WAIT_SECONDS% seconds.
) else (
  echo [OK] WEB is ready.
  set "WEB_READY=1"
)

if "%START_DATAVIEW%"=="1" if defined DV_DIR if exist "%DV_DIR%\package.json" (
  echo [INFO] Waiting for DataView on http://localhost:%DV_PORT% ...
  call :WaitForPort %DV_PORT% %WAIT_SECONDS%
  if errorlevel 1 (
    echo [WARN] DataView did not become ready within %WAIT_SECONDS% seconds.
  ) else (
    echo [OK] DataView is ready.
    set "DV_READY=1"
  )
)

if "!API_READY!"=="1" (
  echo [INFO] Opening API Swagger...
  start "" "http://localhost:%API_PORT%/index.html"
) else (
  echo [WARN] API browser was not opened because the API port is not ready.
)

if "!WEB_READY!"=="1" (
  echo [INFO] Opening Lesson Learn dashboard...
  start "" "http://localhost:!WEB_PORT!/#/LL_Dashboard"
) else (
  echo [WARN] WEB browser was not opened because the WEB port is not ready.
)

echo.
echo ============================================
echo [OK] All startup commands have been launched.
echo ============================================
echo API Swagger:  http://localhost:%API_PORT%/index.html
echo Web Dev URL:  http://localhost:!WEB_PORT!
echo Lesson Learn Dashboard: http://localhost:!WEB_PORT!/#/LL_Dashboard
echo Lesson Learn Center:    http://localhost:!WEB_PORT!/#/LL_LessonLearn
if "%START_DATAVIEW%"=="1" if defined DV_DIR (
  echo DataView URL: http://localhost:%DV_PORT%
) else (
  echo DataView URL: not started
)
echo.
if "!API_READY!"=="0" echo [TIP] Check the "VOL API" window for startup errors.
if "!WEB_READY!"=="0" echo [TIP] Check the "VOL WEB" window for startup errors.
if "%START_DATAVIEW%"=="1" if defined DV_DIR if "!DV_READY!"=="0" echo [TIP] Check the "VOL DataView" window for startup errors.
echo.
pause
endlocal
exit /b 0

:TryRoot
set "TRY_ROOT=%~1"
if "%TRY_ROOT%"=="" exit /b 1
if not "%TRY_ROOT:~-1%"=="\" set "TRY_ROOT=%TRY_ROOT%\"
if exist "%TRY_ROOT%api\VolPro.WebApi\VolPro.WebApi.csproj" (
  if exist "%TRY_ROOT%web.vite\package.json" (
    set "ROOT=%TRY_ROOT%"
    exit /b 0
  )
)
exit /b 1

:SetupWorkRoot
set "WORK_ROOT=%ROOT%"
echo %ROOT% | findstr /C:" " >nul
if errorlevel 1 exit /b 0

for %%L in (V W X Y Z) do (
  if not defined SUBST_DRIVE (
    if not exist "%%L:\NUL" (
      set "SUBST_DRIVE=%%L:"
    )
  )
)

if not defined SUBST_DRIVE (
  echo [WARN] No free drive letter available for SUBST. Startup will continue with the original path.
  exit /b 0
)

echo [INFO] Project path contains spaces. Creating temporary drive mapping !SUBST_DRIVE! ...
subst !SUBST_DRIVE! "%ROOT:~0,-1%" >nul 2>&1
if errorlevel 1 (
  echo [WARN] SUBST failed. Startup will continue with the original path.
  exit /b 0
)

if exist "!SUBST_DRIVE!\api\VolPro.WebApi\VolPro.WebApi.csproj" (
  set "WORK_ROOT=!SUBST_DRIVE!\"
  echo [OK] Using temporary drive !SUBST_DRIVE! for startup.
) else (
  echo [WARN] SUBST drive verification failed. Startup will continue with the original path.
  set "WORK_ROOT=%ROOT%"
)
exit /b 0

:WaitForPort
set "WAIT_PORT=%~1"
set "WAIT_MAX=%~2"
for /L %%S in (1,1,%WAIT_MAX%) do (
  powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %WAIT_PORT% -ErrorAction SilentlyContinue; if ($listener) { exit 0 } else { exit 1 }" >nul 2>&1
  if not errorlevel 1 exit /b 0
  timeout /t 1 /nobreak >nul
)
exit /b 1
