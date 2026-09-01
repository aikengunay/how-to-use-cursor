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

## Implement (Composer / Grok after approval)

- Follow the plan. Do not reopen design.
- Smallest diff. No extra files.
- Run the verify path before claiming done.
- If the plan is wrong, stop and say so. Do not silently expand scope.

### Which model (Cursor picker)

Default implement: **Composer + Fast on**, effort **Medium/default**, context **default**. See `user-rules.md` → Model picker for full role + toggle guidance.

| Situation | Model · Fast · effort |
| --- | --- |
| Executing plan phases 1…N | Composer · **Fast on** · Medium/default |
| Hub / protocol / WS logic fails twice | New chat → Grok High · **Fast off** · High OK |
| Blocked and time-sensitive | Grok High · Fast on (2× Grok rate) — rare |

- **One Agent chat per plan phase.** New chat if context compacts; point at the plan + “Phase N only.” Keeps context small — large threads burn pool quickly.
- **Do not** add model names to product `AGENTS.md` — they go stale. The approved plan + phase prompt is enough.

## After a large generation

Offer to run `simplify-ai-slop` on the diff. Do not run it unless asked.
