---
name: wjttc-builder
description: Auto-generate WJTTC (Championship-Grade) test suites for any project. This skill analyzes codebases, identifies critical test tiers (Brake/Engine/Aero), creates comprehensive test plans, and generates executable test files. Use when starting testing on a new project, creating test documentation, or building regression test suites.
---

# WJTTC Builder - Championship Test Suite Generator

**Philosophy:** "We break things so others never have to know they were broken."

This skill generates F1-inspired test suites following the WJTTC (Wolfe James Tests The Code) methodology.

## GOALS

| Goal | How |
|------|-----|
| **Pre-defined** | Test plan before code → improves code quality |
| **Inline Testing** | Tests/approves at write time → catches bugs at inception |
| **Layer 1 → Layer 2** | Industry + Expert = GOLD Code |
| **AI Optimized** | 100% bi-sync with project.faf |
| **Best Code Possible** | 🏆 Championship standard |

## GOLD Code ✨

**Code earns GOLD status when:**

```
┌────────────────────────────────────────┐
│         🏆 GOLD CODE ✨                │
│  ════════════════════════════════════  │
│  ✓ Pre-test plan defined               │
│  ✓ Inline testing at write time        │
│  ✓ Layer 1: 100% industry coverage     │
│  ✓ Layer 2: WJTTC expert edge cases    │
│  ✓ Bi-sync with project.faf            │
│  ✓ All tests passing                   │
│  ════════════════════════════════════  │
│  This code has earned its name.        │
└────────────────────────────────────────┘
```

## Position in Development Pipeline

**WJTTC comes AFTER project.faf, BEFORE coding:**

```
1. project.faf      → Define WHAT we're building (context)
2. WJTTC-TESTS.md   → Define SUCCESS CRITERIA (tests first)
3. Code             → Build to pass the tests
4. Test             → Pass/Fail
5. Repeat           → Until Championship grade
```

## Test-Driven Code (TDC)

**The WJTTC Cycle:**

```
Think → Cross-check → Confirm → Code → Test → [Repeat]
  │         │           │        │       │
  │         │           │        │       └── Pass/Fail verdict
  │         │           │        └── Write implementation
  │         │           └── Green light to proceed
  │         └── STOP if missing info - get it first
  └── Understand what we're building
```

**Cross-check Gate:** STOP if missing information. Get it before proceeding.
- Missing requirements? Ask.
- Unclear acceptance criteria? Clarify.
- Unknown edge cases? Define them.

**Red → Green → Refactor:**
1. Write failing test (RED)
2. Write code to pass (GREEN)
3. Clean up (REFACTOR)

**Never code without knowing what "done" looks like.**

## Two-Layer Testing Architecture

### Layer 1: Industry Standard (100% Coverage)
Use the framework's native testing - Jest, pytest, Vitest, etc.
- Unit tests
- Integration tests
- Standard assertions
- Coverage requirements

**This is the baseline. Non-negotiable.**

### Layer 2: WJTTC Expert (Stress + Edge Cases)
The championship layer that catches what industry tests miss:

| Category | What We Test |
|----------|--------------|
| **Syntax** | Special chars, escapes, quotes, brackets |
| **Emoji** | 🏎️ in strings, filenames, variables |
| **Typecases** | camelCase, snake_case, SCREAMING_CASE, mixed |
| **Variables** | Empty, null, undefined, MAX_INT, negative |
| **Unicode** | RTL text, combining chars, zero-width |
| **Injection** | SQL, XSS, command injection attempts |
| **Boundaries** | 0, 1, -1, MAX, MAX+1, empty array |

**Test Targets:**
- MCP servers and tools
- CLI commands and flags
- API endpoints and payloads
- Engine internals
- Infrastructure configs

## We Test the Testing

**Meta-testing checklist:**
- [ ] Do the tests actually run?
- [ ] Do they fail when code is broken?
- [ ] Do they pass when code is correct?
- [ ] Are edge cases covered?
- [ ] Can tests be run in isolation?
- [ ] Do tests clean up after themselves?

## When to Use This Skill

- AFTER defining project.faf context
- BEFORE writing any implementation code
- When starting a new feature (define tests first)
- When fixing a bug (write failing test first)
- Building regression test suites

## Test Tier System

### Tier 1: BRAKE SYSTEMS 🚨 (Critical)
**When failure = catastrophic consequences**

Identify and test:
- Security vulnerabilities (auth bypass, injection, XSS)
- Data loss or corruption risks
- Payment/financial processing
- API key/credential exposure
- Backup/restore functionality

### Tier 2: ENGINE SYSTEMS ⚡ (Core Functionality)
**When failure = poor experience or incorrect results**

Identify and test:
- Core API endpoints
- Data transformations
- Business logic accuracy
- Integration points
- Performance benchmarks

### Tier 3: AERODYNAMICS 🏁 (Polish)
**When failure = minor inconvenience**

Identify and test:
- UI/UX edge cases
- Error message formatting
- Optional features
- Documentation accuracy

## Test Suite Generation Process

### Step 1: Analyze the Project

To understand what to test:

1. Read key files (package.json, main entry points, API routes)
2. Identify the project type (web app, CLI, API, library)
3. List all public interfaces (APIs, functions, UI interactions)
4. Note external dependencies (databases, APIs, services)

### Step 2: Categorize by Tier

For each identified component, assign a tier:

```
Tier 1 (Brake): Authentication, data writes, payments, security
Tier 2 (Engine): Core features, API responses, business logic
Tier 3 (Aero): UI polish, optional features, edge cases
```

### Step 3: Generate Test Plan

Create a WJTTC-TEST-SUITE.md file with:

1. **Header** - Project name, version, date, tester
2. **Test Summary** - Objectives and pass rate targets
3. **Tier 1 Tests** - All critical tests with pass/fail tables
4. **Tier 2 Tests** - Core functionality tests
5. **Tier 3 Tests** - Polish and edge case tests
6. **Edge Cases** - Error handling, network issues
7. **Performance Targets** - Timing benchmarks
8. **Execution Log** - Checklist for running tests
9. **Championship Certification** - Pass rate to tier mapping

### Step 4: Generate Executable Tests (Optional)

If requested, generate test files:

- JavaScript: `tests/*.test.js` (Jest/Vitest)
- Python: `tests/test_*.py` (pytest)
- Bash: `tests/test_*.sh` (shell scripts)

## Output Format

### Test Suite Location
```
project/
└── tests/
    ├── WJTTC-TEST-SUITE.md    # Test plan document
    ├── test_tier1_critical.js  # Executable tests (optional)
    ├── test_tier2_core.js
    └── test_tier3_polish.js
```

### Championship Scoring

| Pass Rate | Tier | Badge |
|-----------|------|-------|
| 95-100% | Championship | 🏆 |
| 85-94% | Podium | 🥇 |
| 70-84% | Points | 🥈 |
| 55-69% | Midfield | 🥉 |
| <55% | DNF | 🔴 |

## Quick Generation Command

To generate a test suite for the current project:

1. Analyze the codebase structure
2. Identify all testable components
3. Assign tiers to each component
4. Generate WJTTC-TEST-SUITE.md
5. Optionally generate executable test files

## Example Test Table Format

```markdown
### T1.1 - [Test Name]
**Status:** ⏳ PENDING
**Priority:** CRITICAL

| Test | Expected | Actual | Status |
|------|----------|--------|--------|
| [Scenario 1] | [Expected result] | | |
| [Scenario 2] | [Expected result] | | |

**Test Command:**
\`\`\`bash
[How to run this test]
\`\`\`
```

## Integration with Existing WJTTC-Tester

This skill generates the test plan. Use the `wjttc-tester` skill to execute tests and generate reports.

---

*Championship Testing Standards 🏎️*
