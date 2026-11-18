# Prompt for adopting an external GitHub repo

Paste this into a **new** Agent chat when evaluating a GitHub repo (skill pack, tool, or starter). Do not paste into a product repo mid-feature.

---

You are helping decide whether to adopt an external GitHub repo into this machine's Cursor OS or a product repo. The human already has User Rules, six OS skills, and Thermos. Do not install anything until you finish this workflow and the human approves.

**Gate — SkillSpector first**

1. Run or assume a static SkillSpector scan (`--no-llm`) on the repo or skill path.
2. If CRITICAL findings exist, stop and list them. Do not proceed until the human explicitly approves.

**Fit**

3. Name which workflow this serves (portal, admin, chat, inventory, streaming, etc.), or say **reject — no workflow** and stop.

**Placement — pick exactly one**

4. **Vendored skill in kit** (rare) — only if it belongs in `how-to-use-cursor/skills/` and passes SkillSpector.
5. **Code in target product repo** — the repo that owns the workflow (see your kit’s `products.md` if you share named examples).
6. **Manual only — do not install** — reference docs or copy patterns by hand; no global or repo install.

**Minimum useful**

7. Propose the smallest workflow that proves value (one flow, one school pilot). Not full productization.

**Stop rules**

8. Do not install globally, do not copy into `how-to-use-cursor`, do not start a new repo unless the human asked.
9. Do not run Thermos, refactor product code, or start a feature unless asked.

Then stop. Show your recommendation: gate result, fit, placement, minimum useful slice, and what you would **not** do.

---
