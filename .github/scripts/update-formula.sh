#!/bin/bash
set -e

FORMULA_PATH="$1"

if [ -z "$FORMULA_PATH" ]; then
  echo "Usage: $0 <formula_path>"
  exit 1
fi

# Extract current version and GitHub repo from first URL
CURRENT_VERSION=$(grep 'version' "$FORMULA_PATH" | head -1 | sed 's/.*"\(.*\)".*/\1/')
FIRST_URL=$(grep 'url ' "$FORMULA_PATH" | head -1 | sed 's/.*"\(.*\)".*/\1/')
GITHUB_REPO=$(echo "$FIRST_URL" | sed -n 's|.*github.com/\([^/]*/[^/]*\)/.*|\1|p')

echo "GitHub repo: $GITHUB_REPO"
echo "Current version: $CURRENT_VERSION"

# Get latest version
LATEST_VERSION=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
echo "Latest version: $LATEST_VERSION"

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
  echo "Already up to date"
  echo "needs_update=false" >> "$GITHUB_OUTPUT"
  exit 0
else
  echo "needs_update=true" >> "$GITHUB_OUTPUT"
  echo "version=$LATEST_VERSION" >> "$GITHUB_OUTPUT"
fi

# Update version everywhere (in version field and URLs)
sed -i '' "s/$CURRENT_VERSION/$LATEST_VERSION/g" "$FORMULA_PATH"

# Download each URL and update its SHA
for url in $(grep 'url ' "$FORMULA_PATH" | sed 's/.*"\(.*\)".*/\1/'); do
  echo "Downloading: $url"
  TEMP_FILE=$(mktemp)
  curl -sL -o "$TEMP_FILE" "$url"
  SHA=$(shasum -a 256 "$TEMP_FILE" | awk '{print $1}')
  rm "$TEMP_FILE"
  echo "SHA256: $SHA"

  # Find and replace the SHA that comes after this URL
  OLD_SHA=$(grep -A1 "$url" "$FORMULA_PATH" | tail -1 | sed 's/.*"\(.*\)".*/\1/')
  sed -i '' "s/$OLD_SHA/$SHA/" "$FORMULA_PATH"
done

echo "Updated successfully"
