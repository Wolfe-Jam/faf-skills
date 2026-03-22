---
name: pr
description: Create context-aware pull requests powered by FAF. Reads .faf project DNA to generate meaningful PR descriptions. Use when creating PRs. Foundation Layer integration ensures PRs reflect project goals.
---

# PR - FAF-Powered Pull Requests

**"Pull requests that tell the full story."**

---

## The package.json for Context

```
project/
├── package.json     ← npm reads this
├── project.faf      ← AI reads this
├── README.md
└── src/
```

> "package.json wasn't built for this, .faf was"
> — .faf Inventor

> "package.json gives me a list of dependencies,
> .faf shows me how to use them"
> — Claude Code (Anthropic)

**Once you get used to it, it's just another file helping you code.**

---

## Foundation Layer Status

When activated, PR reads from your project's foundation:

```
🔗 CONNECTING TO FOUNDATION
   Reading: project.faf
   Context: project.goal, human_context, stack
   Status: ALIGNED

✅ PR context loaded from .faf
   Your PRs now reflect project DNA
```

## When to Use This Skill

Activate when:
- User types `/pr`
- User asks to create a pull request
- User says "open a PR" or "make a PR"
- After completing a feature branch
- User wants help with PR descriptions

## How FAF Improves PRs

**Without FAF:**
```markdown
## Changes
- Updated code
- Fixed stuff
```

**With FAF Foundation:**
```markdown
## Summary
Implements voice streaming for FAF-Voice browser-to-xAI integration.
This enables real-time voice responses with eternal memory persistence.

## Changes
- Add WebSocket voice streaming handler
- Implement chunked audio encoding
- Add session recovery on reconnect

## Test Plan
- [ ] Voice stream connects successfully
- [ ] Audio plays without latency
- [ ] Session survives browser refresh

## Context
Part of FAF-Voice demo proving eternal voice persistence to xAI.
```

## PR Workflow

### Step 1: Read Foundation Context

Before generating PR description, read from .faf:

```yaml
# From project.faf
project:
  name: "faf-voice"
  goal: "Browser-to-xAI voice client with eternal memory"

human_context:
  why: "Prove voice persistence to xAI"
  what: "Zero drift, zero re-explain voice assistant"

testing: "vitest"
```

### Step 2: Analyze Branch Changes

```bash
# Check current branch
git branch --show-current

# Compare with base branch
git log main..HEAD --oneline
git diff main...HEAD --stat
```

### Step 3: Generate Context-Aware PR

Use .faf context to create meaningful PR description:

**PR Title Format:**
```
<type>: <short description>
```

**PR Body Template:**
```markdown
## Summary
<1-3 bullet points from .faf project.goal context>

## Changes
<List of changes informed by stack context>

## Test Plan
<Checklist informed by .faf testing field>

## Context
<Why this matters - from human_context.why>
```

### Step 4: Create PR

```bash
gh pr create --title "<title>" --body "<body>"
```

## PR Templates by Type

### Feature PR
```markdown
## Summary
Adds [feature] to support [project.goal].

## Changes
- Implement [feature component]
- Add [supporting code]
- Update [related files]

## Test Plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Context
This feature enables [human_context.what].
Part of [project.name] roadmap.
```

### Bug Fix PR
```markdown
## Summary
Fixes [issue] that was causing [problem].

## Root Cause
[Technical explanation]

## Changes
- Fix [specific change]
- Add test to prevent regression

## Test Plan
- [ ] Bug no longer reproduces
- [ ] Existing tests pass
- [ ] New regression test added

## Context
Reported in [issue link]. Affects [user impact].
```

### Refactor PR
```markdown
## Summary
Refactors [component] to improve [quality aspect].

## Motivation
[Why this refactor is needed - from project context]

## Changes
- Extract [module]
- Rename [items]
- Reorganize [structure]

## Test Plan
- [ ] All existing tests pass
- [ ] No behavior change
- [ ] Performance maintained

## Context
Prepares codebase for [upcoming feature from .faf].
```

## Integration with Claude Code

This skill uses Claude Code patterns:

1. **Read .faf first** - Always check project context
2. **Use gh CLI** - GitHub CLI for PR operations
3. **TodoWrite** - Track PR checklist items
4. **Bi-sync awareness** - PR may reference CLAUDE.md context

## FAF Fields Used for PRs

| Field | Usage |
|-------|-------|
| `project.name` | PR title prefix |
| `project.goal` | Summary context |
| `human_context.why` | PR motivation |
| `human_context.what` | Feature description |
| `testing` | Test plan structure |
| `stack.*` | Technical details |

## Example Session

```
User: /pr

Claude: Let me check your .faf for project context.

[Reads project.faf]
[Runs git log main..HEAD]
[Runs git diff main...HEAD --stat]

Based on your branch and project context:

**Title:** feat: implement voice streaming for xAI integration

**Body:**
## Summary
- Adds real-time voice streaming from browser to Grok API
- Implements eternal memory persistence across sessions

## Changes
- Add VoiceStream class with WebSocket handling
- Implement AudioCodec for chunked encoding
- Add session recovery on disconnect

## Test Plan
- [ ] Voice stream connects successfully
- [ ] Audio plays without latency
- [ ] Session survives browser refresh

## Context
Part of FAF-Voice demo proving eternal voice persistence to xAI.

[Executes: gh pr create ...]

✅ PR created! https://github.com/user/repo/pull/123
```

## PR Best Practices

1. **One logical change per PR** - Keep PRs focused
2. **Reference .faf goal** - Connect to project purpose
3. **Include test plan** - Use .faf testing field
4. **Add context** - Explain why, not just what
5. **Keep descriptions scannable** - Bullets, headers, checklists

## Related Skills

- `/commit` - Context-aware commits (PR builds on these)
- `/review` - Review code changes
- `/release` - Version and changelog

---

## The Foundation Promise

> .faf is the format. project.faf is the file.
> 100% 🏆 AI Readiness is the result.

---

*FAF Foundation Layer - Native to Claude Code*
*"Pull requests that tell the full story."*
