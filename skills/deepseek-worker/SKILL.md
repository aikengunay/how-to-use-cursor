---
name: deepseek-worker
description: >-
  Route bulk code generation through DeepSeek MCP while Cursor orchestrates
  and verifies. Use when the user opts into cost mode, says DeepSeek worker
  mode, or asks for deepseek_code for implementation. Skip typos, tiny fixes,
  and secrets-sensitive repos.
---

# DeepSeek worker

Cursor plans, applies patches, and verifies. DeepSeek generates via MCP. Default implement stays Composer unless the human opts in.

Setup: [`deepseek-worker-setup.md`](../../deepseek-worker-setup.md). Prompts and cost report: [`deepseek-worker-prompt.md`](../../deepseek-worker-prompt.md).

## When to use

- Bulk codegen, new files, HTML/CSS blobs, repetitive fixes
- Human says "DeepSeek worker mode" or references this skill

## When to skip

- Typos, renames, ≤10-line edits
- personal finance, calendar, and client product repos unless AGENTS.md says yes or the human asks
- Secrets in context (`.env`, keys, credentials)

## Chat visibility

**First reply**

```markdown
> **DeepSeek worker mode active**
> Orchestrator: Cursor · Worker: DeepSeek MCP
> Session started: [local] / [UTC]
```

**After each MCP call:** `Worker call: \`deepseek_code\` · deepseek-v4-pro · [in/out]`

**MCP fail:** `> **DeepSeek worker unavailable** — falling back to Composer for this step.`

No opt-in → no banner → Composer only.

## Workflow

1. Banner + start time
2. `deepseek_ping` once per session if unverified
3. `deepseek_code` once per generation unit (`deepseek-v4-pro`; thinking false). Do not write code first unless MCP failed after one restart retry.
4. Apply output; strip fences and token footer
5. Run verify from the plan
6. Closing report from [`deepseek-worker-prompt.md`](../../deepseek-worker-prompt.md)

### Session cost report rules

**Always accurate (agent must fill):**
- Start/end timestamps
- Every MCP call: tool, model, tokens in/out from footers (never guess)
- DeepSeek $: formula in [`deepseek-worker-setup.md`](../../deepseek-worker-setup.md) using footer model + rates
- Routing yes/no: banner, deepseek_code before Write, fallback used

**Human confirms (leave blanks or ask):**
- Cursor token sum from dashboard for the window
- DeepSeek platform spike yes/no
- Included vs on-demand on Cursor bill

**Never claim without human data:**
- "You saved $X" on Included Pro
- Cursor $ total (no billing API)

Optional one line, labeled **reference only**: public list-rate math for Composer tokens if human pasted a token sum — not invoice, not savings.

Pass only the task + 1–3 file snippets. Reviews: `deepseek_analyze`.

Weak output (not infra errors): retry once with `deepseek_chat` + `thinking: true`. MCP errors: restart MCP, then Composer once.

Cost mode: subagents Fast off or Explore disabled. New chat per phase.
