---
name: faf-expert
description: Master the IANA-registered .faf format (application/vnd.faf+yaml) — the typed, portable context that makes any AI understand your project. Covers scoring internals, MCP server config, bi-directional sync, and the full 21-slot model. The mechanic's manual for expert-level control. New to FAF? Start with faf-context to hit 100%, then come here to go deep. See also faf-wizard for the done-for-you path.
license: MIT
---

# FAF Expert — Master the Format

**`.faf` is an IANA-registered context format (`application/vnd.faf+yaml`)** — a typed, portable file *you own*, readable by any AI, with no bespoke manifest and no vendor lock-in. This is the mechanic's manual: scoring internals, MCP configuration, bi-directional sync, and the full slot model.

## The FAF skill family — where this fits

| Skill | What it's for | |
|-------|---------------|---|
| **faf-wizard** | Done-for-you — one-click `.faf` for any project | DFY |
| **faf-context** | The builder's quickstart — hand the AI what it needs to hit **100% ✪**, fast | **← start here if you're new** |
| **faf-expert** *(you are here)* | Master the format — scoring internals, MCP config, bi-sync, the full slot model | Deep |

*New to FAF? Start with **faf-context** to reach 100%. Come here to go deep.*

## When to use this skill

- Configuring `.faf` files and the MCP server beyond the basics
- Understanding the scoring engine and how to drive a project to high tiers
- Multi-AI workflows — one context across Claude, Cursor, Gemini, Codex, Windsurf
- Reviving a legacy codebase into AI-readable project DNA
- Standardizing context format across a team

## The format

```
project/
├── package.json     ← dependencies (npm reads this)
├── project.faf      ← AI context (any AI reads this)
├── CLAUDE.md        ← human docs (synced from .faf)
└── src/             ← code (guided by the context)
```

`README.md` is prose for humans · `CLAUDE.md` is prose for Claude · **`project.faf` is structure for ANY AI** (IANA `application/vnd.faf+yaml`). One source of truth; everything else is emitted from it.

### Universal compatibility — one `.faf`, every tool

| AI platform | Emitted file | Command |
|-------------|--------------|---------|
| Claude (Desktop / Code) | `CLAUDE.md` | `faf sync` |
| OpenAI Codex / agents | `AGENTS.md` | `faf sync` |
| Cursor | `.cursorrules` | `faf export --cursor` |
| Google Gemini | `GEMINI.md` | `faf export --gemini` |
| GitHub Copilot | `.github/copilot-instructions.md` | `faf export --copilot` |

## Quick start

**1. Install the CLI**
```bash
npm install -g faf-cli        # or: brew install wolfe-jam/faf/faf-cli
faf --version
```

**2. Configure the MCP server** — add to Claude Desktop's `claude_desktop_config.json`, then restart Claude:
```json
{
  "mcpServers": {
    "faf": {
      "command": "npx",
      "args": ["-y", "claude-faf-mcp@latest"]
    }
  }
}
```

**3. The loop to 100% ✪**
```bash
faf auto     # 1. detect stack + language, seed context from your README
faf score    # 2. the % + exactly which slots are still empty
faf go       # 3. guided fill — answer only the gaps the AI can't source
faf score    # 4. 100% ✪
faf sync     # 5. push context → CLAUDE.md / AGENTS.md
```

## CLI commands

```bash
# The path to Trophy
faf auto                # detect + seed (fills what it can)
faf score               # AI-readiness % + the empty slots
faf go                  # guided fill — close the gaps
faf sync                # emit CLAUDE.md / AGENTS.md from the .faf

# Anytime
faf init                # create a fresh project.faf
faf check               # validate structure (IANA-clean)
faf git <url>           # score any GitHub repo → .faf, no clone
faf formats             # browse the supported stacks
faf migrate             # upgrade an older .faf
faf export --copilot    # emit .github/copilot-instructions.md
faf taf setup           # wire up TAF test receipts (CI)
```

## MCP server tools

`claude-faf-mcp` brings the format into the tool surface. The live tool set (verified against the running server):

```
# The path to 100% ✪
faf_auto     → scan manifests (package.json, Cargo.toml, pyproject.toml…) + fill the .faf
faf_score    → 0–100% AI-readiness + tier + per-slot breakdown
faf_go       → the friendly front door — asks the 6 Ws
faf_sync     → sync .faf → CLAUDE.md (+ optionally AGENTS.md)

# Anytime
faf_init     → create a new project.faf (name, goal, language) + starting score
faf_context  → set / show the active project path faf_ calls resolve against
faf_doctor   → diagnose: empty / weak slots + how to fix each
faf_enhance  → refine the .faf with an AI model (claude / gemini / grok, optional consensus)
faf_trust    → attest integrity: validity, score + a deterministic parity hash anyone can verify
faf_bench    → prove the .faf earns its place — the context's worth on THIS repo, falsifiably
faf_about    → explain the FAF format — project DNA for AI (IANA-registered)

# Project soul (.fafm) — memory across sessions
faf_etch     → remember a decision / gotcha / win to the .fafm
faf_recall   → recall memories from the .fafm, ranked by priority + recency
```

(The exact set evolves release to release — verify against your installed version with the MCP client's tool list.)

## Scoring

### Tiers

| Score | Tier | Symbol | Status |
|-------|------|--------|--------|
| 100% | Trophy | ✪ | Perfect — Gold Code |
| 99% | Gold | ★ | Exceptional |
| 95% | Silver | ◆ | Top tier |
| 85% | Bronze | ◇ | Production ready |
| 70% | Green | ● | Solid foundation |
| 55% | Yellow | ● | Needs improvement |
| 1% | Red | ○ | Major work needed |
| 0% | White | ♡ | Empty |

The score is **deterministic** — a WASM-compiled engine, mechanical and falsifiable. Same input → same score, every time. **FAF doesn't lie.**

### The 21-slot model

**faf-cli scores on 21 slots.** Your `app_type` selects which are *active* — a CLI ignores frontend slots (`slotignored`, never counted against you). Detection fills the stack + language; you supply only the underivable bits — `project.name`/`goal` + the 6 Ws (a sharp goal seeds several). **100% = every *active* slot filled** (not all 21). *(Teams / Enterprise tiers add more slots — separate from faf-cli's 21.)*

```yaml
# project.faf — IANA application/vnd.faf+yaml
faf_version: "3.0"

project:                          # required
  name: modern-web-app
  goal: Real-time collaboration platform for distributed teams
  main_language: typescript

human_context:                    # the 6 Ws — the underivable half
  who: distributed product teams
  what: real-time collaboration tool
  why: remove the latency tax of async handoffs
  where: AWS (ECS)
  when: production, since 2026
  how: TypeScript · React · Node · PostgreSQL

stack:                            # auto-detected
  frontend: react
  backend: express
  database: postgresql
  runtime: node
  deployment: aws-ecs
  build: vite
  testing: vitest
  cicd: github-actions
```

**Validation rules:** must have `faf_version`, `project.name`, `project.goal` · valid YAML · **no secrets/credentials** · works across all AI platforms.

### The honesty rule

The engine **only scores what's truthfully there** — detection fills the stack, you fill the underivable Ws, and what nobody can source stays **honestly empty**. **Empty beats wrong.** That's why the resulting context is trustworthy.

## Best practices — drive to Trophy

```bash
faf auto                    # 1. baseline: detect + seed
faf score                   # 2. see the empty slots
faf go                      # 3. close the gaps (guided)
faf check                   # 4. IANA compliance
faf sync                    # 5. emit CLAUDE.md / AGENTS.md
git add project.faf CLAUDE.md AGENTS.md && git commit -m "Add AI context (.faf)"
```

The `.faf` **is** the standard — commit it, and everyone's AI shares one context. Common boosters: add the `human_context` block, specify deployment, document the testing strategy.

## Ecosystem

| Package | Registry | Purpose |
|---------|----------|---------|
| `faf-cli` (`faf`) | npm | the CLI |
| `claude-faf-mcp` | npm | Claude Desktop / Code MCP server |
| `faf-mcp` | npm | universal MCP server |
| `gemini-faf-mcp` | PyPI | Google Gemini integration |
| `grok-faf-mcp` | npm | xAI Grok integration |
| `faf-scoring-kernel` | npm | the WASM scoring engine |

**100k+ downloads across npm + PyPI + crates.io.** **claude-faf-mcp, faf-mcp, and gemini-faf-mcp hold AAA** on Glama (earned, not conferred).

## Standing

- **IANA-registered** media type: `application/vnd.faf+yaml`
- In the **original Anthropic MCP ecosystem** (PR #2759, merged Oct 2025)
- Maintainer of the `.faf` format specification

## Troubleshooting

**MCP server not responding**
```bash
faf check                                   # is the .faf well-formed?
# re-check claude_desktop_config.json (see Quick start), then restart Claude
tail -f ~/Library/Logs/Claude/mcp-server-claude-faf-mcp.log
```

**Low AI-readiness score**
```bash
faf score          # shows the empty slots holding you back
faf go             # guided fill — close them to 100%
```

**Tools not showing** — restart Claude after editing the config, and confirm the server started (see the MCP log above).

## Get this skill

- **Plugin marketplace (recommended):** `/plugin marketplace add Wolfe-Jam/faf-skills` → `/plugin install faf@faf-skills`
- **Manual:** `git clone https://github.com/Wolfe-Jam/faf-skills.git && cp -r faf-skills/skills/* ~/.claude/skills/`
- **Browse the family:** https://skills.faf.one

## Resources

- Website: https://faf.one · Skills Site: https://skills.faf.one
- faf-cli: https://github.com/Wolfe-Jam/faf-cli · npm: https://npmjs.com/package/faf-cli
- claude-faf-mcp: https://npmjs.com/package/claude-faf-mcp

---

*MIT · part of the FAF skill family (faf-context · faf-wizard · faf-expert). The format is the foundation — without `.faf`, there is no portable context.*
