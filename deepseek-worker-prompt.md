# DeepSeek worker — copy-paste prompts

Cost-mode chats only. Daily Composer work uses [`user-rules.md`](user-rules.md) → First message template.

## Start of chat

```markdown
DeepSeek worker mode — follow the deepseek-worker skill.

Rules:
- First reply: activation banner + start time (local + UTC)
- deepseek_ping once if MCP not verified this session
- deepseek_code (deepseek-v4-pro) before any codegen; Cursor applies + verifies
- Do not implement code yourself before deepseek_code
- Minimal context only (@ files)

## Goal
[one sentence]

## Files
@ [paths only]

## Verify
[command or click path]

## Out of scope
[what not to touch]

At end: session cost report below.
```

Short: `DeepSeek worker mode. Banner + start time. deepseek_ping → deepseek_code. Goal: [X]. Files: @[paths]. Verify: [Y]. End with session cost report.`

## What you should see

```markdown
> **DeepSeek worker mode active**
> Orchestrator: Cursor · Worker: DeepSeek MCP
> Session started: Sep 17, 2026 11:30 AM UTC+8 / 03:30 UTC
```

After codegen: `Worker call: \`deepseek_code\` · deepseek-v4-pro · 118/945 tokens`

No banner → worker did not engage.

Missing report: `Session cost report now — use the deepseek-worker closing format.`

## Session cost report

```markdown
## Session cost report

**Window for dashboard lookup**
- Started: [local] / [UTC]
- Ended: [local] / [UTC]

**DeepSeek worker** (MCP footers)
| Call | Model | Tokens in | Tokens out | Time (UTC) |
| --- | --- | --- | --- | --- |
| deepseek_ping | … | … | … | … |
| deepseek_code | … | … | … | … |
| **Subtotal** | | **…** | **…** | |

Rough DeepSeek cost: [estimate or check platform.deepseek.com for this window]

**Cursor orchestrator** (no billing API)
- Filter cursor.com/dashboard/usage between Started and Ended
- Sum `composer-2.5` / `composer-2.5-fast` / subagent rows in that window

**Routing check**
- [ ] DeepSeek activity in this window
- [ ] Cursor orchestrator rows in this window
- [ ] DeepSeek flat but task done → Composer-only fallback
```
