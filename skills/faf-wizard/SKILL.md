---
name: faf-wizard
description: 'Detects the stack, reads what already exists (README, docs, an existing CLAUDE.md or .cursorrules), writes project.faf and scores it. The stack comes from the repo; the goal and six W''s are suggested from what exists, each with its source, and written only once the user confirms them. Use when someone wants project context set up for them: "set up Claude for this repo", "onboard AI to this codebase", "make me a project.faf". Works on new, legacy or inherited code. Turns the CLAUDE.md you already have into the structured facts behind it: GOOD to BETTER.'
license: MIT
---

<!-- faf:start -->
```yaml
v: 1
needs:
  - "faf-cli on Node 22+ for the score (not installed: run `npx faf-cli score`)"
reads: [README.md, docs/, "CLAUDE.md or .cursorrules", package manifests, the directory structure]
writes: ["project.faf at the project root (stack from the repo; the goal and six W's only as the user confirms them)"]
network: ["registry.npmjs.org (read, only when npx fetches faf-cli)"]
publishes: false
done_when: "project.faf exists at the project root and has a score"
project: project.faf
```
<!-- faf:end -->

# FAF Wizard

> **The pit crew.** Point it at any project, get a scored `.faf` file back: the repo's facts filled in, the goal and six W's suggested for you to confirm.
> See also: `faf-expert` — the mechanic's manual for when you want to understand every bolt.

## What This Does

Generates a `project.faf` file for any codebase. You don't need to know the format: the wizard handles detection, generation, scoring and reporting. The one thing it never does is decide your project's goal and six W's for you: it suggests them, and you confirm each one.

```
You: "Set up project context for this repo"
Wizard: Detects stack → writes project.faf → suggests the goal and 6 W's → you confirm → scores it → reports gaps
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

Pull signals from what exists. These are **sources for suggestions**, never values written straight into the goal or the six W's:
- README.md (the first paragraph, a `## Why` or `## What` section)
- docs/ (architecture decisions)
- CLAUDE.md or .cursorrules (existing AI context, to migrate)
- Package manifests (the `description`; dependencies reveal the stack)
- Directory structure (architecture patterns)

### Step 3: Generate project.faf

Create focused AI context at project root. **Every `.faf` is scored against the same 33 slots**: faf-cli fills the 21 base slots and marks the 12 enterprise slots `slotignored` unless your app type uses them. `app_type` selects which are *active*; the rest are `slotignored` (never counted against you).

Write the stack from detection (`faf init` or `faf auto` does this, and leaves the goal and six W's empty). Then go to Step 3b: the goal and six W's are the person's to give.

```yaml
faf_version: "3.0"

project:
  name: my-project
  goal: One-line purpose
  main_language: typescript

human_context:               # the user's words, confirmed in Step 3b
  who: Small teams tracking shared tasks
  what: A REST API for task boards and assignments
  why: Spreadsheets lose who owns what
  where: Vercel (serverless), npm
  when: Beta since March 2026
  how: Express REST handlers over PostgreSQL; a queue worker sends reminders

stack:
  frontend: react
  backend: express
  api_type: rest
  runtime: node
  database: postgresql
  hosting: vercel
  build: vite
  testing: vitest                 # informational — not one of the 33 scored slots
  cicd: github-actions
```

Keep under 200 lines. Only what changes AI behavior.

### Step 3b: Suggest the goal and six W's, the user confirms

The goal and the six W's are human slots: AI suggests them, a person confirms each one. Never write one the user hasn't seen and approved.

1. **Draft a suggestion only where something exists to quote**, with its source: the README's first paragraph for the goal, the package `description` for `what`, a `## Why` section for `why`. Never offer an install line, a badge or link row, a notice ("deprecated", "sponsored by"), or a heading.
2. **Ask with AskUserQuestion**, one question per slot: the suggestion and its source (`README.md § Why`), with use it · edit it (Other) · skip. No suggestion: ask the question, with the slot's definition as help.
3. **Write only what the user confirmed, word for word:** `faf edit human_context.why "<their text>"` (or `project.goal`). Skipped slots stay empty.

What each slot holds (one line, every word earns its place):
- **goal:** what it does, and for whom
- **who:** the people who use it, not the author
- **what:** what they make or do with it
- **why:** the problem it removes
- **where:** where it runs or ships
- **when:** the stage it's at, and since when (not a version or a date to ship)
- **how:** how it works: the mechanism, and the choice that shapes the code (not an install command or a list of the stack)

### Step 4: Score and Report

```
Generated: project.faf
AI-Readiness: 87% ◇ Bronze — Production ready

Filled: 13/15 active slots
slotignored: the slots that don't apply to this app_type (never counted)

To reach 100% ✪:
  - Add deployment details
  - Document the testing strategy
  - Confirm the goal and W's still empty (faf-go asks for them)
```

**The target is 100% ✪ — Bronze is the floor, not the finish line.** At 100% every *active* slot is filled and the AI starts every session already knowing the project.

## Tier System

| Score | Tier | Symbol | Status |
|-------|------|--------|--------|
| 100% | Trophy | ✪ | AI is optimized to code |
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
- Hold no goal or W the user didn't confirm
- Be valid YAML
- Have `faf_version` and `project.name`
- Contain NO secrets or credentials
- Stay under 200 lines

## Credentials

- **IANA Media Type:** `application/vnd.faf+yaml`
- Listed in **modelcontextprotocol/servers** (#2759, merged 2025-10-17)
- **Website:** https://faf.one
