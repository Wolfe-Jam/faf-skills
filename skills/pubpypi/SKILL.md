---
name: pubpypi
description: FAF publish protocol for PyPI. Run pre-publish checklist, verify build/tests, dry-run, prepare approval request for Python package publishing.
---

# PubPyPI - FAF PyPI Publish Protocol

Run the FAF publish protocol checklist before any PyPI publish.

## Usage

```
/pubpypi             # Interactive menu (recommended)
/pubpypi gemini      # gemini-faf-mcp package (PyPI)
```

## Package Registry

| Argument | Package | Path | Registry |
|----------|---------|------|----------|
| `gemini` | gemini-faf-mcp | `/Users/wolfejam/FAF/gemini-faf-mcp` | PyPI + MCP |

## The Protocol

### Step 0: Package Selection (if no argument)

If `/pubpypi` is called without an argument, use **AskUserQuestion** to present an interactive menu:

```
Question: "Which Python package do you want to publish?"
Header: "Package"
Options:
  - label: "gemini-faf-mcp"
    description: "/Users/wolfejam/FAF/gemini-faf-mcp - Gemini MCP (PyPI + MCP Registry)"
```

### Step 1: Change to Package Directory

Based on argument or menu selection, cd to the correct path.

### Step 1.5: Documentation Gate (CRITICAL — prevents stale README on PyPI)

**PyPI bakes the README into the package at publish time. Once published, it's permanent. This step prevents stale docs shipping.**

Verify ALL documentation is current BEFORE any version bump or publish:

- [ ] README.md — features, install commands, test count all current
- [ ] CHANGELOG.md — entry exists for this version
- [ ] project.faf — version, state, metadata all current

**If ANY file is stale, update it NOW — before proceeding to Step 2.**

### Step 2: Pre-Flight Checks

```bash
# Current version in pyproject.toml
grep '^version' pyproject.toml | head -1

# Check __init__.py version matches
grep '__version__' src/gemini_faf_mcp/__init__.py

# Check client.py version matches
grep '__version__' src/gemini_faf_mcp/client.py

# Previous version (for bump reporting)
git log --oneline -10

# Git status - must be clean
git status --short
```

**Version Consistency:** All three locations MUST match:
- `pyproject.toml` → `version = "X.X.X"`
- `src/gemini_faf_mcp/__init__.py` → `__version__ = "X.X.X"`
- `src/gemini_faf_mcp/client.py` → `__version__ = "X.X.X"`

If they don't match, fix before proceeding.

### Step 3: Set Up Venv & Run Tests

```bash
# Create/activate venv
python3 -m venv .venv
source .venv/bin/activate

# Install in editable dev mode
pip install -e ".[dev]"

# Run tests (local tests only — Tiers 6+7 don't need network)
python -m pytest tests/ -v -k "Tier6 or Tier7"
```

**All must pass. Zero failures.**

### Step 4: 🚨 MANDATORY Dry-Run Check

**NEVER SKIP THIS STEP**

```bash
source .venv/bin/activate
echo "=== DRY RUN BUILD CHECK ==="
python -m build 2>&1
twine check dist/* 2>&1
```

**STOP and review the output with the user:**
- Package files built (sdist + wheel)
- Package size
- twine check PASSED (no warnings)
- Version correct in filenames

**Present the output to the user and explicitly ask:**
"The dry-run output is above. Does this look correct? Should I proceed with the checklist?"

**DO NOT CONTINUE without user confirmation.**

### Step 5: Verify Files (CRITICAL)

**Verification Checklist:**
- [ ] Tests passing (note count: X/X)
- [ ] Build clean (sdist + wheel)
- [ ] twine check PASSED
- [ ] Version bumped correctly (from X.X.X to X.X.X)
- [ ] Version consistent across pyproject.toml, __init__.py, client.py
- [ ] README.md current
- [ ] CLAUDE.md current
- [ ] GEMINI.md score correct (run `python sync_faf.py` if needed)
- [ ] pyproject.toml metadata complete (description, license, urls, classifiers)
- [ ] Git clean and pushed

### Step 6: Generate Approval Request

Format the results as a table:

```
## <package-name> v<version> Ready for Publish

| Check | Status |
|-------|--------|
| **🚨 Dry-Run** | ✅ Build + twine check reviewed by user |
| **Tests** | ✅ X/X passing |
| **Version** | ✅ X.X.X (from X.X.X) |
| **Version Sync** | ✅ pyproject.toml + __init__.py + client.py match |
| **README** | ✅ Current |
| **CLAUDE.md** | ✅ Current |
| **GEMINI.md** | ✅ Score correct (X%) |
| **pyproject.toml** | ✅ Metadata complete |
| **Git** | ✅ Clean, pushed |

**Changes in vX.X.X:**
- <bullet points of what changed>

---

Awaiting GO! from wolfejam
```

### Step 7: Wait for Approval

**DO NOT PUBLISH** until wolfejam responds with:
- "GO!"
- "GREEN LIGHT"

Any other response = DO NOT PUBLISH

### Step 8: Publish (After Approval)

**gemini-faf-mcp uses Trusted Publisher (OIDC) — publish via GitHub Release:**

```bash
# Clean old dist
rm -rf dist/

# Tag the release
git tag v<VERSION>
git push origin v<VERSION>

# Create GitHub release (triggers pypi.yml workflow)
gh release create v<VERSION> --title "v<VERSION>" --notes "$(cat <<'EOF'
## Changes in v<VERSION>

- <bullet points>
EOF
)"
```

**Verify on PyPI:**
```bash
# Check it's live (may take 2-3 minutes to index)
pip index versions gemini-faf-mcp 2>/dev/null || pip install gemini-faf-mcp==<VERSION> --dry-run
```

**Monitor GitHub Actions:**
```bash
gh run list --workflow=pypi.yml --limit=1
gh run view --workflow=pypi.yml
```

### Step 9: Post-Publish Verification

```bash
# Verify on PyPI
open "https://pypi.org/project/gemini-faf-mcp/<VERSION>/"

# Test install in fresh venv
python3 -m venv /tmp/test-install
source /tmp/test-install/bin/activate
pip install gemini-faf-mcp==<VERSION>
python -c "import gemini_faf_mcp; print(gemini_faf_mcp.__version__)"
deactivate
rm -rf /tmp/test-install
```

### Step 10: MCP Registry Publish (Optional)

**If scope includes MCP Registry:**

```bash
# Update server.json version
# version: "<NEW_VERSION>"
# packages[0].version: "<NEW_VERSION>"

mcp-publisher publish server.json
```

## Emergency Rollback

If something goes wrong:

```bash
# PyPI does NOT support deletion after 72 hours
# Within the first few minutes, you can yank:
pip install twine
twine upload --skip-existing  # Won't overwrite

# Best option: publish a patch version with the fix
# e.g., if 1.1.0 is broken, publish 1.1.1 ASAP
```

**Note:** PyPI versions are permanent. Unlike npm, you cannot unpublish after the window.
Plan ahead. Dry-run catches problems before they're permanent.

## pyproject.toml Metadata Checklist

Every PyPI package MUST have these fields before publishing:

```toml
[project]
name = "..."
version = "..."
authors = [{name = "wolfejam", email = "james@wolfejam.dev"}]
description = "..."           # Required by PyPI
license = {text = "MIT"}      # Required by PyPI
readme = "README.md"
requires-python = ">=3.12"
classifiers = [...]           # PyPI classifiers
keywords = [...]              # Discoverability
dependencies = [...]          # Runtime deps

[project.urls]
"Homepage" = "https://github.com/Wolfe-Jam/..."
"Bug Tracker" = "https://github.com/Wolfe-Jam/.../issues"
```

## Publish Family

```
/pubpro    → npm packages (faf-cli, claude-faf-mcp, grok-faf-mcp, etc.)
/pubcrate  → Rust crates (faf-rust-sdk, faf-radio-rust, etc.)
/pubpypi   → Python packages (gemini-faf-mcp)
/publish   → Announce everywhere (blog, Dev.to, X, etc.)
```

## Why This Exists

- Trust is everything
- PyPI versions are permanent — no delete, no undo
- 3k+ downloads in 2 weeks with zero advertising
- Trusted Publisher (OIDC) — no tokens to leak
- Dry-run catches problems before they're permanent

**Professional. Boring. Trusted.**

## Quick Reference

```
FAF Python Packages
└── gemini-faf-mcp  (PyPI + MCP Registry)
```

**Auth:** Trusted Publisher (OIDC via GitHub Actions — no token needed)
**Build:** `python -m build` (sdist + wheel)
**Check:** `twine check dist/*` (MANDATORY before every publish)
**Publish:** Tag + GitHub Release triggers `pypi.yml` workflow
**Rollback:** Publish a patch version (PyPI versions are permanent)
