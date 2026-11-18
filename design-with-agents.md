# Design with agents

How visual work fits this OS. Product look still lives in that repo’s plan or `.cursor/rules`. This file is the machine rule so agents do not treat galleries, palettes, or “design skills” as a component library.

Bookmarks: [`design-references.md`](design-references.md). Models: [`model-routing.md`](model-routing.md).

## Layers (do not mix)

| Layer | Use | Do not use for |
| --- | --- | --- |
| **Shipped UI** | Mobbin MCP (web, low limits). Record app name + what to copy + `mobbin_url`. No `image_url` in plans (links expire). | Inventing a new palette from a reel |
| **One section** | Galleries in `design-references.md` (hero, nav, CTA, footer, pricing) | “Install this site” — they are not npm packages |
| **Color lock** | Kit skill `color-system-hsb` (install with `./install-global.sh --design`). HSB primitives → semantic aliases. Write the choice in the product’s `DESIGN.md` or `decisions.md` | Pasting a Realtime Colors URL as the system |
| **Type lock** | Kit skill `type-system` (same install flag). Scale, line height, breakpoints → tokens in `DESIGN.md` | One-off px sizes per screen with no shared scale |
| **Agent design process** | **One** optional skill, after SkillSpector: [oil-ui](https://github.com/oil-oil/oil-ui) **or** [superdesign-skill](https://github.com/superdesigndev/superdesign-skill). Not both. Not a default OS skill | Replacing Mobbin or rewriting a locked UI section mid-phase |
| **Motion** | [motion-primitives](https://github.com/ibelick/motion-primitives) after layout is decided | Admin dashboards, loading the page with animation |
| **Decoration** | [Haikei](https://haikei.app/) — at most one quiet shape on a marketing page | Default blob heroes |
| **Icons** | Lucide in the app, or [better-icons](https://github.com/better-auth/better-icons) MCP if you already installed it | Treating an icon pack as a design system |
| **Copy** | `no-ai-slop` after you draft | Code, CSS, `.cursor/rules` |
| **Generated bloat** | `simplify-ai-slop` after a big generation | Taste decisions |

Apple [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) are for native Apple UI. Web admin and marketing sites follow Mobbin + the product tokens. Do not add an “Apple design skill” unless the product is iOS or macOS, and then the source is Apple’s docs, not a social-media summary.

## Who implements the look

| Job | Who |
| --- | --- |
| Search Mobbin / galleries | Cursor (MCP or browser). Never DeepSeek |
| Lock references, tokens, shell rules in the plan | Cursor, in the design chat |
| Shell, landing, login, CSS tokens | **Composer** (or you), from the locked brief |
| Bulk TS/SQL after the brief exists | DeepSeek worker is allowed |
| CSS / shell / “make it look better” with no grid, type scale, and do-not list | **Not DeepSeek.** It cannot see screenshots or Mobbin. Vague visual tasks come back as generic shadcn |

Research chat output into the build chat: **bullets + URLs**. Not image dumps.

## Optional design skill (not installed by default)

Do not `npx skills add` from a reel. New chat → [`adopt-external-repo-prompt.md`](adopt-external-repo-prompt.md) → SkillSpector `--no-llm` → you approve.

| Skill | When it fits | When it does not |
| --- | --- | --- |
| **oil-ui** | You want several **different** directions, you pick one, then the agent tightens against real screenshots. Complements Mobbin (references) with a process. | The plan already locked one direction and later phases must follow it |
| **superdesign-skill** | Greenfield marketing where you want generated mockups on a canvas, then you copy a direction into code. Product site: [superdesign.dev](https://www.superdesign.dev). The old [superdesign](https://github.com/superdesigndev/superdesign) IDE repo is **unmaintained** — do not install that extension from the README | A product whose UI direction is already written. It will invent a second system |

Install at most one. Two design skills both claim “design this UI” and fight.

## Abuse (these are real tools used badly)

- Gallery sites (Godly, footer, CTA, navbar, pricing) are **inspiration**, not dependencies.
- Realtime Colors is a **preview**. Lock colors with `color-system-hsb`.
- Haikei and motion-primitives do not fix a bad layout.
- A skill that says it ships Stripe-quality UI from one prompt is the claim to ignore. Stars and a README mean the repo exists. They do not mean the output matches your product.
