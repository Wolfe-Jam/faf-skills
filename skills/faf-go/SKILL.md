---
name: faf-go
description: Guided interview to Gold Code (100% AI-Readiness). Use when helping users improve their .faf file through questions. Leverages Claude Code's AskUserQuestion for seamless integration. Just type /faf-go and answer questions till done.
---

# FAF Go - Guided Path to Gold Code

**"Just type /faf-go, answer questions till you're done. 100% target."**

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

Once you get used to it, it's just another file helping you code.

---

## Foundation Layer Status

When activated, FAF Go connects to your project's foundation:

```
🔗 CONNECTING TO FOUNDATION
   Reading: project.faf
   Syncing: CLAUDE.md ←→ .faf
   Status: ALIGNED

✅ Your CLAUDE.md is synced at the foundational layer
   Context drift: PREVENTED
```

## When to Use This Skill

Activate when:
- User wants to improve their .faf score
- User mentions "Gold Code" or "100%"
- User has incomplete project context
- After `faf init` to fill in missing fields
- User says "help me with my .faf"
- CLAUDE.md needs fresh context from foundation

## Integration with Claude Code

FAF Go is built FOR Claude Code:
- **AskUserQuestion** - Native Claude Code UI for questions
- **multiSelect: true** - Allow multiple answers (e.g., "pytest + WJTTC")
- **TodoWrite** - Track progress through the interview
- **Structured output** - JSON that Claude Code understands
- **Bi-sync** - Answers flow to .faf AND CLAUDE.md

### multiSelect Support

Some questions allow multiple selections:
- `stack.testing` → "pytest + WJTTC"
- `stack.cicd` → "GitHub Actions + Cloud Build"
- `stack.frontend` → "React + Tailwind"
- `human_context.who` → "Developers + AI agents"

When `multiSelect: true`, user can pick 2+ options. Results are joined with " + ".

## Workflow

### Step 1: Check Current State

Run faf score to understand current position:

```bash
faf score --breakdown
```

Or use the structured output:

```bash
faf go
```

This returns JSON with:
- `currentScore` - Current percentage
- `targetScore` - Always 100
- `questions` - Prioritized list of missing fields

### Step 2: Ask Questions Using AskUserQuestion

For each missing field, use Claude Code's AskUserQuestion tool:

**Priority Order (most impactful first):**
1. `project.goal` - What does this project do?
2. `human_context.why` - Why does this exist?
3. `human_context.who` - Who uses this?
4. `human_context.what` - What problem does it solve?
5. `project.main_language` - Primary language
6. `stack.database` - Database choice
7. `stack.hosting` - Where is it deployed?
8. `stack.frontend` - Frontend framework
9. `stack.backend` - Backend framework
10. `human_context.where` - Environment
11. `human_context.when` - Timeline/phase
12. `human_context.how` - AI assistance preferences

### Step 3: Apply Answers

After collecting answers, update the .faf file:

```bash
# Read current .faf
cat project.faf

# Update fields (use Edit tool)
# Then verify:
faf score
```

### Step 4: Celebrate or Continue

If score >= 100: Celebrate Gold Code achievement
If score < 100: Continue with remaining questions

## Question Templates for AskUserQuestion

### Single-Select Questions (pick one)

#### project.goal
```json
{
  "question": "What does this project do? (one clear sentence)",
  "header": "Goal",
  "multiSelect": false,
  "options": [
    {"label": "Let me type it", "description": "I'll describe it myself"},
    {"label": "Help me write it", "description": "Guide me through it"}
  ]
}
```

#### human_context.why
```json
{
  "question": "Why does this project exist?",
  "header": "Why",
  "multiSelect": false,
  "options": [
    {"label": "Business need", "description": "Solving a business problem"},
    {"label": "Personal project", "description": "Learning or hobby"},
    {"label": "Open source", "description": "Community contribution"},
    {"label": "Let me explain", "description": "Custom reason"}
  ]
}
```

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

#### stack.testing
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

#### human_context.who
```json
{
  "question": "Who uses this project?",
  "header": "Users",
  "multiSelect": true,
  "options": [
    {"label": "Developers", "description": "Software developers"},
    {"label": "End users", "description": "Non-technical users"},
    {"label": "AI agents", "description": "Claude, Gemini, etc."},
    {"label": "Internal team", "description": "Your team only"}
  ]
}
```
**Result format:** `Developers + AI agents`

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

[Runs: faf score --breakdown]

Your score is 45%. Let's get you to Gold Code!

[Uses AskUserQuestion for project.goal]

User: [Selects option or types custom]

Claude: Great! Now let's capture why this project exists.

[Uses AskUserQuestion for human_context.why]

... continues until 100% ...

Claude: 🏆 GOLD CODE ACHIEVED!
Your AI now has complete context for championship performance.
```

## TodoWrite Integration

Track progress with todos:

```javascript
[
  {"content": "Answer project.goal question", "status": "completed"},
  {"content": "Answer human_context.why question", "status": "in_progress"},
  {"content": "Answer stack.database question", "status": "pending"},
  {"content": "Verify Gold Code achieved", "status": "pending"}
]
```

## CLI Fallback

If not in Claude Code context, run:

```bash
faf go
```

This returns structured JSON that can be processed programmatically.

## Success Metrics

- User reaches 100% score
- All required fields filled with meaningful content
- No placeholder values (TBD, Unknown, None where inappropriate)
- User understands what each field is for

## On Completion

When Gold Code is achieved:

```
🏆 GOLD CODE ACHIEVED - 100%

✅ project.faf: Complete
✅ CLAUDE.md: Synced from foundation
✅ Context drift: PREVENTED

Your AI now has complete, aligned context.
Foundation layer is locked in.
```

## Related Skills

- `/faf-status` - Quick foundation health check
- `/faf-score` - Score your foundation
- `/faf-sync` - Bi-sync .faf ←→ CLAUDE.md

---

## The Foundation Promise

> .faf is the format. project.faf is the file.
> 100% 🏆 AI Readiness is the result.

---

*FAF Foundation Layer - Native to Claude Code*
