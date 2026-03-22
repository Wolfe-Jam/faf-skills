---
name: review
description: Context-aware code reviews powered by FAF. Reads .faf project DNA to provide meaningful review feedback. Use when reviewing PRs or code changes. Foundation Layer integration ensures reviews align with project standards.
---

# Review - FAF-Powered Code Reviews

**"Reviews that understand your standards."**

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

When activated, review reads from your project's foundation:

```
🔗 CONNECTING TO FOUNDATION
   Reading: project.faf
   Context: stack, testing, conventions
   Status: ALIGNED

✅ Review context loaded from .faf
   Reviews now reflect project standards
```

## When to Use This Skill

Activate when:
- User types `/review`
- User asks to review a PR
- User says "review this code" or "check this PR"
- User shares a GitHub PR link
- User wants feedback on code changes

## How FAF Improves Reviews

**Without FAF:**
```
Looks good to me! 👍
```

**With FAF Foundation:**
```markdown
## Review Summary
✅ Approved with suggestions

## Alignment with Project Goals
This PR advances the voice streaming capability outlined in project.goal.
Good alignment with the "eternal memory" objective.

## Code Quality
- ✅ Follows TypeScript strict mode (per stack.language)
- ✅ Tests included (per testing: vitest)
- ⚠️ Consider adding error boundary for WebSocket failures

## Suggestions
1. **Line 45**: Add timeout handling for stream connection
2. **Line 72**: Consider extracting codec logic per project structure

## Test Coverage
- Unit tests: ✅ Present
- Integration tests: ⚠️ Consider adding reconnection test
```

## Review Workflow

### Step 1: Read Foundation Context

Before reviewing, read from .faf:

```yaml
# From project.faf
project:
  goal: "Browser-to-xAI voice client with eternal memory"

stack:
  language: typescript
  framework: svelte

testing: vitest

conventions:
  - "Strict TypeScript"
  - "No any types"
  - "Tests required for new features"
```

### Step 2: Fetch PR Details

```bash
# Get PR info
gh pr view <number>

# Get PR diff
gh pr diff <number>

# Get PR comments
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

### Step 3: Review Against Standards

Check code against .faf-defined standards:

| Check | Source |
|-------|--------|
| Language patterns | `stack.language` |
| Framework conventions | `stack.framework` |
| Test coverage | `testing` |
| Project alignment | `project.goal` |
| Code structure | `structure` |

### Step 4: Provide Feedback

Structure feedback using project context:

```markdown
## Review: PR #123

### Alignment
[Does this advance project.goal?]

### Code Quality
[Does this follow stack conventions?]

### Testing
[Does this meet testing standards?]

### Suggestions
[Specific, actionable improvements]
```

## Review Categories

### 1. Goal Alignment Review
Check if changes advance `project.goal`:

```markdown
## Goal Alignment
- Project goal: "Browser-to-xAI voice client with eternal memory"
- This PR: Adds voice streaming
- Alignment: ✅ Direct contribution to core goal
```

### 2. Stack Compliance Review
Check against `stack` configuration:

```markdown
## Stack Compliance
- Language: TypeScript ✅ (strict mode used)
- Framework: Svelte ✅ (follows component patterns)
- Build: Vite ✅ (config unchanged)
```

### 3. Testing Review
Check against `testing` field:

```markdown
## Testing Review
- Framework: vitest ✅
- Unit tests: ✅ Added for VoiceStream
- Integration: ⚠️ Missing reconnection scenario
- Coverage: Estimated 85%
```

### 4. Security Review
Check for security concerns:

```markdown
## Security Review
- Input validation: ✅ Audio chunks validated
- Auth: ✅ Token handled securely
- XSS: N/A (no user-generated HTML)
- Secrets: ✅ No hardcoded credentials
```

## Review Response Templates

### Approve
```markdown
## ✅ Approved

Great work! This PR:
- Advances [project.goal]
- Follows [stack] conventions
- Includes appropriate tests

Ship it! 🚀
```

### Request Changes
```markdown
## 🔄 Changes Requested

This PR needs adjustments before merge:

### Required
1. [Critical issue that must be fixed]

### Suggested
1. [Nice-to-have improvement]

Once addressed, happy to re-review!
```

### Comment
```markdown
## 💬 Review Comments

Some thoughts on this PR:

### Questions
- [Question about approach]

### Suggestions
- [Optional improvement]

Not blocking - just wanted to share feedback.
```

## Integration with Claude Code

This skill uses Claude Code patterns:

1. **Read .faf first** - Always check project context
2. **Use gh CLI** - GitHub CLI for PR operations
3. **Structured feedback** - Clear, actionable comments
4. **Bi-sync awareness** - Review against CLAUDE.md standards

## FAF Fields Used for Reviews

| Field | Usage |
|-------|-------|
| `project.goal` | Alignment check |
| `stack.*` | Technical standards |
| `testing` | Test coverage expectations |
| `conventions` | Code style requirements |
| `structure` | File organization |

## Example Session

```
User: /review 123

Claude: Let me check your .faf for project standards.

[Reads project.faf]
[Runs gh pr view 123]
[Runs gh pr diff 123]

## Review: PR #123 - Add voice streaming

### Goal Alignment ✅
Directly advances "browser-to-xAI voice client" goal.

### Stack Compliance ✅
- TypeScript strict mode: ✅
- Svelte patterns: ✅
- Vite config: Unchanged ✅

### Testing ⚠️
- Unit tests present: ✅
- Missing: Reconnection test scenario

### Suggestions
1. **src/voice/stream.ts:45** - Add timeout for initial connection
2. **src/voice/codec.ts:72** - Consider extracting to separate module

### Verdict
✅ **Approved** with minor suggestions above.

Great work advancing the voice streaming capability!
```

## Review Best Practices

1. **Check .faf first** - Understand project context
2. **Be specific** - Reference exact lines
3. **Be constructive** - Suggest solutions, not just problems
4. **Prioritize feedback** - Required vs suggested
5. **Acknowledge good work** - Positive reinforcement matters

## Related Skills

- `/commit` - Context-aware commits
- `/pr` - Create pull requests
- `/release` - Version and changelog

---

## The Foundation Promise

> .faf is the format. project.faf is the file.
> 100% 🏆 AI Readiness is the result.

---

*FAF Foundation Layer - Native to Claude Code*
*"Reviews that understand your standards."*
