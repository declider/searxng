# Running SearXNG natively on Windows

Upstream targets Linux/Unix and points Windows users at Docker or WSL. This
branch makes SearXNG run **natively on Windows** with no Docker and no WSL.

## Setup (one time)

```powershell
uv venv --python 3.12
uv pip install -r requirements.txt tzdata
```

`uv` fetches the Python 3.12 toolchain itself; SearXNG does not support 3.14.
Installing the requirements (rather than the package) is enough — the webapp
runs from the repository root, so no build step is needed.

## Run

```powershell
run.cmd
```

Serves on `http://127.0.0.1:8888`. On first launch `run.cmd` creates
`settings.yml` from `settings.windows.yml` with a freshly generated secret key.

## Using it from a client

It exposes the standard SearXNG JSON API, so any client that can talk to a
SearXNG instance works — MCP SearXNG servers, LangChain/LlamaIndex, Open WebUI,
browser extensions, or a plain request:

```powershell
curl "http://127.0.0.1:8888/search?q=your+query&format=json"
```

Tools that take a SearXNG backend URL just point at it, e.g.:

```powershell
your-tool --search-backend-url http://127.0.0.1:8888
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
