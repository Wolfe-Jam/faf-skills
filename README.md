# FAF Skills

**30 Claude Code Skills for Professional Developers**

---

## What is This?

Reusable Claude Code skills for project context, testing, publishing, architecture, and workflow automation. Built on the FAF ecosystem (`application/vnd.faf+yaml` — IANA-registered).

```bash
# Install all skills
git clone https://github.com/Wolfe-Jam/faf-skills.git
cp -r faf-skills/skills/* ~/.claude/skills/
```

Skills activate automatically via `/skillname` or natural language in Claude Code.

---

## Skills (30)

### FAF Context (14 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **faf-teacher** | — | Explains FAF concepts and The Reading Order |
| **faf-init** | — | Initialize `project.faf` from any codebase |
| **faf-go** | `/faf-go` | Guided interview to 100% AI-readiness |
| **faf-expert** | `/faf-expert` | Deep expertise on `.faf` files and project DNA |
| **faf-score** | — | Measure AI-readiness (0-100%, 7-tier system) |
| **faf-enhance** | — | Guided improvement to reach higher tiers |
| **faf-sync** | — | Bidirectional sync: `.faf` ↔ `CLAUDE.md` (8ms) |
| **faf-validate** | — | IANA format compliance checking |
| **faf-migrate** | — | Upgrade old formats to current spec |
| **faf-docs** | — | FAF documentation and reference |
| **faf-git** | — | Git practices for `.faf` files |
| **faf-platforms** | — | CLI vs MCP vs claude.ai comparison |
| **faf-format-validator** | — | Validate both SKILL.md and project.faf |
| **mcp-builder** | `/mcp-builder` | Guide for creating MCP servers |

### Testing (2 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **wjttc-builder** | `/wjttc-builder` | Auto-generate championship-grade test suites |
| **wjttc-tester** | `/wjttc-tester` | F1-inspired testing with detailed reports |

### Publishing (5 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **pubpro** | `/pubpro` | FAF publish protocol for npm + MCP Registry |
| **publish** | `/publish` | Multi-platform publishing (npm, PyPI, blog, social) |
| **pubcrate** | `/pubcrate` | Publish protocol for crates.io (Rust) |
| **pubpypi** | `/pubpypi` | Publish protocol for PyPI (Python) |
| **pubblog** | — | Generate release blog posts |

### Architecture & Planning (3 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **sys-reqs-builder** | `/sys-reqs-builder` | Generate system requirements documents |
| **prd-builder** | `/prd-builder` | Generate product requirements documents |
| **arch-builder** | `/arch-builder` | Generate technical architecture documents |

### Git & Code Review (3 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **commit** | `/commit` | Context-aware git commits powered by FAF |
| **pr** | `/pr` | Context-aware pull requests powered by FAF |
| **review** | `/review` | Context-aware code reviews powered by FAF |

### Workflow & Utilities (3 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **skill-creator** | `/skill-creator` | Guide for creating new Claude Code skills |
| **gif-recorder** | `/gif-recorder` | Terminal GIF recordings using VHS |
| **repo-maintainer** | `/repo-maintainer` | Repository health audits and cleanup |

### n8n Automation (2 skills)

| Skill | Command | What it does |
|-------|---------|-------------|
| **n8n-builder** | `/n8n-builder` | Build n8n workflows from scratch |
| **n8n-debugger** | `/n8n-debugger` | Debug and fix broken n8n workflows |

---

## Installation

### Copy Individual Skills

```bash
# Copy one skill
cp -r skills/faf-expert ~/.claude/skills/

# Copy a category
cp -r skills/wjttc-* ~/.claude/skills/
```

### Install All Skills

```bash
git clone https://github.com/Wolfe-Jam/faf-skills.git
cp -r faf-skills/skills/* ~/.claude/skills/
```

Restart Claude Code. Skills activate automatically.

### Prerequisites

```bash
# Required for FAF skills
npm install -g faf-cli

# Optional: MCP server
npm install -g claude-faf-mcp
```

---

## Tier System

| Score | Tier | Emoji |
|-------|------|-------|
| 100% | Trophy | 🏆 |
| 99%+ | Gold | 🥇 |
| 95%+ | Silver | 🥈 |
| 85%+ | Bronze | 🥉 |
| 70%+ | Green | 🟢 |
| 55%+ | Yellow | 🟡 |
| < 55% | Red | 🔴 |
| 0% | White | 🤍 |

---

## Repository Structure

```
faf-skills/
├── README.md
├── skills/               # 30 skills
│   ├── faf-teacher/      # FAF education
│   ├── faf-init/         # Project initialization
│   ├── faf-go/           # Guided interview
│   ├── faf-expert/       # .faf expertise
│   ├── faf-score/        # AI-readiness scoring
│   ├── faf-enhance/      # Score improvement
│   ├── faf-sync/         # Bidirectional sync
│   ├── faf-validate/     # Format compliance
│   ├── faf-migrate/      # Version upgrade
│   ├── faf-docs/         # Documentation
│   ├── faf-git/          # Git practices
│   ├── faf-platforms/    # Platform comparison
│   ├── faf-format-validator/ # Dual format validation
│   ├── mcp-builder/      # MCP server creation
│   ├── wjttc-builder/    # Test suite generator
│   ├── wjttc-tester/     # F1-inspired testing
│   ├── pubpro/           # npm publish protocol
│   ├── publish/          # Multi-platform publishing
│   ├── pubcrate/         # crates.io publishing
│   ├── pubpypi/          # PyPI publishing
│   ├── pubblog/          # Release blog posts
│   ├── sys-reqs-builder/ # System requirements
│   ├── prd-builder/      # Product requirements
│   ├── arch-builder/     # Architecture docs
│   ├── commit/           # Git commits
│   ├── pr/               # Pull requests
│   ├── review/           # Code reviews
│   ├── skill-creator/    # Create new skills
│   ├── gif-recorder/     # Terminal GIF recording
│   ├── repo-maintainer/  # Repository health
│   ├── n8n-builder/      # n8n workflow building
│   └── n8n-debugger/     # n8n workflow debugging
├── CONTRIBUTING.md
├── TESTING.md
├── install.sh
├── project.faf
└── LICENSE
```

---

## Resources

- **Website:** https://faf.one
- **faf-cli:** https://github.com/Wolfe-Jam/faf-cli
- **claude-faf-mcp:** https://github.com/Wolfe-Jam/claude-faf-mcp
- **IANA Registration:** `application/vnd.faf+yaml`
- **npm:** https://npmjs.com/package/faf-cli (36k+ downloads)

---

## License

MIT License

---

*By [@Wolfe-Jam](https://github.com/Wolfe-Jam)*
