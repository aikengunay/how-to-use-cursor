#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
export DEEPSEEK_API_KEY_FILE="${DEEPSEEK_API_KEY_FILE:-${HOME}/.config/deepseek/api_key}"
export PYTHONUNBUFFERED=1
exec "${ROOT}/.venv/bin/python" "${ROOT}/server.py"
