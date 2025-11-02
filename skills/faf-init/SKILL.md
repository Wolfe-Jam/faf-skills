---
name: faf-init
description: Initialize project.faf files when starting new projects, when user asks to set up AI context, create project DNA, or needs persistent context. Automatically detects project type (React, TypeScript, Next.js, Svelte, etc.), generates appropriate IANA-registered format (application/vnd.faf+yaml), and creates project.faf in repository root. Use when user mentions "context", "project setup", "AI-readiness", or "FAF".
allowed-tools: Read, Write, Bash, Grep, Glob
---

# FAF Init - Project Context Initialization

## Purpose

Automatically generate `project.faf` files for any codebase, providing persistent AI context that works across Claude Code, Cursor, Gemini CLI, OpenAI Codex CLI, and all AI coding assistants.

**The Problem:** AI assistants need to reverse-engineer project context from code, README, and package.json every single session. This wastes 5-30 minutes per conversation.

**The Solution:** One `project.faf` file provides complete project DNA in <1 second. Context persists across sessions, tools, and AI systems.

## When to Use

This skill activates automatically when the user:
- Says "set up project context"
- Says "initialize FAF" or "create project.faf"
- Says "create project DNA"
- Asks "how do I make this AI-ready?"
- Mentions "persistent context" or "AI context"
- Starts work on a new codebase without existing context
- Asks about The Reading Order (project.faf → CLAUDE.md → README.md → code)

**Trigger Words:** init, initialize, setup, context, project DNA, AI-ready, FAF, project.faf, persistent context

## How It Works

### Step 1: Verify faf-cli is Installed

Check if `faf` command is available:

```bash
which faf
```

If not found, provide installation instructions:

```bash
# via npm (works everywhere)
npm install -g faf-cli

# via Homebrew (macOS/Linux)
brew install wolfe-jam/faf/faf-cli
```

### Step 2: Check Current Directory

Verify we're in a project directory (look for indicators):
- `package.json` (Node.js project)
- `pyproject.toml` or `requirements.txt` (Python)
- `Cargo.toml` (Rust)
- `go.mod` (Go)
- `.git/` directory (any git repo)
- Source code files

If not in a project directory, ask user to `cd` to their project first.

### Step 3: Execute faf init

Run the existing `faf init` command:

```bash
faf init
```

This command (from faf-cli v3.1.1):
- Detects project type automatically
- Identifies framework (React, Next.js, Svelte, TypeScript, etc.)
- Generates optimal project.faf structure
- Creates file in repository root
- Uses IANA-registered format: `application/vnd.faf+yaml`

### Step 4: Verify Creation

Check that `project.faf` was created:

```bash
ls -la project.faf
```

If file exists, read first few lines to confirm:

```bash
head -20 project.faf
```

### Step 5: Calculate AI-Readiness Score

Immediately run `faf score` to show initial AI-readiness:

```bash
faf score
```

This shows Podium scoring (0-100%):
- 🏆 Trophy (85%+)
- 🥇 Gold (70%+)
- 🥈 Silver (55%+)
- 🥉 Bronze (40%+)
- 🟢 Green (35%+)
- 🟡 Yellow (20%+)
- 🔴 Red (10%+)
- 🤍 White (<10%)

### Step 6: Explain Next Steps

Tell the user:

1. **What was created:** `project.faf` with complete project DNA
2. **Current score:** Their AI-readiness percentage and tier
3. **Format authority:** IANA-registered `application/vnd.faf+yaml`
4. **The Reading Order:** project.faf → CLAUDE.md → README.md → code
5. **How to improve:** Run `faf enhance` to increase score
6. **Persistence:** This context now works across all AI tools forever

## Examples

### Example 1: New React Project

**User:** "Set up project context for this React app"

**Skill Activates:**
1. Verify `faf` is installed
2. Confirm we're in project directory
3. Run `faf init`
4. Output:
   ```
   ✓ Detected: React 18.2.0
   ✓ Detected: TypeScript 5.3.3
   ✓ Created: project.faf
   ✓ Format: application/vnd.faf+yaml (IANA-registered)
   ```
5. Run `faf score`
6. Output:
   ```
   🥈 Silver (58%) - Good foundation
   Next tier: 🥇 Gold at 70%

   Suggestions:
   - Add testing information
   - Document architecture decisions
   - Include deployment details
   ```
7. Explain to user:
   - project.faf now provides persistent AI context
   - Score is 58% (Silver tier) - good starting point
   - Run `faf enhance` to reach Gold (70%+)
   - Context works across Claude, Cursor, Gemini, Codex

### Example 2: Existing Next.js Project

**User:** "How do I make this Next.js project AI-ready?"

**Skill Activates:**
1. Run `faf init`
2. Auto-detection finds:
   - Next.js 14.0.0
   - React 18
   - TypeScript
   - Tailwind CSS
   - App Router
3. Creates comprehensive project.faf
4. Score: 🥇 Gold (72%) - excellent baseline
5. Explain The Reading Order:
   - AI reads project.faf first (architecture, purpose, stack)
   - Then reads CLAUDE.md (workflow instructions)
   - Then reads README.md (user documentation)
   - Finally reads code (implementation)
6. Result: AI understands complete context in <1 second vs 10-30 minutes of questions

### Example 3: Python Data Science Project

**User:** "Create project DNA for this Python analysis"

**Skill Activates:**
1. Run `faf init`
2. Detects Python 3.11, pandas, numpy, jupyter
3. Creates project.faf with data science context
4. Score: 🥉 Bronze (45%) - needs enhancement
5. Suggest:
   - Add notebook descriptions
   - Document data sources
   - Explain analysis methodology
   - Run `faf enhance` for guided improvements

## Format Details

### IANA Registration

The `.faf` format is **officially registered with IANA** as:
- **Media Type:** `application/vnd.faf+yaml`
- **Registration Date:** October 31, 2025
- **Authority:** Internet Assigned Numbers Authority
- **Status:** Internet standard (same recognition as PDF, JSON, XML)

This is not a tool or documentation format. **This is foundational infrastructure.**

### File Structure

The generated `project.faf` follows this structure:

```yaml
name: project-name
purpose: One-line description of what this project does
version: 1.0.0

metadata:
  created: 2025-11-01
  format_version: 3.0.0
  iana_media_type: application/vnd.faf+yaml

architecture:
  type: web-app | library | api | cli | mobile-app | etc.
  language: TypeScript | Python | Rust | Go | etc.
  framework: React | Next.js | Svelte | Django | etc.

stack:
  runtime: Node.js 18+ | Python 3.11+ | etc.
  dependencies: [key dependencies]

testing:
  framework: Jest | pytest | etc.
  coverage: X tests passing

context:
  ai_readiness_score: 58
  tier: silver
  last_updated: 2025-11-01
```

## The Reading Order

**This is foundational education:**

AI wants to read (in optimal order):
1. **project.faf** - Project DNA (architecture, purpose, stack)
2. **CLAUDE.md** - Workflow instructions (how to work here)
3. **README.md** - User documentation (how humans use it)
4. **package.json** - Dependencies (what it needs)
5. **Config files** - Build settings (how to compile)
6. **Code** - Implementation (what it does)

**Why project.faf first?**
- Architecture before implementation
- Context before code
- Complete picture in <1 second
- Persistent across sessions

Compare:
- **Without project.faf:** AI spends 10-30 min reverse-engineering from code
- **With project.faf:** AI has complete context in <1 second

## Verification & Troubleshooting

### Success Indicators

✅ `project.faf` file exists in repository root
✅ File contains valid YAML (no syntax errors)
✅ IANA media type header present: `application/vnd.faf+yaml`
✅ AI-readiness score calculated (0-100%)
✅ Project type detected correctly
✅ Framework/language identified

### Common Issues

**Issue: `faf: command not found`**
```bash
# Solution: Install faf-cli
npm install -g faf-cli

# Verify installation
faf --version  # Should show v3.1.1 or later
```

**Issue: "Not in a project directory"**
```bash
# Solution: cd to project root
cd /path/to/your/project
ls package.json  # or other project indicators
faf init
```

**Issue: Low AI-readiness score (<40%)**
```bash
# Solution: Enhance the context
faf enhance

# This provides guided improvements:
# - Add missing sections
# - Enhance descriptions
# - Include architecture details
# - Document testing approach
```

**Issue: YAML syntax errors**
```bash
# Solution: Validate the file
faf validate

# Fix any reported issues
# Re-run scoring
faf score
```

## Supporting Files

This skill works with:
- **faf-cli** (v3.1.1+) - The engine that generates project.faf
- **claude-faf-mcp** (v2.7.2+) - MCP server for persistent access
- **IANA registration** - Official Internet media type authority

## Related Skills

After running `faf-init`, users typically want:
- **faf-score** - Calculate current AI-readiness (0-100%)
- **faf-enhance** - Improve score through guided enhancements
- **faf-sync** - Keep project.faf synced with CLAUDE.md
- **faf-validate** - Ensure format compliance

## Key Principles

**NO BS ZONE:**
- Only use verified claims (IANA registration is real, Oct 31 2025)
- No hype, no guarantees (it's free software)
- Professional, boring, trusted
- Format-driven architecture

**Format-First:**
- IANA-registered standard: `application/vnd.faf+yaml`
- Not a tool, not documentation - **foundational infrastructure**
- Works with ANY AI (Claude, Gemini, Codex, Cursor, etc.)
- Persists across sessions, tools, and systems

**The Reading Order:**
- Educate users on optimal AI reading sequence
- project.faf provides architecture BEFORE code
- Context before code philosophy
- Complete picture first

## Success Metrics

When this skill succeeds, users should:
1. Have a valid `project.faf` file in repository root
2. Know their AI-readiness score (0-100%)
3. Understand The Reading Order concept
4. Know how to improve their score (`faf enhance`)
5. Understand this is IANA-registered Internet standard

## References

- **Official Website:** https://faf.one
- **IANA Registration:** application/vnd.faf+yaml (Oct 31, 2025)
- **faf-cli:** https://npmjs.com/package/faf-cli
- **claude-faf-mcp:** https://npmjs.com/package/claude-faf-mcp
- **Official Anthropic Registry:** PR #2759 (merged)
- **Documentation:** https://faf.one/docs
- **The Reading Order:** https://faf.one/docs/reading-order

---

**Generated by FAF Skill: faf-init v1.0.0**
**Format Authority: IANA-registered application/vnd.faf+yaml**
**"Context before code. project.faf first."**
