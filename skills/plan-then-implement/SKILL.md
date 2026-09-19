---
name: plan-then-implement
description: >-
  Audits the repo and writes a short plan a cheaper or faster model can
  follow. Use for medium or large tasks, Plan mode, multi-file features,
  or when the user asks to plan then implement. Skip for typos, renames,
  and small CSS.
---

# Plan then implement

Think first. Change files only after the human approves, unless they already said to implement the plan.

## Skip this skill

Typos, renames, one-line fixes, small visual tweaks. Those go straight to Agent.

## Plan (thinking model)

1. Read only the files needed to be right. No repo tourism.
2. State the goal, the files, the steps, and the verify path.
3. Call out risks and the smallest rollback.

```markdown
## Goal
One sentence.

## Steps
1. ...
2. ...

## Files
- path — create | edit | delete

## Verify
- command or click path that proves it

## Out of scope
- ...

## Risks
- ...
```

The plan must be specific enough that a faster model cannot invent a new architecture while implementing.

### Detailed plans — First messages + Model

Medium or large work that splits into implement chats (Phase 1 Chat A…E style) should end the `.cursor/plans/*_detailed.plan.md` with **First messages** — one section per chat. Do **not** put model names in product `AGENTS.md`. Slice overrides live in the plan.

**Two parts per chat — do not merge:**

1. **Model (human only)** — bullet list **above** the fence. The operator sets the Cursor picker from this; **do not paste Model into the chat** (the agent cannot read the picker from your message).
2. **Paste into chat** — one fenced block with `## Goal`, `## Files`, `## Verify`, `## Closeout`, `## Out of scope`.
3. **After final gate (human only)** — one section at the end of the plan for optional reviews/skills — not pasted into implement chats.

Model block uses **picker labels** (not SKU metaphors):

```
Model (you — set picker; do not paste):
- Mode: Agent
- Pool: Cursor Models
- Model: Composer 2.5
- Fast: On
- Effort: Medium (default)
- Context: Default
- DeepSeek worker: No
```

Plan-mode chats use Mode: Plan, Effort: High, Fast: Off. Name the thinking model the human already picked (e.g. Claude Fable 5.1).

**Defaults by slice (override only when the job needs it):**

| Slice | Model · Fast · Effort | DeepSeek worker |
| --- | --- | --- |
| Implement A…N (wiring, pages, deploy) | Composer 2.5 · **On** · Medium | **No** |
| Bulk new files / SCSS+config blobs (cost mode) | Composer 2.5 · On · Medium (orchestrate) | **Optional** — name exact files |
| Player / timing / protocol | Composer 2.5 · On · Medium | **No** |
| Stuck twice on protocol | New chat → Grok 4.6 High · **Off** · High | No |
| Plan / design (once) | Thinking model · Off · High · Plan mode | No |

Claude / GPT implement only when the human chose Other Models on purpose. Escalation line for every implement chat: `If blocked twice on timing/protocol: new chat → Grok 4.6 High, Fast Off`.

Do not create a second “prompts only” file unless the human asks. The detailed plan is the single copy-paste source.

**Closeout line in every paste block** — list the exact todo IDs for that slice (work items + gate), e.g.:

```markdown
## Closeout
Mark `status: completed` in the plan frontmatter for: `p2a-config`, `p2a-env`, … `gate-2a`. Required before you stop — do not mark the next slice's todos.
```

### Detailed plans — Todo closeout (required)

Plans with YAML frontmatter todos (`id` + `status`) are the slice tracker. **Every implement chat must end with todo updates** — agents often skip this unless the paste block says so.

1. Run verify for this slice only.
2. Edit `.cursor/plans/*_detailed.plan.md` frontmatter: set `status: completed` on **every todo ID for this slice** (sub-phase items + gate). Do not mark the next slice early.
3. Tell the human which IDs were marked done and that the next chat can start.

If verify fails, leave todos pending and say what blocked the gate.

### Detailed plans — After final gate (human only)

End every detailed plan with this section. **Do not paste into implement chats.** Gates between slices are enough; branch reviews run once at the end.

```markdown
## After final gate

Human-only — do not paste into implement chats.

| When | Action |
| --- | --- |
| After last gate passes | Optional `simplify-ai-slop` if any slice felt bloated |
| Branch merge-ready / ship | Optional Thermos (both tracks) — **one** review chat |
| Human-facing copy you wrote | Optional `no-ai-slop` on your draft |
| Do not | Thermos, Bugbot, or Security Review between slices (mid-feature) |
| Do not | Stack Thermos + Bugbot + Security on the same diff unless the human asks |

Product `.cursor/rules` apply automatically — no plan line needed.
```

## Implement (Composer / Grok after approval)

- Follow the plan. Do not reopen design.
- Smallest diff. No extra files.
- Run the verify path before claiming done.
- **Mark this slice's plan todos `completed` in frontmatter before you stop** (see Closeout in the paste block).
- If the plan is wrong, stop and say so. Do not silently expand scope.

### Which model (Cursor picker)

Default implement: **Composer + Fast on**, effort **Medium/default**, context **default**. See `user-rules.md` → Model picker for full role + toggle guidance. If the human opts into cost mode for the implement phase, load `deepseek-worker` instead of Composer-only generation.

| Situation | Model · Fast · effort |
| --- | --- |
| Executing plan phases 1…N | Composer · **Fast on** · Medium/default |
| Hub / protocol / WS logic fails twice | New chat → Grok High · **Fast off** · High OK |
| Blocked and time-sensitive | Grok High · Fast on (2× Grok rate) — rare |

- **One Agent chat per plan phase.** New chat if context compacts; point at the plan + “Phase N only.” Keeps context small — large threads burn pool quickly.
- **Do not** add model names to product `AGENTS.md` — they go stale. The approved plan + phase prompt is enough.

## After a large generation

Offer to run `simplify-ai-slop` on the diff. Do not run it unless asked.
