# Running SearXNG natively on Windows

Upstream targets Linux/Unix and points Windows users at Docker or WSL. This
branch makes SearXNG run **natively on Windows** with no Docker and no WSL.

## Setup (one time)

```powershell
# uv provides the Python 3.12 toolchain (3.14 is not supported by SearXNG)
uv venv .venv --python 3.12

uv pip install --python .venv\Scripts\python.exe setuptools wheel pyyaml msgspec typing-extensions pybind11
uv pip install --python .venv\Scripts\python.exe --no-build-isolation -e .
uv pip install --python .venv\Scripts\python.exe tzdata

# Config: copy the template and set a unique secret
copy settings.windows.yml settings.yml
.venv\Scripts\python.exe -c "import secrets;print(secrets.token_hex(32))"
# paste the output into server.secret_key in settings.yml
```

## Run

```powershell
run.cmd
```

Serves on `http://127.0.0.1:8888`. The JSON format is enabled for API clients.

## Point crw at it

```powershell
crw search "your query" --search-backend-url http://127.0.0.1:8888
```

Or permanently, in `config.toml`:

```toml
[search]
search_backend_url = "http://127.0.0.1:8888"
```

## What this branch changes vs upstream

| Change | Why |
| --- | --- |
| `searx/valkeydb.py`: `import pwd` made optional | `pwd` is a Unix-only stdlib module; the import aborted startup on Windows |
| Deleted 4 files under `utils/templates/etc/` | They contain `:` in their filenames, which NTFS forbids — the repo could not be checked out on Windows at all. All four are Linux service templates (nginx/uwsgi/httpd) with no Windows use |
| Added `run.cmd`, `settings.windows.yml`, `WINDOWS.md` | Launcher and config for the Windows path |
| `tzdata` dependency | Windows ships no IANA time zone database; engines using `ZoneInfo` (e.g. bilibili) fail without it |

Everything else is untouched. `limiter`/bot-detection is off in the template
because it requires a Valkey/Redis server; enable it and run Valkey if you
expose the instance beyond localhost.
