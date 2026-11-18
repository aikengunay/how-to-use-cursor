#!/usr/bin/env bash
# Re-scan vendored skills with SkillSpector, then install via install-global.sh.
# Run from how-to-use-cursor/ after updating skills/no-ai-slop from upstream.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SCAN_VENV="${ROOT}/.tmp-skills-scan/SkillSpector/.venv"

ensure_skillspector() {
  if [[ -x "${SCAN_VENV}/bin/skillspector" ]]; then
    return
  fi
  echo "Setting up SkillSpector (one-time)..." >&2
  mkdir -p "${ROOT}/.tmp-skills-scan"
  if [[ ! -d "${ROOT}/.tmp-skills-scan/SkillSpector/.git" ]]; then
    git clone --depth 1 https://github.com/NVIDIA/SkillSpector.git "${ROOT}/.tmp-skills-scan/SkillSpector"
  fi
  python3 -m venv "${SCAN_VENV}"
  "${SCAN_VENV}/bin/pip" install -q -e "${ROOT}/.tmp-skills-scan/SkillSpector"
}

ensure_skillspector

for skill_dir in "${ROOT}"/skills/*/ "${ROOT}"/design-skills/*/; do
  if [[ -f "${skill_dir}/SKILL.md" ]]; then
    echo "Scanning ${skill_dir}..." >&2
    "${SCAN_VENV}/bin/skillspector" scan "${skill_dir}" --no-llm
  fi
done

DESIGN_ARGS=()
if [[ -d "${ROOT}/design-skills" ]] && compgen -G "${ROOT}/design-skills/*/SKILL.md" >/dev/null; then
  DESIGN_ARGS=(--design)
fi

"${ROOT}/install-global.sh" "${DESIGN_ARGS[@]}"
