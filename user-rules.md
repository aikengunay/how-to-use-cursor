# Cursor OS — User Rules

Paste into **Settings → Rules → User** as one rule (`cursor-os`), or append below git / PR / browser-verify rules. Re-paste after edits in this file (lines 5 onward — skip this header).

## Working philosophy

Do the work and make the human smarter. Explain what changed and why. Do not smash Accept blindly. If you cannot explain a change in one or two sentences, the change is too large or too vague.

Prefer the smallest change that solves the asked problem. Do not add files, abstractions, comments, or features that were not requested.

## UI copy

User-facing text uses sentence case. Never all-caps labels, headings, buttons, or empty states.

## Verify before done

The agent does not know if it is correct until something checks the work.

- Important behavior: write the failing check first, then implement. Implement-then-test is cheating.
- Do not test every line. Test what would hurt if wrong.
- If the stack has types or a linter, run them before calling the task done.
- UI work: exercise the flow the way a user would (click, type, submit, navigate). One screenshot is not verification. Check related routes and edge states. This does not replace any existing browser-verify rule.

## Session hygiene

- One Agent chat per task. A second feature in a spent thread is worse and more expensive.
- Be stupidly specific. Point at files and sources. Vague prompts make the agent read everything.
- If the agent starts exploring files or topics it does not need, stop it and point it at the right ones.
- If context compaction happens mid-task, start a new chat. Point it at the plan and the relevant files, not the whole transcript.

## First message template

**Where rules live (do not duplicate):**

| Layer | File | Holds |
| --- | --- | --- |
| Daily habits | This file | Philosophy, one-off template, session hygiene, review when |
| Phased implement | `plan-then-implement` skill | First messages, Model, Closeout, roadmap tick, After final gate |
| Model choice | `model-routing.md` | Composer vs Grok vs DeepSeek |
| Product | `AGENTS.md`, `docs/roadmap.md` | Run, verify, phase status — not model SKUs |

**One-off tasks:** set the picker first (default implement: Composer 2.5 · Fast On · Cursor Models). Paste **only** this:

```
## Goal
One sentence.

## Files
@ paths only — no whole repo

## Verify
Command or click path that proves done

## Out of scope
What not to touch
```

**Phased work:** `@docs/roadmap.md` (if present) for order → `.cursor/plans/*_detailed.plan.md` → **First messages**. Set picker from **Model (do not paste)**; paste the fenced block from the plan. **Load `plan-then-implement` skill** for Closeout, todos, roadmap tick, and reviews — do not restate that procedure here.

Ultra hygiene: Composer Fast for implement; Cursor Models pool default; new chat after compaction. Cost mode (opt-in): paste `deepseek-worker-prompt.md` — do not treat that as the daily default.

## Plan vs implement

- Medium or large work: Plan mode first. Catch a bad plan in one page, not in twelve files.
- Typos, renames, one-line fixes, small CSS: skip Plan. Go straight to Agent.
- Mix models when useful: a thinking model writes the plan; Composer or Grok implements after approval. Faster does not mean dumb.

### Model picker (roles first, then toggles)

Full decision flow + orchestrator vs worker: [`model-routing.md`](model-routing.md).

Pick by **job**, not by SKU. Menu labels change; these roles do not. Choose **role → defaults below**; touch toggles only when the job needs it.

| Job | Model | Pool |
| --- | --- | --- |
| Plan / design | Thinking model or **Plan mode** | Either — your taste |
| Implement approved plan | **Composer + Fast on** | **Cursor Models** |
| Bulk implement (cost mode, opt-in) | **DeepSeek MCP** via `deepseek-worker` skill; Cursor applies + verifies | DeepSeek top-up + Cursor Models |
| Stuck on protocol / hub / state | **Grok High + Fast off** (new chat) | Cursor Models |
| Deliberate non-Cursor work | Claude / GPT — only when you choose it on purpose | **Other Models** |

**Per-product model rules in `AGENTS.md`:** no. Keep run/verify/product locks there; model choice stays in this OS + the task plan.

#### Defaults by job (Fast · effort · context)

| Job | Fast | Effort | Context (if shown) |
| --- | --- | --- | --- |
| Plan | off / N/A | **High** (or model thinking mode) | default |
| Implement | **Composer: on** | Medium or default | default (~300k) |
| Bulk implement (cost mode) | Composer Standard for glue · **Fast off on subagents** | Medium or default | default |
| Debug (Grok) | **off** | High OK for one chat | default |
| Tiny fix (no plan) | Composer: either | Low or default | default |

**Fast** = speed tier where the picker offers it. **Composer Fast on** is the normal implementer — not a “burn” setting. **Grok Fast on** = **2× standard Grok rates** (Cursor-confirmed) — default **off**; only when blocked and time-sensitive. Other models may not have Fast; use that model’s own thinking toggle instead.

**Effort** (Low → Max) = reasoning depth **per turn**. High on Plan; **not** all-day High on implement — the plan already did the thinking. Extra High / Max: rare — one hard design deadlock, not routine Agent.

**Context** (e.g. 300k vs 1M — not on every plan): stay on **default** for phased work with `@` plan + specific files. Bump to 1M only when you truly need wide repo context and accept the cost — prefer a new chat over a megathread.

#### Other models (Claude, GPT, …)

Intentional only — you picked it, not accidental. Good for Plan you prefer on Claude, prose/review taste, or when Cursor models feel wrong. **Bad default:** implementing hub/protocol work on Claude while Composer is available. Fast and effort follow **that model’s** UI, not Grok’s rules.

### Usage pools (how the meter moves)

Cursor meters **two included pools** (see **Settings → Plan & Usage** — two bars; detail at `cursor.com/dashboard?tab=usage`):

| Pool | Typical models | When to use |
| --- | --- | --- |
| **Cursor Models** | Composer, Grok (first-party) | Default implement + most Agent work on-plan |
| **Other Models** | Claude, GPT, etc. | Only when you deliberately pick a non–first-party model |

Burn stacks: **Grok Fast** (2× Grok) + **High effort** + **large context** + huge cached threads. Same hygiene for any model — one chat per phase; `@` the plan and files; new chat after compaction; do not re-paste long transcripts.

Included usage resets each **billing cycle**; unused allowance does not roll over. Do not put your plan tier or reset date in repo rules — check the app when budgeting.

## Skills and MCP

Load only what this job needs. Skills hold workflows and taste. MCP is for touching a live system (browser, GitHub, calendar, database, optional DeepSeek codegen worker). Do not install a pile of community skills or always-on subagents.

Named skills in this OS: `grill-requirements`, `codebase-architecture`, `simplify-ai-slop`, `plan-then-implement`, `no-ai-slop`, `deepseek-worker`. DeepSeek MCP = optional cheap codegen worker; load on demand — paste [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) in the kit (not this file) for start + closing cost report. Report rule: DeepSeek $ from MCP footers only; Cursor tokens from dashboard (human confirms); never claim "saved $X" on Included Pro. Not default for every task.

External GitHub repos → open a dedicated chat with the kit's `adopt-external-repo-prompt.md` before any install.

**UI look:** Mobbin (or a gallery bookmark) → lock the brief in the product plan → Composer implements shell/CSS. Do not send visual/CSS work to DeepSeek without that brief. Details: kit `design-with-agents.md`. Do not install oil-ui and superdesign-skill together; neither is a default OS skill.

**Prose vs code slop:** `no-ai-slop` is for human-facing writing after you draft; `simplify-ai-slop` is for generated code bloat. Do not swap them.

**Mobile QA:** browser MCP for web. Repeatable mobile flows live in that product repo's Maestro YAML — not global skills.

## Review (on demand only)

The Thermos plugin is installed on this machine. Do not install it again. Do not put plugin install steps in a repo.

- Merge-ready, PR, “review this branch,” ship, thermos, or thermonuclear → run `thermos` (both tracks). If they named one track, run that one: `thermo-nuclear-review` or `thermo-nuclear-code-quality-review`.
- Typos, mid-feature, Plan mode, small UI → do not run Thermos.
- `simplify-ai-slop` is for deleting bloat in the current generation. Thermos is for branch vs main. Do not substitute one for the other.
- Do not stack Thermos and Bugbot and Security Review on the same diff unless they asked for a second pass. One review tool per review chat.
- Project `.cursor/rules` stay in charge of product locks (this app’s UI, streaming, Docker). Do not rewrite or delete them to “make room” for this OS.
