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

## Signal Integrity Audit (The Red-Means-Real Doctrine)

**Before you measure coverage, measure signal trust.**

Red CI is a contract: stop, look, fix. If red means *"shrug, runner had a noisy neighbor, just rerun,"* the signal is dead — and dead signal is worse than no signal at all. A test suite with 100% coverage but flaky reds is **less trustworthy** than one with 80% coverage and zero false alarms, because the team has stopped reading the reds.

**This is the parent doctrine. Every other testing principle serves it.**

### The Audit

For any test suite under review, classify the last 30 days of CI failures into three buckets:

| Bucket | Meaning | Action |
|--------|---------|--------|
| **Real bug** | Red corresponded to an actual code defect that was fixed by a code change | ✓ Signal worked |
| **Flake** | Red was timing/network/concurrency noise; passed on rerun with no code change | ✗ Test design defect |
| **Infra** | Red was missing secret, runner image change, dep upstream — not the code under test | ✗ Workflow design defect |

### Signal Integrity Score

```
SI = (Real bugs) / (Real bugs + Flakes + Infra) × 100
```

| SI % | Verdict | Required Action |
|------|---------|-----------------|
| 100% | TROPHY 🏆 | Maintain — exemplary signal |
| 95-99% | Championship | Annotate any flake immediately |
| 85-94% | Acceptable | Schedule flake-class fix this sprint |
| 70-84% | Eroding | Stop adding tests; fix flakes first |
| <70% | DEAD SIGNAL | Block all merges until signal restored |

**The credibility problem precedes the coverage problem.** A suite at 60% coverage with 100% SI is healthier than one at 95% coverage with 70% SI.

### Common Flake Sources to Eliminate on Sight

- **Hard absolute-time perf assertions on shared CI runners** — `expect(time).toBeLessThan(30)`. Move to non-gating workflow with `continue-on-error: true`.
- **Network-dependent tests in main suite** — mock at the boundary or route to integration tier.
- **Concurrency tests without explicit ordering** — use deterministic schedulers.
- **OS scheduler-dependent timing** — replace with statistical (P95 over N) or relative (vs same-run baseline) assertions.
- **Secret-dependent steps that fail when missing** — grey-skip, don't fail. (Cross-ref: `feedback-ci-guard-missing-secrets.md`.)

### The Inverse Rule

**Green CI that passes when something is broken is equally a contract violation.** If a real bug shipped despite green CI, that's a coverage gap that demands a regression test BEFORE the fix lands. Treat false negatives with the same urgency as false positives.

### When the Conversation Is the Real Gate

Automated CI is supporting infrastructure. **The human + AI conversational audit — noticing patterns, tracing root causes, fixing systems — is the actual quality gate.** Flaky CI wastes the conversation's bandwidth. Signal Integrity exists to keep CI worthy of the conversation it serves.

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
| 85-94% | Podium | ★ |
| 70-84% | Points | ◆ |
| 55-69% | Midfield | ◇ |
| <55% | DNF | ○ |

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
