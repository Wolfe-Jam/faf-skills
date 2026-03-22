---
name: repo-maintainer
description: Championship-grade repository maintenance. Audits for test artifacts, dependency issues, CI/CD health, documentation sync, and FAF alignment. Generates prioritized cleanup plans. Use when repos need deep cleaning or ongoing maintenance.
---

# Repo Maintainer - Championship Repository Hygiene

**"When brakes must work flawlessly, so must our repos."**

---

## When to Use This Skill

Activate when:
- User types `/repo-maintainer` or `/maintain`
- User says "clean up this repo" or "audit the repo"
- Starting maintenance on a repository (like claude-faf-mcp #2759)
- After major refactoring or before releases
- Monthly/quarterly repo health checks
- Onboarding to a new codebase

## What This Skill Does

### 🔍 **Phase 1: Comprehensive Audit**

Systematically checks 7 critical areas:

#### 1. **Artifact Detection**
```bash
# Find test artifacts
*.test.js leftovers
*.spec.ts.snap orphans
.DS_Store files
tmp/, temp/, cache/ directories
coverage/ not in .gitignore
dist/, build/ committed by accident
node_modules/ somehow in git
```

**Detection Strategy:**
- Check `git status` for untracked patterns
- Scan for common artifact extensions
- Compare against .gitignore
- Find large files (>1MB) in working directory

#### 2. **Dependency Health**
```bash
# Check package health
npm outdated
npm audit
npx depcheck (find unused deps)
Check for pinned versions (inquirer@8.2.5 pattern)
Verify Dependabot config
```

**Red Flags:**
- Packages with security vulnerabilities
- EOL runtime versions (Node 16, Python 3.7)
- Duplicate dependencies (lodash + lodash.merge)
- Unused dependencies (installed but never imported)

#### 3. **CI/CD Alignment**
```bash
# Workflow consistency check
Node versions across all workflows
Test matrices (should match across ci.yml, release.yml)
Action versions (@v6 vs @v5)
Failed/skipped workflow runs
Secrets/tokens properly configured
```

**What We Fixed Today:**
- ✅ Node 16 → removed from release.yml (EOL)
- ✅ Node versions aligned across workflows (18/20/22)
- ✅ `open@8.4.2` pinned to fix ESM issues

#### 4. **Documentation Sync**
```bash
# Context alignment check
README.md ↔ CLAUDE.md ↔ project.faf
CHANGELOG up to date with git tags
package.json version matches latest tag
Examples in README still work
Links not broken (404 checks)
```

**FAF-Specific:**
- project.faf reflects current state
- CLAUDE.md bi-sync active
- .faf-dna not churning unnecessarily

#### 5. **Git Hygiene**
```bash
# .gitignore audit
Untracked files that should be ignored
  *.config.mjs (like we saw today)
  *.faf (test artifacts like svelte.faf)
  .env.local, .env.development
Large files in git history (use git-filter-repo)
Binary files that don't belong
```

**Pattern Recognition:**
```gitignore
# Add to .gitignore based on artifacts found
*.config.mjs
*.faf.backup
.faf-dna.tmp
svelte.faf
test-*.faf
```

#### 6. **Code Quality Signals**
```bash
# Quick health indicators
Dead code (unused exports via ts-prune or depcheck)
TODO/FIXME comments (track count, prioritize)
Commented code blocks (remove or document)
Console.log statements in production code
Hardcoded secrets/tokens
```

#### 7. **FAF Ecosystem Health**

For FAF projects specifically:
```yaml
# Check FAF alignment
.faf score accuracy (run faf score)
Bi-sync status (faf bi-sync --check)
MCP server compliance (if applicable)
WJTTC test coverage (for faf-cli, MCP servers)
```

For MCP servers (#2759 claude-faf-mcp):
```bash
# MCP-specific checks
package.json has "mcp" field
Server implements required tools
Tests cover all tool endpoints
README has MCP installation instructions
Listed in Anthropic MCP registry
```

---

### 🛠️ **Phase 2: Cleanup Plan Generation**

After audit, generate prioritized task list:

```markdown
# 🏎️ REPO HEALTH REPORT: faf-cli

**Overall Score:** 85% 🥉 BRONZE
**Status:** Production-ready with minor cleanup needed

---

## 🚨 CRITICAL (Fix Now)

### 1. Security: `open@10` breaking CI/CD
- **Impact:** Release pipeline failing
- **Fix:** Pin to `open@8.4.2` ✅ FIXED
- **Effort:** 5 minutes
- **Auto-fix:** Available

### 2. EOL Runtime: Node 16 in release.yml
- **Impact:** Testing on unsupported runtime
- **Fix:** Remove Node 16, add Node 22 ✅ FIXED
- **Effort:** 2 minutes
- **Auto-fix:** Available

---

## ⚠️  MEDIUM (This Week)

### 3. .gitignore Gaps
- **Issue:** `*.config.mjs`, `*.faf` test files not ignored
- **Fix:** Add patterns to .gitignore
- **Effort:** 1 minute
- **Auto-fix:** Available
  ```gitignore
  *.config.mjs
  svelte.faf
  test-*.faf
  ```

### 4. Dependency Audit
- **Issue:** 15 outdated packages, 3 low severity vulnerabilities
- **Fix:** Run `npm update` for non-breaking, review majors
- **Effort:** 30 minutes
- **Auto-fix:** Partial

### 5. CHANGELOG Missing v4.4.0
- **Issue:** Latest release not documented
- **Fix:** Add v4.4.0 section to CHANGELOG.md
- **Effort:** 10 minutes
- **Auto-fix:** Available (draft from git log)

---

## ℹ️  LOW (Nice to Have)

### 6. README Links
- **Issue:** 2 broken links to old docs
- **Fix:** Update URLs
- **Effort:** 5 minutes

### 7. TODO Comments
- **Issue:** 3 TODO comments in source code
- **Fix:** Create issues or resolve
- **Effort:** Variable
- **Files:**
  - src/cli.ts:511 (FAFb commands commented)
  - src/utils/email-opt-in.ts:45
  - tests/wjttc-cli.test.ts:89

### 8. Unused Dependencies
- **Issue:** `depcheck` found 2 unused packages
- **Fix:** Remove or document why needed
- **Effort:** 10 minutes
- **Packages:** `chalk-animation`, `ora`

---

## ✅ EXCELLENT

- Test coverage: 799/799 passing
- TypeScript strict mode: enabled
- FAF score: 83% (good)
- CI/CD: All workflows aligned
- Security: No critical vulnerabilities
- Documentation: CLAUDE.md in sync

---

## 🎯 RECOMMENDED ACTIONS

**Quick Wins (30 min):**
1. ✅ Update .gitignore (1 min)
2. ✅ Add CHANGELOG entry (10 min)
3. ✅ Fix broken README links (5 min)
4. ✅ Run npm update for safe updates (10 min)

**This Week:**
- Review TODO comments, create issues
- Remove unused dependencies
- Bump patch version (v4.4.1)

**Monthly:**
- Run full dependency audit
- Review git history for large files
- Performance baseline check

---

## 🔧 AUTO-FIX AVAILABLE

I can automatically fix:
- ✅ .gitignore additions
- ✅ CHANGELOG draft
- ✅ Safe dependency updates
- ✅ Workflow alignment

**Run auto-fix?** (yes/no)
```

---

### 🤖 **Phase 3: Auto-Fix (Optional)**

For safe, non-breaking fixes:

```bash
# 1. Update .gitignore
cat >> .gitignore <<EOF

# Auto-added by repo-maintainer
*.config.mjs
*.faf.backup
.faf-dna.tmp
test-*.faf
svelte.faf
EOF

# 2. Generate CHANGELOG entry from git log
git log v4.3.3..v4.4.0 --pretty=format:"- %s (%h)" >> CHANGELOG.draft.md

# 3. Safe dependency updates (non-breaking)
npm update --save

# 4. Create cleanup branch
git checkout -b repo-maintenance/$(date +%Y-%m-%d)
git add .gitignore CHANGELOG.md package.json package-lock.json
git commit -m "chore: repo maintenance - cleanup artifacts and update deps

- Add missing .gitignore patterns
- Update CHANGELOG with v4.4.0
- Safe dependency updates (patch/minor only)

Generated by /repo-maintainer skill"
```

---

## Workflow

### Step 1: Initial Assessment
```bash
# Quick health check
pwd
git status
git log --oneline -5
ls -la | head -20
```

### Step 2: Systematic Audit

Run checks in order of priority:

1. **Critical first** - CI/CD failures, security issues
2. **Medium next** - Dependencies, documentation gaps
3. **Low priority** - Code quality signals, nice-to-haves

### Step 3: Generate Report

Create structured report with:
- Overall health score (0-100%)
- Critical/Medium/Low sections
- Effort estimates
- Auto-fix availability
- Recommended action plan

### Step 4: Execute (with approval)

Ask user:
- "Run auto-fix for safe items?"
- "Create cleanup branch?"
- "Open issues for manual items?"

Never make changes without explicit approval.

---

## MCP Server Maintenance (#2759 claude-faf-mcp)

### Additional MCP Checks:

```bash
# 1. MCP-specific structure
package.json has "mcp" field ✅
Server exports via index.ts ✅
Tools properly registered ✅

# 2. Registry compliance
Listed in Anthropic registry ✅
README has MCP install instructions
Works with Claude Desktop config

# 3. Tool coverage
Each tool has tests
Each tool has description
Error handling implemented

# 4. Version alignment
package.json version
git tag version
MCP registry version
npm published version
```

### MCP Cleanup Checklist:

- [ ] Remove test artifacts
- [ ] Update dependencies
- [ ] Align workflows (Node 18/20/22)
- [ ] Verify MCP tools still work
- [ ] Update README examples
- [ ] Check CHANGELOG current
- [ ] Verify published to npm
- [ ] Confirm registry listing accurate

---

## 🏆 Tier System (Aligned with FAF)

**CRITICAL: Use Official FAF Tiers for All Scoring**

| Score Range | Tier | Emoji | Description |
|-------------|------|-------|-------------|
| 100% | Trophy | 🏆 | Perfect |
| 99% | Gold | 🥇 | Exceptional |
| 90-95% | Silver | 🥈 | Top tier |
| 85-89% | Bronze | 🥉 | Production ready |
| 70-84% | Green | 🟢 | Solid foundation |
| 55-69% | Yellow | 🟡 | Needs improvement |
| <55% | Red | 🔴 | Major work needed |
| 0% | White | 🤍 | Empty |

**Note:** 🍊 **Big Orange** is a **BADGE**, not a score. It's awarded for excellence beyond metrics, never calculated.

**Apply These Tiers to:**
- Overall repo health score
- Individual category scores (CI/CD, Dependencies, etc.)
- Summary reports
- Cleanup recommendations

**Examples:**
```
✅ 95% Security     → 🥈 Silver (NOT 🥇 Gold)
✅ 88% Overall      → 🥈 Silver
✅ 78% Dependencies → 🟢 Green (NOT 🟡 Yellow)
✅ 70% Git Hygiene  → 🟢 Green (NOT 🟡 Yellow)
✅ 40% CI/CD        → 🔴 Red
✅ 100% Tests       → 🏆 Trophy
```

---

## Related Skills

- `/pubpro` - FAF publish protocol (pre-release checks)
- `/commit` - Context-aware commits (for cleanup commits)
- `/pr` - Create cleanup PR
- `/wjttc-builder` - Add missing tests

---

## Best Practices

### 1. **Run Regularly**
- After major refactors
- Before releases
- Monthly maintenance
- When onboarding new devs

### 2. **Prioritize Impact**
- Fix breaking issues first (CI/CD, security)
- Document before cleaning (understand why artifacts exist)
- Test after cleanup (ensure nothing broke)

### 3. **Track Progress**
- Use TodoWrite for multi-step cleanups
- Create issues for manual items
- Document decisions in CLAUDE.md

### 4. **Automate Where Safe**
- .gitignore additions ✅
- CHANGELOG drafts ✅
- Workflow alignment ✅
- Breaking changes ❌ (need review)

---

## Example Session

```
User: /repo-maintainer

Claude: 🏎️ Starting championship repo maintenance audit...

[Runs git status]
[Checks workflows]
[Scans for artifacts]
[Runs npm outdated]
[Checks .gitignore]

📊 AUDIT COMPLETE

Overall Health: 85% 🥉 BRONZE
Critical Issues: 2
Medium Issues: 3
Low Priority: 5

Top Issues:
1. 🚨 open@10 breaking CI/CD (auto-fixable)
2. 🚨 Node 16 in workflows (EOL)
3. ⚠️  .gitignore missing *.config.mjs
4. ⚠️  15 outdated dependencies
5. ⚠️  CHANGELOG missing v4.4.0

I can auto-fix items 1, 2, 3, and draft 5.
Would you like me to proceed? (yes/no)

User: yes

Claude: ✅ Fixing...
[Pins open@8.4.2]
[Updates workflows to Node 20]
[Adds .gitignore patterns]
[Drafts CHANGELOG entry]

✅ Auto-fixes complete!

Remaining manual items:
- Review 15 dependency updates
- 3 TODO comments need review

Create cleanup branch? (yes/no)
```

---

## The Championship Promise

> "F1 teams maintain their cars between every race.
> Your repos deserve the same attention."

---

*Repo Maintainer - Championship Repository Hygiene*
*"When brakes must work flawlessly, so must our repos."*
