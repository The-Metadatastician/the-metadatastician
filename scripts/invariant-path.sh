#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
IP_ROOT="${REPO_ROOT}/../invariant-path"

if [[ ! -d "${IP_ROOT}" ]]; then
  echo "invariant-path workspace not found at ${IP_ROOT}" >&2
  echo "Run from the shared estate clone or invoke invariant-path directly." >&2
  exit 1
fi

exec cargo run --manifest-path "${IP_ROOT}/Cargo.toml" -p invariant-path-cli -- "$@"
