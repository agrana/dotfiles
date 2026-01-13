#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: backup-brew.sh [--file PATH]

Dump installed Homebrew packages, taps, and casks into a Brewfile so the
setup can be reproduced on another machine.
EOF
}

brewfile=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file)
      brewfile="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ -z "${brewfile}" ]]; then
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  brewfile="${script_dir}/Brewfile"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed or not on PATH." >&2
  exit 1
fi

brew bundle dump --file="${brewfile}" --force
