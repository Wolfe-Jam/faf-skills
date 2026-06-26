# FAF Skills

**A curated set of Claude Code skills — quality over quantity.**

Every skill here is held to one bar: accurate, on-brand, and genuinely procedural (it teaches an agent to *do* something, not just narrate a CLI command). **`faf-context` is the reference standard** the rest conform to. Built on the FAF ecosystem (`application/vnd.faf+yaml` — IANA-registered).

---

## What is this?

Reusable, championship-grade Claude Code skills for getting any project to **100% 🏆 AI-readiness** and shipping it well. Not a dumping ground — a curated bundle. Skills activate automatically via `/skillname` or natural language in Claude Code.

```bash
# Plugin marketplace (recommended)
/plugin marketplace add Wolfe-Jam/faf-skills
/plugin install faf@faf-skills

# Or manual
git clone https://github.com/Wolfe-Jam/faf-skills.git && cp -r faf-skills/skills/* ~/.claude/skills/
```

---

## Skills

### Core — the path to 100% 🏆

| Skill | Command | What it does |
|-------|---------|-------------|
| **faf-context** | `/faf-context` | The builder's quickstart **and the reference standard** — hand the AI the underivable context (goal + 6 Ws) to hit 100%, fast |
| **faf-wizard** | `/faf-wizard` | Done-for-you `.faf` generator — point at any project, get a scored file back |
| **faf-expert** | `/faf-expert` | The mechanic's manual — scoring internals, MCP config, bi-sync, the full 21-slot model |
| **faf-go** | `/faf-go` | Guided AskUserQuestion interview to 100% AI-readiness |

### Build & Test

| Skill | Command | What it does |
|-------|---------|-------------|
| **mcp-builder** | `/mcp-builder` | Build high-quality MCP servers (phased: research → implement → review → evaluate) |
| **wjttc-builder** | `/wjttc-builder` | Generate WJTTC championship-grade test plans (F1 tiers + Signal Integrity) |
| **wjttc-tester** | `/wjttc-tester` | Execute tests and file detailed WJTTC reports |

### Author & Maintain

| Skill | Command | What it does |
|-------|---------|-------------|
| **skill-creator** | `/skill-creator` | Author well-formed Claude Code skills (anatomy, progressive disclosure) |
| **repo-maintainer** | `/repo-maintainer` | Multi-phase repository health audit → prioritized cleanup |

---

## Installation

```bash
# All skills
git clone https://github.com/Wolfe-Jam/faf-skills.git
cp -r faf-skills/skills/* ~/.claude/skills/

# One skill
cp -r faf-skills/skills/faf-expert ~/.claude/skills/
```

Restart Claude Code. Skills activate automatically.

### Prerequisites
```bash
npm install -g faf-cli           # required
npm install -g claude-faf-mcp    # optional: MCP server
```

---

## Tier System

| Score | Tier | Symbol |
|-------|------|--------|
| 100% | Trophy | 🏆 |
| 99% | Gold | ★ |
| 95% | Silver | ◆ |
| 85% | Bronze | ◇ |
| 70% | Green | ● |
| 55% | Yellow | ● |
| 1% | Red | ○ |
| 0% | White | ♡ |

---

## Repository Structure

```
faf-skills/
├── README.md
├── skills/
│   ├── faf-context/      # Builder quickstart + reference standard
│   ├── faf-wizard/       # Done-for-you generator
│   ├── faf-expert/       # Mechanic's manual
│   ├── faf-go/           # Guided interview
│   ├── mcp-builder/      # Build MCP servers
│   ├── wjttc-builder/    # Test-plan generator (F1 tiers)
│   ├── wjttc-tester/     # Test execution + reports
│   ├── skill-creator/    # Author new skills
│   └── repo-maintainer/  # Repository health audit
├── scripts/
│   └── build-skills-json.mjs   # generates skills.json (single source for skills.faf.one)
├── skills.json           # the hub manifest (generated — do not hand-edit)
├── CONTRIBUTING.md · TESTING.md · install.sh · project.faf · LICENSE
```

> `skills.json` is **generated** from the SKILL.md frontmatters and verified in CI — never edit it by hand. After changing a skill, run `node scripts/build-skills-json.mjs`.

---

## Resources

- **Website:** https://faf.one · **Skills hub:** https://skills.faf.one
- **faf-cli:** https://github.com/Wolfe-Jam/faf-cli · **npm:** https://npmjs.com/package/faf-cli
- **claude-faf-mcp:** https://github.com/Wolfe-Jam/claude-faf-mcp
- **IANA:** `application/vnd.faf+yaml`

---

If `faf-skills` has been useful, consider starring the repo — it helps others find it.

## License

MIT License

---

*By [@Wolfe-Jam](https://github.com/Wolfe-Jam) · curated, not collected.*
