# How to use Cursor

This folder is the source of truth for a small **Cursor operating system**: how the agent should work on every project. It is not a giant project dump and it does not replace product-specific rules already in a real app.

Live install (this machine — already done if you followed the steps):

- **User Rules** — paste [`user-rules.md`](user-rules.md) once in Cursor Settings
- **Personal skills** — six OS skills in `~/.cursor/skills/`
- **Thermos plugin** — Cursor marketplace, on-review only
- **Project stub** — [`project-stub/AGENTS.md`](project-stub/AGENTS.md) only when a repo has no identity file

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

Workflow for client-facing text: human outline first → `/no-ai-slop` → you manually polish the last pass. Do not run `no-ai-slop` on `.cursor/rules`, code comments, or finance/calendar domain rules.

### Client delivery lens

Shadow before automate, ship the smallest slice, wrap what builds trust:

- **Shadow:** Observe one real user path (admin captive login, teacher portal, chat join) before automating.
- **Minimum useful:** Smallest shippable slice — one flow, one school pilot.
- **Wrapper:** What creates client trust — runbooks, offline fallback, logs, export, plain-language docs (`no-ai-slop` for client-facing text).
- **Where it lives:** Wrapper docs and Maestro flows in **product** `AGENTS.md` / `docs/`, not this kit.
- **External worker:** default **no** on personal finance, calendar, and client product repos. Composer only unless the human enables DeepSeek.

### Mobile QA (product repos, not this kit)

Repeatable mobile checks belong in **each app repo** — not in this OS kit.

| Layer | Tool | Where |
|---|---|---|
| Web UI on desktop | Browser MCP | Agent chat |
| Mobile regression (repeat before ship) | [Maestro](https://maestro.mobile.dev/) CLI (free, local) | `maestro/flows/` in the product repo |
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

Copies `grill-requirements`, `codebase-architecture`, `simplify-ai-slop`, `plan-then-implement`, `no-ai-slop`, and `deepseek-worker`. Cloudflare skills stay.

After updating a vendored skill from upstream, run `./install-external-skills.sh` — SkillSpector scan, then re-copy via `install-global.sh`.

### Optional: DeepSeek worker

Cost mode, **opt-in per task**. Fresh machine or this Mac: [`deepseek-worker-setup.md`](deepseek-worker-setup.md). Daily prompt: [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md).

### Thermos

Installed from the Cursor marketplace (plugin by Cursor). Skills it adds stay off until a review. You do not copy Thermos into repos.

### Edit here, re-copy

Change a skill here, then re-run `./install-global.sh`. Change User Rules here, then re-paste that block in Settings.

## 2. New project

1. Copy [`project-stub/AGENTS.md`](project-stub/AGENTS.md) to the repo root.
2. Fill every `TODO`. Delete sections that do not apply. Keep it short.
3. Add 2–5 **product** rules only if this app has locks the agent always gets wrong (example: video playback on iOS). Do not copy another product’s full rule folder into a new app.
4. New Agent chat. Point at `AGENTS.md`.

Do not copy this `how-to-use-cursor` folder into the new repo. Do not copy the six skills or Thermos into the project.

## 3. Existing project (real apps)

Layer 1 already applies when you open the repo. You do **not** install Thermos or skills again there.

**Do not revise** a working `.cursor/rules` set to “make room” for this OS. They stack:

| Layer | Who owns it | Example |
|---|---|---|
| Global User Rules + 6 skills + Thermos | This kit / this machine | Verify, plan vs implement, review, prose/code slop, optional DeepSeek worker |
| Repo rules / `.cursorrules` | That product | Chat UI, video playback, portal split |
| `AGENTS.md` | Optional index | How to run, how to verify, 5 stack facts |

**Skip filling a stub when identity already exists and is enough:**

- Personal domain repos (finance, calendar) — leave their rules.
- A product that already has `.cursor/rules` — optional: add a short `AGENTS.md` that **points at** README + `.cursor/rules/README.md`. Do not duplicate those handbooks.
- A product that already has `.cursorrules` — optional: add `AGENTS.md` for run/verify; **keep** the existing `.cursorrules`.

**How to tell Cursor in that repo:** open a **new** Agent chat there and paste [`existing-project-prompt.md`](existing-project-prompt.md). Do not ask it to install plugins or copy this kit.

## 4. Day to day

- **Start a task** — [`user-rules.md`](user-rules.md) → First message template. Phased work: set picker from **Model (do not paste)**, paste Goal/Files/Verify/**Closeout**/Out of scope; agent marks slice todos done before stopping. After final gate: optional Thermos — plan **After final gate** section.
- **New Agent chat per task.**
- **Plan mode** for medium or large work. Skip it for typos, renames, and small CSS.
- **Models:** [`model-routing.md`](model-routing.md) — when Composer vs DeepSeek vs Grok vs Claude; role first (Plan → thinking; implement → **Composer Fast on**; stuck → **Grok High Fast off**). Per-slice overrides live in the plan’s **Model (do not paste)** bullets — not in product `AGENTS.md`. Bulk implement (cost mode, opt-in) → paste [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md). Toggles + pools → `user-rules.md` → Model picker. Detailed-plan template: [`skills/plan-then-implement/SKILL.md`](skills/plan-then-implement/SKILL.md).
- **Grill** vague features (`grill-requirements`). **Architecture** for “where does this live?”
- **Simplify code** after a big generation (`simplify-ai-slop`). **Clean prose** after you draft client copy (`no-ai-slop`).
- **Mobile QA** — browser MCP for web; Maestro flows in the product repo before ship (see above).
- **Thermos** only on merge-ready / PR / “review this branch.” One review tool per review chat (do not also fire Bugbot unless you want a second pass).
- **UI** — click the flow. One screenshot is not done.

### Adopt an external repo

Found a GitHub repo or skill pack? Open a **new** Agent chat and paste [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md). Run [SkillSpector](https://github.com/NVIDIA/SkillSpector) before any `npx skills add` or global install.

## 5. Do not add

- Community skill packs (scan with [SkillSpector](https://github.com/NVIDIA/SkillSpector) first if you must try one)
- Always-on Plan mode, Thermos, subagents, or loops
- This kit copied into product repos
- Rewriting a product’s rules to match the stub

## Files

| Path | Role |
|---|---|
| [`user-rules.md`](user-rules.md) | Paste into Cursor User Rules |
| [`model-routing.md`](model-routing.md) | When to use Composer vs DeepSeek vs Grok vs Other models |
| [`skills/`](skills/) | Source for the six OS skills (`no-ai-slop` vendored from [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop)) |
| [`deepseek-worker-setup.md`](deepseek-worker-setup.md) | Fresh-machine + MCP setup for optional DeepSeek worker |
| [`deepseek-worker-prompt.md`](deepseek-worker-prompt.md) | Cost-mode start prompt + session cost report |
| [`deepseek-mcp-server/`](deepseek-mcp-server/) | MCP server source (`install.sh` → `~/.cursor/deepseek-mcp-server`) |
| [`skills/deepseek-worker/`](skills/deepseek-worker/) | On-demand cost-mode routing skill |
| [`install-global.sh`](install-global.sh) | Copies OS skills to `~/.cursor/skills/` |
| [`install-external-skills.sh`](install-external-skills.sh) | SkillSpector scan + re-run `install-global.sh` |
| [`project-stub/AGENTS.md`](project-stub/AGENTS.md) | Thin identity file for a new repo |
| [`existing-project-prompt.md`](existing-project-prompt.md) | Paste into an existing app's Agent chat |
| [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md) | Paste when evaluating a GitHub repo or skill pack |
