# DeepSeek worker — machine setup

Optional. Cursor orchestrates; DeepSeek MCP generates bulk code. Default implement stays Composer.

Do **not** enable this on personal finance, calendar, or client product repos unless the human says so. Never send `.env` or secrets in worker context.

## Fresh machine (from this kit)

1. Clone this repo. Paste [`user-rules.md`](user-rules.md) into Cursor Settings → User Rules.
2. `./install-global.sh`
3. Account + top-up at [platform.deepseek.com](https://platform.deepseek.com). Save the key:

```bash
mkdir -p ~/.config/deepseek
chmod 700 ~/.config/deepseek
# one line, no quotes
chmod 600 ~/.config/deepseek/api_key
```

4. Install the MCP server (copies into `~/.cursor`, creates venv, merges `mcp.json`):

```bash
chmod +x deepseek-mcp-server/install.sh
./deepseek-mcp-server/install.sh
~/.cursor/deepseek-mcp-server/verify-mcp.sh
```

5. Cursor Settings → MCP → **deepseek** → Restart. New Agent chat: `deepseek_ping`.
6. Cost-mode chats: paste [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md).

The live server is `~/.cursor/deepseek-mcp-server`. This kit holds the source. Do not copy it into product repos.

## What lives where

| Piece | Location |
| --- | --- |
| Source in kit | [`deepseek-mcp-server/`](deepseek-mcp-server/) |
| Live server | `~/.cursor/deepseek-mcp-server` |
| MCP config | `~/.cursor/mcp.json` → `deepseek` |
| API key | `~/.config/deepseek/api_key` or `DEEPSEEK_API_KEY` |
| Skill | `~/.cursor/skills/deepseek-worker/` after `./install-global.sh` |

`mcp.json` must use `/bin/bash` + `run.sh`. Direct `run.sh` exec can hit `EACCES` in Cursor.

If `verify-mcp.sh` passes but Cursor fails: MCP → Restart, then Reload Window.

## Models and tools

- `deepseek-flash` — ping, cheap calls
- `deepseek-v4-pro` — codegen default

| Tool | Use |
| --- | --- |
| `deepseek_ping` | Session health check |
| `deepseek_code` | Implementation |
| `deepseek_analyze` | Review |
| `deepseek_chat` | General prompt (`thinking` available) |

Each reply appends `— model: …; tokens in/out: …/…`

## Dual meter

Worker ~1k tokens/task (DeepSeek top-up). Orchestrator ~100k–500k/turn (Cursor pool). Top-up does not replace Ultra.

Fact-check with the session timestamps in [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md): [platform.deepseek.com](https://platform.deepseek.com) and [cursor.com/dashboard/usage](https://cursor.com/dashboard/usage).

## BYOK (not this skill)

Custom model in Cursor Settings → Models, base URL `https://api.deepseek.com` (no `/v1`). Bills **Other Models**. Whole chat on DeepSeek — different tradeoff.
