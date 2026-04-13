set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default: validate

validate:
    ./scripts/validate-docs.sh

invariant-path *ARGS:
    ./scripts/invariant-path.sh {{ARGS}}

changelog-check BASE="origin/main" HEAD="HEAD":
    ./scripts/check-changelog.sh {{BASE}} {{HEAD}}

release-notes TAG:
    ./scripts/release-notes-from-changelog.sh {{TAG}}
