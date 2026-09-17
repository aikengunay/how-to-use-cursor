#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PY="${ROOT}/.venv/bin/python"

echo "== 1/2 Direct Python ping =="
"$PY" -c "
import sys
sys.path.insert(0, '${ROOT}')
import server
print(server.deepseek_ping())
"

echo ""
echo "== 2/2 Stdio MCP client (matches Cursor: bash run.sh) =="
"$PY" -c "
import asyncio
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client

async def main():
    params = StdioServerParameters(
        command='/bin/bash',
        args=['${ROOT}/run.sh'],
        env=None,
    )
    async with stdio_client(params) as (read, write):
        async with ClientSession(read, write) as session:
            await session.initialize()
            result = await session.call_tool('deepseek_ping', {})
            print(result.content[0].text)

asyncio.run(main())
"

echo ""
echo "OK. Restart deepseek in Cursor Settings → MCP if Cursor is already open."
