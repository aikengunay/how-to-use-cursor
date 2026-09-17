#!/usr/bin/env bash
# Install this folder to ~/.cursor/deepseek-mcp-server and merge the MCP entry.
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.cursor/deepseek-mcp-server"
KEY_FILE="${HOME}/.config/deepseek/api_key"
MCP_JSON="${HOME}/.cursor/mcp.json"

mkdir -p "${DEST}"
cp "${SRC}/server.py" "${SRC}/run.sh" "${SRC}/requirements.txt" "${SRC}/verify-mcp.sh" "${DEST}/"
chmod +x "${DEST}/run.sh" "${DEST}/verify-mcp.sh"

if [[ ! -x "${DEST}/.venv/bin/python" ]]; then
  python3 -m venv "${DEST}/.venv"
fi
"${DEST}/.venv/bin/pip" install -q -r "${DEST}/requirements.txt"

mkdir -p "$(dirname "${KEY_FILE}")"
chmod 700 "$(dirname "${KEY_FILE}")" 2>/dev/null || true
if [[ ! -f "${KEY_FILE}" ]]; then
  echo "Create ${KEY_FILE} (one line, no quotes) from platform.deepseek.com — then re-run verify."
fi

python3 - <<PY
import json
from pathlib import Path

path = Path("${MCP_JSON}")
path.parent.mkdir(parents=True, exist_ok=True)
data = json.loads(path.read_text()) if path.is_file() else {}
if not isinstance(data, dict):
    data = {}
servers = data.setdefault("mcpServers", {})
if not isinstance(servers, dict):
    servers = {}
    data["mcpServers"] = servers
servers["deepseek"] = {
    "type": "stdio",
    "command": "/bin/bash",
    "args": ["${DEST}/run.sh"],
    "env": {
        "DEEPSEEK_API_KEY_FILE": "${KEY_FILE}",
        "PYTHONUNBUFFERED": "1",
    },
}
path.write_text(json.dumps(data, indent=2) + "\n")
print(f"merged deepseek into {path}")
PY

echo "installed ${DEST}"
echo "Next: save API key if missing, then ${DEST}/verify-mcp.sh"
echo "Then Cursor Settings → MCP → deepseek → Restart"
