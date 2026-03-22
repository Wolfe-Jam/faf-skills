---
name: arch-builder
description: Generate Technical Architecture documents. Use after PRD to define system components, data flow, technology choices, and integration patterns. Third step in Wolfejam Workflow. Outputs inform project.faf creation.
---

# Architecture Builder

## Purpose

Generate Technical Architecture documents that translate product requirements into system design. Architecture docs define the COMPONENTS, CONNECTIONS, and CONSTRAINTS that shape how the system is built.

## When to Use

Activate this skill when:
- PRD is complete and needs technical translation
- Designing system components and data flow
- User says "architecture", "system design", or "how should this be built"
- Making technology stack decisions
- Defining API contracts and integration patterns

## Wolfejam Workflow Position

```
Sys Reqs → PRD → [3. ARCHITECTURE] → project.faf → WJTTC-TESTS.md → Code → Test → GOLD Code
                       ↑
                    YOU ARE HERE
```

## Architecture Document Structure

### Template

```markdown
# Technical Architecture: {Project Name}

**Version:** 1.0
**Date:** {Date}
**Architect:** {Name} (via Claude)
**Status:** Draft | Review | Approved

---

## 1. Architecture Overview

### 1.1 System Context
[High-level view: what the system is and how it fits in the larger ecosystem]

### 1.2 Architecture Style
[e.g., Monolith, Microservices, Serverless, Event-Driven, Hybrid]

### 1.3 Key Design Decisions
| Decision | Choice | Rationale |
|----------|--------|-----------|
| [Decision 1] | [Choice] | [Why] |
| [Decision 2] | [Choice] | [Why] |

---

## 2. System Components

### 2.1 Component Diagram

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────▶│    API      │────▶│  Database   │
│  (Browser)  │     │  (Server)   │     │  (Storage)  │
└─────────────┘     └─────────────┘     └─────────────┘
```

### 2.2 Component Specifications

#### Component: {Name}
**Responsibility:** [What it does]
**Technology:** [Stack/framework]
**Interfaces:** [APIs it exposes/consumes]
**Dependencies:** [Other components it relies on]

#### Component: {Name}
...

---

## 3. Data Architecture

### 3.1 Data Model

```
┌──────────────┐       ┌──────────────┐
│    User      │       │    Item      │
├──────────────┤       ├──────────────┤
│ id           │───┐   │ id           │
│ email        │   │   │ name         │
│ created_at   │   └──▶│ user_id (FK) │
└──────────────┘       └──────────────┘
```

### 3.2 Data Flow
[How data moves through the system]

### 3.3 Data Storage
| Data Type | Storage | Reasoning |
|-----------|---------|-----------|
| [Type 1] | [Store] | [Why] |
| [Type 2] | [Store] | [Why] |

---

## 4. API Design

### 4.1 API Style
[REST | GraphQL | gRPC | WebSocket | Hybrid]

### 4.2 Key Endpoints

#### POST /api/{resource}
**Purpose:** [What it does]
**Request:**
```json
{
  "field": "value"
}
```
**Response:**
```json
{
  "id": "123",
  "status": "created"
}
```

#### GET /api/{resource}/{id}
...

---

## 5. Technology Stack

### 5.1 Stack Summary

| Layer | Technology | Version | Rationale |
|-------|------------|---------|-----------|
| Frontend | [Tech] | [Ver] | [Why] |
| Backend | [Tech] | [Ver] | [Why] |
| Database | [Tech] | [Ver] | [Why] |
| Hosting | [Tech] | [Ver] | [Why] |
| CI/CD | [Tech] | [Ver] | [Why] |

### 5.2 Dependencies
```json
{
  "dependencies": {
    "package": "version"
  }
}
```

---

## 6. Security Architecture

### 6.1 Authentication
[How users prove identity: OAuth, JWT, Sessions, etc.]

### 6.2 Authorization
[How access is controlled: RBAC, ABAC, Scopes]

### 6.3 Data Protection
- At rest: [Encryption method]
- In transit: [TLS, etc.]
- Secrets: [Management approach]

---

## 7. Infrastructure

### 7.1 Deployment Architecture

```
┌─────────────────────────────────────┐
│           Cloud Provider            │
├─────────────┬─────────────┬─────────┤
│   CDN       │   Compute   │   DB    │
│ (Static)    │  (Server)   │ (Data)  │
└─────────────┴─────────────┴─────────┘
```

### 7.2 Environments
| Environment | Purpose | URL |
|-------------|---------|-----|
| Development | Local testing | localhost |
| Staging | Pre-production | staging.example.com |
| Production | Live users | example.com |

### 7.3 Scaling Strategy
[Horizontal | Vertical | Auto-scaling rules]

---

## 8. Integration Points

### 8.1 External Services
| Service | Purpose | Protocol | Auth |
|---------|---------|----------|------|
| [Service 1] | [Use] | [API type] | [Auth method] |
| [Service 2] | [Use] | [API type] | [Auth method] |

### 8.2 Internal Integrations
[How components communicate internally]

---

## 9. Non-Functional Requirements Mapping

| NFR | Architectural Solution |
|-----|------------------------|
| Performance (<50ms) | [How achieved] |
| Security (OAuth) | [How achieved] |
| Scalability (10x) | [How achieved] |
| Reliability (99.9%) | [How achieved] |

---

## 10. Technical Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | [Impact] | [Strategy] |
| [Risk 2] | [Impact] | [Strategy] |

---

## 11. Architecture Decision Records (ADRs)

### ADR-001: {Decision Title}
**Status:** Accepted | Proposed | Deprecated
**Context:** [Why this decision was needed]
**Decision:** [What was decided]
**Consequences:** [Positive and negative effects]

---

## Appendix

### A. Sequence Diagrams
[Key user flows]

### B. Related Documents
- System Requirements: [link]
- PRD: [link]

---

*Generated with Wolfejam Workflow - Step 3: Architecture*
```

## Architecture Patterns Quick Reference

### Monolith
**When:** Small team, simple domain, rapid iteration needed
**Pros:** Simple deployment, easy debugging, single codebase
**Cons:** Scaling entire app, deployment risk, team coupling

### Microservices
**When:** Large team, complex domain, independent scaling needed
**Pros:** Independent deployment, tech flexibility, fault isolation
**Cons:** Operational complexity, network latency, data consistency

### Serverless
**When:** Variable load, event-driven, cost optimization priority
**Pros:** No server management, pay-per-use, auto-scaling
**Cons:** Cold starts, vendor lock-in, execution limits

### Event-Driven
**When:** Loose coupling, async processing, audit trails needed
**Pros:** Decoupling, scalability, temporal flexibility
**Cons:** Debugging complexity, eventual consistency, event ordering

## Process

### Step 1: Understand Requirements
Review PRD and System Requirements:
- Map user stories to components
- Map NFRs to architectural decisions

### Step 2: Choose Architecture Style
Select based on:
- Team size and skills
- Scaling requirements
- Deployment constraints
- Budget and timeline

### Step 3: Design Components
For each major capability:
- Define component boundaries
- Identify interfaces
- Document dependencies

### Step 4: Define Data Architecture
Design:
- Data models (entities, relationships)
- Storage choices (SQL, NoSQL, cache)
- Data flow (sync, async, streaming)

### Step 5: Document Decisions
Create ADRs for significant choices:
- Why the decision was made
- What alternatives were considered
- What trade-offs were accepted

## Output Location

Save architecture document to:
```
{project}/docs/ARCHITECTURE.md
```

Or for FAF projects:
```
{project}/FAF/architecture.faf
```

## Input/Output Flow

**Input:** PRD (PRD.md) + System Requirements (SYS-REQS.md)
**Output:** Technical Architecture (ARCHITECTURE.md)

## Next Step

After completing Architecture, proceed to:
- **project.faf creation** - Encode DNA into FAF format
- **WJTTC-TESTS.md** - Pre-define test scenarios

---

*Wolfejam Workflow Step 3 of 8*
*"Architecture is the skeleton; code is the muscle."*
