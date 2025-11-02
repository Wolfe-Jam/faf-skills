---
name: faf-migrate
description: Migrate old project.faf formats to current IANA-registered version (3.0.0+). Upgrades from legacy formats, adds required fields, preserves existing content. Use when user has old FAF file, sees format version warnings, or wants latest specification compliance.
allowed-tools: Read, Write, Edit, Bash
---

# FAF Migrate - Format Version Upgrader

## Purpose

Automatically upgrade `project.faf` files from older format versions to the current IANA-registered specification (v3.0.0+). Preserves all existing content while adding required modern fields.

**The Goal:** Painless migration from any old format to current standard. Zero data loss.

## When to Use

This skill activates automatically when the user:
- Has old project.faf (format version <3.0.0)
- Sees "old format version" warning from `faf validate`
- Says "Upgrade my FAF format"
- Says "Migrate to latest version"
- Asks "How do I update my project.faf?"
- Has project.faf without IANA media type
- Wants IANA registration compliance

**Trigger Words:** migrate, upgrade, update, convert, modernize, latest version, IANA compliance

## How It Works

### Step 1: Detect Current Version

Check existing format version:

```bash
# Read current format version
grep -A2 "metadata:" project.faf | grep "format_version"
```

**Possible versions:**
- v1.x (original, pre-metadata) - deprecated
- v2.x (added metadata) - deprecated
- v3.x (IANA registered) - current

### Step 2: Backup Original

Always backup before migration:

```bash
# Create backup
cp project.faf project.faf.backup

# Verify backup exists
ls -la project.faf.backup
```

### Step 3: Execute Migration

Run the migration command:

```bash
faf migrate
```

This command (from faf-cli v3.1.1):
- Detects current version
- Determines required upgrades
- Adds missing fields
- Updates format version
- Preserves all existing content
- Creates backup automatically

### Step 4: Verify Migration

Check migration succeeded:

```bash
# Validate new format
faf validate

# Check new version
grep -A2 "metadata:" project.faf | grep "format_version"
# Should show: 3.0.0 or higher

# Verify IANA media type added
grep "iana_media_type" project.faf
# Should show: application/vnd.faf+yaml
```

### Step 5: Test & Score

After migration, verify everything works:

```bash
# Score the migrated file
faf score

# Sync if you have CLAUDE.md
faf bi-sync

# Final validation
faf validate
```

## Migration Paths

### v1.x → v3.0.0

**What v1.x looked like:**
```yaml
name: my-project
description: What it does
language: TypeScript
framework: React
testing: Jest
```

**What gets added:**
```yaml
# Original content preserved
name: my-project

# 'description' renamed to 'purpose' (semantic clarity)
purpose: What it does

# Metadata section added (v3.0.0 requirement)
metadata:
  format_version: 3.0.0
  iana_media_type: application/vnd.faf+yaml
  created: 2025-11-02
  migrated_from: 1.0.0

# Version field added (semver)
version: 1.0.0

# Architecture section added (v3.0.0 structure)
architecture:
  type: web-app  # Inferred from context
  language: TypeScript  # Moved from root

# Stack section added (v3.0.0 structure)
stack:
  framework: React  # Moved from root

# Testing section restructured
testing:
  framework: Jest  # Moved from root
```

**Migration time:** ~50ms

### v2.x → v3.0.0

**What v2.x looked like:**
```yaml
name: my-project
purpose: What it does
version: 1.0.0

metadata:
  format_version: 2.5.0
  created: 2024-06-15

architecture:
  type: web-app
  language: TypeScript

stack:
  framework: React 18
```

**What gets added:**
```yaml
# All original content preserved

# metadata section enhanced
metadata:
  format_version: 3.0.0  # Updated from 2.5.0
  iana_media_type: application/vnd.faf+yaml  # Added (IANA registration)
  created: 2024-06-15  # Preserved
  migrated_from: 2.5.0  # Migration history

# Everything else unchanged
name: my-project
purpose: What it does
version: 1.0.0

architecture:
  type: web-app
  language: TypeScript

stack:
  framework: React 18
```

**Migration time:** ~20ms

## Examples

### Example 1: Migrate from v1.x

**User:** "Upgrade my FAF format"

**Skill Activates:**

1. **Check current version:**
```bash
grep -A2 "metadata:" project.faf
# No metadata section found → v1.x format
```

2. **Backup original:**
```bash
cp project.faf project.faf.backup
```

3. **Migrate:**
```bash
faf migrate

# Output:
✓ Detected format version: 1.0.0 (legacy)
✓ Backing up to project.faf.backup
✓ Migrating to format version 3.0.0
✓ Adding metadata section
✓ Adding IANA media type
✓ Restructuring architecture section
✓ Migration complete (45ms)

New format version: 3.0.0
IANA compliance: ✓
```

4. **Verify:**
```bash
faf validate
# ✓ Valid YAML syntax
# ✓ Format version 3.0.0
# ✓ IANA media type: application/vnd.faf+yaml
# ✓ All required fields present
# project.faf is valid!

faf score
# 🥈 Silver (58%) - Same content, modern format
```

5. **Report to user:**
"Successfully migrated from v1.0.0 to v3.0.0!

**Changes:**
- Added metadata section
- Added IANA media type (application/vnd.faf+yaml)
- Restructured architecture section
- All original content preserved

**Backup:** project.faf.backup

Your file is now IANA-compliant and ready to use with all modern FAF tools."

### Example 2: Migrate from v2.x

**User:** "I see a format version warning. How do I update?"

**Skill Activates:**

1. **Check version:**
```bash
grep "format_version" project.faf
# format_version: 2.3.0
```

2. **Migrate:**
```bash
faf migrate

# Output:
✓ Detected format version: 2.3.0
✓ Backing up to project.faf.backup
✓ Migrating to format version 3.0.0
✓ Adding IANA media type
✓ Migration complete (18ms)

New format version: 3.0.0
```

3. **Report:**
"Upgraded from v2.3.0 to v3.0.0 (18ms).

**What changed:**
- Format version: 2.3.0 → 3.0.0
- Added: IANA media type (application/vnd.faf+yaml)
- Added: Migration history (migrated_from: 2.3.0)

**What didn't change:**
- All your content (preserved exactly)
- File structure (already modern)
- AI-readiness score (same content)

You're now using the IANA-registered standard."

### Example 3: Already on Latest

**User:** "Migrate my FAF"

**Skill Activates:**

1. **Check version:**
```bash
grep "format_version" project.faf
# format_version: 3.0.0
```

2. **Run migrate:**
```bash
faf migrate

# Output:
✓ Already on latest format version: 3.0.0
✓ IANA media type present
✓ No migration needed

project.faf is up to date!
```

3. **Report:**
"Your project.faf is already on the latest format (v3.0.0). No migration needed!"

## Migration Safety

### Automatic Backups

Every migration creates a backup:

```bash
# Before migration
project.faf  # Original

# After migration
project.faf         # Migrated (new format)
project.faf.backup  # Backup (original, unchanged)
```

**Rollback if needed:**
```bash
# Restore from backup
cp project.faf.backup project.faf
```

### Content Preservation

**Guaranteed preservation:**
- ✅ All field values (preserved exactly)
- ✅ All custom sections (preserved)
- ✅ All comments (preserved where possible)
- ✅ All content structure (preserved or improved)

**What changes:**
- Format version number (old → 3.0.0)
- Metadata structure (adds IANA compliance)
- Section organization (improves, doesn't lose)

**What never changes:**
- Your project name
- Your project purpose
- Your stack information
- Your testing details
- Your custom content

### Validation After Migration

Always validate after migrating:

```bash
faf migrate
faf validate  # Should pass with zero errors
faf score     # Should match or improve previous score
```

**If validation fails after migration:**
This is a bug. Restore backup and report issue:

```bash
# Restore original
cp project.faf.backup project.faf

# Report issue at:
# https://github.com/Wolfe-Jam/faf-cli/issues
```

## Troubleshooting

### Issue: Migration fails with YAML error

**Solution:**
```bash
# Original file may have syntax errors
faf validate  # Check original FIRST

# Fix syntax errors in original
# Then retry migration
faf migrate
```

### Issue: Backup already exists

**Solution:**
```bash
# Multiple migration attempts create project.faf.backup

# Option 1: Remove old backup
rm project.faf.backup
faf migrate

# Option 2: Save old backup
mv project.faf.backup project.faf.backup.old
faf migrate
```

### Issue: Lost custom sections after migration

**Solution:**
```bash
# This should never happen. Restore and report:
cp project.faf.backup project.faf

# Compare files to identify what was lost
diff project.faf.backup project.faf

# Report issue with diff output
```

### Issue: Score decreased after migration

**Solution:**
```bash
# Migration should not decrease score
# If it does, this is a bug

# Restore backup
cp project.faf.backup project.faf

# Compare scores
faf score  # Original score

# Migrate again with verbose output
faf migrate --verbose  # (if supported)

# Report unexpected score decrease
```

## Supporting Files

This skill works with:
- **faf-cli** (v3.1.1+) - Migration engine
- **project.faf** - File being migrated
- **project.faf.backup** - Safety backup

## Related Skills

Migration integrates with:
- **faf-validate** - Check format before/after migration
- **faf-score** - Verify score maintained after migration
- **faf-init** - Alternative: create new file instead of migrating
- **faf-sync** - Sync migrated file to CLAUDE.md

## Key Principles

**Zero Data Loss:**
- All content preserved
- Automatic backups
- Rollback available
- Safety first

**Backward Compatibility:**
- Reads all old formats (v1.x, v2.x)
- Upgrades automatically
- No manual intervention required
- Smooth migration path

**IANA Compliance:**
- Adds official media type
- Updates to registered specification
- Internet standard compliance
- Universal recognition

**NO BS ZONE:**
- Migration is safe (proven, tested)
- Backups are automatic (not optional)
- Validation is enforced (not skipped)
- Rollback is available (not hidden)

## Success Metrics

When this skill succeeds, users should:
1. Have project.faf on format version 3.0.0+
2. Have IANA media type in metadata
3. Have backup of original file
4. Pass validation with zero errors
5. Maintain or improve AI-readiness score
6. Trust the migration process

## Quick Reference

**Migrate to latest:**
```bash
faf migrate
```

**Rollback if needed:**
```bash
cp project.faf.backup project.faf
```

**Verify migration:**
```bash
faf validate  # Should pass
faf score     # Should match or improve
```

**What gets added:**
```yaml
metadata:
  format_version: 3.0.0  # Updated
  iana_media_type: application/vnd.faf+yaml  # Added
  migrated_from: [old version]  # History
```

---

**Generated by FAF Skill: faf-migrate v1.0.0**
**Migration Edition: Zero Data Loss**
**"Safe migration. IANA compliance. Championship standards."**
