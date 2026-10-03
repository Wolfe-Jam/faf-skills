# FAF Skills

[![skills.faf.one](https://img.shields.io/badge/skills-faf.one-FF6B35)](https://skills.faf.one)
[![Open SKILL.md format](https://img.shields.io/badge/format-SKILL.md-1a1a1a)](https://agentskills.io)
[![.faf — IANA registered](https://img.shields.io/badge/.faf-IANA%20registered-00D4D4)](https://www.iana.org/assignments/media-types/application/vnd.faf+yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Wolfe-Jam/faf-skills?style=flat&color=FF6B35)](https://github.com/Wolfe-Jam/faf-skills/stargazers)

Claude Code skills for **persistent project context**: create, score and fill your `project.faf` to 100% ✪, keep CLAUDE.md in step, and generate test suites. Every skill is run end-to-end and receipt-proven before it ships. Built on the IANA-registered `.faf` format (`application/vnd.faf+yaml`).

```bash
# Plugin marketplace
/plugin marketplace add Wolfe-Jam/faf-skills
/plugin install faf@faf-skills

# Or manual
git clone https://github.com/Wolfe-Jam/faf-skills.git && cp -r faf-skills/skills/* ~/.claude/skills/
```

---

## The skills

| Skill | What it does |
|-------|--------------|
| **faf-context** — `/faf-context` | The quickstart **and the reference standard**: a sharp goal plus the 6 Ws, to **100% ✪** fast |
| **faf-go** — `/faf-go` | A guided interview (AskUserQuestion) for the slots only you can fill |
| **faf-wizard** — `/faf-wizard` | Done-for-you `project.faf` generator |
| **faf-expert** — `/faf-expert` | The mechanic's manual: scoring internals, MCP setup, sync, the always-33 slot model |
| **wjttc-builder** — `/wjttc-builder` | Plans and generates tiered test suites (Brake · Engine · Aero · Tyre · Pit) |
| **wjttc-tester** — `/wjttc-tester` | Runs a test plan, reproduces bugs, and files a tiered report |
| **repo-maintainer** — `/repo-maintainer` | Multi-phase repository health audit |

> **Receipt:** a real project taken from `29%` → **`100% ✪`** by following exactly the model `faf-context` teaches: `faf auto` to detect and seed, fill the gaps the AI can't source, `slotignored` what doesn't apply, re-score to Trophy. Deterministic and falsifiable. *(FAF don't lie.)*

Every skill is held to the **FAF Skill Standard** (accurate · on-brand · genuinely procedural).

---

## Tier System

| Score | Tier | Symbol |
|-------|------|--------|
| 100% | Trophy | ✪ |
| 99% | Gold | ★ |
| 95% | Silver | ◆ |
| 85% | Bronze | ◇ |
| 70% | Green | ● |
| 55% | Yellow | ● |
| 1% | Red | ○ |
| 0% | White | ♡ |

> **✪ = 🏆 = 100%** — the same Trophy, two surfaces: **✪** is the FAF-at-Work mark (code · skills · CLI · the Skills Site); **🏆** is the social mark (X · blogs).

---

## Prerequisites

```bash
npm install -g faf-cli           # required
npm install -g claude-faf-mcp    # optional: MCP server
```

> `skills.json` is **generated** from the SKILL.md frontmatters and verified in CI — never edit it by hand (`node scripts/build-skills-json.mjs`).

---

## Resources

- **Website:** https://faf.one · **Skills Site:** https://skills.faf.one
- **faf-cli:** https://github.com/Wolfe-Jam/faf-cli · **npm:** https://npmjs.com/package/faf-cli
- **claude-faf-mcp:** https://github.com/Wolfe-Jam/claude-faf-mcp
- **IANA:** `application/vnd.faf+yaml`

---

★ bookmark repo: [github.com/Wolfe-Jam/faf-skills](https://github.com/Wolfe-Jam/faf-skills)

## License

MIT License

---

*By [@Wolfe-Jam](https://github.com/Wolfe-Jam) · curated, not collected · proof over promises.*
