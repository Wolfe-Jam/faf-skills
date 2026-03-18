# FAF Skills

**17 Claude Code skills for AI-context, testing, and MCP development**

[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://github.com/Wolfe-Jam/faf-skills)

## Install

```bash
claude /plugin install faf-skills
```

All 17 skills activate under the `faf:` namespace — `/faf:context`, `/faf:expert`, `/faf:score`, etc.

---

## What is This?

**FAF Skills** helps you create and optimize `project.faf` files - **the AI equivalent of `package.json`**.

**What is `project.faf`?**
- A **file format** (like `package.json`, `README.md`, `tsconfig.json`)
- Contains your project info in **YAML** (AI's preferred language)
- Gets **scored 0-100%** for AI-readiness
- **IANA-registered** infrastructure (`application/vnd.faf+yaml`)
- Lives in your repository root (next to `package.json`)

**The better your `project.faf`, the better AI understands your project.**

Instead of remembering commands, just ask Claude in natural language and the right skill activates automatically.

**The Analogy:**
```
package.json = For npm to understand dependencies
tsconfig.json = For TypeScript to understand compilation
project.faf = For AI to understand your project
```

**The Vision:**
> One day (sooner the better), all repositories will have a `project.faf`.
>
> If it's missing, AI is not optimized.

**Example:**
- You: "Set up project context for this codebase"
- Claude: *Activates faf-init skill automatically*
- Result: `project.faf` created, scored 0-100%, ready to use

**Zero memorization. Automatic activation. Championship results.**

---

## The Core Skills

### 1. faf-teacher
**Foundational education before action.**

**When it activates:**
- "What is FAF?"
- "Explain The Reading Order"
- "Why do I need this?"
- "How does AI context work?"

**What it does:**
- Explains the 32-minute problem → <1 second solution
- Teaches The Reading Order (project.faf → CLAUDE.md → code)
- Shows verified ROI (73% reduction, 6,444% ROI)
- Corrects common misconceptions

**Result:** You understand WHY before WHAT.

---

### 2. faf-init
**Initialize project.faf files automatically.**

**When it activates:**
- "Set up project context"
- "Initialize FAF"
- "Create project DNA"
- "Make this AI-ready"

**What it does:**
- Auto-detects project type (React, Next.js, Python, etc.)
- Generates valid project.faf in <50ms
- Uses IANA-registered format (application/vnd.faf+yaml)
- Calculates initial AI-readiness score

**Result:** Complete project DNA in seconds.

---

### 3. faf-score
**Measure AI-readiness (0-100%) with Podium scoring.**

**When it activates:**
- "What's my AI-readiness score?"
- "Check my FAF quality"
- "What tier am I at?"

**What it does:**
- Calculates 0-100% AI-readiness score
- Assigns Podium tier (Trophy/Gold/Silver/Bronze)
- Identifies strengths and gaps
- Shows next tier target
- Provides improvement roadmap

**Result:** Measurable progress toward elite context.

**Podium Tiers:**
- 🏆 Trophy (85%+) - Elite AI-readiness
- 🥇 Gold (70-84%) - Excellent AI-readiness
- 🥈 Silver (55-69%) - Good AI-readiness
- 🥉 Bronze (40-54%) - Basic AI-readiness

---

### 4. faf-enhance
**Guided improvement to reach higher tiers.**

**When it activates:**
- "Improve my score"
- "Enhance my FAF"
- "Reach Gold tier"
- "What's missing?"

**What it does:**
- Analyzes current project.faf
- Asks targeted questions
- Adds missing sections incrementally
- Re-scores after each improvement
- Guides to target tier (Bronze → Silver → Gold → Trophy)

**Result:** Step-by-step path to championship quality.

**Typical session:**
- Start: 58% (Silver)
- +6% testing docs → 64%
- +4% API docs → 68%
- +2% architecture → 70% (Gold) ✨

---

### 5. faf-sync
**Bidirectional sync between project.faf and CLAUDE.md in 8ms.**

**When it activates:**
- "Sync my files"
- "Mirror to CLAUDE.md"
- "Keep context updated"

**What it does:**
- Detects which file changed
- Syncs bidirectionally (project.faf ↔ CLAUDE.md)
- Maintains perfect consistency
- Preserves format-specific content
- Completes in <10ms (achieved: 8ms)

**Result:** Zero manual synchronization. Perfect consistency.

**Context-Mirroring:**
- Update project.faf → CLAUDE.md auto-updates
- Update CLAUDE.md → project.faf auto-updates
- Architecture stays aligned
- Workflow stays separate

---

### 6. faf-validate
**Ensure IANA format compliance.**

**When it activates:**
- "Validate my FAF"
- "Check format"
- "Is this correct?"

**What it does:**
- Validates YAML syntax
- Checks required fields
- Verifies format version (3.0.0+)
- Confirms IANA media type
- Reports all errors with fix guidance

**Result:** 100% format compliance. Zero errors.

**Common checks:**
- ✅ Valid YAML syntax
- ✅ Format version 3.0.0+
- ✅ IANA media type: application/vnd.faf+yaml
- ✅ All required fields present
- ✅ Architecture type valid

---

### 7. faf-migrate
**Upgrade old formats to current IANA standard.**

**When it activates:**
- "Upgrade my FAF format"
- "Migrate to latest version"
- Sees "old format version" warning

**What it does:**
- Detects current version (v1.x, v2.x)
- Backs up original automatically
- Upgrades to v3.0.0 (IANA-registered)
- Adds required fields (IANA media type)
- Preserves all existing content

**Result:** Zero data loss. Modern compliance.

**Migration paths:**
- v1.x → v3.0.0 (~50ms)
- v2.x → v3.0.0 (~20ms)
- Automatic backup to project.faf.backup

---

### 8. faf-docs
**Instant documentation and answers.**

**When it activates:**
- "How does FAF work?"
- "Show me the docs"
- "Explain The Reading Order"
- "What is IANA registration?"

**What it does:**
- Answers common questions
- Provides format specification reference
- Explains key concepts
- Links to related skills
- Shows command examples

**Result:** Instant answers. Zero context switching.

---

### 9. faf-git
**Basic Git practices for .faf files.**

**When it activates:**
- "Should I commit project.faf?"
- "Add FAF to Git"
- "Share on GitHub"

**What it does:**
- Guides on committing project.faf and CLAUDE.md
- Provides .gitignore patterns
- Basic repository setup (NOT comprehensive GitHub guide)

**Result:** Correct version control for FAF files.

---

### 10. faf-platforms
**Understand CLI vs MCP vs claude.ai.**

**When it activates:**
- "Does FAF work with Claude Desktop?"
- "CLI vs MCP - which one?"
- "Can I use FAF on claude.ai?"

**What it does:**
- Explains Claude Code (CLI + Skills)
- Explains Claude Desktop (MCP)
- Explains claude.ai (file upload only)
- Compares platforms with feature matrix

**Result:** Clear platform understanding.

---

### 11. faf-format-inspector
**Validate both YAML formats: SKILL.md and project.faf.**

**When it activates:**
- "Validate my skill format"
- "Check my SKILL.md"
- "Is my project.faf valid?"

**What it does:**
- Validates SKILL.md frontmatter format
- Validates project.faf IANA format
- Detects format conflicts (mixed formats)
- Provides format comparison guide

**Result:** Format integrity for both tooling and infrastructure.

---

## Installation

### Plugin Install (Recommended)

```bash
claude /plugin install faf-skills
```

All 17 skills available instantly under `faf:` namespace.

### Manual Install

```bash
# Clone and copy all skills
git clone https://github.com/Wolfe-Jam/faf-skills.git
cp -r faf-skills/skills/* ~/.claude/skills/
```

---

## How Skills Work

### Automatic Activation

Skills activate automatically when you ask questions in natural language:

**Example 1:**
```
You: "What's my AI-readiness score?"
Claude: [faf-score skill activates automatically]
Claude: Runs `faf score`, shows results, explains tier
```

**Example 2:**
```
You: "Improve my project context"
Claude: [faf-enhance skill activates automatically]
Claude: Analyzes gaps, asks questions, adds content, re-scores
```

**Example 3:**
```
You: "Sync project.faf and CLAUDE.md"
Claude: [faf-sync skill activates automatically]
Claude: Runs `faf bi-sync`, reports results (8ms)
```

### Token Efficiency

**Skills are token-efficient:**
- Idle: 30-50 tokens (just description)
- Active: Full instructions load only when needed
- 99%+ savings vs manual prompting

**Simon Willison (Oct 2025):**
> "Claude Skills are potentially more impactful than MCP because of their simplicity and efficiency."

---

## Prerequisites

**You need faf-cli installed:**

```bash
# via npm (works everywhere)
npm install -g faf-cli

# via Homebrew (macOS/Linux)
brew install wolfe-jam/faf/faf-cli

# Verify installation
faf --version  # Should show v5.0.6 or later
```

**Optional but recommended:**

```bash
# claude-faf-mcp (MCP server)
npm install -g claude-faf-mcp
```

---

## The Skill Workflow

**Typical session with FAF Agent Toolkit:**

```bash
# 1. Learn (first time)
You: "What is FAF?"
→ faf-teacher activates
→ Explains the 32-minute problem, The Reading Order, IANA registration

# 2. Initialize
You: "Set up project context"
→ faf-init activates
→ Creates project.faf, shows initial score (58% Silver)

# 3. Score
You: "What's my score?"
→ faf-score activates
→ Shows 58% (Silver tier), gaps identified

# 4. Enhance
You: "Improve my score"
→ faf-enhance activates
→ Adds testing docs (+6%), API docs (+4%), architecture (+2%)
→ New score: 70% (Gold tier) ✨

# 5. Sync
You: "Sync to CLAUDE.md"
→ faf-sync activates
→ Bidirectional sync in 8ms

# 6. Validate
You: "Is my format correct?"
→ faf-validate activates
→ 100% compliant with IANA spec

# 7. Share
You: "Ready to share!"
→ project.faf is validated, scored, synced, compliant
```

**Total time:** 15-30 minutes from zero to Gold tier.

---

## The Reading Order

**What FAF Skills help you create:**

```
1. project.faf   → Project DNA (architecture, stack)     [Skills: init, score, enhance]
2. CLAUDE.md     → Workflow instructions                [Skills: sync]
3. README.md     → User documentation
4. package.json  → Dependencies
5. Config files  → Build settings
6. Code          → Implementation
```

**Why this matters:**
- AI reads architecture BEFORE code
- Complete context in <1 second
- Zero questions, instant understanding
- 95%+ accuracy vs 60-70% from code alone

---

## Key Principles

### Format-Driven Architecture

**FAF is IANA-registered infrastructure:**
- **Media Type:** application/vnd.faf+yaml
- **Registration Date:** October 31, 2025
- **Authority:** Internet Assigned Numbers Authority
- **Recognition:** Same level as PDF, JSON, XML

**Not a tool. Foundational infrastructure.**

### Context Before Code

**Skills teach this philosophy:**
- Architecture BEFORE implementation
- Purpose BEFORE details
- Complete picture BEFORE diving in

**Result:** Better AI suggestions, fewer mistakes.

### Measurable Progress

**Podium scoring provides:**
- 0-100% quantifiable AI-readiness
- Clear tier system (Trophy/Gold/Silver/Bronze)
- Visible progress (58% → 70% → 89%)
- Actionable improvement paths

### NO BS ZONE

**All skills follow:**
- Only verified claims (IANA registration is real)
- Real metrics (73% reduction, Anthropic research)
- Honest limitations (it's free software)
- Professional, boring, trusted

---

## Success Patterns

### Pattern 1: New Project Setup

```
1. faf-init → Create project.faf (45% Bronze)
2. faf-enhance → Add details (70% Gold)
3. faf-sync → Mirror to CLAUDE.md
4. faf-validate → Confirm compliance
```

**Time:** 30-60 minutes
**Result:** Gold tier AI-readiness

### Pattern 2: Existing Project Upgrade

```
1. faf-teacher → Understand value
2. faf-init → Generate from codebase (58% Silver)
3. faf-score → See baseline
4. faf-enhance → Targeted improvements (72% Gold)
5. faf-sync → Integrate with workflow
```

**Time:** 1-2 hours
**Result:** Excellent AI context

### Pattern 3: Legacy Format Migration

```
1. faf-validate → Detect old format (v2.x)
2. faf-migrate → Upgrade to v3.0.0
3. faf-validate → Confirm IANA compliance
4. faf-score → Measure quality
5. faf-enhance → Improve if needed
```

**Time:** 10-20 minutes
**Result:** Modern, compliant format

---

## Repository Structure

```
faf-skills/
├── .claude-plugin/              # Claude Code Plugin manifest
│   └── plugin.json              # v1.0.0, namespace: faf
├── skills/                      # 17 skills
│   ├── faf-context/             # AI-context DNA generator
│   ├── faf-expert/              # .faf specialist
│   ├── faf-enhance/             # Guided improvement
│   ├── faf-score/               # AI-readiness scoring
│   ├── faf-sync/                # Bidirectional sync (8ms)
│   ├── faf-validate/            # Format compliance
│   ├── faf-migrate/             # Version upgrade
│   ├── faf-docs/                # Documentation
│   ├── faf-git/                 # Git practices
│   ├── faf-platforms/           # Platform comparison
│   ├── faf-teacher/             # Foundational education
│   ├── faf-format-inspector/    # Dual format validation
│   ├── mcp-builder/             # MCP server creation
│   ├── n8n-builder/             # n8n workflow creation
│   ├── n8n-debugger/            # n8n debugging
│   ├── wjttc-builder/          # Test suite generation
│   └── wjttc-tester/           # F1-inspired testing
├── README.md
├── CONTRIBUTING.md
├── TESTING.md
├── install.sh
└── LICENSE                      # MIT
```

---

## Verified Stats

**FAF Ecosystem (as of March 2026):**
- ✅ IANA registration: application/vnd.faf+yaml
- ✅ 36,000+ downloads across npm, PyPI, crates.io
- ✅ 6 packages: faf-cli + 5 MCP servers (Claude, Gemini, Grok, Cursor/IDEs, Rust)
- ✅ Format compliance: 100% (IANA spec)

**Performance:**
- faf-cli: 1,143 tests, 50 suites, 18ms average
- faf-wasm-sdk: 136 tests in 0.13s
- bi-sync: 8ms achieved
- Skills idle: 30-50 tokens

---

## What Makes This Different

### vs MCP Servers

**MCP Servers:**
- Require server setup
- Higher token usage
- More complex integration
- Explicit tool calls

**FAF Skills:**
- Zero setup (copy files)
- 30-50 tokens idle
- Natural language activation
- Automatic detection

**Simon Willison:** "Skills > MCP" (token efficiency)

### vs Manual CLI Usage

**Manual CLI:**
- Remember commands
- Type faf commands manually
- No guidance
- No progressive enhancement

**Skills:**
- Natural language ("improve my score")
- Auto-activates correct skill
- Guided workflows
- Interactive improvement

### vs Other Context Formats

**Other formats:**
- No universal standard
- Tool-specific
- No scoring
- No versioning

**FAF:**
- IANA-registered (Internet standard)
- Works with ALL AI tools
- Podium scoring (0-100%)
- Version managed (v3.0.0)

---

## Roadmap

- [x] 17 skills written and tested
- [x] Claude Code Plugin manifest (v1.0.0)
- [x] `faf:` namespace
- [x] GitHub distribution
- [ ] Smithery marketplace submission
- [ ] Community contributions

---

## Contributing

**We welcome contributions!**

**How to contribute:**
1. Fork this repository
2. Create a new skill in `skills/your-skill-name/`
3. Follow SKILL.md format (see existing skills)
4. Test activation with Claude Code
5. Submit pull request

**Skill quality standards:**
- Clear trigger words in description
- Comprehensive examples
- Troubleshooting section
- NO BS ZONE compliance
- Format-driven architecture

---

## License

**MIT License - Free Forever**

This toolkit is free software. No guarantees. Professional, boring, trusted.

---

## Quick Start

```bash
# Install the plugin
claude /plugin install faf-skills

# Use naturally — skills activate automatically:
# /faf:context  → generate .faf for any project
# /faf:score    → measure AI-readiness (0-100%)
# /faf:expert   → .faf specialist
# /faf:sync     → bidirectional sync (8ms)
```

---

## FAF Family

| | |
|---|---|
| **[faf-cli](https://www.npmjs.com/package/faf-cli)** | `npx faf-cli init` — create .faf for any project |
| **[claude-faf-mcp](https://www.npmjs.com/package/claude-faf-mcp)** | MCP server for Claude Desktop |
| **[gemini-faf-mcp](https://pypi.org/project/gemini-faf-mcp/)** | MCP server for Gemini CLI |
| **[grok-faf-mcp](https://www.npmjs.com/package/grok-faf-mcp)** | MCP server for Grok |
| **[faf-mcp](https://www.npmjs.com/package/faf-mcp)** | MCP server for Cursor, Windsurf, Cline, VS Code |
| **[rust-faf-mcp](https://crates.io/crates/rust-faf-mcp)** | MCP server in Rust |
| **[faf-skills](https://github.com/Wolfe-Jam/faf-skills)** | 17 Claude Code skills |
| **[faf.one](https://faf.one)** | Blog, downloads, docs |
| **[IANA Registration](https://www.iana.org/assignments/media-types/application/vnd.faf+yaml)** | `application/vnd.faf+yaml` |

*format | driven 🏎️⚡️ [wolfejam.dev](https://wolfejam.dev)*
