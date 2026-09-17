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
- End with session cost report (accurate block only — no invented savings)

## Goal
[one sentence]

## Files
@ [paths only]

## Verify
[command or click path]

## Out of scope
[what not to touch]
```

Short: `DeepSeek worker mode. Banner + start time. deepseek_ping → deepseek_code. Goal: [X]. Files: @[paths]. Verify: [Y]. Session cost report at end.`

## What you should see

```markdown
> **DeepSeek worker mode active**
> Orchestrator: Cursor · Worker: DeepSeek MCP
> Session started: Sep 17, 2026 11:30 AM UTC+8 / 03:30 UTC
```

After each MCP call: `Worker call: deepseek_code · deepseek-v4-pro · 118/945 tokens`

No banner → worker did not engage.

Missing report: `Session cost report now — accurate block from deepseek-worker-prompt.md.`

---

## Session cost report (required at end)

The agent fills **Accurate** and **Routing** from this chat only. **You confirm** on dashboards. Never claim dollar savings on Included Pro.

```markdown
## Session cost report

### Accurate (from this chat)

**Window**
- Started: [local] / [UTC]
- Ended: [local] / [UTC]

**DeepSeek MCP calls** (copy from footers — do not invent rows)
| Tool | Model | Tokens in | Tokens out | UTC |
| --- | --- | ---: | ---: | --- |
| deepseek_ping | … | … | … | … |
| deepseek_code | … | … | … | … |
| **Subtotal** | | **…** | **…** | |

**DeepSeek cost (calculated from footers)**
- Formula: `(tokens_in ÷ 1,000,000 × input_rate) + (tokens_out ÷ 1,000,000 × output_rate)`
- Rates used: [model from footer] off-peak per [deepseek-worker-setup.md](deepseek-worker-setup.md) — verify on [platform.deepseek.com](https://platform.deepseek.com)
- **DeepSeek total: $0.00XX** (top-up bill; this number is as accurate as the footers + published rates)

**Cursor orchestrator**
- No billing API in chat. Orchestrator tokens are **not** auto-summed here.

### You confirm (dashboards)

Use **Started–Ended** above.

| Check | Where | Your answer |
| --- | --- | --- |
| DeepSeek spike matches subtotal? | platform.deepseek.com → Usage | yes / no |
| Cursor rows in window? | cursor.com/dashboard/usage | yes / no |
| Cursor token sum (paste) | Same window, sum Token column | ______ (e.g. 412k) |
| Cursor line on bill | Included / on-demand $ | ______ (often Included = $0) |

### Routing (factual)

| Question | Answer |
| --- | --- |
| Activation banner shown? | yes / no |
| deepseek_code before first Write/StrReplace on codegen? | yes / no |
| Composer fallback used? | yes / no |
| Worker engaged successfully? | yes / no |

### Do not claim

- Do **not** write "you saved $X" unless the human pasted **on-demand** Cursor dollars for this window.
- Do **not** convert Cursor Included tokens to dollars as "savings" — that is not cash on Pro.
- Optional **reference only** (label clearly): "At public list rates, [N]k Composer tokens ≈ $Y — not your invoice."
```

---

## Example homepage test (new chat)

```markdown
DeepSeek worker mode — follow the deepseek-worker skill.

## Goal
Redesign draft/homepage-test/index.html: dark theme, hero, 3 feature cards, footer.

## Files
@ draft/homepage-test/index.html

## Verify
open draft/homepage-test/index.html in browser

## Out of scope
No npm, no framework, inline CSS only
```
