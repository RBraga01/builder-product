#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/RBraga01/builder-product"
PACK="builder-product"
TARGET="${1:-.}"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Installing ${PACK} into ${TARGET}...${NC}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

git clone --filter=blob:none --sparse "$REPO" "$TMP/$PACK" --quiet
cd "$TMP/$PACK"
git sparse-checkout set skills .claude

cd - > /dev/null

cp -rn "$TMP/$PACK/skills" "$TARGET/" 2>/dev/null || true
cp -rn "$TMP/$PACK/.claude" "$TARGET/" 2>/dev/null || true

echo -e "${GREEN}Done. Skills installed to ${TARGET}/skills/${NC}"
echo -e "${GREEN}Agents installed to ${TARGET}/.claude/agents/${NC}"
echo ""
echo "Start with: prd-quality-gate → feature-scoping → metric-definition"
