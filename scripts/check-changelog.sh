#!/usr/bin/env bash
set -euo pipefail

BASE_REF="${1:-origin/main}"
HEAD_REF="${2:-HEAD}"

changed_files="$(git diff --name-only "${BASE_REF}" "${HEAD_REF}")"

if [[ -z "${changed_files}" ]]; then
  echo "No changed files detected; changelog check skipped."
  exit 0
fi

if printf '%s\n' "${changed_files}" | grep -qx 'CHANGELOG.md'; then
  echo "CHANGELOG.md updated."
  exit 0
fi

non_docs_changes="$(printf '%s\n' "${changed_files}" | grep -Ev '^(CHANGELOG\.md|README\.adoc|CONTRIBUTING\.md|CODE_OF_CONDUCT\.md|SECURITY\.md|MAINTAINERS\.md|GOVERNANCE\.adoc|LICENSE|\.gitignore|\.github/.*)$' || true)"

if [[ -z "${non_docs_changes}" ]]; then
  echo "Docs/community-health-only change detected; CHANGELOG.md update not required."
  exit 0
fi

echo "Functional or operational changes detected without CHANGELOG.md update:" >&2
printf '%s\n' "${non_docs_changes}" >&2

echo "Update CHANGELOG.md before merge." >&2
exit 1
