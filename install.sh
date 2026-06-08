#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/RBraga01/builder-product"
PACK="builder-product"
TARGET="${1:-.}"
MIN_GIT_MAJOR=2
MIN_GIT_MINOR=25

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

error() { echo -e "${RED}Error: $1${NC}" >&2; exit 1; }

# Verify target directory exists
[ -d "$TARGET" ] || error "Target directory '$TARGET' does not exist."

# Check git version
if ! command -v git &>/dev/null; then
    error "git not found. Please install git >= ${MIN_GIT_MAJOR}.${MIN_GIT_MINOR}."
fi
GIT_MAJOR=$(git --version | grep -oE '[0-9]+' | head -1)
GIT_MINOR=$(git --version | grep -oE '[0-9]+' | sed -n '2p')
if [ "$GIT_MAJOR" -lt "$MIN_GIT_MAJOR" ] || { [ "$GIT_MAJOR" -eq "$MIN_GIT_MAJOR" ] && [ "$GIT_MINOR" -lt "$MIN_GIT_MINOR" ]; }; then
    error "git >= ${MIN_GIT_MAJOR}.${MIN_GIT_MINOR} required (found $(git --version)). Please upgrade git."
fi

echo -e "${CYAN}Installing ${PACK} into ${TARGET}...${NC}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

git clone --filter=blob:none --sparse "$REPO" "$TMP/$PACK" --quiet
cd "$TMP/$PACK"
git sparse-checkout set skills .claude
cd - > /dev/null

if [ ! -d "$TARGET/skills" ]; then
    cp -r "$TMP/$PACK/skills" "$TARGET/"
fi
if [ ! -d "$TARGET/.claude" ]; then
    cp -r "$TMP/$PACK/.claude" "$TARGET/"
fi

echo -e "${GREEN}Done. Skills installed to ${TARGET}/skills/${NC}"
echo -e "${GREEN}Agents installed to ${TARGET}/.claude/agents/${NC}"
echo ""
echo "Start with: prd-quality-gate → feature-scoping → metric-definition"
