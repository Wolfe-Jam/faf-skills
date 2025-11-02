#!/bin/bash

# FAF Agent Toolkit Installer
# Championship-Grade Skills for Universal AI Context

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Header
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  FAF Agent Toolkit Installer${NC}"
echo -e "${BLUE}  Championship Skills for Claude Code${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect skills directory
# Claude Code uses: ~/.config/claude-code/skills
# Or custom location if $CLAUDE_SKILLS_DIR is set

if [ -n "$CLAUDE_SKILLS_DIR" ]; then
    SKILLS_DIR="$CLAUDE_SKILLS_DIR"
    echo -e "${BLUE}Using custom skills directory:${NC} $SKILLS_DIR"
elif [ -d "$HOME/.config/claude-code/skills" ]; then
    SKILLS_DIR="$HOME/.config/claude-code/skills"
    echo -e "${BLUE}Using Claude Code skills directory:${NC} $SKILLS_DIR"
else
    # Create directory if it doesn't exist
    SKILLS_DIR="$HOME/.config/claude-code/skills"
    echo -e "${YELLOW}Creating skills directory:${NC} $SKILLS_DIR"
    mkdir -p "$SKILLS_DIR"
fi

echo ""

# Check if faf-cli is installed
echo -e "${BLUE}Checking prerequisites...${NC}"
if command -v faf &> /dev/null; then
    FAF_VERSION=$(faf --version 2>&1 | head -1 || echo "unknown")
    echo -e "${GREEN}✓${NC} faf-cli installed: $FAF_VERSION"
else
    echo -e "${RED}✗${NC} faf-cli not found"
    echo ""
    echo -e "${YELLOW}faf-cli is required. Install it with:${NC}"
    echo ""
    echo "  npm install -g faf-cli"
    echo ""
    echo "  OR"
    echo ""
    echo "  brew install wolfe-jam/faf/faf-cli"
    echo ""
    exit 1
fi

echo ""

# Count skills to install
SKILL_COUNT=$(ls -1 skills | wc -l | tr -d ' ')
echo -e "${BLUE}Installing $SKILL_COUNT FAF skills...${NC}"
echo ""

# Install each skill
INSTALLED=0
FAILED=0

for skill_dir in skills/*/; do
    skill_name=$(basename "$skill_dir")

    # Skip if not a directory
    if [ ! -d "$skill_dir" ]; then
        continue
    fi

    # Check if SKILL.md exists
    if [ ! -f "$skill_dir/SKILL.md" ]; then
        echo -e "${YELLOW}⚠${NC}  Skipping $skill_name (no SKILL.md found)"
        continue
    fi

    # Copy skill to skills directory
    TARGET_DIR="$SKILLS_DIR/$skill_name"

    # Check if skill already exists
    if [ -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}⚠${NC}  $skill_name already exists, backing up..."
        mv "$TARGET_DIR" "$TARGET_DIR.backup.$(date +%Y%m%d-%H%M%S)"
    fi

    # Copy skill
    cp -r "$skill_dir" "$TARGET_DIR"

    if [ -f "$TARGET_DIR/SKILL.md" ]; then
        echo -e "${GREEN}✓${NC}  Installed: $skill_name"
        ((INSTALLED++))
    else
        echo -e "${RED}✗${NC}  Failed: $skill_name"
        ((FAILED++))
    fi
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Installation summary
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ Installation complete!${NC}"
    echo ""
    echo -e "  Installed: $INSTALLED skills"
    echo -e "  Location: $SKILLS_DIR"
else
    echo -e "${YELLOW}⚠ Installation completed with warnings${NC}"
    echo ""
    echo -e "  Installed: $INSTALLED skills"
    echo -e "  Failed: $FAILED skills"
    echo -e "  Location: $SKILLS_DIR"
fi

echo ""
echo -e "${BLUE}Installed skills:${NC}"
echo ""

# List installed skills
for skill_dir in "$SKILLS_DIR"/faf-*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        echo -e "  • $skill_name"
    fi
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}Next steps:${NC}"
echo ""
echo "  1. Restart Claude Code (skills activate automatically)"
echo "  2. Try asking Claude:"
echo ""
echo -e "     ${BLUE}\"What is FAF?\"${NC}            → faf-teacher activates"
echo -e "     ${BLUE}\"Set up project context\"${NC}  → faf-init activates"
echo -e "     ${BLUE}\"What's my score?\"${NC}        → faf-score activates"
echo ""
echo "  Skills activate automatically on natural language."
echo "  No commands to memorize. Zero configuration."
echo ""
echo -e "${BLUE}Documentation:${NC} https://faf.one/docs"
echo -e "${BLUE}GitHub:${NC} https://github.com/Wolfe-Jam/faf-agent-toolkit"
echo ""
echo -e "${GREEN}Happy context building!${NC}"
echo ""
