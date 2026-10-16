@echo off
rem Start the Windows-native SearXNG instance (http://127.0.0.1:8888).
setlocal
cd /d "%~dp0"

rem On first launch, create settings.yml from the template with a generated secret.
if not exist "settings.yml" (
  ".venv\Scripts\python.exe" -c "import pathlib,secrets;t=pathlib.Path('settings.windows.yml').read_text(encoding='utf-8');pathlib.Path('settings.yml').write_text(t.replace('CHANGE-ME',secrets.token_hex(32)),encoding='utf-8')"
)

set "SEARXNG_SETTINGS_PATH=%~dp0settings.yml"
".venv\Scripts\python.exe" -m searx.webapp %*
