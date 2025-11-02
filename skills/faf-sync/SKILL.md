---
name: faf-sync
description: Keep project.faf and CLAUDE.md in bidirectional sync using Context-Mirroring technology (8ms bi-sync). Maintains consistency between project DNA (project.faf) and workflow instructions (CLAUDE.md). Use when user asks "sync my files", "keep FAF updated", "mirror to CLAUDE.md", or after making changes to either file.
allowed-tools: Read, Write, Edit, Bash
---

# FAF Sync - Bidirectional Context Mirroring

## Purpose

Maintain perfect synchronization between `project.faf` (project DNA) and `CLAUDE.md` (workflow instructions) using bi-directional mirroring. Changes in one file automatically reflect in the other, keeping AI context consistent.

**The Goal:** Zero manual synchronization work. Update once, synchronized everywhere in <10ms.

## When to Use

This skill activates automatically when the user:
- Says "Sync project.faf and CLAUDE.md"
- Says "Keep my files in sync"
- Says "Mirror to CLAUDE.md"
- Says "Update CLAUDE.md from project.faf"
- Just updated project.faf and wants CLAUDE.md updated
- Just updated CLAUDE.md and wants project.faf updated
- Asks "Are my files synchronized?"
- Says "Bi-sync my context"

**Trigger Words:** sync, mirror, bi-sync, synchronize, update, keep consistent, context-mirroring

## How It Works

### Step 1: Check Both Files Exist

Verify both files are present:

```bash
ls -la project.faf CLAUDE.md
```

**If project.faf missing:** Run `faf init` first (use **faf-init** skill)
**If CLAUDE.md missing:** Create from template or generate from project.faf

### Step 2: Determine Sync Direction

Check which file was modified most recently:

```bash
# Get modification times
stat -f "%m %N" project.faf CLAUDE.md
```

**If project.faf newer:** Sync project.faf → CLAUDE.md
**If CLAUDE.md newer:** Sync CLAUDE.md → project.faf
**If timestamps equal:** Check with user which direction

### Step 3: Execute Bidirectional Sync

Run the existing bi-sync command:

```bash
faf bi-sync
```

This command (from faf-cli v3.1.1):
- Detects which file changed
- Syncs changed content bidirectionally
- Maintains format-specific sections
- Preserves unique content in each file
- Completes in <10ms (target: 8ms)

### Step 4: Verify Synchronization

Check that sync completed successfully:

```bash
# Re-check modification times
ls -la project.faf CLAUDE.md

# Optionally validate both files
faf validate
```

### Step 5: Report Results

Tell user:
- Which direction sync occurred
- What content was synchronized
- Any conflicts or issues
- Current sync status (in sync / out of sync)

## Understanding Context-Mirroring

### What Gets Synchronized

**Bidirectional (synced both ways):**
- Project name
- Project purpose/description
- Architecture type and details
- Stack information (language, framework, runtime)
- Dependencies
- Testing framework and approach
- Build information

**Project.faf Only (not synced to CLAUDE.md):**
- YAML structure
- Metadata fields (created date, format version)
- IANA media type header
- Detailed API schemas
- Database ERD diagrams

**CLAUDE.md Only (not synced to project.faf):**
- Workflow instructions (git protocol, commit format)
- Team conventions
- Development commands
- Code style guidelines
- AI assistant notes
- Temporary project context

### The Reading Order Integration

Context-Mirroring ensures both files stay aligned in The Reading Order:

```
1. project.faf     → Project DNA (architecture, stack)      [SYNCED]
2. CLAUDE.md       → Workflow instructions (how to work)    [SYNCED]
3. README.md       → User documentation (how humans use it)
4. package.json    → Dependencies (what it needs)
5. Config files    → Build settings
6. Code            → Implementation
```

When synced, AI reads both files and gets:
- **Complete architecture** from project.faf
- **Complete workflow** from CLAUDE.md
- **Zero redundancy** (no duplicate information)
- **Perfect consistency** (architecture details match)

## Sync Workflows

### Workflow 1: Project.faf → CLAUDE.md (Most Common)

**When:** User updates project.faf (e.g., after `faf enhance`)

**Process:**
1. User runs `faf enhance` and improves project.faf
2. User runs `faf bi-sync`
3. Architecture changes from project.faf copy to CLAUDE.md
4. CLAUDE.md "Project Overview" section updates
5. Workflow instructions in CLAUDE.md remain unchanged

**Example:**

**Before sync:**
```yaml
# project.faf
stack:
  framework: Next.js 14
  features: App Router, Server Components
```

```markdown
# CLAUDE.md
## Project Overview
Stack: Next.js 13
```

**After sync:**
```markdown
# CLAUDE.md
## Project Overview
Stack: Next.js 14 (App Router, Server Components)
```

### Workflow 2: CLAUDE.md → Project.faf (Less Common)

**When:** User updates workflow instructions that affect architecture

**Process:**
1. User edits CLAUDE.md (e.g., adds new architecture decision)
2. User runs `faf bi-sync`
3. Architecture-related changes copy to project.faf
4. Workflow instructions remain in CLAUDE.md only

**Example:**

**Before sync:**
```markdown
# CLAUDE.md
## Architecture
Design Pattern: Repository pattern for data access
```

**After sync:**
```yaml
# project.faf
architecture_decisions:
  - decision: "Repository pattern for data access"
    rationale: "Separates data logic from business logic"
```

### Workflow 3: Automatic Continuous Sync

**When:** User wants always-in-sync files

**Setup:**
```bash
# Option 1: Git pre-commit hook
echo "faf bi-sync" > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Option 2: File watcher (advanced)
# Uses nodemon or similar to watch for changes
```

**Benefit:** Never think about sync, it just happens

## Examples

### Example 1: After Enhancing Project.faf

**User:** "I just improved my project.faf. Sync to CLAUDE.md"

**Skill Activates:**

1. **Check files exist:**
```bash
ls -la project.faf CLAUDE.md
# Both exist ✓
```

2. **Check which is newer:**
```bash
stat -f "%m %N" project.faf CLAUDE.md
# project.faf modified 30 seconds ago
# CLAUDE.md modified 2 hours ago
# → Sync project.faf → CLAUDE.md
```

3. **Execute sync:**
```bash
faf bi-sync
# Output:
# ✓ Synced project.faf → CLAUDE.md (8ms)
# Updated sections:
# - Project Overview
# - Architecture
# - Tech Stack
```

4. **Report to user:**
"Successfully synced! Your CLAUDE.md now reflects the improvements you made to project.faf:
- Updated Next.js version (13 → 14)
- Added Server Components note
- Documented testing strategy
- Sync completed in 8ms"

### Example 2: Creating CLAUDE.md from Scratch

**User:** "I have project.faf but no CLAUDE.md. Create and sync it."

**Skill Activates:**

1. **Check files:**
```bash
ls project.faf  # ✓ exists
ls CLAUDE.md    # ✗ missing
```

2. **Create CLAUDE.md template:**
```markdown
# CLAUDE.md

## Project Overview
[Will be synced from project.faf]

## Architecture
[Will be synced from project.faf]

## Tech Stack
[Will be synced from project.faf]

## Development Commands
```bash
# Add your common commands here
npm run dev
npm test
npm run build
```

## Git Protocol
[Add your team's git workflow]

## AI Assistant Notes
- This project follows The Reading Order
- Read project.faf first for complete architecture
- This file (CLAUDE.md) provides workflow context
```

3. **Execute bi-sync:**
```bash
faf bi-sync
# Populates CLAUDE.md sections from project.faf
```

4. **Verify:**
```bash
cat CLAUDE.md
# Now contains project overview, architecture, stack from project.faf
```

### Example 3: Detecting Out-of-Sync Files

**User:** "Are my files synchronized?"

**Skill Activates:**

1. **Check sync status:**
```bash
# Compare key sections
grep "Next.js" project.faf
grep "Next.js" CLAUDE.md

# If they differ, files are out of sync
```

2. **Report findings:**
"Your files are OUT OF SYNC:
- project.faf says: Next.js 14 with App Router
- CLAUDE.md says: Next.js 13

Last sync: 3 days ago

Run `faf bi-sync` to synchronize."

3. **Offer to sync:**
"Would you like me to sync them now?"

4. **If yes, execute:**
```bash
faf bi-sync
```

### Example 4: Conflict Resolution

**User:** "Both files changed. How do I sync?"

**Skill Activates:**

1. **Detect conflict:**
```bash
# Both files modified today
# project.faf: architecture updated
# CLAUDE.md: workflow updated
```

2. **Explain options:**
"Both files have changed:

**Option 1: Merge (Recommended)**
- Sync architecture changes from project.faf → CLAUDE.md
- Keep workflow changes in CLAUDE.md
- No data loss

**Option 2: Force project.faf → CLAUDE.md**
- Overwrite CLAUDE.md with project.faf content
- Lose workflow changes in CLAUDE.md

**Option 3: Force CLAUDE.md → project.faf**
- Overwrite project.faf with CLAUDE.md content
- Lose architecture changes in project.faf"

3. **User chooses Option 1 (merge):**
```bash
faf bi-sync
# Intelligently merges both changes
```

4. **Verify merge:**
"Merge complete:
- ✓ Architecture changes from project.faf preserved
- ✓ Workflow changes from CLAUDE.md preserved
- ✓ No conflicts or data loss"

## Performance

### The 8ms Target

Context-Mirroring targets **<10ms** for bi-directional sync (achieved: 8ms average).

**Why this matters:**
- Instant feedback (feels instantaneous)
- Can run on every save (git hooks)
- No workflow interruption
- F1-grade performance standards

**How it's achieved:**
- Efficient file parsing
- In-memory diff algorithms
- Minimal disk I/O
- Optimized YAML operations

### Performance Verification

Check sync performance:

```bash
# Time the sync
time faf bi-sync

# Should show:
# real    0m0.008s  (8ms)
# user    0m0.006s
# sys     0m0.002s
```

**Podium tiers for sync speed:**
- 🏆 Trophy: <5ms (elite)
- 🥇 Gold: 5-10ms (excellent) ← Current target
- 🥈 Silver: 10-25ms (good)
- 🥉 Bronze: 25-50ms (acceptable)
- ⚠️ Slow: >50ms (needs optimization)

## Verification & Troubleshooting

### Success Indicators

✅ Both files have same modification timestamp (within seconds)
✅ Architecture sections match between files
✅ Sync completed in <10ms
✅ No YAML syntax errors in project.faf
✅ No markdown formatting issues in CLAUDE.md

### Common Issues

**Issue: Sync command not found**

```bash
# Solution: Update faf-cli
npm install -g faf-cli@latest

# Verify version (need 3.1.0+)
faf --version
```

**Issue: Sync is slow (>50ms)**

```bash
# Solution: Check file sizes
wc -l project.faf CLAUDE.md

# If either file is very large (>500 lines), consider:
# - Removing redundant content
# - Splitting into multiple files
# - Optimizing YAML structure
```

**Issue: Sync creates duplicate content**

```bash
# Solution: Validate format
faf validate

# Check for:
# - Duplicate sections in either file
# - Malformed YAML in project.faf
# - Incorrect section headers in CLAUDE.md

# Fix issues and re-sync
faf bi-sync
```

**Issue: CLAUDE.md workflow instructions lost after sync**

```bash
# Solution: Workflow sections should NOT be synced
# They're CLAUDE.md-only content

# If lost, check:
# 1. Did you force-overwrite CLAUDE.md?
# 2. Are sections properly marked as CLAUDE.md-only?

# Restore from git if needed:
git checkout CLAUDE.md

# Then sync properly:
faf bi-sync
```

## Integration with Other Skills

**After faf-init:**
```bash
faf init        # Create project.faf
faf bi-sync     # Create/update CLAUDE.md
```

**After faf-enhance:**
```bash
faf enhance     # Improve project.faf
faf bi-sync     # Mirror improvements to CLAUDE.md
```

**After faf-score:**
```bash
faf score       # Check AI-readiness
faf bi-sync     # Ensure both files reflect current state
```

**Continuous workflow:**
```bash
# Make changes to either file
# Then always:
faf bi-sync     # Keep synchronized
```

## File Structure Templates

### Minimal CLAUDE.md Template

```markdown
# CLAUDE.md - AI Context

## Project Overview
[Synced from project.faf]

## Architecture
[Synced from project.faf]

## Tech Stack
[Synced from project.faf]

## Development Commands
```bash
npm run dev
npm test
npm run build
```

## Git Protocol
- Commit format: `type: description`
- Types: feat, fix, docs, refactor, test
- No exclamation marks
- Professional, boring, trusted

## AI Assistant Notes
- Follow The Reading Order: project.faf → CLAUDE.md → README.md → code
- This project uses FAF for AI context
- Architecture in project.faf, workflow in CLAUDE.md
```

### Enhanced CLAUDE.md Template

```markdown
# CLAUDE.md - Championship AI Context

## Project Overview
**Name:** [Synced from project.faf]
**Purpose:** [Synced from project.faf]
**Type:** [Synced from project.faf]

## Architecture
[Synced from project.faf]

Key decisions:
[Synced from project.faf]

## Tech Stack
**Language:** [Synced from project.faf]
**Framework:** [Synced from project.faf]
**Runtime:** [Synced from project.faf]

Dependencies:
[Synced from project.faf]

## Testing
**Framework:** [Synced from project.faf]
**Approach:** [Synced from project.faf]
**Coverage:** [Synced from project.faf]

## Development Commands
```bash
# Install
npm install

# Develop
npm run dev

# Test
npm test
npm run test:coverage

# Build
npm run build

# Deploy
npm run deploy
```

## Git Protocol
**Branching:** main (production), develop (staging), feature/*

**Commits:**
```
type: description

- detail 1
- detail 2
```

**Types:** feat, fix, docs, refactor, test, chore

**Rules:**
- No exclamation marks
- No emoji
- Professional, boring, trusted
- NO BS ZONE (verified claims only)

## Code Style
- TypeScript strict mode
- ESLint + Prettier
- 100% type safety
- Comprehensive tests required

## AI Assistant Notes
- Read project.faf FIRST (architecture)
- Read CLAUDE.md SECOND (workflow)
- Files kept in sync via `faf bi-sync`
- This is The Reading Order in action
- NO BS ZONE: no guarantees, it's free software

---

*Generated by FAF Context-Mirroring*
*Synced: [timestamp]*
```

## Supporting Files

This skill works with:
- **faf-cli** (v3.1.1+) - Bi-sync engine
- **project.faf** - Project DNA file
- **CLAUDE.md** - Workflow instructions file

## Related Skills

Sync integrates with:
- **faf-init** - Creates initial project.faf
- **faf-enhance** - Improves project.faf (then sync)
- **faf-score** - Measures quality (then sync to reflect)
- **faf-validate** - Ensures both files are valid

## Key Principles

**Bidirectional, Not One-Way:**
- project.faf → CLAUDE.md ✓
- CLAUDE.md → project.faf ✓
- Intelligent merge, not overwrite
- Preserves unique content in each file

**Performance First:**
- <10ms target (8ms achieved)
- F1-grade engineering
- Instant feedback
- Can run on every save

**Format-Aware:**
- YAML in project.faf
- Markdown in CLAUDE.md
- Respects format conventions
- Intelligent content mapping

**NO BS ZONE:**
- Sync is real (measurable in milliseconds)
- Performance is verified (not claimed)
- Conflicts handled honestly (not hidden)
- Format compliance enforced (not optional)

## Success Metrics

When this skill succeeds, users should:
1. Have both files synchronized
2. Know sync completed in <10ms
3. Understand what content was synced
4. See no data loss or conflicts
5. Trust the sync process
6. Use sync regularly without thinking

## References

- **Context-Mirroring:** faf-cli bi-sync implementation
- **faf bi-sync command:** https://faf.one/docs/bi-sync
- **The Reading Order:** https://faf.one/docs/reading-order
- **Performance benchmarks:** faf-cli <50ms target, bi-sync 8ms achieved

---

**Generated by FAF Skill: faf-sync v1.0.0**
**Context-Mirroring Edition: 8ms Bidirectional Sync**
**"Perfect consistency. Zero manual work. Championship performance."**
