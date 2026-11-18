---
name: type-system
description: >-
  Builds a product or marketing type scale with line height and letter spacing
  rules. Use when defining heading and paragraph tokens, responsive type, or
  when the user mentions type scale, line height, or Figma Academy typography.
---

# Type system

Define a small reusable set of text styles. Numbers are starting points — adjust on a real screen. Record final tokens in the product’s `DESIGN.md`.

Source method: Figma Academy — typography system.

## When to stop

One-off font-size tweaks in a single component, or work that only applies an existing token map — skip this skill.

## Scale and base

- **Base size:** 16px (shared anchor for body and mid headings).
- **Multiplier:** **1.2** for products (web apps, admin). **1.33** for marketing sites.
- **Grid:** round every font size to the **nearest 4px**.

Build H1–H5 and P1–P3 (or your naming) from the scale. Overlap roles on purpose so pages use fewer distinct sizes:

| Shared size | Typical roles |
| --- | --- |
| 20px | H3 + P1 |
| 16px | H4 + P2 (base) |
| 14px | H5 + P3 |

Exact pixel steps depend on the multiplier; recompute with [type-scale.com](https://type-scale.com) or equivalent, then round.

## Line height

Round results to the nearest 4px (headings usually round **down** for a tighter block).

| Role | Rule |
| --- | --- |
| Headings | font size × **1.2** (about 110–120%) |
| Paragraphs | font size × **1.5** (about **1.4** on mobile when vertical space is tight) |
| Buttons and single-line labels | **1.0** (no wrap; centers in controls) |

## Letter spacing

Ordinary UI fonts only — decorative faces need per-font tuning.

| Role | Rule |
| --- | --- |
| Headings | about **−2%** |
| Paragraphs | default (0); do not track paragraphs for “style” |
| Single-line UI labels | default unless design explicitly needs otherwise |

Do **not** add all-caps label styles in the kit — sentence case is the default in this OS.

## Breakpoints

- Maintain **one set for web** and **one for mobile** at minimum.
- Add **tablet** only when the product and team need a third density — not by default.

Map the same semantic roles (H1…, P1…) across breakpoints; change size and line height, not role names.

## Workflow

1. Pick scale (1.2 vs 1.33) and base 16px from the product surface (app vs marketing).
2. Generate sizes, round to 4px, assign H/P roles with shared sizes at 20 / 16 / 14 where possible.
3. Set line height per role table; loosen paragraph line height slightly on mobile if needed.
4. Apply heading letter spacing only.
5. Write font family, scale, sizes, line heights, and breakpoints into **`DESIGN.md`** in the product repo. Font choice belongs there, not in this skill.

## Checks

- More than one arbitrary px size for the same role on one breakpoint = consolidate.
- Paragraph line height below 1.4 on long copy = readability risk.
- Buttons with line height > 1.0 and wrapped label text = reset to 1.0 or fix copy.