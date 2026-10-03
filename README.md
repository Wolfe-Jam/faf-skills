# FAF Skills

[![skills.faf.one](https://img.shields.io/badge/skills-faf.one-FF6B35)](https://skills.faf.one)
[![Open SKILL.md format](https://img.shields.io/badge/format-SKILL.md-1a1a1a)](https://agentskills.io)
[![.faf — IANA registered](https://img.shields.io/badge/.faf-IANA%20registered-00D4D4)](https://www.iana.org/assignments/media-types/application/vnd.faf+yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Wolfe-Jam/faf-skills?style=flat&color=FF6B35)](https://github.com/Wolfe-Jam/faf-skills/stargazers)

**Claude starts every session knowing your project.** These skills help you build a `project.faf`: one small file with your project's goal, stack and the who, what and why, scored 0–100% so you can see exactly what's missing. Built on the IANA-registered `.faf` format (`application/vnd.faf+yaml`). The set also includes skills for risk-tiered test plans and repo health checks.

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
| **faf-context** — `/faf-context` | The quickstart: a sharp goal plus the who, what, why, where, when and how, to **100% ✪** fast |
| **faf-go** — `/faf-go` | A guided interview (AskUserQuestion) for the slots only you can fill |
| **faf-wizard** — `/faf-wizard` | Done-for-you `project.faf` generator |
| **faf-expert** — `/faf-expert` | The reference: how scoring works, MCP setup, sync, and the 33 slots every `.faf` is scored on |
| **wjttc-builder** — `/wjttc-builder` | Plans and generates WJTTC test suites, tiered by risk (Brake · Engine · Aero · Tyre · Pit) |
| **wjttc-tester** — `/wjttc-tester` | Runs a test plan, reproduces bugs, and files a tiered report |
| **repo-maintainer** — `/repo-maintainer` | Multi-phase repository health audit |

## Works with CLAUDE.md

Claude Code reads `CLAUDE.md` for your project instructions. `project.faf` doesn't replace it. It's the structured source behind it:

- **Scored.** A 0–100% score shows exactly which facts about your project are missing.
- **Kept in step.** `faf sync` writes CLAUDE.md from it, so the two never drift.
- **Portable.** The same file writes `AGENTS.md`, `.cursorrules`, `GEMINI.md` and Copilot instructions (`faf export`), so every AI tool gets the same facts.
- **Yours.** Plain YAML in your repo: read it, diff it, commit it.

Write your instructions in CLAUDE.md. Keep the facts about your project in project.faf.

## Try it

Ask Claude in any project:

- *"Create a project.faf for this repo and score it."* → `faf-context` / `faf-wizard`
- *"Interview me for the slots you can't fill, until we hit 100%."* → `faf-go`
- *"Plan a tiered test suite for this repo."* → `wjttc-builder`

> **Receipt:** [agents-md-facts](https://github.com/Wolfe-Jam/agents-md-facts) went from `52%` → **`100% ✪`** ([PR #1](https://github.com/Wolfe-Jam/agents-md-facts/pull/1)) by following exactly the model `faf-context` teaches: `faf auto` to detect and seed, fill the one gap the AI couldn't source (Bun, from `bun.lock`), `slotignored` what doesn't apply, re-score. The score is deterministic: run `npx faf-cli score project.faf` in that repo and you get the same number.

Every command, flag and tool a skill names is checked against the live faf-cli and claude-faf-mcp before it ships.

---

## Tier System

| Score | Tier | Symbol |
|-------|------|--------|
| 100% | <img src="assets/trophy.svg" width="16" alt="Trophy"> Trophy | ✪ |
| 99% | Gold | ★ |
| 95% | Silver | ◆ |
| 85% | Bronze | ◇ |
| 70% | Green | ● |
| 55% | Yellow | ● |
| 1% | Red | ○ |
| 0% | White | ♡ |

> **✪ Trophy = 100%: AI is optimized to code.** Every definition slot for your app type is filled, so AI has the truth about your stack and your intent.

---

## Prerequisites

```bash
npm install -g faf-cli                           # required (or: brew install wolfe-jam/faf/faf-cli)
claude mcp add faf -- npx -y claude-faf-mcp@7.0.1   # optional: MCP server
```

## What this plugin runs

The plugin ships skills only: no hooks, no MCP servers, nothing runs on install. The skills ask Claude to run local `faf` commands, which read and write files in your project (`project.faf`, `CLAUDE.md`, `AGENTS.md`). Network use: installing `faf-cli` or running `npx claude-faf-mcp@7.0.1` downloads from npm; `faf git <url>` shallow-clones a public GitHub repo to a temp folder; `faf bench --submit` (opt-in) posts a score receipt to a public ledger. The plugin itself collects no data.

**Support:** [GitHub issues](https://github.com/Wolfe-Jam/faf-skills/issues) · team@faf.one

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
