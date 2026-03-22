---
name: sys-reqs-builder
description: Generate System Requirements documents. Use when starting a new project or feature to define functional and non-functional requirements before PRD, architecture, or coding begins. First step in Wolfejam Workflow.
---

# System Requirements Builder

## Purpose

Generate comprehensive System Requirements documents that define WHAT the system must do (functional) and HOW WELL it must perform (non-functional). This is the foundation for all subsequent planning documents.

## When to Use

Activate this skill when:
- Starting a new project from scratch
- Beginning a major new feature
- User says "sys reqs", "system requirements", or "what should this do"
- Before writing a PRD or architecture document
- Clarifying scope and constraints for a project

## Wolfejam Workflow Position

```
[1. SYS REQS] → PRD → Architecture → project.faf → WJTTC-TESTS.md → Code → Test → GOLD Code
     ↑
  YOU ARE HERE
```

## System Requirements Document Structure

### Template

```markdown
# System Requirements: {Project/Feature Name}

**Version:** 1.0
**Date:** {Date}
**Author:** {Author} (via Claude)

---

## 1. Overview

### 1.1 Purpose
[What problem does this solve? Why does it exist?]

### 1.2 Scope
[What's IN scope? What's OUT of scope?]

### 1.3 Definitions
[Key terms and their meanings]

---

## 2. Functional Requirements (FR)

### FR-001: {Requirement Name}
**Priority:** MUST | SHOULD | COULD | WON'T
**Description:** [What the system must do]
**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

### FR-002: {Requirement Name}
...

---

## 3. Non-Functional Requirements (NFR)

### NFR-001: Performance
**Target:** [e.g., <50ms response time, 1000 concurrent users]
**Measurement:** [How to verify]

### NFR-002: Security
**Target:** [e.g., OAuth 2.0, encrypted at rest]
**Measurement:** [How to verify]

### NFR-003: Scalability
**Target:** [e.g., horizontal scaling, 10x growth]
**Measurement:** [How to verify]

### NFR-004: Reliability
**Target:** [e.g., 99.9% uptime, graceful degradation]
**Measurement:** [How to verify]

### NFR-005: Usability
**Target:** [e.g., <3 clicks to complete task]
**Measurement:** [How to verify]

---

## 4. Constraints

### 4.1 Technical Constraints
- [e.g., Must run on Node.js 18+]
- [e.g., Must work offline]

### 4.2 Business Constraints
- [e.g., Budget: $0 (open source)]
- [e.g., Timeline: 2 weeks]

### 4.3 Regulatory Constraints
- [e.g., GDPR compliance required]

---

## 5. Assumptions

- [Assumption 1]
- [Assumption 2]

---

## 6. Dependencies

| Dependency | Type | Status |
|------------|------|--------|
| [External API] | External | Available |
| [Library X] | Internal | TBD |

---

## 7. Open Questions

- [ ] Question 1?
- [ ] Question 2?

---

*Generated with Wolfejam Workflow - Step 1: System Requirements*
```

## MoSCoW Priority Guide

| Priority | Meaning | Example |
|----------|---------|---------|
| **MUST** | Non-negotiable, system fails without it | User authentication |
| **SHOULD** | Important but not critical | Password reset flow |
| **COULD** | Nice to have if time permits | Dark mode |
| **WON'T** | Explicitly out of scope (this version) | Mobile app |

## Process

### Step 1: Gather Context
Ask about:
- What problem is being solved?
- Who are the users?
- What are the critical success factors?
- What constraints exist (time, budget, tech)?

### Step 2: Define Functional Requirements
For each feature:
- Give it a unique ID (FR-001, FR-002)
- Assign MoSCoW priority
- Write clear, testable acceptance criteria

### Step 3: Define Non-Functional Requirements
Cover the "-ilities":
- Performance (speed, throughput)
- Security (auth, encryption, access control)
- Scalability (growth handling)
- Reliability (uptime, error handling)
- Usability (ease of use, accessibility)

### Step 4: Document Constraints & Assumptions
Be explicit about:
- Technical limitations
- Business rules
- What you're assuming to be true

### Step 5: Identify Open Questions
Capture unknowns for later resolution.

## Output Location

Save system requirements to:
```
{project}/docs/SYS-REQS.md
```

Or for FAF projects:
```
{project}/FAF/sys-reqs.faf
```

## Next Step

After completing System Requirements, proceed to:
- **PRD Builder** (`/prd-builder`) - Product Requirements Document

---

*Wolfejam Workflow Step 1 of 8*
*"Define before you design, design before you code."*
