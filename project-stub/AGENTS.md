# Project

Replace every `TODO` with facts about this repo. Delete any section that does not apply. Keep this file short.

## What this is

TODO: one paragraph. Who it is for and what it does.

## How to run

```bash
TODO: install and start commands
```

## How to verify done

- TODO: test / typecheck / lint command
- TODO: the one user flow that must still work
- TODO (if mobile matters): Maestro flow path and command, e.g. `maestro test maestro/flows/`
- TODO (if UI matters): click path; fill `DESIGN.md` and `@` product design rules if `.cursor/rules` exist

## Stack facts

- Language / framework: TODO
- Package manager: TODO
- Where config lives: TODO
- Where the main entry is: TODO
- Anything the agent always gets wrong in this repo: TODO

## Current status

TODO: what is true today. Not a roadmap.

## Cursor in this repo

Layer 1 (User Rules, personal skills, Thermos plugin) is already on the machine. Do not install plugins or copy skills into this repo.

Product rules in `.cursor/rules` or `.cursorrules` stay. Thermos only when asked for merge-ready or a branch review.

Client runbooks and deploy docs live in `docs/` or README — not in the OS kit. Multi-phase products: `docs/roadmap.md` for phase order; phased implement procedure in the `plan-then-implement` skill — do not copy Closeout rules here. Model names belong in task plans, not in this file.

## External worker (optional)

- DeepSeek MCP worker: TODO no (default) | yes
- If no: Composer only; do not call `deepseek_code`
- If yes: bulk codegen via `deepseek-worker`; no secrets in worker context. Default no unless this repo’s `AGENTS.md` or your org’s `products.md` says otherwise.
