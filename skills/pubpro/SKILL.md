---
name: pubpro
description: FAF publish protocol for npm + MCP Registry + Cloudflare Workers. Run pre-publish checklist, verify build/tests, prepare approval request. Covers all 5 FAF ecosystem servers + CLI + MCPaaS.
---

# PubPro - FAF Publish Protocol

Run the FAF publish protocol checklist before any npm/PyPI/Cloudflare publish.

## Usage

```
/pubpro            # Interactive menu (recommended)
/pubpro cli        # faf-cli package (npm)
/pubpro mcp        # claude-faf-mcp package (npm)
/pubpro faf-mcp    # faf-mcp package (npm)
/pubpro grok       # grok-faf-mcp package (npm)
/pubpro gemini     # gemini-faf-mcp package (PyPI)
/pubpro mcpaas     # mcpaas-cf (Cloudflare Workers)
/pubpro slash      # slash-tokens package (npm)
```

## Publish Scope

After package selection, ask for publish scope:

```
Question: "What scope for this publish?"
Header: "Scope"
Options:
  - label: "npm/PyPI only"
    description: "Package registry only (quick release)"
  - label: "Full Ecosystem (Recommended)"
    description: "npm/PyPI + MCP Registry + all listings"
```

## The Five Fingers - FAF Ecosystem #2759

| Server | Registry ID | npm/PyPI | MCP Registry |
|--------|-------------|----------|--------------|
| **Claude** | io.github.Wolfe-Jam/claude-faf-mcp | npm v5.3.0 | v5.3.0 |
| **Core FAF** | io.github.Wolfe-Jam/faf-mcp | npm v1.2.4 | v1.2.4 |
| **Grok** | io.github.Wolfe-Jam/grok-faf-mcp | npm v1.0.2 | v1.0.2 |
| **Gemini** | io.github.Wolfe-Jam/gemini-faf-mcp | PyPI v1.0.2 | v1.0.2 |
| **WJTTC** | io.github.Wolfe-Jam/WJTTC | npm v1.1.0 | v1.1.0 |

**Plus CLI:** faf-cli (npm + Homebrew)
**Plus Infrastructure:** mcpaas-cf (Cloudflare Workers)
**Plus Product:** slash-tokens (npm)

## Package Paths

| Argument | Package | Path | Registry |
|----------|---------|------|----------|
| `cli` | faf-cli | `/Users/wolfejam/FAF/cli` | npm + Homebrew |
| `mcp` | claude-faf-mcp | `/Users/wolfejam/FAF/claude-faf-mcp` | npm + MCP |
| `faf-mcp` | faf-mcp | `/Users/wolfejam/FAF/faf-mcp` | npm + MCP |
| `grok` | grok-faf-mcp | `/Users/wolfejam/FAF/grok-faf-mcp` | npm + MCP |
| `gemini` | gemini-faf-mcp | `/Users/wolfejam/FAF/gemini-faf-mcp` | PyPI + MCP |
| `mcpaas` | mcpaas-cf | `/Users/wolfejam/FAF/mcpaas-cf` | Cloudflare Workers |
| `slash` | slash-tokens | `/Users/wolfejam/FAF/slash-tokens/npm` | npm |

## The Protocol

### Step 0: Package Selection (if no argument)

If `/pubpro` is called without an argument, use **AskUserQuestion** to present an interactive menu:

```
Question: "Which package do you want to publish?"
Header: "Package"
Options:
  - label: "faf-cli"
    description: "/Users/wolfejam/FAF/cli - CLI tool (npm + Homebrew)"
  - label: "claude-faf-mcp"
    description: "/Users/wolfejam/FAF/claude-faf-mcp - MCP server (npm + MCP Registry)"
  - label: "faf-mcp"
    description: "/Users/wolfejam/FAF/faf-mcp - Core MCP (npm + MCP Registry)"
  - label: "grok-faf-mcp"
    description: "/Users/wolfejam/FAF/grok-faf-mcp - Grok MCP (npm + MCP Registry)"
  - label: "gemini-faf-mcp"
    description: "/Users/wolfejam/FAF/gemini-faf-mcp - Gemini MCP (PyPI + MCP Registry)"
  - label: "mcpaas-cf"
    description: "/Users/wolfejam/FAF/mcpaas-cf - MCPaaS (Cloudflare Workers)"
  - label: "slash-tokens"
    description: "/Users/wolfejam/FAF/slash-tokens/npm - Pre-flight checks (npm)"
```

### Step 1: Change to Package Directory

Based on argument or menu selection, cd to the correct path.

### Step 1.1: CI Gate (MANDATORY — no red buttons on npm)

**Check GitHub Actions CI status before anything else. A red badge on npm is permanent damage.**

```bash
# Get the repo from package.json
REPO=$(node -e "const p=require('./package.json'); const u=p.repository?.url||''; const m=u.match(/github\.com[\/:]([^\/]+\/[^\/\.]+)/); console.log(m?m[1]:'unknown')")

# Check latest CI run on main
gh run list --repo "$REPO" --branch main --limit 5 --json status,conclusion,name,createdAt \
  --jq '.[] | "\(.conclusion // .status) \(.name) \(.createdAt)"'
```

**Rules:**
- All jobs must show `success` — no `failure`, no `cancelled`
- If any job is `in_progress`, **wait** — do not publish while CI is running
- If any job shows `failure` — **BLOCKED. Fix CI first. Do not proceed.**

**Present status to user:**
- ✅ CI green — proceed
- ⏳ CI in progress — wait and re-check
- 🚫 CI red — BLOCKED, show which job failed

**Do NOT continue to Step 1.25 until CI is confirmed green.**

### Step 1.25: FAF Gate (MANDATORY — no package ships without FAF standard)

**Every FAF package must meet the FAF standard before publish. No exceptions.**

Run these checks automatically — do NOT ask the user, just do them:

```bash
# 1. Check faf_version — if old or missing, regenerate
bun ~/FAF/cli/src/cli.ts score 2>/dev/null
# If faf_version < 3.0, run:
bun ~/FAF/cli/src/cli.ts init --force

# 2. Auto-fill what we can
bun ~/FAF/cli/src/cli.ts auto

# 3. Score
bun ~/FAF/cli/src/cli.ts score
```

**If human_context slots are empty:**
- Fill them yourself using project knowledge (README, package.json, description)
- who: target users
- what: one-line description
- why: the problem it solves
- where: registries, deployment URLs
- when: version, ship date
- how: install/usage command

**If database/connection are empty but irrelevant (e.g. MCP server, CLI):**
- Set to `slotignored`

**Score requirements:**
- **100% Trophy** — ideal, ship immediately
- **99%+ Gold** — approved, ship
- **95%+ Silver** — approved, ship
- **85%+ Bronze** — approved, ship with note
- **Below 85%** — **BLOCKED. Cannot publish.** Fix empty slots first.

```bash
# 4. MANDATORY: sync AFTER score — 100% 🏆 must be followed by sync, no exceptions
bun ~/FAF/cli/src/cli.ts sync
```

**⚠️ SYNC IS MANDATORY AFTER SCORE — DO NOT SKIP**
A 100% 🏆 score that is not followed by `faf sync` is incomplete. The sync locks in the score into CLAUDE.md and MEMORY.md. Commit any changes sync produces before proceeding.

**After FAF Gate passes:**
- project.faf is current spec (v3.0+)
- All applicable slots populated
- Score is Bronze (85%) or above
- `faf sync` has been run and changes committed
- CLAUDE.md has one-liner meta stamp
- Proceed to Step 1.5

### Step 1.5: Documentation Gate (CRITICAL — prevents stale README on npm)

**npm bakes the README into the tarball at publish time. Once published, it's effectively permanent. This step prevents stale docs shipping.**

Verify ALL documentation is current BEFORE any version bump or publish:

```bash
# Read and verify each file reflects the CURRENT state
cat README.md      # Must show correct tool count, test count, features
cat CHANGELOG.md   # Must have entry for the version being published
cat CLAUDE.md      # Must be bi-synced with project.faf
cat project.faf    # Must show correct version, tools, tests
```

**README and CHANGELOG must be in sync — both reflect the same version, same features, same test counts. Read both. Cross-check them.**

**Checklist (present to user):**
- [ ] README.md — test count, command descriptions, features match what's actually shipping
- [ ] CHANGELOG.md — entry exists for this version, matches README
- [ ] README ↔ CHANGELOG in sync (same version story, same numbers)
- [ ] CLAUDE.md — bi-synced with project.faf
- [ ] project.faf — version, state, metadata all current

**If ANY file is stale, update it NOW — before proceeding to Step 2.**

### Step 2: 🚨 MANDATORY Dry-Run Check

**NEVER SKIP THIS STEP - It's what the user relies on most**

```bash
# For npm packages:
echo "=== DRY RUN PUBLISH CHECK ==="
npm publish --dry-run 2>&1 | tee /tmp/dry-run-output.txt

# For mcpaas-cf (Cloudflare Workers):
echo "=== DRY RUN DEPLOY CHECK ==="
npx wrangler deploy --dry-run 2>&1 | tee /tmp/dry-run-output.txt
```

**STOP and review the output with the user:**
- Files being included
- Package size
- Any warnings or errors
- Missing or unexpected files

**Present the output to the user and explicitly ask:**
"The dry-run output is above. Does this look correct? Should I proceed with the checklist?"

**DO NOT CONTINUE without user confirmation.**

### Step 3: Run Build & Tests

**For ALL packages:**
```bash
npm run build
npm test
```

**Additional for faf-cli:**
```bash
npm run build:verify
npm run version:truth
```

### Step 4: Verify ALL Files (CRITICAL)

**Run these checks - DO NOT SKIP:**

```bash
# Current version
cat package.json | grep '"version"' | head -1

# Previous version (for bump reporting)
git log --oneline -10  # Find previous version commit

# CHANGELOG - MUST have entry for current version
head -30 CHANGELOG.md

# README - check header/version references
head -50 README.md

# CLAUDE.md - verify current
head -30 CLAUDE.md

# Git status - must be clean
git status --short
```

**Verification Checklist:**
- [ ] Build clean (no errors)
- [ ] Tests passing (note count: X/X)
- [ ] Version bumped correctly (from X.X.X to X.X.X)
- [ ] **CHANGELOG.md has entry for current version** (if missing, ADD IT)
- [ ] README current (update if new features)
- [ ] CLAUDE.md current
- [ ] Git clean (if not, commit pending changes first)

**If CHANGELOG is missing entries:** Update it with changes from `git log` before proceeding.

### Step 5: Generate Approval Request

Format the results as a table:

```
## <package-name> v<version> Ready for Publish

| Check | Status |
|-------|--------|
| **CI/CD** | ✅ Green — all jobs passing |
| **🚨 Dry-Run** | ✅ Reviewed and approved by user |
| **Build** | ✅ Clean |
| **Tests** | ✅ X/X passing |
| **Version** | ✅ X.X.X (from X.X.X) |
| **CHANGELOG** | ✅ Updated (entry for vX.X.X) |
| **README** | ✅ Current |
| **package.json** | ✅ Version correct |
| **CLAUDE.md** | ✅ Current |
| **Git** | ✅ Clean, pushed |

**Changes in vX.X.X:**
- <bullet points of what changed>

---

Awaiting GO! from wolfejam
```

### Step 6: Wait for Approval

**DO NOT PUBLISH** until wolfejam responds with:
- "GO!"
- "GREEN LIGHT"

Any other response = DO NOT PUBLISH

### Step 6.5: 🚨 FINAL Dry-Run (MANDATORY if any commits landed after Step 2)

**Dry-run has saved the show many times. Never skip because CI is green or an earlier dry-run passed.**

If ANY commit has landed between Step 2 and Step 7 — even a documentation-only one, even a workflow rename, even a single-character README tweak — the tarball has changed. Re-run dry-run and show the user the diff before `npm publish`.

```bash
# For npm packages — re-run against the current HEAD
npm publish --dry-run 2>&1 | tee /tmp/dry-run-final.txt
```

**Compare to the Step 2 dry-run:**
- Has `package size` changed?
- Has any file size changed (especially README.md)?
- Are there any new warnings?
- Is the file list identical?

**Why this matters:** CI inspects code. Dry-run inspects the actual tarball — the thing users download. README edits, .npmignore changes, accidentally-included files show up in dry-run only. The final dry-run catches the "wait, was this what I meant to ship?" moment that CI cannot.

**Present to user:**
- If identical to Step 2 dry-run → "Tarball unchanged from approval. Proceeding to publish."
- If different → Show the diff (sizes, file list) and ask: "These changes landed after the approval. Proceed with publish?"

**DO NOT PUBLISH without this final check if any post-Step-2 commit exists.**

### Step 7: Post-Publish (After Approval)

**For npm packages:**
```bash
npm publish
```

**For gemini-faf-mcp (PyPI):**
```bash
# Uses Trusted Publisher (OIDC) - no token needed
git tag v<VERSION>
git push origin v<VERSION>
# GitHub Actions will publish via pyproject.toml
```

**For mcpaas-cf (Cloudflare Workers):**
```bash
cd /Users/wolfejam/FAF/mcpaas-cf
npx wrangler deploy
# Then run post-deploy verification (Step 7.5)
```

**For faf-cli ONLY** - Update Homebrew:
```bash
# Get new SHA256
curl -sL https://registry.npmjs.org/faf-cli/-/faf-cli-<VERSION>.tgz | shasum -a 256

# Update formula
cd /usr/local/Homebrew/Library/Taps/wolfe-jam/homebrew-faf
# Edit Formula/faf-cli.rb with new version and sha256
git add Formula/faf-cli.rb
git commit -m "chore: Update faf-cli to v<VERSION>"
git push
```

### Step 7.5: Post-Deploy Verification (For Live Services)

**Skip if:** Package is a CLI tool or library with no live deployment.

**Applies to:** mcpaas-cf (mcpaas.live), mcpaas-beacon, or any package that deploys to a live endpoint.

After publish/deploy, run the post-deploy WJTTC test suite to verify the live service:

```bash
# MCPaaS (mcpaas.live)
cd /Users/wolfejam/FAF/mcpaas-cf
npx wrangler deploy              # Deploy to Cloudflare
npm test -- tests/wjttc/post-deploy.test.ts  # 52 tests, ~34s
```

**What it checks:**
- Health, security headers, CORS (TIER 1 BRAKE)
- All pages, souls, MCP protocol, API, well-known endpoints (TIER 2 ENGINE)
- Canonical headers, caching, badges, manifest (TIER 3 AERO)

**Pass criteria:** All tests pass. Report auto-generated at `reports/post-deploy-latest.md`.

**If tests fail:** Do NOT proceed to Step 8. Fix and redeploy first.

### Step 8: MCP Registry Publish (For MCP Servers)

**Prerequisite:** Install mcp-publisher
```bash
brew install mcp-publisher
```

**Authenticate (uses Trusted Publisher - no tokens):**
```bash
mcp-publisher login github
# Follow device code flow at https://github.com/login/device
```

**Update server.json version** (must match npm/PyPI version):
```bash
# Edit server.json
# version: "<NEW_VERSION>"
# packages[0].version: "<NEW_VERSION>"
```

**Publish to MCP Registry:**
```bash
mcp-publisher publish server.json
```

**All 5 FAF MCPs use Ecosystem: #2759 in description**

### Step 8.5: Smithery Publish (For MCP Servers)

**Smithery is a major MCP marketplace — publish immediately after MCP Registry.**

```bash
cd /path/to/package
npx @smithery/cli publish
```

**Interactive prompts:**
- Namespace: `wolfe-jam` (select from list)
- Server name: `<package-name>` (e.g. `claude-faf-mcp`)

**Smithery config** lives in `.smithery/shttp/manifest.json` — no manual edits needed.

**If token expired:** `npx @smithery/cli login` then retry.

### Step 9: Distribution Checklist

After npm/PyPI + MCP Registry, distribute to the full ecosystem.

**Reference:** `/Users/wolfejam/FAF-GOLD/PLANET-FAF/docs/MCP-REGISTRY-LANDSCAPE-2026.md`

#### TIER 1: OFFICIAL / AUTHORITATIVE

| Registry | URL | Notes |
|----------|-----|-------|
| **Official MCP Registry** | registry.modelcontextprotocol.io | THE source. mcp-publisher CLI. |
| **GitHub MCP Registry** | docs.github.com/en/copilot/concepts/context/mcp | Powers VS Code MCP marketplace |

#### TIER 2: MAJOR DIRECTORIES (High Traffic)

| Directory | URL | Size | Submission |
|-----------|-----|------|------------|
| **MCP.so** | mcp.so | 17,387+ | Auto-indexes npm/PyPI |
| **PulseMCP** | pulsemcp.com/servers | 7,890+ | Submit via form |
| **Glama.ai** | glama.ai/mcp/servers | Large | Auto-indexes GitHub |
| **Smithery.ai** | smithery.ai | 1,500+ | `npx @smithery/cli publish` |

#### TIER 3: CURATED LISTS (GitHub PRs)

| List | URL | Notes |
|------|-----|-------|
| **awesome-mcp-servers** (punkpeye) | github.com/punkpeye/awesome-mcp-servers | Production + experimental |
| **awesome-mcp-servers** (wong2) | github.com/wong2/awesome-mcp-servers | Original curated list |

#### TIER 4: AGGREGATORS / FINDERS

| Site | URL |
|------|-----|
| **MCPMarket.com** | mcpmarket.com |
| **mcp-awesome.com** | mcp-awesome.com |
| **mcpservers.org** | mcpservers.org |
| **mcpserverfinder.com** | mcpserverfinder.com |
| **mcpregistry.online** | mcpregistry.online |

#### TIER 5: IDE-SPECIFIC

| Platform | Notes |
|----------|-------|
| **Cline MCP Marketplace** | GitHub Issue submission |
| **Cursor.directory** | Cursor-specific listing |
| **LobeHub** | MCP server directory |

#### Phased Rollout Plan

| Phase | Timeline | Targets |
|-------|----------|---------|
| Phase 1 | Immediate | Official Registry, GitHub Registry |
| Phase 2 | Week 1 | MCP.so, PulseMCP, Glama, Smithery |
| Phase 3 | Week 2 | awesome-mcp-servers PRs (both repos) |
| Phase 4 | Ongoing | Aggregators, IDE-specific directories |

**GitHub Release (ALL packages):**

Create a GitHub release immediately after npm/MCP Registry publish:

```bash
gh release create v<VERSION> \
  --title "v<VERSION> — <Edition Name if applicable>" \
  --notes "<release notes from CHANGELOG>"
```

**Edition detection — if the CHANGELOG entry has a named edition (e.g. "The Relentless Edition", "The Conductor Edition"), include it in the release title:**
- Named edition → `v5.4.0 — The Relentless Edition`
- No edition name → `v5.4.0`

Release notes must include:
- What's new (from CHANGELOG)
- Test count
- "FAF defines. MD instructs. AI codes." closing line

### Step 9.5: Post-Release CI Verification (MANDATORY — no red badges on npm)

**Step 1.1 verifies CI before the release. This step verifies the release event itself. The `release:created` event triggers workflows a second time — if any job fails there, the npm badge flips red even though publish succeeded. A red badge on npm is permanent damage; this step exists to catch the failure inside the pubpro flow instead of a user seeing it first.**

**This is the blind spot that caused the v5.5.1 red badge on claude-faf-mcp — pubpro's pre-publish CI gate was green, but the release event fired a CI workflow that failed (CI was trying to double-publish). Fixed in FAF workflows by removing `npm publish` from CI, but the verification step stays as a permanent guard.**

```bash
# Resolve repo from package.json
REPO=$(node -e "const p=require('./package.json'); const u=p.repository?.url||''; const m=u.match(/github\.com[\/:]([^\/]+\/[^\/\.]+)/); console.log(m?m[1]:'unknown')")

# Poll the release-triggered workflow run for up to 3 minutes
for i in $(seq 1 36); do
  STATUS_JSON=$(gh run list --repo "$REPO" --event release --limit 1 --json status,conclusion,databaseId)
  CONCLUSION=$(echo "$STATUS_JSON" | jq -r '.[0].conclusion // ""')
  RUN_STATUS=$(echo "$STATUS_JSON" | jq -r '.[0].status // ""')
  RUN_ID=$(echo "$STATUS_JSON" | jq -r '.[0].databaseId // ""')

  if [ "$CONCLUSION" = "success" ]; then
    echo "✅ Release CI green — npm badge will stay green"
    break
  elif [ "$CONCLUSION" = "failure" ] || [ "$CONCLUSION" = "cancelled" ]; then
    echo "🚫 RELEASE CI FAILED — npm badge is now RED"
    gh run view "$RUN_ID" --repo "$REPO"
    exit 1
  fi
  echo "⏳ Release CI: $RUN_STATUS (attempt $i/36)"
  sleep 5
done
```

**Rules:**
- ✅ Release CI green → proceed to distribution
- ⏳ Release CI in progress → keep waiting up to 3 min
- 🚫 Release CI failed → **STOP. Flag to wolfejam immediately. Do NOT proceed to distribution or social posts.** Fix the CI failure first; red badges on npm are banned.

**If you see `npm publish` sneaking back into any FAF repo's workflow file, open a PR to remove it immediately.** CI validates, pubpro publishes — never both.

**(Optional) Post-Publish Assets:**
- `/pubblog` — Blog post for faf.one (do this first, everything flows from the blog)
- `/diagram-builder` — HTML/CSS architecture diagram for hero image (screenshot-ready, FAF-styled)
- `/gif-recorder` — VHS terminal recording for compile/usage demos (GIF format)
- X/Twitter: `https://twitter.com/intent/tweet?text=...&url=...`

## Emergency Rollback

If something goes wrong:

```bash
# Within 72 hours
npm unpublish <package>@<version>

# After 72 hours
npm deprecate <package>@<version> "Rollback - use <previous-version>"
```

## Why This Exists

- Trust is everything
- Production infrastructure for thousands of developers
- Official Anthropic MCP steward responsibility
- One bad publish = permanent reputation damage
- FAF Ecosystem #2759 - 5 MCP servers serving Claude, Grok, Gemini

**Professional. Boring. Trusted.**

## Quick Reference

```
FAF Ecosystem #2759
├── claude-faf-mcp   (npm + MCP Registry)
├── faf-mcp          (npm + MCP Registry)
├── grok-faf-mcp     (npm + MCP Registry)
├── gemini-faf-mcp   (PyPI + MCP Registry)
├── WJTTC            (npm + MCP Registry)
├── faf-cli          (npm + Homebrew)
└── mcpaas-cf        (Cloudflare Workers)
```

**MCP Registry Schema:** 2025-12-11 (current)
**PyPI Auth:** Trusted Publisher (OIDC)
**npm Auth:** Standard npm login
