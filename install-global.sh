#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.cursor/skills"
SKILLS=(
  grill-requirements
  codebase-architecture
  simplify-ai-slop
  plan-then-implement
  no-ai-slop
  deepseek-worker
)
DESIGN_SKILLS=(
  color-system-hsb
  type-system
)

PERSONAL_SKILLS=(
  ui-anti-slop
)

INSTALL_DESIGN=0
INSTALL_PERSONAL=0
for arg in "$@"; do
  case "$arg" in
    --design) INSTALL_DESIGN=1 ;;
    --personal) INSTALL_PERSONAL=1 ;;
    *)
      echo "unknown option: $arg" >&2
      echo "usage: $0 [--design] [--personal]" >&2
      exit 1
      ;;
  esac
done

install_skill() {
  local skill="$1"
  local src="$2"
  if [[ ! -f "$src/SKILL.md" ]]; then
    echo "missing $src/SKILL.md" >&2
    exit 1
  fi
  rm -rf "$DEST/$skill"
  cp -R "$src" "$DEST/$skill"
  echo "installed $skill -> $DEST/$skill"
}

mkdir -p "$DEST"

for skill in "${SKILLS[@]}"; do
  install_skill "$skill" "$ROOT/skills/$skill"
done

if [[ "$INSTALL_DESIGN" -eq 1 ]]; then
  for skill in "${DESIGN_SKILLS[@]}"; do
    install_skill "$skill" "$ROOT/design-skills/$skill"
  done
fi

if [[ "$INSTALL_PERSONAL" -eq 1 ]]; then
  for skill in "${PERSONAL_SKILLS[@]}"; do
    install_skill "$skill" "$ROOT/personal-skills/$skill"
  done
fi