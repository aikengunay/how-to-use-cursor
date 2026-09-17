# When to use which model

Quick reference for **Cursor orchestrator** vs **DeepSeek worker** vs **Other models**. Toggle details (Fast, effort, context) stay in [`user-rules.md`](user-rules.md) → Model picker.

---

## Mental model

```
You → Cursor (orchestrator: tools, files, MCPs, verify)
         ↓ optional
      DeepSeek MCP (worker: cheap text/code generation only)
```

| | **Cursor** | **DeepSeek MCP** |
| --- | --- | --- |
| Role | Manager + hands | Subcontractor, text only |
| Tools | Files, terminal, browser, Mobbin, Gmail, … | None — API chat only |
| Writes files | Yes | No — returns text; Cursor applies |
| Internet / MCP | Yes | No — only what Cursor pastes in `context` |
| Images | Yes (`GenerateImage`, screenshots) | No |
| Billing | Included / on-demand (Cursor dashboard) | Top-up (platform.deepseek.com) |

**DeepSeek does not replace Cursor.** It replaces **large Composer generation passes** when you opt into cost mode.

---

## Pick by job (default)

| Job | Model / mode | Pool | Notes |
| --- | --- | --- | --- |
| Plan / design | Thinking model or **Plan mode** | Either | Once per feature; lock architecture |
| Implement (normal) | **Composer + Fast on** | Cursor Models | Daily default |
| Bulk codegen (opt-in) | **DeepSeek** `deepseek_code` + Composer apply/verify | DeepSeek top-up + Cursor Models | Paste [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) |
| Stuck on protocol / hub / state | **Grok High, Fast off** (new chat) | Cursor Models | After two failed Composer attempts |
| Blocked + time-sensitive | Grok High, Fast on | Cursor Models | Rare — 2× Grok rate |
| Tiny fix (≤10 lines) | Composer (Fast either) | Cursor Models | Skip DeepSeek |
| Prose / review taste | Claude or GPT **on purpose** | Other Models | Not for bulk implement |
| Research (Mobbin, web) | **Cursor + MCP** | Cursor Models | Never DeepSeek — no MCP access |

**Do not put model names in product `AGENTS.md`.** Model choice lives here + the approved plan.

---

## Decision flow

```
New task
  │
  ├─ Typo / rename / ≤10 lines? ──────────────► Composer only
  │
  ├─ Medium/large feature?
  │     ├─ Plan mode or thinking model (once)
  │     ├─ Research needed? ───────────────────► Cursor + MCP (bullets only downstream)
  │     ├─ Scaffold / wiring? ─────────────────► Composer Fast
  │     └─ Many new files / big HTML-CSS-TSX blob?
  │           ├─ Cost mode opt-in? ────────────► DeepSeek worker + Composer verify
  │           └─ No ─────────────────────────► Composer Fast (whole implement)
  │
  ├─ Same bug twice / hub-protocol weirdness? ──► New chat, Grok High Fast off
  │
  └─ Want Claude/GPT prose or review taste? ────► Other Models, intentional only
```

---

## What DeepSeek is (and is not)

**Good for**

- Multi-file codegen units (homepage, components, CSS blobs)
- Repetitive generation Cursor would otherwise output token-heavy
- `deepseek_analyze` — tight code review when you paste the diff

**Not for**

- Mobbin, Figma, browser, terminal, git
- Planning with tool use
- “Search the web and build from that”
- Image generation
- Secrets (`.env`, keys) in context

**MCP tools:** `deepseek_ping`, `deepseek_code`, `deepseek_chat`, `deepseek_analyze` — all text in/out.

---

## Does DeepSeek mean I never use Grok / Claude / GPT?

**No.** Common community pattern:

| Need | Use |
| --- | --- |
| Cheap bulk **generation** | DeepSeek worker |
| **Orchestration** + tools | Composer (Fast default) |
| Hard **debug** / protocol | Grok High |
| **Plan** or prose **taste** | Thinking model, Claude, GPT — your choice |
| **Research** with live data | Cursor + MCP (Mobbin, browser, etc.) |

DeepSeek reduces **how often** frontier models must **emit** huge code blocks. It does **not** remove the need for a capable **orchestrator** or specialty models for hard problems.

---

## Chat split (saves Cursor tokens)

Separate chats by phase — do not merge research + codegen:

| Chat | Mode | Example cost driver |
| --- | --- | --- |
| 1 Plan | Plan / thinking | Design locked once |
| 2 Research | Cursor + Mobbin MCP | Large if raw dumps stay in thread |
| 3 Scaffold | Composer only | Empty shells, no UI |
| 4 Build | DeepSeek worker + Composer | Orchestration context, not full codegen output |

**Rule:** Research outputs **bullets + URLs** into the build chat — not Mobbin images or full metadata dumps.

---

## Cost honesty (homepage test reference)

Real numbers from one controlled build (Sep 2026):

| Line | Approx. |
| --- | --- |
| DeepSeek (4× `deepseek_code` + ping) | **~$0.008** top-up |
| Cursor (full phase, 4 chats) | **~6.9M Included tokens** |
| Mobbin research chat alone | **~4.2M** Included tokens |
| DeepSeek build chat (orchestration) | **~1.7M** Included tokens |

**Takeaways**

- DeepSeek top-up is negligible for bulk codegen.
- Cursor still burns tokens on **orchestration, context, and MCP research**.
- On **Included Pro**, DeepSeek saves **headroom**, not necessarily cash today.
- On **on-demand** Cursor billing, routing generation to DeepSeek matters more in dollars.

Never claim “you saved $X” on Included Pro without on-demand dashboard proof. See [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) → Session cost report.

---

## Fast · effort · context (short)

Full table: [`user-rules.md`](user-rules.md) → Defaults by job.

- **Composer Fast on** — normal implementer; not a “burn” setting.
- **Grok Fast on** — 2× Grok rate; default off; blocked + urgent only.
- **High effort** — Plan and rare deadlocks; not all-day on implement.
- **1M context** — only when you truly need wide repo; prefer new chat + `@` plan.

---

## Related files

| File | Role |
| --- | --- |
| [`user-rules.md`](user-rules.md) | Model picker tables, pools, hygiene |
| [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) | Cost-mode start + session report |
| [`deepseek-worker-setup.md`](deepseek-worker-setup.md) | MCP install + DeepSeek $ math |
| [`skills/deepseek-worker/SKILL.md`](skills/deepseek-worker/SKILL.md) | Agent routing when worker is opt-in |
| [`skills/plan-then-implement/SKILL.md`](skills/plan-then-implement/SKILL.md) | Plan vs implement split |
