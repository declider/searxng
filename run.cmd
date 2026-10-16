@echo off
rem Start the Windows-native SearXNG instance (localhost:8888).
setlocal
cd /d "%~dp0"
if not exist "settings.yml" (
  echo ERROR: settings.yml not found.
  echo Copy settings.windows.yml to settings.yml and set server.secret_key first.
  exit /b 1
)
set "SEARXNG_SETTINGS_PATH=%~dp0settings.yml"
".venv\Scripts\python.exe" -m searx.webapp %*
