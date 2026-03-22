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
| **Claude** | io.github.Wolfe-Jam/claude-faf-mcp | npm v4.0.0 | v4.0.0 |
| **Core FAF** | io.github.Wolfe-Jam/faf-mcp | npm v1.2.4 | v1.2.4 |
| **Grok** | io.github.Wolfe-Jam/grok-faf-mcp | npm v1.0.2 | v1.0.2 |
| **Gemini** | io.github.Wolfe-Jam/gemini-faf-mcp | PyPI v1.0.2 | v1.0.2 |
| **WJTTC** | io.github.Wolfe-Jam/WJTTC | npm v1.1.0 | v1.1.0 |

**Plus CLI:** faf-cli (npm + Homebrew)
**Plus Infrastructure:** mcpaas-cf (Cloudflare Workers)

## Package Paths

| Argument | Package | Path | Registry |
|----------|---------|------|----------|
| `cli` | faf-cli | `/Users/wolfejam/FAF/cli` | npm + Homebrew |
| `mcp` | claude-faf-mcp | `/Users/wolfejam/FAF/claude-faf-mcp` | npm + MCP |
| `faf-mcp` | faf-mcp | `/Users/wolfejam/FAF/faf-mcp` | npm + MCP |
| `grok` | grok-faf-mcp | `/Users/wolfejam/FAF/grok-faf-mcp` | npm + MCP |
| `gemini` | gemini-faf-mcp | `/Users/wolfejam/FAF/gemini-faf-mcp` | PyPI + MCP |
| `mcpaas` | mcpaas-cf | `/Users/wolfejam/FAF/mcpaas-cf` | Cloudflare Workers |

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
```

### Step 1: Change to Package Directory

Based on argument or menu selection, cd to the correct path.

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

**Checklist (present to user):**
- [ ] README.md — tool count, test count, features all current
- [ ] CHANGELOG.md — entry exists for this version
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
- Create release with changelog
- Tag format: `v<VERSION>`

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
