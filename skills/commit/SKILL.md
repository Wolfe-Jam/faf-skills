---
name: commit
description: Context-aware git commits powered by FAF. Reads .faf project DNA to generate meaningful commit messages. Use when committing code changes. Foundation Layer integration ensures commits reflect project goals.
---

# Commit - FAF-Powered Git Commits

**"Commits that understand your project."**

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

When activated, commit reads from your project's foundation:

```
🔗 CONNECTING TO FOUNDATION
   Reading: project.faf
   Context: project.goal, stack, conventions
   Status: ALIGNED

✅ Commit context loaded from .faf
   Your commits now reflect project DNA
```

## When to Use This Skill

Activate when:
- User types `/commit`
- User asks to commit changes
- User says "commit this" or "make a commit"
- After completing a coding task
- User wants help with commit messages

## How FAF Improves Commits

**Without FAF:**
```
git commit -m "fix bug"
git commit -m "update code"
git commit -m "changes"
```

**With FAF Foundation:**
```
git commit -m "fix: resolve API timeout in voice streaming

Addresses issue where Grok voice responses would timeout
after 30s. Now properly handles chunked streaming.

Context: FAF-Voice browser-to-xAI integration"
```

The difference: FAF provides `project.goal`, `human_context.why`, and `stack` information that makes commits meaningful.

## Commit Workflow

### Step 1: Read Foundation Context

Before generating commit message, read from .faf:

```yaml
# From project.faf
project:
  name: "faf-voice"
  goal: "Browser-to-xAI voice client with eternal memory"

human_context:
  why: "Prove voice persistence to xAI"
  what: "Zero drift, zero re-explain voice assistant"
```

### Step 2: Analyze Changes

Run git commands to understand what changed:

```bash
git status
git diff --staged
git diff
```

### Step 3: Generate Context-Aware Message

Use .faf context to create meaningful commit:

**Format:**
```
<type>: <short description>

<optional body with context from .faf>

<optional footer>
```

**Types (conventional commits):**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Formatting (no code change)
- `refactor:` - Code restructure (no behavior change)
- `test:` - Adding tests
- `chore:` - Maintenance tasks

### Step 4: Execute Commit

```bash
git add <files>
git commit -m "<message>"
```

## Commit Message Templates

### Feature Commit
```
feat: add voice streaming to Grok integration

Implements real-time voice streaming from browser to xAI API.
Uses chunked transfer encoding for low-latency responses.

Part of FAF-Voice demo for xAI partnership.
```

### Bug Fix Commit
```
fix: resolve memory leak in voice session handler

Sessions were not properly cleaned up after disconnect.
Now implements proper cleanup in WebSocket close handler.

Fixes eternal memory persistence issue.
```

### Refactor Commit
```
refactor: extract voice codec logic to separate module

Moves audio encoding/decoding to dedicated VoiceCodec class.
Improves testability and prepares for multi-codec support.

No behavior change - all existing tests pass.
```

## Integration with Claude Code

This skill uses Claude Code patterns:

1. **Read .faf first** - Always check project context
2. **Use git tools** - Bash for git operations
3. **TodoWrite** - Track commit progress if multiple commits needed
4. **Bi-sync awareness** - Commits may affect CLAUDE.md context

## FAF Fields Used for Commits

| Field | Usage |
|-------|-------|
| `project.name` | Prefix for multi-repo commits |
| `project.goal` | Context for "why" in commit body |
| `human_context.why` | Business reason for change |
| `human_context.what` | Feature context |
| `stack.*` | Technical context |

## Example Session

```
User: /commit

Claude: Let me check your .faf for project context.

[Reads project.faf]
[Runs git status]
[Runs git diff --staged]

Based on your changes and project context, here's the commit:

feat: implement voice session persistence

Adds WebSocket reconnection with session recovery.
Voice context survives browser refresh and network drops.

Part of FAF-Voice eternal memory demo.

[Executes: git commit -m "..."]

✅ Committed! Your changes are now part of the project history.
```

## Commit Best Practices

1. **One logical change per commit** - Don't mix unrelated changes
2. **Present tense** - "add feature" not "added feature"
3. **Imperative mood** - "fix bug" not "fixes bug"
4. **Reference .faf goal** - Connect changes to project purpose
5. **50/72 rule** - Subject ≤50 chars, body wrapped at 72

## Related Skills

- `/pr` - Create pull request (uses commit context)
- `/review` - Review code changes
- `/release` - Version and changelog

---

## The Foundation Promise

> .faf is the format. project.faf is the file.
> 100% 🏆 AI Readiness is the result.

---

*FAF Foundation Layer - Native to Claude Code*
*"Commits that understand your project."*
