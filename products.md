# Product repos this kit sits beside

Keep product names in each product repo. This file stays generic. Do not paste it into a product repo unless it helps onboarding.

## Client delivery lens

Shadow before automate, ship the smallest slice, wrap what builds trust:

- **Shadow:** Observe one real user path before automating.
- **Minimum useful:** Smallest shippable slice — one flow, one pilot.
- **Wrapper:** What creates client trust — runbooks, offline fallback, logs, export, plain-language docs (`no-ai-slop` for client-facing text).
- **Where it lives:** Wrapper docs and Maestro flows in **product** `AGENTS.md` / `docs/`, not this kit.
- **External worker:** default **no** on personal finance, calendar, and client product repos. Composer only unless the human enables DeepSeek.

## Existing repos — do not clobber rules

Layer 1 (User Rules, personal skills, Thermos) already applies when you open the repo. You do **not** install Thermos or skills again there.

**Do not revise** a working `.cursor/rules` set to “make room” for this OS. They stack:

| Layer | Who owns it | Example |
|---|---|---|
| Global User Rules + 6 skills + Thermos | This kit / your machine | Verify, plan vs implement, review, prose/code slop, optional DeepSeek worker |
| Repo rules / `.cursorrules` | That product | Chat UI, video playback, portal split |
| `AGENTS.md` | Optional index | How to run, how to verify, 5 stack facts |

**Skip filling a stub when identity already exists and is enough:**

- Personal domain repos (finance, calendar) — leave their rules.
- A product that already has `.cursor/rules` — optional: add a short `AGENTS.md` that **points at** README + `.cursor/rules/README.md`. Do not duplicate those handbooks.
- A product that already has `.cursorrules` — optional: add `AGENTS.md` for run/verify; **keep** the existing `.cursorrules`.

**How to tell Cursor in that repo:** open a **new** Agent chat there and paste [`existing-project-prompt.md`](existing-project-prompt.md). Do not ask it to install plugins or copy this kit.

## DeepSeek worker — default off

Do **not** enable the DeepSeek MCP worker on these unless the human explicitly says so:

- Personal finance repos
- Personal calendar repos
- Client product repos (portal, chat, inventory, streaming, and the like)

Never send `.env` or secrets in worker context. Per-repo override belongs in that repo’s `AGENTS.md`.

## Kit housekeeping

- **Prose slop:** Do not run `no-ai-slop` on `.cursor/rules`, code comments, or finance/calendar domain rules — only client-facing drafts you wrote.
- **Mobile QA:** Maestro flows live in product repos under `maestro/flows/`, not in this kit.
- **New project examples:** Product rules might cover video playback, chat UI, or a portal split — copy only what fits the new app; do not paste another product’s full rule folder.
- **Do not:** Rewrite an existing product’s rules to match the kit stub.

## Adopt external repo — fit examples

When pasting [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md), workflow fit might be a portal, an admin screen, chat, inventory, and so on. Placement for code usually means the repo that owns that workflow.
