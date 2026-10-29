#!/bin/bash
# Packages the mod into dist/<repo>-<branch>.zip with a top-level wrapper folder,
# the layout VCMI's installer expects (the wrapper is renamed to the mod ID on install).
set -euo pipefail

REPO_NAME="${GITHUB_REPOSITORY##*/}"
WRAP="${REPO_NAME}-${GITHUB_REF_NAME}"
OUT="dist/${WRAP}.zip"

mkdir -p dist
rm -rf .pack
mkdir -p ".pack/${WRAP}"

# What VCMI loads, plus docs and screenshots for offline browsing.
cp -a mod.json Mods screenshots ".pack/${WRAP}/"
cp -a README.md LICENSE.md CHANGELOG.md ".pack/${WRAP}/" 2>/dev/null || true
cp -a docs ".pack/${WRAP}/" 2>/dev/null || true

(cd .pack && zip -9 -r -q "../${OUT}" "${WRAP}")

echo "Created: ${OUT}"
