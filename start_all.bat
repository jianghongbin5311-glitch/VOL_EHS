@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT="
set "SCRIPT_DIR=%~dp0"
set "FALLBACK_ROOT=C:\Users\FZP28D\Desktop\AI Created\VOL_Pro_Antigravity\"
set "API_DIR="
set "WEB_DIR="
set "DV_DIR="
set "API_PORT=9100"
set "WEB_PORT="
set "DV_PORT=9200"
set "WAIT_SECONDS=180"
set "API_READY=0"
set "WEB_READY=0"
set "DV_READY=0"

call :TryRoot "%SCRIPT_DIR%"
if not defined ROOT call :TryRoot "%CD%\"
if not defined ROOT call :TryRoot "%FALLBACK_ROOT%"

if not defined ROOT (
  for %%D in ("%USERPROFILE%\Desktop\AI Created\VOL_Pro_Antigravity\" "%USERPROFILE%\Desktop\VOL_Pro_Antigravity\") do (
    if not defined ROOT call :TryRoot "%%~fD"
  )
)

if not defined ROOT (
  for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $roots=@('%USERPROFILE%\Desktop','%USERPROFILE%\Documents'); $found = Get-ChildItem -Path $roots -Filter VolPro.WebApi.csproj -File -Recurse | Where-Object { $_.FullName -like '*\api\VolPro.WebApi\VolPro.WebApi.csproj' } | Select-Object -First 1; if($found){ Split-Path (Split-Path $found.FullName -Parent) -Parent }"`) do (
    if not defined ROOT call :TryRoot "%%D\"
  )
)

if defined ROOT (
  set "API_DIR=%ROOT%api\VolPro.WebApi"
  set "WEB_DIR=%ROOT%web.vite"
  set "DV_DIR=%ROOT%dataview"
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

:: Check if node_modules exists, run npm install if missing
if not exist "%WEB_DIR%\node_modules\.package-lock.json" (
  echo [INFO] WEB node_modules not found or incomplete, running npm install...
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

:: Check DataView node_modules
if exist "%DV_DIR%\package.json" (
  if not exist "%DV_DIR%\node_modules\.package-lock.json" (
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

for /L %%P in (9000,1,9010) do (
  powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %%P -ErrorAction SilentlyContinue; if ($listener) { exit 1 } else { exit 0 }" >nul 2>&1
  if not errorlevel 1 (
    set "WEB_PORT=%%P"
    goto :PORT_FOUND
  )
)

echo [ERROR] No available web port found between 9000 and 9010.
pause
exit /b 1

:PORT_FOUND
echo [INFO] Starting VOL API window...
start "VOL API" cmd /k "cd /d ""%API_DIR%"" && dotnet run"

echo [INFO] Starting VOL WEB window...
start "VOL WEB" cmd /k "cd /d ""%WEB_DIR%"" && npm run dev -- --port !WEB_PORT! --strictPort"

if exist "%DV_DIR%\package.json" (
  echo [INFO] Starting DataView window...
  start "VOL DataView" cmd /k "cd /d ""%DV_DIR%"" && npm run dev"
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

if exist "%DV_DIR%\package.json" (
  echo [INFO] Waiting for DataView on http://localhost:!DV_PORT! ...
  call :WaitForPort !DV_PORT! %WAIT_SECONDS%
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
  echo [INFO] Opening WEB home page...
  start "" "http://localhost:!WEB_PORT!"
) else (
  echo [WARN] WEB browser was not opened because the WEB port is not ready.
)

echo.
echo ============================================
echo [OK] All startup commands have been launched.
echo ============================================
echo API Swagger:  http://localhost:%API_PORT%/index.html
echo Web Dev URL:  http://localhost:!WEB_PORT!
echo DataView URL: http://localhost:!DV_PORT!
echo.
if "!API_READY!"=="0" echo [TIP] Check the "VOL API" window for startup errors.
if "!WEB_READY!"=="0" echo [TIP] Check the "VOL WEB" window for startup errors.
if "!DV_READY!"=="0" echo [TIP] Check the "VOL DataView" window for startup errors.
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

:WaitForPort
set "WAIT_PORT=%~1"
set "WAIT_MAX=%~2"
for /L %%S in (1,1,%WAIT_MAX%) do (
  powershell -NoProfile -Command "$listener = Get-NetTCPConnection -State Listen -LocalPort %WAIT_PORT% -ErrorAction SilentlyContinue; if ($listener) { exit 0 } else { exit 1 }" >nul 2>&1
  if not errorlevel 1 exit /b 0
  timeout /t 1 /nobreak >nul
)
exit /b 1
