#!/usr/bin/env bash
set -euo pipefail

required=(
  README.adoc
  LICENSE
  SECURITY.md
  CONTRIBUTING.md
  CODE_OF_CONDUCT.md
  MAINTAINERS.md
  GOVERNANCE.adoc
  CHANGELOG.md
)

missing=0
for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "missing required file: $f" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

if grep -R -nE "\b(TODO|TBD|To be added)\b" README.adoc CONTRIBUTING.md GOVERNANCE.adoc MAINTAINERS.md SECURITY.md CODE_OF_CONDUCT.md CHANGELOG.md >/dev/null; then
  echo "placeholder content detected (TODO/TBD/To be added)." >&2
  grep -R -nE "\b(TODO|TBD|To be added)\b" README.adoc CONTRIBUTING.md GOVERNANCE.adoc MAINTAINERS.md SECURITY.md CODE_OF_CONDUCT.md CHANGELOG.md || true
  exit 1
fi

echo "documentation baseline validation passed"
