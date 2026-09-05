#!/usr/bin/env bash
# Install third-party skills after SkillSpector scan. Run from how-to-use-cursor/.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.cursor/skills"
SCAN_VENV="${ROOT}/.tmp-skills-scan/SkillSpector/.venv"
PHONE_HOME="${HOME}/.phone-harness"

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

scan_skill() {
  local path="$1"
  echo "Scanning ${path}..." >&2
  "${SCAN_VENV}/bin/skillspector" scan "${path}" --no-llm
}

install_no_ai_slop() {
  local src="${ROOT}/skills/no-ai-slop"
  if [[ ! -f "${src}/SKILL.md" ]]; then
    echo "missing ${src}/SKILL.md" >&2
    exit 1
  fi
  scan_skill "${src}"
  rm -rf "${DEST}/no-ai-slop"
  cp -R "${src}" "${DEST}/no-ai-slop"
  echo "installed no-ai-slop -> ${DEST}/no-ai-slop"
}

install_phone_harness() {
  mkdir -p "${ROOT}/.tmp-skills-scan"
  if [[ ! -d "${ROOT}/.tmp-skills-scan/phone-harness/.git" ]]; then
    git clone --depth 1 https://github.com/ShawnPana/phone-harness.git "${ROOT}/.tmp-skills-scan/phone-harness"
  fi

  echo "" >&2
  echo "phone-harness full-repo scan (expect CRITICAL from intentional exec() in the CLI):" >&2
  scan_skill "${ROOT}/.tmp-skills-scan/phone-harness" || true

  echo "" >&2
  echo "phone-harness SKILL.md scan:" >&2
  scan_skill "${ROOT}/.tmp-skills-scan/phone-harness/SKILL.md"

  if [[ ! -d "${PHONE_HOME}/.git" ]]; then
    cp -R "${ROOT}/.tmp-skills-scan/phone-harness" "${PHONE_HOME}"
  fi
  python3 -m pip install -q -e "${PHONE_HOME}"
  mkdir -p "${DEST}/phone-harness"
  phone-harness skill > "${DEST}/phone-harness/SKILL.md"
  echo "installed phone-harness CLI -> ${PHONE_HOME}"
  echo "installed phone-harness skill -> ${DEST}/phone-harness/SKILL.md"
  echo "" >&2
  echo "Next: grant iPhone Mirroring permissions and run: phone-harness --doctor" >&2
}

mkdir -p "${DEST}"
ensure_skillspector
install_no_ai_slop
install_phone_harness
