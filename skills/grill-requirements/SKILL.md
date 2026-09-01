---
name: grill-requirements
description: >-
  Interrogates a feature request against the real codebase and docs before any
  implementation. Use when starting a new feature, when the request is vague,
  when requirements conflict, or when the user asks to grill, refine, or
  clarify requirements.
---

# Grill requirements

Do not implement yet. Turn a fuzzy request into a short, testable spec.

## When to stop grilling

If the ask is a typo, rename, one-line fix, or small CSS change, skip this skill and do the work.

## Workflow

1. Restate the goal in one sentence.
2. Read only the files and docs that could change the answer. Do not tour the repo.
3. Ask only the questions that would change the design. Cap at 5. Prefer concrete options over open essays.
4. Write the spec below. Wait for approval before coding unless the user already said to proceed after the spec.

## Spec format

```markdown
## Goal
One sentence.

## In scope
- ...

## Out of scope
- ...

## Constraints
Stack, files, data, time, existing rules.

## How we will know it works
- Check 1 (command, click path, or assertion)
- Check 2

## Open questions
- Question — default if unanswered
```

## Rules

- Prefer existing patterns in this repo over new ones.
- If a project `AGENTS.md` or `.cursor/rules` already answers a question, use that answer. Do not re-ask.
- Do not invent product requirements. Mark guesses as guesses.
- Docs beat memory. If the user pointed at a file, video, or URL, use it.
