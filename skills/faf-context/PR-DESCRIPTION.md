# PR: Add faf-context skill

## Title
`feat: Add faf-context skill - the missing link between package.json and README`

---

## Summary

Adds `faf-context` - a skill for generating `.faf` files that give any AI instant, persistent understanding of a project.

### The Missing Link

`project.faf` sits alphabetically between `package.json` and `README.md` — because that's exactly where it belongs conceptually:

```
package.json      ← What you HAVE (dependencies)
project.faf       ← How AI USES IT (context)   ← THE MISSING LINK
README.md         ← What it DOES (for humans)
```

> "package.json gives me a list of dependencies, .faf shows me how to use them"
> — Claude Code

**The gap this fills:** Every AI session wastes time reverse-engineering the bridge between "what dependencies do I have" and "what does this project do." That bridge is `project.faf`.

### The Reality

**Every repo starts at 0%.** React. Kubernetes. Your codebase. ALL of them.

Why? Because AI-context doesn't exist until you create it. Documentation ≠ AI-context.

```
Before faf init:    0%   [RED]     - AI guesses everything
After faf init:    ~60%  [GREEN]   - AI understands basics
After faf auto:    85%+  [BRONZE]  - AI collaboration is productive
After faf go:      100%  [TROPHY]  - Championship-grade context
```

**The good news:** Getting to 100% is easy. `faf init` bootstraps, `faf auto` optimizes, `faf go` guides you to perfection - all with minimal technical input. The tooling does the heavy lifting.

### The Problem This Solves

Even React, Kubernetes, and Rails score 0% for AI-context. Why? Because AI-context is a NEW requirement - it didn't exist until AI became a coding partner.

| File | What it answers |
|------|-----------------|
| package.json | "What dependencies?" (for tools) |
| **project.faf** | "How should AI help build this?" (for AI) |
| README.md | "What does this do?" (for humans) |

Great documentation doesn't mean great AI-context. They're different artifacts for different readers.

### What This Skill Does

- Generates `project.faf` for ANY project (new, legacy, famous, or forgotten)
- Detects stack from manifests (package.json, Cargo.toml, pyproject.toml, go.mod)
- Mines existing context from README, docs/, CLAUDE.md, .cursorrules
- Scores AI-readiness (Bronze 85%+ = production ready)
- Portable across Claude, Cursor, Gemini CLI, WARP, Windsurf

### Credentials

- **IANA-registered:** `application/vnd.faf+yaml` (Oct 31, 2025)
- **21,000+ npm downloads**
- **Anthropic MCP Registry:** #2759 (merged)
- **Website:** https://faf.one

## Files Added

```
skills/faf-context/
├── SKILL.md              # 142 lines
├── LICENSE.txt           # Apache 2.0
└── references/
    ├── format-spec.md    # .faf schema
    ├── tier-system.md    # Scoring methodology
    └── templates.md      # Per-stack examples
```

## Why This Belongs Here

Current skills cover documents (pdf, docx), creation (art, design), and dev tools (mcp-builder) — but nothing for **project context**.

This is the "BEFORE you code" skill:
- mcp-builder = build servers
- webapp-testing = test apps
- **faf-context = give AI context first**

## Test Plan

- [ ] SKILL.md frontmatter validates
- [ ] Triggers on "what does this project do?"
- [ ] Stack detection works (TS, Rust, Python, Go)
- [ ] Generated .faf is valid YAML
- [ ] References load via progressive disclosure

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)
