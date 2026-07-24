#!/usr/bin/env bash

set -euo pipefail

readonly TAP="lcmen/extra"
readonly OUTPUT_DIR="api/formula"

repository_root="$(git rev-parse --show-toplevel)"
cd "$repository_root"

mkdir -p "$OUTPUT_DIR"

for formula_path in Formula/*.rb; do
  name="$(basename "$formula_path" .rb)"
  output_path="${OUTPUT_DIR}/${name}.json"
  temporary_path="$(mktemp "${TMPDIR:-/tmp}/${name}.json.XXXXXX")"
  tap_git_head="$(git log -1 --format=%H -- "$formula_path")"

  brew info --json=v2 --variations "${TAP}/${name}" |
    jq --exit-status \
      --arg tap_git_head "$tap_git_head" \
      '
        if (.formulae | length) != 1 or (.casks | length) != 0 then
          error("expected exactly one formula and no casks")
        else
          .formulae[0]
        end
        | .tap_git_head = $tap_git_head
        | .installed = []
        | .linked_keg = null
        | .pinned = false
        | .outdated = false
      ' > "$temporary_path"

  expected_checksum="$(
    git show "${tap_git_head}:${formula_path}" |
      shasum -a 256 |
      awk '{print $1}'
  )"
  recorded_checksum="$(
    jq --raw-output '.ruby_source_checksum.sha256' "$temporary_path"
  )"

  if [[ "$recorded_checksum" != "$expected_checksum" ]]; then
    echo >&2 \
      "${name}: Ruby source checksum does not match ${formula_path} at ${tap_git_head}"
    rm -f "$temporary_path"
    exit 1
  fi

  jq --sort-keys '.' "$temporary_path" > "$output_path"
  rm -f "$temporary_path"
done
