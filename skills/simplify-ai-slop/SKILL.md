---
name: simplify-ai-slop
description: >-
  Cuts generated bloat after the agent writes a chunk of code. Use when the
  user names this skill, asks to simplify, review slop, thermonuclear review,
  or clean up AI-generated code. Do not run on every small edit.
disable-model-invocation: true
---

# Simplify AI slop

The goal is less code that still does the asked job. Delete before you rewrite.

## Scope

Only the files touched by the current change unless the user points wider. Do not "improve" unrelated modules.

## Cut list

Delete or collapse:

- Extra files that could have been a function in an existing file
- Wrappers, helpers, and "utils" used once
- Abstractions for a single implementation
- Comments that restate the code
- Feature flags, config, and TODOs nobody asked for
- Tests that assert implementation details or cover every line
- User-facing ALL CAPS
- Unrelated refactors bundled into the same diff

Keep:

- The behavior that was requested
- Existing project patterns
- Checks that would fail if the behavior broke

## Workflow

1. Diff the change. Restate the asked job in one sentence.
2. List each cut with the file and why it is safe.
3. Apply the cuts.
4. Re-run the project's verify path (tests, types, lint, or the UI flow).
5. Report: what was deleted, what remains, how it was verified.

## Pass test

If a line does not earn its keep against the asked job, it goes. Clever is not a reason to keep it.
