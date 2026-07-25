#!/usr/bin/env bash

set -euo pipefail

readonly TAP="${HOMEBREW_TAP:-lcmen/extra}"

if [[ "$#" -ne 2 ]]; then
  echo "Usage: $0 <formula> <bottle-root-url>" >&2
  exit 1
fi

readonly formula_name="$1"
readonly bottle_root_url="$2"
readonly formula_ref="${TAP}/${formula_name}"

brew trust --tap "$TAP"
brew install --build-bottle "$formula_ref"
brew test "$formula_ref"
brew linkage --test "$formula_ref"
brew bottle --json --root-url="$bottle_root_url" "$formula_ref"

shopt -s nullglob
bottle_metadata=("${formula_name}"--*.bottle.json)

if [[ "${#bottle_metadata[@]}" -ne 1 ]]; then
  echo "Expected one bottle JSON file for ${formula_name}, found ${#bottle_metadata[@]}" >&2
  exit 1
fi

bottle_filename="$(
  jq --exit-status --raw-output '
    [.[].bottle.tags[].local_filename] |
    if length == 1
    then .[0]
    else error("expected exactly one bottle filename")
    end
  ' "${bottle_metadata[0]}"
)"

if [[ "$bottle_filename" != "${formula_name}--"* || "$bottle_filename" == */* ]]; then
  echo "Invalid bottle filename in ${bottle_metadata[0]}: ${bottle_filename}" >&2
  exit 1
fi

readonly bottle_path="${PWD}/${bottle_filename}"

if [[ ! -f "$bottle_path" ]]; then
  echo "Bottle archive listed in ${bottle_metadata[0]} does not exist: ${bottle_filename}" >&2
  exit 1
fi

brew uninstall --force "$formula_ref"
HOMEBREW_DEVELOPER=1 brew install "$bottle_path"
brew test "$formula_ref"
brew linkage --test "$formula_ref"
