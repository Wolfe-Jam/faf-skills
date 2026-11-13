---
name: faf-context
description: 'Runs `faf auto` to detect the stack, suggests the goal and six W''s from what the repo already says and asks you to confirm each one, scores the project.faf 0–100%, and `faf sync` writes the facts into CLAUDE.md. Use when someone wants Claude to know their project from the first message: "improve my CLAUDE.md", "set up project context", "Claude keeps forgetting my stack". Takes a CLAUDE.md from GOOD (it exists) to BETTER (backed by a scored project.faf). The quickest path; faf-go fills the last gaps, faf-expert goes deep.'
license: MIT
---

<!-- faf:start -->
```yaml
v: 1
needs:
  - "faf-cli on Node 22+ (not installed: run `npx faf-cli <command>` in place of `faf <command>`)"
reads: [project.faf, "the repo's manifests and README"]
writes:
  - "project.faf (faf auto)"
  - "CLAUDE.md (faf sync, faf's block only)"
network: ["registry.npmjs.org (read, only when npx fetches faf-cli)"]
publishes: false
done_when: "project.faf is scored, and CLAUDE.md is written by faf sync"
project: project.faf
```
<!-- faf:end -->

# FAF Context — Give the AI What It Needs

**AI writes its best code when it has your project's context. This skill helps you hand it over — fast, and to 100%.**

`.faf` is an **IANA-registered context format** (`application/vnd.faf+yaml`) — a typed, portable file *you own*, readable by any AI (no bespoke manifest, no vendor lock-in). The whole point is one number: **AI-readiness, 0–100%.** At **100% ✪** the AI starts every session already knowing your project — no re-explaining, no guessing. This skill is the *builder's* path to that number: minimum typing, maximum context.

> For a .faf generated from the repo, with the goal and six W's suggested for you to confirm, use **faf-wizard**. To master the format, use **faf-expert**. This skill is the quickstart in between.

## How it works: app-type → AI fills the max → you answer the gaps

**Every `.faf` is scored against the same 33 slots.** faf-cli fills the 21 base slots and marks the 12 enterprise slots `slotignored` unless your app type uses them; slotignored slots never count against you. **100% ✪ = every active slot filled.** It works in three steps, and only the last one needs you:

1. **Your app type sets which slots are *required*.** A CLI needs different slots than a full-stack web app — faf-cli right-sizes the set and `slotignored`s the rest (never counted against you).
2. **The AI fills what it can detect.** `faf auto` detects your stack and language. The goal and six W's it only **suggests**, from your README and package.json, and a sharp **goal sentence** seeds suggestions for who/what/where.
3. **You confirm the rest.** `faf go` shows each suggestion with where it came from; you accept it, edit it, or skip. Anything with no suggestion, you answer. → **100% ✪.**

So your job isn't "fill 33 boxes." It's: **write one good goal, confirm the suggestions, and answer the few the repo can't.**


## You rarely type all 6 Ws — here's why

The 6 Ws are "the underivable half": they're yours, and nothing is written into them until you confirm it. But you rarely type all six from scratch:

- **who / what / where** → **suggested from your goal sentence** (the facts your goal literally states)
- **why / how** → **suggested from your README** when it has a `## Why` or `## How it works` section
- **when** → usually yours to type: the stage it's at, and since when

**So the fast path is: write one sharp goal, confirm the suggestions, type what's left. → 100%.**

> **"Sometimes the goal alone is enough."** A great goal sentence and a README with a Why section can suggest most of the six, leaving you one or two short answers. You still confirm each one.

## The fastest path to 100% ✪

```bash
faf auto      # 1. Detects your stack; says how many suggestions wait for the goal and 6 Ws
faf score     # 2. See the number + exactly which slots are still empty
faf go        # 3. Each suggestion in gray, with its source: Enter confirms, Tab edits, skip leaves it
faf score     # 4. 100% ✪
faf sync      # 5. Push context into CLAUDE.md (optional; AGENTS.md: faf export --agents)
```

Most projects are one good goal sentence, a few confirmations and an answer or two away from Trophy.

## Write the ONE goal sentence (this does the heavy lifting)

The goal is the **generative input**: it seeds suggestions for who/what/where, which you confirm in `faf go`. Make it a real, specific sentence (it's also your *use-case*):

- ✓ *"A CLI that scores any repo's AI-readiness and syncs context to Claude, Cursor, and Gemini — for solo developers."*
  → suggests **what** (a CLI that scores AI-readiness), **where** (Claude, Cursor, Gemini), **who** (solo developers). You confirm those and add **why**, **when** and **how**.
- ✗ *"A tool to improve development."* → generic; seeds nothing. (Generic phrases are *ignored* on purpose — empty beats wrong.)

## The 6 Ws — one line each, every word earns its place

Each W is one line of fact, not a paragraph: short when the fact is short, a full line when it needs one.

| W | Holds | Example |
|---|------|---------|
| Who | the people who use it, not the author | `solo developers` |
| What | what they make or do with it | `an AI-readiness score for any repo` |
| Why | the problem it removes | `AI forgets the project every session` |
| Where | where it runs or ships | `npm, Homebrew` |
| When | the stage it's at, and since when (not a version) | `production since September 2025` |
| How | how it works: the mechanism, not an install command or a stack list | `detects the stack from repo files; scores with a WASM kernel` |

## Slots that don't apply → `slotignored`

A CLI has no frontend; an API has no UI library. Mark those **`slotignored`** and they drop out of the denominator — you're scored only on slots that *matter for your app type*. **100% means "everything that applies is filled,"** not "every box checked." (`faf auto` and `faf go` handle most of this for you.)

## The honesty rule (why this works)

The AI **only suggests facts your goal/README literally state**, never invents, never uses templates, and **writes none of the goal or six W's until you confirm it.** What it can't source, it leaves empty for you. **Empty beats wrong.** That's why the resulting context is trustworthy: every slot is either detected, confirmed by you, or honestly blank.

## When you're done here

- Want a `.faf` generated from the repo, with the goal and six W's suggested for you to confirm? → **faf-wizard**
- Want to **master** the format (scoring internals, MCP config, sync)? → **faf-expert**
- Driving a repo all the way with an agent? → **`faf go`** / **`faf loop`**

---

**The goal:** the AI is only as good as the context you give it. Answer the few things only you know — the gaps it couldn't fill itself — and it's optimized to help you at **100% ✪**.

*MIT · part of the FAF skill family (faf-context · faf-wizard · faf-expert)*
