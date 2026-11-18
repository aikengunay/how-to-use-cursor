# How to use Cursor

This folder is the source of truth for a small **Cursor operating system**: how the agent should work on every project. It is not a giant project dump and it does not replace product-specific rules already in a real app.

## Onboarding (new machine)

1. **Clone** this repo.
2. **User Rules** — paste [`user-rules.md`](user-rules.md) once in Cursor Settings → Rules → User Rules (append to your existing git/PR rules).
3. **Skills** — `chmod +x install-global.sh && ./install-global.sh`. Add `--design` if you build UI (installs color and type skills).
4. **Thermos** — install from the Cursor marketplace (on-review only).
5. **Optional:** [Mobbin MCP](design-with-agents.md), [DeepSeek worker](deepseek-worker-setup.md).
6. **Named products** — if you work on repos listed in [`products.md`](products.md), read that file for delivery lens, existing-repo guardrails, and worker defaults.

```
Layer 1  You            User Rules + personal skills + Thermos plugin   every project
Layer 2  This project   AGENTS.md and/or .cursor/rules / .cursorrules     this repo
Layer 3  On demand      named skills, Plan mode, Thermos, deepseek-worker   this task
```

Nothing else to install for the default OS. Optional DeepSeek worker is extra — see below. Do not add Pocock, shadcn/improve, or a skills.sh bundle. **Scan** any other GitHub skill with [SkillSpector](https://github.com/NVIDIA/SkillSpector) before installing.

### Prose slop vs code slop

Three layers — do not mix them:

| Layer | Tool | Where |
|---|---|---|
| UI look/behavior | Product `.cursor/rules` (e.g. chat-ui-identity) | `@` rules on UI tasks |
| Client prose | `no-ai-slop` | After **you** wrote a rough draft |
| Generated code | `simplify-ai-slop` | After a big Agent generation |

Workflow for client-facing text: human outline first → `/no-ai-slop` → you manually polish the last pass. Do not run `no-ai-slop` on `.cursor/rules`, code comments, or narrow domain rules in personal tooling repos — see [`products.md`](products.md).

### Client delivery lens

Shadow before automate, ship the smallest slice, wrap what builds trust. Full wording and worker defaults for client repos: [`products.md`](products.md).

### Mobile QA (product repos, not this kit)

Repeatable mobile checks belong in **each app repo** — not in this OS kit.

| Layer | Tool | Where |
|---|---|---|
| Web UI on desktop | Browser MCP | Agent chat |
| Mobile regression (repeat before ship) | [Maestro](https://maestro.mobile.dev/) CLI (free, local) | `maestro/flows/` in that product repo |
| How to run | `AGENTS.md` → verify section | That product repo |

Do not add Maestro flows here. When a repo gains mobile users, add flows there and document the command in its `AGENTS.md`.

## 1. One-time global install

### User Rules (you paste)

Cursor does not auto-load this file. Open **Cursor Settings → Rules → User Rules**, keep your existing git / PR / browser-verify rules, and **append** the contents of [`user-rules.md`](user-rules.md). If you pasted an older copy, replace **only** the Cursor OS block with the current file.

### Skills

```bash
chmod +x install-global.sh
./install-global.sh
```

Copies `grill-requirements`, `codebase-architecture`, `simplify-ai-slop`, `plan-then-implement`, `no-ai-slop`, and `deepseek-worker`. Cloudflare skills stay. Use `./install-global.sh --design` to also install `color-system-hsb` and `type-system`.

After updating a vendored skill from upstream, run `./install-external-skills.sh` — SkillSpector scan, then re-copy via `install-global.sh`.

### Optional: DeepSeek worker

Cost mode, **opt-in per task**. Fresh machine: [`deepseek-worker-setup.md`](deepseek-worker-setup.md). Daily prompt: [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md). Default-off repos: [`products.md`](products.md).

### Thermos

Installed from the Cursor marketplace (plugin by Cursor). Skills it adds stay off until a review. You do not copy Thermos into repos.

### Edit here, re-copy

Change a skill here, then re-run `./install-global.sh`. Change User Rules here, then re-paste that block in Settings.

## 2. New project

1. Copy [`project-stub/AGENTS.md`](project-stub/AGENTS.md) to the repo root. If the app has UI, copy [`project-stub/DESIGN.md`](project-stub/DESIGN.md) too.
2. Fill every `TODO`. Delete sections that do not apply. Keep it short.
3. Add 2–5 **product** rules only if this app has locks the agent always gets wrong (streaming/HLS, chat chrome, portal split, etc.). Do not copy another product’s full rule folder into a new app.
4. New Agent chat. Point at `AGENTS.md` (and `DESIGN.md` when relevant).

Do not copy this `how-to-use-cursor` folder into the new repo. Do not copy the six skills or Thermos into the project.

## 3. Existing project (real apps)

Layer 1 already applies when you open the repo. You do **not** install Thermos or skills again there.

**Do not revise** a working `.cursor/rules` set to “make room” for this OS. Product locks stay; global OS rules stack on top.

Repos that already have handbooks, optional `AGENTS.md` patterns, and per-product examples: [`products.md`](products.md) → **Existing repos**.

**How to tell Cursor in that repo:** open a **new** Agent chat there and paste [`existing-project-prompt.md`](existing-project-prompt.md). Do not ask it to install plugins or copy this kit.

## 4. Day to day

- **Start a task** — [`user-rules.md`](user-rules.md) → First message template (one-off vs phased pointer). Phased implement procedure: [`skills/plan-then-implement/SKILL.md`](skills/plan-then-implement/SKILL.md) only — Closeout, todos, roadmap tick, After final gate.
- **New Agent chat per task.**
- **Plan mode** for medium or large work. Skip it for typos, renames, and small CSS.
- **Models:** [`model-routing.md`](model-routing.md) — Composer vs DeepSeek vs Grok vs Claude. Per-slice picker: task plan **Model (do not paste)** bullets. Bulk implement (cost mode): [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md). Toggles + pools: `user-rules.md` → Model picker.
- **Grill** vague features (`grill-requirements`). **Architecture** for “where does this live?”
- **Simplify code** after a big generation (`simplify-ai-slop`). **Clean prose** after you draft client copy (`no-ai-slop`).
- **Mobile QA** — browser MCP for web; Maestro flows in the product repo before ship (see above).
- **Thermos** only on merge-ready / PR / “review this branch.” One review tool per review chat (do not also fire Bugbot unless you want a second pass).
- **UI** — click the flow. One screenshot is not done. Look: [`design-with-agents.md`](design-with-agents.md) (Mobbin + tokens; galleries in [`design-references.md`](design-references.md)). Shell and CSS stay on Composer unless the plan already lists grid, type, and what not to copy. DeepSeek does not see Mobbin.

### Adopt an external repo

Found a GitHub repo or skill pack? Open a **new** Agent chat and paste [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md). Run [SkillSpector](https://github.com/NVIDIA/SkillSpector) before any `npx skills add` or global install.

## 5. Do not add

- Community skill packs (scan with [SkillSpector](https://github.com/NVIDIA/SkillSpector) first if you must try one)
- Always-on Plan mode, Thermos, subagents, or loops
- This kit copied into product repos
- Rewriting a product’s mature rules to match the stub — see [`products.md`](products.md)

## Files

| Path | Role |
|---|---|
| [`user-rules.md`](user-rules.md) | Paste into Cursor User Rules |
| [`model-routing.md`](model-routing.md) | When to use Composer vs DeepSeek vs Grok vs Other models |
| [`products.md`](products.md) | Named repos: client lens, existing-repo list, DeepSeek default-off |
| [`skills/`](skills/) | Source for the six OS skills (`no-ai-slop` vendored from [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop)) |
| [`design-skills/`](design-skills/) | Opt-in color and type skills (`--design` on install) |
| [`deepseek-worker-setup.md`](deepseek-worker-setup.md) | Fresh-machine + MCP setup for optional DeepSeek worker |
| [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) | Cost-mode start prompt + session cost report |
| [`deepseek-mcp-server/`](deepseek-mcp-server/) | MCP server source (`install.sh` → `~/.cursor/deepseek-mcp-server`) |
| [`skills/deepseek-worker/`](skills/deepseek-worker/) | On-demand cost-mode routing skill |
| [`install-global.sh`](install-global.sh) | Copies OS skills to `~/.cursor/skills/` |
| [`install-external-skills.sh`](install-external-skills.sh) | SkillSpector scan + re-run `install-global.sh` |
| [`project-stub/AGENTS.md`](project-stub/AGENTS.md) | Thin identity file for a new repo |
| [`project-stub/DESIGN.md`](project-stub/DESIGN.md) | Visual lock stub for new UI products |
| [`existing-project-prompt.md`](existing-project-prompt.md) | Paste into an existing app's Agent chat |
| [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md) | Paste when evaluating a GitHub repo or skill pack |
| [`design-with-agents.md`](design-with-agents.md) | Mobbin, tokens, who implements look, optional oil-ui or superdesign-skill |
| [`design-references.md`](design-references.md) | Gallery and tool bookmarks — not skills |