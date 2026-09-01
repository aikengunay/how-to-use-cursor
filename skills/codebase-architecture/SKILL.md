---
name: codebase-architecture
description: >-
  Decides where new code should live and how it should connect to what exists.
  Use when adding a system, refactoring structure, asking where a feature
  belongs, or when the user mentions architecture, folder layout, or module
  boundaries.
---

# Codebase architecture

Map the change onto the current tree. Do not start from a greenfield fantasy.

## Workflow

1. Identify the job of the change in one sentence.
2. Read the existing layout: top-level folders, the nearest similar feature, and any `AGENTS.md` / project rules.
3. Name 2–3 placement options. Pick one. Say why the others lose.
4. List the files that will be added, edited, or left alone.
5. If the user asked for a visual, add a small mermaid diagram of the chosen shape. Skip decoration.

## Placement test

A file belongs where the next person would look for it. Colocate with the feature it serves. Do not create a new top-level folder unless nothing existing can hold it.

## Output

```markdown
## Job
One sentence.

## Chosen shape
Where it lives, and the one-sentence reason.

## Rejected
- Option — why not

## Files
- add: path — why
- edit: path — why
- do not touch: path — why

## Boundaries
What this module may import, and what it must not know about.
```

## Rules

- Match this repo's existing patterns. Do not import a different stack's conventions.
- Prefer fewer modules over a "clean" layer cake the codebase does not already use.
- If the change is local to one file, say so and stop. Architecture theater is slop.
