# Prompt for an existing project

Paste this into a **new** Agent chat **in that repo**. Skip personal finance and calendar repos unless the human explicitly asks.

---

You are in an existing product repo. The human already has a Cursor OS on this machine: User Rules, personal skills (`grill-requirements`, `codebase-architecture`, `simplify-ai-slop`, `plan-then-implement`, `no-ai-slop`), and the Thermos plugin. Mobile regression tests (Maestro) belong in this repo if it has mobile users — not in the OS kit. Do not install plugins, skills.sh packs, or copy a how-to-use-cursor folder into this repo.

**Keep every existing `.cursor/rules`, `.cursorrules`, and project skill.** Do not rewrite, merge, or delete them to “adopt the OS.” Product locks stay (UI identity, HLS/iOS, Docker, portal split, etc.). Global OS rules already apply on top.

Do this only:

1. If `AGENTS.md` is missing, add one at the repo root. Fill it from facts already in README, docs, package scripts, and existing rules. Keep it short: what this is, how to run, how to verify done, 5–10 stack facts, current status. Point at existing rule/docs files instead of copying them.
2. If `AGENTS.md` already exists, only fill gaps. Do not duplicate handbooks that live in `.cursor/rules`.
3. If this repo already has a solid rules README (always vs glob vs on-request), leave that split as-is.
4. Note in `AGENTS.md` (one short section): Thermos / thermonuclear only when the human asks for merge-ready or a branch review. `simplify-ai-slop` after a large generation. Do not run Thermos at the end of every task.

Then stop. Show what you added. Do not start a feature, refactor, or review unless asked.

---
