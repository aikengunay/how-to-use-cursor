---
name: color-system-hsb
description: >-
  Builds or rewrites UI color primitives in HSB (hue, saturation, brightness),
  then aliases semantic tokens. Use when creating a brand palette, retuning
  neutrals, dropping unused accent scales, rebranding `_variables.scss`
  primitives, or when the user mentions HSB, neutrals inheriting primary hue,
  or Figma Academy color lessons.
---

# Color system (HSB)

Build primitives in HSB. Alias semantics. Do not rename tokens in an existing codebase.

Source method: Figma Academy — brand palette, themeable neutrals, interface palette, semantic variables.

## When to stop

Typos, one-line remaps of an existing alias, or chat work that only touches component SCSS — skip this skill.

## Workflow

1. **Brand hue first.** Pick primary in HSB. Keep sibling brand hues within ~10 S and ~10 B of each other.
2. **Light and dark shades per brand hue.** Not a nine-step ramp. One light and one dark per hue.
   - **Light:** keep hue; brightness near 99; saturation about 5–10.
   - **Dark:** keep saturation; brightness near 50; adjust by eye.
   - **Contrast:** dark text on the light shade must clear **7:1** (AAA). If a hue cannot (yellow often lands near 5:1 at brightness 50), keep that yellow as accent or border, not body text on the light fill.
3. **Neutrals inherit the brand hue.** Same H on every gray step. Choose an S range (~1–20 typical; darker steps more sat). **S = 0** if brand is white / near-black / no hue.
4. **Neutrals in light and dark pairs.** Think high contrast and low contrast, not “dark theme only.” For each job, pick a step on each end of the scale:
   - **Text:** strong at the scale ends (AAA headings); subtle at **≥ 4.5:1**; inactive at **≥ 3:1**.
   - **Backgrounds:** three stacked surfaces from each end (e.g. light: white → 100 → 200; dark: 950 → 900 → 800 — exact steps come from the screen).
   - **Borders:** three levels one step inward from backgrounds — subtle (inactive cards), base (controls), strong (hover). Reuse the higher-contrast background fill as **border-subtle** on the middle surface so contrast stays consistent.
   - **Icons:** high at the ends; mid aligns with AA text; low contrast flips the light/dark pair (e.g. 600 vs 400).
   Trust the screen over the generator.
5. **Interface ≠ brand.** Success, warning, error must separate from brand hues visually.
   - Free hues: build green / yellow / red in the same ~10-point S and B band as brand accents. Drop green brightness by ~20 because green reads light.
   - Brand already has yellow or green: reuse for warning or success.
   - Brand already has red: push error saturation more than **10 points** or shift hue until error is obvious; do not invent a duplicate red in the brand band.
   - Check status like brand: dark text on the light status fill **above 7:1**.
   Drop unused brand scales after a rebrand. Keep green / yellow / red for interface semantics.
6. **Semantic structure.** Four categories: **background**, **border**, **text**, **icon**. Name **element-first** (`text-subtle`, `bg-base`, not only surface-first). Share a short attribute list across categories: base, secondary, subtle, inactive, brand, accent, plus success / warning / error. Start at the **semantic** layer (alias primitives or hex); add a component-specific token only when a real atom needs it. **Add a token only when a screen shows the gap** — ship a small MVP set and grow it.
7. **Record the product choice** in that repo’s `DESIGN.md` or `decisions.md` (hue, S range, which scales exist, light/dark or single mode). Do not copy another product’s hex.

## In code

- Remap `--text-*` / `--bg-*` / `--border-*` (or your stack’s equivalent). **Do not rename** existing CSS custom properties in a live codebase. **Do not** point components at raw primitives like `--color-blue-500`.

## Checks

- Two gray families with different hues on the same page = leftover parent brand. Converge or delete one.
- Unused primitive scales with no semantic aliases = delete.
- Page chrome on S = 0 and cards on a tinted neutral = the neutrals still believe the old primary.
- Status toast colors that blend into brand CTAs = fix separation before shipping.

## Out of scope for this skill

Figma variable scoping, library publishing, and picker configuration — use your design tool’s docs; the semantic naming rules above still apply in code tokens.