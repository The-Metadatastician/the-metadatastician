set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default: validate

validate:
    ./scripts/validate-docs.sh

invariant-path *ARGS:
    ./scripts/invariant-path.sh {{ARGS}}
