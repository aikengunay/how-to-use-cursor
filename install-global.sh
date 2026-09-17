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

mkdir -p "$DEST"

for skill in "${SKILLS[@]}"; do
  src="$ROOT/skills/$skill"
  if [[ ! -f "$src/SKILL.md" ]]; then
    echo "missing $src/SKILL.md" >&2
    exit 1
  fi
  rm -rf "$DEST/$skill"
  cp -R "$src" "$DEST/$skill"
  echo "installed $skill -> $DEST/$skill"
done
