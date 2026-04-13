#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <tag>" >&2
  echo "example: $0 v0.1.0" >&2
  exit 1
fi

tag="$1"
version="${tag#v}"

if [[ "${tag}" == "${version}" ]]; then
  echo "tag must start with 'v' (got: ${tag})" >&2
  exit 1
fi

awk -v version="${version}" '
BEGIN { in_section=0; found=0 }
$0 ~ ("^## \\[" version "\\]") { in_section=1; found=1; next }
in_section && $0 ~ /^## \[/ { exit }
in_section { print }
END {
  if (found == 0) {
    exit 2
  }
}
' CHANGELOG.md
