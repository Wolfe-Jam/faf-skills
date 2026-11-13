---
name: faf-go
description: 'Runs `faf score`, then asks about each empty slot with AskUserQuestion, one question at a time, until the score reaches 100%. For the goal and six W''s it offers a suggestion from the repo with its source, and writes only what the user confirms. Use when someone wants to fill in what only they know about their project: "interview me", "ask me what''s missing", "get my project.faf to 100%". The answers go into project.faf; `faf sync` carries them into CLAUDE.md. Finishes the BETTER rung: every fact Claude can''t detect, supplied by the person who knows it.'
license: MIT
---

<!-- faf:start -->
```yaml
v: 1
needs:
  - "faf-cli on Node 22+ (not installed: run `npx faf-cli <command>` in place of `faf <command>`)"
  - "AskUserQuestion (Claude Code)"
reads: [project.faf]
writes:
  - "project.faf (the answers)"
  - "CLAUDE.md (faf sync, faf's block only)"
network: ["registry.npmjs.org (read, only when npx fetches faf-cli)"]
publishes: false
done_when: "project.faf scores 100%, or every slot still empty is one the user chose to skip; CLAUDE.md re-synced by faf sync"
project: project.faf
```
<!-- faf:end -->

# FAF Go — Guided Path to 100% ✪

**"Just type /faf-go, answer questions till you're done. 100% target."**

`.faf` is an **IANA-registered context format** (`application/vnd.faf+yaml`) — a typed, portable file *you own*, readable by any AI. **Every `.faf` is scored against the same 33 slots**: faf-cli fills the 21 base slots and marks the 12 enterprise slots `slotignored` unless your app type uses them. Your `app_type` selects which are *active*, and **100% ✪ = every active slot filled**. This skill is the guided interview that gets you there: faf-cli fills what it can detect, then Claude asks you, through AskUserQuestion, for the rest. The goal and six W's are yours: Claude suggests them where the repo has something to quote, shows where each came from, and writes only what you confirm.

## When to Use This Skill

Activate when:
- User wants to improve their .faf score
- User mentions "Trophy" or "100%"
- User has incomplete project context
- After `faf init` to fill in missing fields
- User says "help me with my .faf"

## Integration with Claude Code

FAF Go is built FOR Claude Code:
- **AskUserQuestion** - Native Claude Code UI for questions
- **multiSelect: true** - Allow multiple answers (e.g., "pytest + WJTTC")
- **TodoWrite** - Track progress through the interview
- **Structured output** - JSON that Claude Code understands
- **Sync** - Answers go into project.faf; `faf sync` writes them into CLAUDE.md (one way)

### multiSelect Support

Some questions allow multiple selections:
- `stack.testing` → "pytest + WJTTC" (informational — not one of the 33 scored slots)
- `stack.cicd` → "GitHub Actions + Cloud Build"
- `stack.frontend` → "React + Tailwind"

The goal and six W's are never multi-pick: each is one line in the user's words (see the templates below).

When `multiSelect: true`, user can pick 2+ options. Results are joined with " + ".

## Workflow

### Step 1: Check Current State

Run faf score to understand current position:

```bash
faf score --verbose
```

Or get it as structured data for programmatic use:

```bash
faf score --json
```

`--json` returns the score + per-slot breakdown — the empty slots are what you interview on (the priority order is in Step 2).

### Step 2: Ask Questions Using AskUserQuestion

For each missing field, use Claude Code's AskUserQuestion tool:

**Priority Order (most impactful first):**
1. `project.goal` - What does it do, and for whom? (one sentence)
2. `human_context.why` - What problem does it remove?
3. `human_context.who` - Who uses it? (not the author)
4. `human_context.what` - What do they make or do with it?
5. `project.main_language` - Primary language
6. `stack.database` - Database choice
7. `stack.hosting` - Where is it deployed?
8. `stack.frontend` - Frontend framework
9. `stack.backend` - Backend framework
10. `human_context.where` - Where does it run or ship? (platform, store, registry)
11. `human_context.when` - What stage is it at, and since when? (not a version)
12. `human_context.how` - How does it work? (the mechanism, and the choice that shapes the code; not an install command or a stack list)

**The goal and six W's: suggest, then ask.** They are human slots: AI suggests, the user confirms. Before asking one, look for something to quote: the README's first paragraph (goal), the package `description` (what), a `## Why` section (why). `faf init` and `faf auto` say how many suggestions are waiting, and in which files. Put the suggestion first in the question, with its source; never offer an install line, a badge or link row, a notice, or a heading. No suggestion: ask, with the slot's definition as help.

### Step 3: Apply Answers

After collecting answers, write each one as the user gave it, nothing else:

```bash
faf edit human_context.why "<the user's words>"   # one call per answer
faf score                                         # verify
```

A slot the user skipped stays empty. Never write a goal or W the user didn't confirm.

### Step 4: Celebrate, or stop with what's open

- Score 100%: celebrate Trophy ✪.
- Under 100%: ask the next empty slot. **Never re-ask a slot the user skipped this session.** When every empty slot has been asked or skipped, stop: report the score and the slots still open (the user can run faf-go again any time).

## Question Templates for AskUserQuestion

### Single-Select Questions (pick one)

#### project.goal (with a suggestion from the repo)
```json
{
  "question": "What does it do, and for whom? Suggested from README.md § first paragraph.",
  "header": "Goal",
  "multiSelect": false,
  "options": [
    {"label": "Use the suggestion", "description": "A tiny parser that turns small config files into typed objects for Node.js apps."},
    {"label": "Skip for now", "description": "Leave the goal empty"}
  ]
}
```
"Other" lets the user edit it or type their own. Write exactly what they chose.

#### human_context.why (with a suggestion from the repo)
```json
{
  "question": "What problem does it remove? Suggested from README.md § Why.",
  "header": "Why",
  "multiSelect": false,
  "options": [
    {"label": "Use the suggestion", "description": "Hand-rolled config parsing breaks on edge cases and gives you untyped data."},
    {"label": "Skip for now", "description": "Leave why empty"}
  ]
}
```
No suggestion in the repo: ask the question with the slot's definition as help, and let the user type the answer.

#### stack.database
```json
{
  "question": "What database do you use?",
  "header": "Database",
  "multiSelect": false,
  "options": [
    {"label": "PostgreSQL", "description": "Relational database"},
    {"label": "MongoDB", "description": "Document database"},
    {"label": "SQLite", "description": "File-based database"},
    {"label": "None", "description": "No database"}
  ]
}
```

#### stack.hosting
```json
{
  "question": "Where is this deployed?",
  "header": "Hosting",
  "multiSelect": false,
  "options": [
    {"label": "Vercel", "description": "Frontend/serverless"},
    {"label": "AWS", "description": "Amazon Web Services"},
    {"label": "Local only", "description": "Not deployed"},
    {"label": "Other", "description": "Different platform"}
  ]
}
```

### Multi-Select Questions (pick multiple, joined with " + ")

#### stack.testing (informational — not scored)
```json
{
  "question": "What testing tools/methodologies do you use?",
  "header": "Testing",
  "multiSelect": true,
  "options": [
    {"label": "pytest", "description": "Python testing framework"},
    {"label": "Jest", "description": "JavaScript testing"},
    {"label": "Vitest", "description": "Vite-native testing"},
    {"label": "WJTTC", "description": "Championship methodology (Layer 2)"}
  ]
}
```
**Result format:** `pytest + WJTTC` (industry first, WJTTC follows)

**Ordering:** When both selected, industry tests come first:
- `pytest + WJTTC` (not `WJTTC + pytest`)
- WJTTC can also run standalone

#### stack.cicd
```json
{
  "question": "What CI/CD tools do you use?",
  "header": "CI/CD",
  "multiSelect": true,
  "options": [
    {"label": "GitHub Actions", "description": "GitHub-native CI/CD"},
    {"label": "Cloud Build", "description": "Google Cloud CI/CD"},
    {"label": "CircleCI", "description": "CircleCI pipelines"},
    {"label": "None", "description": "No CI/CD yet"}
  ]
}
```
**Result format:** `GitHub Actions + Cloud Build`

#### stack.frontend
```json
{
  "question": "What frontend technologies do you use?",
  "header": "Frontend",
  "multiSelect": true,
  "options": [
    {"label": "React", "description": "React framework"},
    {"label": "Next.js", "description": "React meta-framework"},
    {"label": "Svelte", "description": "Svelte framework"},
    {"label": "None/API-only", "description": "No frontend"}
  ]
}
```

#### human_context.who (and what, where, when, how) with no suggestion in the repo
```json
{
  "question": "Who uses it? The people who use it, not the author. One line.",
  "header": "Who",
  "multiSelect": false,
  "options": [
    {"label": "Let me type it", "description": "e.g. Small teams tracking shared tasks"},
    {"label": "Skip for now", "description": "Leave who empty"}
  ]
}
```
The same shape for every W without a suggestion: the question is the slot's definition (Step 2), the example shows the kind of answer, and "Other" takes the user's words. With a suggestion from the repo, use the goal/why shape instead: the suggestion first, with its source.

### Processing Multi-Select Answers

When user selects multiple options, join them with " + ":

```python
# Example: User selects ["pytest", "WJTTC"]
selected = ["pytest", "WJTTC"]
value = " + ".join(selected)  # "pytest + WJTTC"
```

This creates readable, scannable values in the .faf file:
```yaml
stack:
  testing: pytest + WJTTC
  cicd: GitHub Actions + Cloud Build
```

## Example Session

```
User: /faf-go

Claude: Let me check your current .faf status.

[Runs: faf score --verbose]

Your score is 45%. Let's get you to Trophy ✪!

[Uses AskUserQuestion for project.goal]

User: [Selects option or types custom]

Claude: Great! Now let's capture why this project exists.

[Uses AskUserQuestion for human_context.why]

... continues until 100% ...

Claude: ✪ TROPHY — 100%, AI is optimized to code!
Your AI now has complete context for championship performance.
```

## TodoWrite Integration

Track progress with todos:

```javascript
[
  {"content": "Answer project.goal question", "status": "completed"},
  {"content": "Answer human_context.why question", "status": "in_progress"},
  {"content": "Answer stack.database question", "status": "pending"},
  {"content": "Verify Trophy ✪ achieved", "status": "pending"}
]
```

## CLI Fallback

Outside Claude Code, the same destination is reached with the CLI's own interactive interview:

```bash
faf go            # interactive terminal interview (--resume continues a session)
```

This skill is the **Claude-native** version of that interview — AskUserQuestion instead of terminal prompts. For structured, programmatic data, use `faf score --json`.

## Success Metrics

- User reaches 100% score
- All required fields filled with meaningful content
- No placeholder values (TBD, Unknown, None where inappropriate)
- User understands what each field is for

## On Completion

When 100% ✪ is achieved:

```
✪ 100% Trophy — AI is optimized to code

project.faf: complete
CLAUDE.md:   run `faf sync` to update
```

Optionally run `faf sync` to emit CLAUDE.md (and `faf export --agents` for AGENTS.md) from the .faf. Your AI now starts every session with complete project context.

## Related Skills

- **faf-context** — the builder's quickstart: hand the AI what it needs to hit 100%, fast
- **faf-wizard**: a .faf for any project: the repo's facts filled in, the goal and six W's suggested for you to confirm
- **faf-expert** — master the format: scoring internals, MCP config, sync, the always-33 slot model

---

> .faf is the format. project.faf is the file.
> 100% ✪ AI-Readiness is the result.

---

*MIT · part of the FAF skill family (faf-context · faf-wizard · faf-expert). Native to Claude Code.*
