# Design references (bookmarks)

Not skills. Not packages. Open these when Mobbin’s query is the wrong grain (one hero, one nav, one pricing block). Record the **decision** in the product plan. Do not commit screenshot URLs that expire.

Process: [`design-with-agents.md`](design-with-agents.md).

## Galleries

| Site | Use for |
| --- | --- |
| [Mobbin](https://mobbin.com) (MCP in Cursor) | Full screens and flows — primary |
| [godly.design](https://godly.design/) | Marketing sites, overall mood |
| [navbar.gallery](https://www.navbar.gallery/) | Top nav only |
| [cta.gallery](https://www.cta.gallery/) | Button rows and hero CTAs |
| [footer.design](https://www.footer.design/browse) | Footers only |
| [pricingpages.com](https://pricingpages.com/) | Pricing layouts (marketing), not admin tables |

## Tools (optional, after layout exists)

| Tool | Use for | Limit |
| --- | --- | --- |
| [Realtime Colors](https://www.realtimecolors.com/) | Try a palette in a fake UI | Then lock with `color-system-hsb`. Do not ship the default purple stack |
| [Haikei](https://haikei.app/) | One SVG background | Marketing only. Skip on admin |
| [motion-primitives](https://motion-primitives.com/) ([repo](https://github.com/ibelick/motion-primitives), ~6.5k stars) | Small open-source motion pieces | After the layout is good. Not a design system |
| [better-icons](https://github.com/better-auth/better-icons) | Search many icon sets via MCP/CLI | Skip if the app already uses Lucide |
| [ui.oiloil.org](https://ui.oiloil.org) | Examples for the oil-ui skill | Skill install is separate — see design-with-agents |
| [superdesign.dev](https://www.superdesign.dev) | Hosted mockup canvas | Skill is `superdesigndev/superdesign-skill`, not the old IDE repo |

## Not design systems

| Name | What it actually is |
| --- | --- |
| [dqnamo.com](https://www.dqnamo.com/) | A person’s site. Mood only |
| [superhero.com.au](https://www.superhero.com.au/) | An Australian hosting company site. Not a UI kit |
| Apple HIG | Native Apple apps. Official: [developer.apple.com/design/human-interface-guidelines](https://developer.apple.com/design/human-interface-guidelines/) |

Checked Oct 2026: the galleries and GitHub repos above resolve and match their READMEs. “Real” is not “install this into every app.”
