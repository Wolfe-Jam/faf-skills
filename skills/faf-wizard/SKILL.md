---
name: faf-wizard
description: Done-for-you .faf generator. Creates AI-context DNA for ANY project — new, legacy, famous, or forgotten. Detects stack, mines existing context, generates project.faf, scores AI-readiness. Use when onboarding AI to any codebase. Works with Claude, Cursor, Gemini CLI, WARP, Windsurf. See also faf-expert for the mechanic's manual.
---

# FAF Wizard - Done For You

> **The pit crew.** Point it at any project, get a scored `.faf` file back.
> See also: `faf-expert` — the mechanic's manual for when you want to understand every bolt.

## What This Does

Generates a `project.faf` file for any codebase. You don't need to know the format — the wizard handles detection, generation, scoring, and reporting.

```
You: "Set up project context for this repo"
Wizard: Detects stack → generates project.faf → scores it → reports gaps
```

## The Problem It Solves

**Even famous repos score 0%.** React. Kubernetes. Rails. Django. None have AI-context.

| What exists | What it answers |
|-------------|-----------------|
| README.md | "What does this do?" (for humans) |
| docs/ | "How do I use this?" (for humans) |
| **project.faf** | "How should AI help build this?" (for AI) |

Documentation tells humans how to use code. AI-context tells AI how to help you write it. **They're not the same thing.**

## Works on ANY Project

| Project State | What FAF Wizard Does |
|--------------|----------------------|
| **Brand new** | Optimized AI context from line one |
| **Legacy codebase** | AI finally understands the archaeology |
| **Famous OSS** | Even React needs this (it doesn't have one) |
| **Side project** | Stop re-explaining every session |
| **Client handoff** | Portable context for any AI tool |

## Workflow

### Step 1: Detect Stack

Look for manifest files:
- `package.json` → Node.js/TypeScript
- `Cargo.toml` → Rust
- `pyproject.toml` → Python
- `go.mod` → Go
- `pom.xml` → Java
- `Gemfile` → Ruby

No manifest? Still generate — ask user for stack info.

### Step 2: Mine Existing Context

Pull signals from what exists:
- README.md (description, purpose)
- docs/ (architecture decisions)
- CLAUDE.md or .cursorrules (existing AI context — migrate it)
- Package manifests (dependencies reveal intent)
- Directory structure (architecture patterns)

### Step 3: Generate project.faf

Create focused AI context at project root using Mk4 33-slot structure:

```yaml
faf_version: "3.0"

project:
  name: my-project
  goal: One-line purpose
  main_language: typescript

human_context:
  who: Solo developer
  what: REST API for task management
  why: Learning project, portfolio piece
  where: Vercel (serverless)
  when: Started March 2026
  how: TypeScript, Express, PostgreSQL

stack:
  frontend: react
  css_framework: tailwind
  backend: express
  api_type: rest
  runtime: node
  database: postgresql
  hosting: vercel
  build: vite
  cicd: github-actions
```

Keep under 200 lines. Only what changes AI behavior.

### Step 4: Score and Report

```
Generated: project.faf
AI-Readiness: 87% 🥉 Bronze — Production ready

Filled: 9/11 active slots
Ignored: 22 slots (not applicable for this project type)

To reach Silver (95%):
  - Add deployment details (+5%)
  - Document API patterns (+3%)
```

## Tier System (Mk4)

| Score | Tier | Emoji |
|-------|------|-------|
| 100% | Trophy | 🏆 |
| 99%+ | Gold | 🥇 |
| 95%+ | Silver | 🥈 |
| 85%+ | Bronze | 🥉 |
| 70%+ | Green | 🟢 |
| 55%+ | Yellow | 🟡 |
| > 0% | Red | 🔴 |
| 0% | White | 🤍 |

**Target: 🥉 Bronze (85%+).** This is where AI collaboration becomes productive.

## Migration

When CLAUDE.md or .cursorrules exist:
- Offer to migrate to .faf (portable format)
- .faf works in Cursor, Gemini, WARP, Windsurf — not just Claude
- YAML structure parses better than freeform markdown

## Validation

Generated files must:
- Be valid YAML
- Have `faf_version` and `project.name`
- Contain NO secrets or credentials
- Stay under 500 lines

## Credentials

- **IANA Media Type:** `application/vnd.faf+yaml`
- **Anthropic MCP:** Registry #2759 (merged)
- **Website:** https://faf.one
