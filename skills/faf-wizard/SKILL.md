---
name: faf-wizard
description: Done-for-you .faf generator. Creates AI-context DNA for ANY project — new, legacy, famous, or forgotten. Detects stack, mines existing context, generates project.faf, scores AI-readiness. Use when onboarding AI to any codebase. Works with Claude, Cursor, Gemini CLI, WARP, Windsurf. See also faf-expert for the mechanic's manual.
license: MIT
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

**Even famous repos have no AI-context.** React. Kubernetes. Rails. Django — none ship a `.faf`. Detection alone gets React to ~56%; the human half (who / why / where) that grounds an AI is missing. **That's the gap.**

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

Create focused AI context at project root. **faf-cli scores on 21 slots** — `app_type` selects which are *active*; the rest are `slotignored` (never counted against you). Detection fills the stack; the human supplies the underivable bits (`project.name`/`goal` + the 6 Ws). `human_context.how` is **how it's built** (sourced from the stack), not AI preferences.

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
  how: TypeScript · Express · PostgreSQL

stack:
  frontend: react
  backend: express
  api_type: rest
  runtime: node
  database: postgresql
  deployment: vercel
  build: vite
  testing: vitest
  cicd: github-actions
```

Keep under 200 lines. Only what changes AI behavior.

### Step 4: Score and Report

```
Generated: project.faf
AI-Readiness: 87% ◇ Bronze — Production ready

Filled: 9/11 active slots
slotignored: the slots that don't apply to this app_type (never counted)

To reach 100% ✪:
  - Add deployment details
  - Document the testing strategy
  - Fill the last Ws the AI couldn't source
```

**The target is 100% ✪ — Bronze is the floor, not the finish line.** At 100% every *active* slot is filled and the AI starts every session already knowing the project.

## Tier System

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

**Target: 100% ✪.** Bronze (◇ 85%) is the floor where AI collaboration becomes productive — Trophy is the goal: every *active* slot filled, the AI fully grounded from session one.

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
- In the **original Anthropic MCP ecosystem** (#2759, merged Oct 2025)
- **Website:** https://faf.one
