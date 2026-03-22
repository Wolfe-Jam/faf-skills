---
name: prd-builder
description: Generate Product Requirements Documents (PRD). Use after system requirements to define user stories, features, success metrics, and product scope. Second step in Wolfejam Workflow.
---

# PRD Builder

## Purpose

Generate Product Requirements Documents that translate system requirements into user-focused product specifications. PRDs define WHO uses the product, WHAT features they need, and HOW success is measured.

## When to Use

Activate this skill when:
- System requirements are complete and need product translation
- Defining user stories and personas
- User says "prd", "product requirements", or "what features"
- Planning feature prioritization
- Defining success metrics and KPIs

## Wolfejam Workflow Position

```
Sys Reqs → [2. PRD] → Architecture → project.faf → WJTTC-TESTS.md → Code → Test → GOLD Code
              ↑
           YOU ARE HERE
```

## PRD Document Structure

### Template

```markdown
# Product Requirements Document: {Product Name}

**Version:** 1.0
**Date:** {Date}
**Product Owner:** {Owner} (via Claude)
**Status:** Draft | Review | Approved

---

## 1. Product Overview

### 1.1 Vision Statement
[One sentence describing the product's purpose and value]

### 1.2 Problem Statement
[What pain point does this solve? Why now?]

### 1.3 Target Users
[Who are the primary and secondary users?]

---

## 2. User Personas

### Persona 1: {Name}
**Role:** [Job title/role]
**Goals:** [What they want to achieve]
**Pain Points:** [Current frustrations]
**Success Criteria:** [How they measure success]

### Persona 2: {Name}
...

---

## 3. User Stories

### Epic 1: {Epic Name}

#### US-001: {User Story Title}
**As a** [persona]
**I want** [capability]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]

**Priority:** P0 | P1 | P2 | P3
**Effort:** S | M | L | XL

#### US-002: {User Story Title}
...

---

## 4. Feature Specifications

### Feature 1: {Feature Name}
**Description:** [What it does]
**User Stories:** US-001, US-002
**Dependencies:** [Other features needed first]
**Out of Scope:** [What this feature does NOT include]

### Feature 2: {Feature Name}
...

---

## 5. Success Metrics

### Primary KPIs
| Metric | Current | Target | Timeline |
|--------|---------|--------|----------|
| [Metric 1] | [Baseline] | [Goal] | [When] |
| [Metric 2] | [Baseline] | [Goal] | [When] |

### Secondary Metrics
- [Metric 3]: [Target]
- [Metric 4]: [Target]

---

## 6. Release Plan

### MVP (v1.0)
**Target:** [Date or Sprint]
**Features:** US-001, US-002, US-003
**Success Criteria:** [What defines MVP success]

### v1.1
**Target:** [Date or Sprint]
**Features:** US-004, US-005

### Future Considerations
- [Feature for later]
- [Feature for later]

---

## 7. Risks and Mitigations

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Strategy] |
| [Risk 2] | High/Med/Low | High/Med/Low | [Strategy] |

---

## 8. Open Questions

- [ ] Question requiring PM decision
- [ ] Question requiring stakeholder input

---

## Appendix

### A. Competitive Analysis
[Brief overview of alternatives]

### B. Related Documents
- System Requirements: [link]
- Architecture: [link]

---

*Generated with Wolfejam Workflow - Step 2: PRD*
```

## Priority Framework

| Priority | Meaning | Release Target |
|----------|---------|----------------|
| **P0** | Critical - MVP blocker | v1.0 (MVP) |
| **P1** | Important - Core experience | v1.0 or v1.1 |
| **P2** | Nice to have - Enhances value | v1.1+ |
| **P3** | Future - Good idea, not now | Backlog |

## Effort Estimation

| Size | Complexity | Example |
|------|------------|---------|
| **S** | Simple, well-understood | Add button, change text |
| **M** | Moderate, some unknowns | New API endpoint |
| **L** | Complex, significant work | New feature area |
| **XL** | Epic-level, needs breakdown | Major subsystem |

## Process

### Step 1: Review System Requirements
Start from the SYS-REQS.md to ensure alignment:
- Map FR requirements to user stories
- Map NFR requirements to success metrics

### Step 2: Define Personas
Create 2-3 user personas:
- Primary user (main beneficiary)
- Secondary users (supporting roles)
- Edge case users (if applicable)

### Step 3: Write User Stories
For each persona:
- Identify their key jobs-to-be-done
- Write stories in "As a... I want... So that..." format
- Define testable acceptance criteria

### Step 4: Prioritize Features
Use P0/P1/P2/P3 priority and S/M/L/XL effort:
- P0 + S/M = MVP candidates
- P0 + L/XL = Needs breakdown
- P2/P3 = Future backlog

### Step 5: Define Success Metrics
Include:
- User-focused metrics (adoption, satisfaction)
- Business metrics (revenue, efficiency)
- Technical metrics (performance, reliability)

## Output Location

Save PRD to:
```
{project}/docs/PRD.md
```

Or for FAF projects:
```
{project}/FAF/prd.faf
```

## Input/Output Flow

**Input:** System Requirements (SYS-REQS.md)
**Output:** Product Requirements Document (PRD.md)

## Next Step

After completing PRD, proceed to:
- **Architecture Builder** (`/arch-builder`) - Technical Architecture

---

*Wolfejam Workflow Step 2 of 8*
*"Know your users before you build for them."*
