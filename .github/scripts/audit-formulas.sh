#!/usr/bin/env bash

set -euo pipefail

readonly TAP="lcmen/extra"

repository_root="$(git rev-parse --show-toplevel)"
cd "$repository_root"

formulas=()

for formula_path in Formula/*.rb; do
  formulas+=("${TAP}/$(basename "$formula_path" .rb)")
done

brew audit --formula --strict "${formulas[@]}"
