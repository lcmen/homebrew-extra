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

if [[ ! "$formula_name" =~ ^[a-z0-9][a-z0-9@+._-]*$ ]]; then
  echo "Invalid formula name: ${formula_name}" >&2
  exit 1
fi

if [[ ! "$bottle_root_url" =~ ^https:// ]]; then
  echo "Bottle root URL must use HTTPS: ${bottle_root_url}" >&2
  exit 1
fi

brew install --build-bottle "$formula_ref"
brew test "$formula_ref"
brew linkage --test "$formula_ref"

brew bottle \
  --json \
  --root-url="$bottle_root_url" \
  "$formula_ref"

shopt -s nullglob
bottles=("${formula_name}"--*.bottle.tar.gz)
bottle_metadata=("${formula_name}"-*.bottle.json)

if [[ "${#bottles[@]}" -ne 1 ]]; then
  echo "Expected one bottle archive for ${formula_name}, found ${#bottles[@]}" >&2
  exit 1
fi

if [[ "${#bottle_metadata[@]}" -ne 1 ]]; then
  echo "Expected one bottle JSON file for ${formula_name}, found ${#bottle_metadata[@]}" >&2
  exit 1
fi

readonly bottle_path="${PWD}/${bottles[0]}"

brew uninstall --force "$formula_ref"
brew install "$bottle_path"
brew test "$formula_ref"
brew linkage --test "$formula_ref"
