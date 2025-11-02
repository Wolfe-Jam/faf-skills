---
name: faf-validate
description: Validate project.faf format compliance with IANA-registered application/vnd.faf+yaml specification. Checks YAML syntax, required fields, format version, and best practices. Use when user asks "validate my FAF", "check format", "is my project.faf correct", or before publishing/sharing.
allowed-tools: Read, Bash
---

# FAF Validate - Format Compliance Verification

## Purpose

Verify that `project.faf` files comply with the IANA-registered `application/vnd.faf+yaml` specification. Catches syntax errors, missing required fields, and format violations before they cause issues.

**The Goal:** 100% format compliance. Zero errors. Championship-grade validation.

## When to Use

This skill activates automatically when the user:
- Says "Validate my project.faf"
- Says "Check my FAF format"
- Says "Is my project.faf correct?"
- Before publishing or sharing project.faf
- After manual edits to project.faf
- When scoring fails unexpectedly
- When sync produces errors
- Asks "Does this follow the spec?"

**Trigger Words:** validate, check, verify, correct, compliant, spec, format, errors

## How It Works

### Step 1: Check File Exists

```bash
ls -la project.faf
```

If missing, suggest running `faf init` (use **faf-init** skill).

### Step 2: Execute Validation

Run the existing validation command:

```bash
faf validate
```

This command (from faf-cli v3.1.1):
- Parses YAML syntax
- Checks required fields
- Verifies format version
- Validates IANA media type
- Checks field types and values
- Reports all errors and warnings

### Step 3: Parse Results

Validation output includes:

**✅ Success:**
```
✓ Valid YAML syntax
✓ Format version 3.0.0
✓ IANA media type: application/vnd.faf+yaml
✓ All required fields present
✓ No errors

project.faf is valid!
```

**❌ Errors:**
```
✗ YAML syntax error: line 15, unexpected character
✗ Missing required field: name
✗ Invalid format_version: 2.5.0 (expected 3.0.0+)
✗ Missing IANA media type in metadata

project.faf has 4 errors
```

### Step 4: Report to User

**If valid:**
- Congratulate user
- Show compliance status
- Suggest next steps (score, enhance, sync)

**If errors:**
- List all errors clearly
- Explain each error
- Provide fix guidance
- Offer to help correct

### Step 5: Fix Errors (If Needed)

Guide user through fixing each error:
- YAML syntax: Show correct syntax
- Missing fields: Provide templates
- Invalid values: Explain valid options
- Format version: Update metadata

## Validation Rules

### Required Fields

**Critical (must exist):**
```yaml
name: project-name              # Required: string
purpose: What this project does # Required: string
version: 1.0.0                  # Required: semver

metadata:
  format_version: 3.0.0         # Required: 3.0.0+
  iana_media_type: application/vnd.faf+yaml  # Required: exact string

architecture:
  type: web-app                 # Required: valid type
  language: TypeScript          # Required: string
```

**Important (recommended):**
```yaml
stack:
  runtime: Node.js 18+          # Recommended
  framework: Next.js 14         # Recommended

testing:
  framework: Jest               # Recommended
```

### Valid Architecture Types

Allowed values for `architecture.type`:
- `web-app`
- `library`
- `api`
- `cli`
- `mobile-app`
- `desktop-app`
- `service`
- `framework`
- `tool`
- `extension`

### Format Version Requirements

**Current:** 3.0.0 (as of faf-cli v3.1.1)

**History:**
- v1.x: Original format (deprecated)
- v2.x: Added metadata section (deprecated)
- v3.x: IANA registration, full specification (current)

**Migration:**
If project.faf uses old version:
```bash
# Auto-upgrade
faf migrate

# Or manually update:
metadata:
  format_version: 3.0.0  # Changed from 2.x
  iana_media_type: application/vnd.faf+yaml  # Added
```

### IANA Media Type

**Required exact string:**
```yaml
metadata:
  iana_media_type: application/vnd.faf+yaml
```

**Why it matters:**
- Official Internet standard (registered Oct 31, 2025)
- Same recognition as PDF, JSON, XML
- Browsers/email clients recognize .faf files
- Universal format authority

**Common mistakes:**
- ❌ `iana_media_type: faf`
- ❌ `iana_media_type: application/faf`
- ❌ `media_type: application/vnd.faf+yaml`
- ✅ `iana_media_type: application/vnd.faf+yaml`

### YAML Syntax Rules

**Valid YAML:**
```yaml
name: my-project
purpose: AI-powered code analysis
stack:
  runtime: Node.js 18+
  framework: Next.js 14
dependencies:
  - react: "^18.2.0"
  - typescript: "^5.3.3"
```

**Common errors:**
```yaml
# ❌ Tabs (YAML requires spaces)
name:	my-project

# ❌ Missing colon
name my-project

# ❌ Incorrect indentation
stack:
runtime: Node.js

# ❌ Missing quotes on special chars
purpose: Here's my project  # apostrophe breaks parsing

# ✅ Correct
purpose: "Here's my project"
```

## Examples

### Example 1: Successful Validation

**User:** "Validate my project.faf"

**Skill Activates:**
```bash
faf validate

# Output:
✓ Valid YAML syntax
✓ Format version 3.0.0
✓ IANA media type: application/vnd.faf+yaml
✓ All required fields present
✓ Architecture type valid: web-app
✓ No warnings

project.faf is valid!
AI-readiness: 72% (Gold tier)
```

**Report:**
"Excellent! Your project.faf is fully compliant with the IANA-registered specification (application/vnd.faf+yaml). No errors found. You're ready to share, sync, or publish this file."

### Example 2: YAML Syntax Error

**User:** "Check my FAF format"

**Skill Activates:**
```bash
faf validate

# Output:
✗ YAML syntax error on line 23:
  Unexpected character ':'

  21 | testing:
  22 |   framework: Jest
  23 |   coverage:: 78%
       ^----------- Extra colon here

project.faf has 1 error
```

**Fix guidance:**
"YAML syntax error found on line 23. You have an extra colon after 'coverage'.

**Incorrect:**
```yaml
coverage:: 78%
```

**Correct:**
```yaml
coverage: 78%
```

Remove one colon and re-validate."

### Example 3: Missing Required Fields

**User:** "Is my project.faf correct?"

**Skill Activates:**
```bash
faf validate

# Output:
✗ Missing required field: metadata.format_version
✗ Missing required field: metadata.iana_media_type
✗ Missing required field: architecture.type

project.faf has 3 errors
```

**Fix guidance:**
"Your project.faf is missing 3 required fields. Add this metadata section:

```yaml
metadata:
  format_version: 3.0.0
  iana_media_type: application/vnd.faf+yaml
  created: 2025-11-02

architecture:
  type: web-app  # Or: library, api, cli, etc.
  language: [your language]
  framework: [your framework]
```

After adding these fields, run `faf validate` again."

### Example 4: Format Version Mismatch

**User:** "Validate my FAF"

**Skill Activates:**
```bash
faf validate

# Output:
⚠ Warning: Old format version detected
  Current: 2.1.0
  Latest: 3.0.0

  Run `faf migrate` to upgrade to latest format.

✗ Missing IANA media type (required in v3.0.0+)

project.faf has 1 error, 1 warning
```

**Fix guidance:**
"Your project.faf uses format version 2.1.0 (old). The current version is 3.0.0 which includes IANA registration.

**Option 1: Auto-migrate (recommended)**
```bash
faf migrate
```
This will automatically upgrade your format to 3.0.0.

**Option 2: Manual upgrade**
Update metadata section:
```yaml
metadata:
  format_version: 3.0.0  # Changed from 2.1.0
  iana_media_type: application/vnd.faf+yaml  # Added (required in 3.0.0+)
```

After migrating, run `faf validate` to confirm."

## Validation Workflow

### Before Sharing/Publishing

```bash
# 1. Validate format
faf validate

# 2. Check AI-readiness score
faf score

# 3. Sync to CLAUDE.md
faf bi-sync

# 4. Final validation
faf validate

# 5. Ready to share!
```

### After Manual Edits

```bash
# Every time you manually edit project.faf:
faf validate

# If errors found:
# - Fix errors
# - Re-validate
# - Repeat until clean
```

### Before Git Commit

```bash
# Pre-commit hook (optional):
#!/bin/bash
if [ -f project.faf ]; then
  faf validate || exit 1
fi
```

This prevents committing invalid project.faf files.

## Verification & Troubleshooting

### Success Indicators

✅ Zero errors reported
✅ Zero warnings (or only minor warnings)
✅ Format version 3.0.0+
✅ IANA media type present
✅ All required fields exist
✅ Valid YAML syntax

### Common Issues

**Issue: "YAML syntax error" but file looks correct**

```bash
# Solution: Check for hidden characters
cat -A project.faf | head -30

# Look for:
# - Tabs (^I) instead of spaces
# - Unusual line endings
# - Non-ASCII characters

# Fix with proper editor (VS Code, Sublime, etc.)
```

**Issue: Validation says field required but it exists**

```bash
# Solution: Check indentation
# YAML is whitespace-sensitive

# ❌ Incorrect (2 spaces instead of 4)
metadata:
  format_version: 3.0.0

# ✅ Correct (consistent indentation)
metadata:
  format_version: 3.0.0
```

**Issue: "Invalid architecture type"**

```bash
# Solution: Use allowed type
# Valid: web-app, library, api, cli, mobile-app, desktop-app, service

architecture:
  type: web-app  # Not "website" or "webapp"
```

**Issue: Validation passes but score is low**

```bash
# Solution: Validation ≠ Quality
# Validation checks format compliance
# Scoring checks content completeness

# Format valid but sparse:
name: my-project
purpose: A project
architecture:
  type: web-app
  language: JavaScript

# This validates ✓ but scores low (maybe 25%)
# Use `faf enhance` to improve content
```

## Supporting Files

This skill works with:
- **faf-cli** (v3.1.1+) - Validation engine
- **project.faf** - File being validated
- **IANA specification** - application/vnd.faf+yaml

## Related Skills

Validation integrates with:
- **faf-init** - Creates valid project.faf from start
- **faf-migrate** - Upgrades old formats to current
- **faf-score** - Measures content quality (validation checks format)
- **faf-enhance** - Improves content (validation ensures correctness)

## Key Principles

**Format Compliance:**
- IANA-registered specification
- Strict YAML syntax
- Required fields enforced
- Version compatibility checked

**Clear Error Messages:**
- Line numbers shown
- Examples provided
- Fix guidance included
- Actionable feedback

**Prevention Over Correction:**
- Validate early, validate often
- Pre-commit hooks recommended
- Catch errors before they propagate
- Championship-grade quality gates

**NO BS ZONE:**
- Errors are real (not warnings disguised as errors)
- Validation is strict (not lenient)
- Compliance is measurable (not subjective)
- Standards are enforced (not suggested)

## Success Metrics

When this skill succeeds, users should:
1. Know if their project.faf is valid
2. Understand any errors found
3. Know how to fix each error
4. Trust the validation process
5. Feel confident sharing their file
6. Maintain format compliance going forward

## Quick Reference

**Validate:**
```bash
faf validate
```

**Common fixes:**
```bash
# YAML syntax error → Fix indentation/colons
# Missing field → Add required section
# Old format → faf migrate
# Invalid type → Use allowed architecture type
```

**Required minimum:**
```yaml
name: project-name
purpose: What it does
version: 1.0.0

metadata:
  format_version: 3.0.0
  iana_media_type: application/vnd.faf+yaml

architecture:
  type: web-app | library | api | cli
  language: Your language
```

---

**Generated by FAF Skill: faf-validate v1.0.0**
**IANA Compliance Edition**
**"100% format compliance. Zero errors. Championship standards."**
