---
name: pubcrate
description: FAF publish protocol for crates.io. Run pre-publish checklist, verify build/tests, dry-run, prepare approval request for Rust crate publishing.
---

# PubCrate - FAF Crates.io Publish Protocol

Run the FAF publish protocol checklist before any crates.io publish.

## Usage

```
/pubcrate            # Interactive menu (recommended)
/pubcrate mcpaas     # mcpaas crate (Radio Protocol client)
/pubcrate faf-sdk    # faf-rust-sdk crate (FAF parser)
```

## Crate Registry

| Argument | Crate | Path | Registry |
|----------|-------|------|----------|
| `mcpaas` | mcpaas | `/Users/wolfejam/FAF/faf-radio-rust` | crates.io |
| `faf-sdk` | faf-rust-sdk | `/Users/wolfejam/FAF/faf-rust-sdk` | crates.io |

## The Protocol

### Step 0: Crate Selection (if no argument)

If `/pubcrate` is called without an argument, use **AskUserQuestion** to present an interactive menu:

```
Question: "Which crate do you want to publish?"
Header: "Crate"
Options:
  - label: "mcpaas"
    description: "/Users/wolfejam/FAF/faf-radio-rust - Radio Protocol client (crates.io)"
  - label: "faf-rust-sdk"
    description: "/Users/wolfejam/FAF/faf-rust-sdk - FAF parser SDK (crates.io)"
```

### Step 1: Change to Crate Directory

Based on argument or menu selection, cd to the correct path.

### Step 1.5: Documentation Gate (CRITICAL — prevents stale README on crates.io)

**crates.io bakes the README into the tarball at publish time. Once published, it's IMMUTABLE. There is NO way to update it without publishing a new version. This step prevents that.**

Verify ALL documentation is current BEFORE any version bump or publish:

```bash
# Read and verify each file reflects the CURRENT state
cat README.md      # Must show correct tool count, test count, install options
cat CHANGELOG.md   # Must have entry for the version being published
cat CLAUDE.md      # Must be bi-synced with project.faf
cat project.faf    # Must show correct version, tools, tests
```

**Checklist (present to user):**
- [ ] README.md — tool count, test count, features, install commands all current
- [ ] CHANGELOG.md — entry exists for this version
- [ ] CLAUDE.md — bi-synced with project.faf
- [ ] project.faf — version, state, metadata all current

**If ANY file is stale, update it NOW — before proceeding to Step 2.**

**WHY:** v0.2.0 of rust-faf-mcp shipped with "5 tools, 49 tests" on crates.io because the README was rewritten AFTER publish. Required a 0.2.1 patch just to fix the README. Never again.

### Step 2: Pre-Flight Checks

```bash
# Current version
grep '^version' Cargo.toml | head -1

# Previous version (for bump reporting)
git log --oneline -10

# Git status - must be clean
git status --short
```

**Version Bump:** If the current version is already published, prompt:
"Current version is X.X.X (already on crates.io). What's the new version?"
- Patch (X.X.+1) for fixes/cleanup
- Minor (X.+1.0) for new features
- Major (+1.0.0) for breaking changes

Update `Cargo.toml` version before proceeding.

### Step 3: Run Build, Lint & Tests

```bash
cargo fmt --check
cargo clippy -- -D warnings
cargo build --release
cargo test
cargo doc --no-deps
```

**All must pass. Zero failures, zero warnings, zero lint errors.**
- `cargo fmt` — consistent formatting
- `cargo clippy` — lint clean (deny warnings)
- `cargo doc` — docs.rs will build this automatically; catch broken doc comments now

### Step 4: 🚨 MANDATORY Dry-Run Check

**NEVER SKIP THIS STEP**

```bash
echo "=== DRY RUN PUBLISH CHECK ==="
cargo publish --dry-run 2>&1
```

**STOP and review the output with the user:**
- Files being packaged (count + size)
- Compilation success
- Any warnings or errors
- Missing or unexpected files

**Present the output to the user and explicitly ask:**
"The dry-run output is above. Does this look correct? Should I proceed with the checklist?"

**DO NOT CONTINUE without user confirmation.**

### Step 5: Verify Files (CRITICAL)

**Verification Checklist:**
- [ ] Build clean (no errors, no warnings)
- [ ] Tests passing (note count: X/X)
- [ ] Dry-run clean (no errors)
- [ ] Clippy clean (zero warnings)
- [ ] Formatting clean (cargo fmt)
- [ ] Version bumped correctly (from X.X.X to X.X.X)
- [ ] README.md current
- [ ] CLAUDE.md current (if exists)
- [ ] Cargo.toml metadata complete (description, license, repository, keywords)
- [ ] Docs build clean (cargo doc)
- [ ] Git clean and pushed

### Step 6: Generate Approval Request

Format the results as a table:

```
## <crate-name> v<version> Ready for Publish

| Check | Status |
|-------|--------|
| **🚨 Dry-Run** | ✅ Reviewed and approved by user |
| **Build** | ✅ Clean (release profile) |
| **Clippy** | ✅ Zero warnings |
| **Fmt** | ✅ Consistent |
| **Tests** | ✅ X/X passing |
| **Docs** | ✅ Build clean |
| **Version** | ✅ X.X.X (from X.X.X) |
| **Cargo.toml** | ✅ Metadata complete |
| **README** | ✅ Current |
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

```bash
cargo publish
```

**Verify on crates.io:**
```bash
# Check it's live (may take a minute to index)
cargo search <crate-name> | head -3
```

### Step 9: Post-Publish

**GitHub Release:**
```bash
# Check tag doesn't already exist
git tag -l v<VERSION>

# Create and push tag
git tag v<VERSION>
git push origin v<VERSION>
```

Create GitHub release with changelog using `gh release create v<VERSION>`.

**(Optional) Post-Publish Assets:**
- `/pubblog` — Blog post for faf.one (do this first, everything flows from the blog)
- `/diagram-builder` — HTML/CSS architecture diagram for hero image (screenshot-ready, FAF-styled)
- `/gif-recorder` — VHS terminal recording for compile/usage demos (GIF format)
- `/publish` — Full multi-platform distribution for major releases

## Emergency Rollback

If something goes wrong:

```bash
# Yank a version (prevents new installs, existing builds unaffected)
cargo yank --version <VERSION>

# Undo a yank
cargo yank --version <VERSION> --undo
```

**Note:** crates.io does NOT support deletion. Yank is the only option.
Yanked versions still exist but won't be used by new `cargo add` or fresh builds.

## Cargo.toml Metadata Checklist

Every crate MUST have these fields before publishing:

```toml
[package]
name = "..."
version = "..."
edition = "..."
authors = ["wolfejam <wolfejam@faf.one>"]
description = "..."        # Required by crates.io
license = "MIT"            # Required by crates.io
repository = "https://github.com/Wolfe-Jam/..."
homepage = "..."
documentation = "https://docs.rs/..."
readme = "README.md"
keywords = ["...", "..."]  # Max 5
categories = ["..."]       # From crates.io category list
```

## Why This Exists

- Trust is everything
- Production infrastructure on crates.io is permanent
- crates.io has NO delete — only yank
- One bad publish lives forever
- Dry-run catches problems before they're permanent

**Professional. Boring. Trusted.**

## Quick Reference

```
FAF Rust Crates
├── mcpaas        (crates.io - Radio Protocol client)
└── faf-rust-sdk  (crates.io - FAF parser SDK)
```

**Auth:** `cargo login` (one-time, token from crates.io/me)
**Dry-run:** `cargo publish --dry-run` (MANDATORY before every publish)
**Rollback:** `cargo yank --version X.X.X` (yank only, no delete)
