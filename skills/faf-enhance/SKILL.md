---
name: faf-enhance
description: Improve project.faf AI-readiness score through guided enhancements. Identifies missing sections, suggests improvements, helps reach next Podium tier (Bronze→Silver→Gold→Trophy). Use when user asks "improve my score", "enhance my FAF", "reach Gold tier", or wants better AI context quality.
allowed-tools: Read, Write, Edit, Bash
---

# FAF Enhance - Guided AI-Readiness Improvement

## Purpose

Guide users through improving their `project.faf` file to reach higher AI-readiness scores and Podium tiers. Provides specific, actionable enhancements based on current state and target tier.

**The Goal:** Help developers systematically improve AI context quality from their current tier to Trophy (85%+) through clear, guided steps.

## When to Use

This skill activates automatically when the user:
- Says "Improve my AI-readiness score"
- Says "Enhance my project.faf"
- Says "How do I reach Gold tier?"
- Says "Make my FAF better"
- Asks "What's missing from my project.faf?"
- Just ran `faf score` and wants to improve
- Says "Optimize my AI context"
- Asks "Get to Trophy tier"

**Trigger Words:** enhance, improve, optimize, upgrade, better, reach tier, increase score, fix gaps

## How It Works

### Step 1: Check Current State

First, assess where the user is starting from:

```bash
# Check if project.faf exists
ls -la project.faf

# Get current score
faf score
```

Parse the score output to identify:
- Current percentage (e.g., 58%)
- Current tier (e.g., Silver)
- Specific gaps identified
- Next tier target (e.g., Gold at 70%)

### Step 2: Execute faf enhance (Analyze)

Run the existing enhancement command:

```bash
faf enhance
```

Note: In faf-cli v3.1.1, this might be called `faf analyze`. The command:
- Analyzes current project.faf
- Identifies missing or weak sections
- Suggests specific improvements
- Prioritizes by impact
- Provides examples

### Step 3: Prioritize Improvements

Based on current tier and target, prioritize actions:

**For Trophy tier (target 85%+):**
1. Architecture decisions documentation
2. Design patterns explanation
3. Performance considerations
4. Monitoring/observability setup
5. Security considerations
6. Edge cases and gotchas

**For Gold tier (target 70-84%):**
1. Testing strategy documentation
2. API documentation (if applicable)
3. Database schema (if applicable)
4. Deployment pipeline details
5. Environment configuration

**For Silver tier (target 55-69%):**
1. Enhanced architecture description
2. Testing framework specification
3. File structure overview
4. Build/deployment basics
5. Development setup steps

**For Bronze tier (target 40-54%):**
1. Clear project purpose
2. Architecture type specification
3. Primary dependencies list
4. Runtime requirements
5. Basic testing information

### Step 4: Guide Interactive Improvements

Work with the user interactively to add missing content:

**Method 1: Question-Driven (Recommended)**
Ask targeted questions to extract information:
- "What testing framework are you using?"
- "Can you describe your main architecture pattern?"
- "What's your deployment target?"
- "Which databases does this connect to?"

**Method 2: Template-Driven**
Provide templates for missing sections:
```yaml
testing:
  framework: [Jest/Vitest/pytest/etc.]
  approach: [unit/integration/e2e]
  coverage: [X% or X tests]

architecture:
  pattern: [MVC/microservices/serverless/etc.]
  rationale: [why this pattern]
  key_decisions:
    - [decision 1 with reasoning]
    - [decision 2 with reasoning]
```

**Method 3: Auto-Detection**
Read project files to infer missing information:
- package.json → dependencies, scripts
- tsconfig.json → TypeScript configuration
- jest.config.js → testing setup
- Dockerfile → deployment approach

### Step 5: Apply Improvements

Edit the project.faf file with new content:

```bash
# Use Edit tool to add sections
# OR guide user to edit manually
# OR use faf enhance command's interactive mode
```

### Step 6: Verify Progress

After each improvement, re-score:

```bash
faf score
```

Show progress:
- "Before: 🥈 Silver (58%)"
- "After: 🥈 Silver (64%) - 6% improvement!"
- "Next: Add API documentation to reach Gold (70%)"

### Step 7: Repeat Until Target Reached

Continue the improve → score → improve cycle until:
- User reaches target tier, OR
- User decides to stop, OR
- No more quick wins available (diminishing returns)

## Enhancement Strategies by Tier

### Reaching Bronze (40%) from Yellow/Red (<40%)

**Time Investment:** 15-30 minutes
**Focus:** Foundation

**Essential Additions:**

1. **Project Purpose** (HIGH IMPACT)
```yaml
purpose: |
  One clear sentence describing what this project does.
  Optionally a second sentence about who uses it or why it exists.
```

2. **Architecture Type** (HIGH IMPACT)
```yaml
architecture:
  type: web-app | library | api | cli | mobile-app | desktop-app | service
```

3. **Core Stack** (HIGH IMPACT)
```yaml
stack:
  language: TypeScript | Python | Rust | Go | Java | etc.
  framework: React | Next.js | Django | FastAPI | etc.
  runtime: Node.js 18+ | Python 3.11+ | etc.
```

4. **Key Dependencies** (MEDIUM IMPACT)
```yaml
dependencies:
  - react: "^18.2.0"
  - typescript: "^5.3.3"
  - vite: "^5.0.0"
```

5. **Basic Testing** (MEDIUM IMPACT)
```yaml
testing:
  framework: Jest | pytest | etc.
  status: X tests passing
```

**Result:** Bronze tier (40-54%) - Basic AI understanding

### Reaching Silver (55%) from Bronze (40-54%)

**Time Investment:** 30-60 minutes
**Focus:** Depth

**Essential Additions:**

1. **Enhanced Architecture** (HIGH IMPACT)
```yaml
architecture:
  type: web-app
  pattern: Server-side rendered React with Next.js App Router
  description: |
    Multi-page application using Next.js 14 App Router.
    TypeScript strict mode throughout.
    Tailwind CSS for styling.
    API routes for backend logic.
```

2. **Testing Strategy** (HIGH IMPACT)
```yaml
testing:
  framework: Jest + React Testing Library
  approach: |
    - Unit tests for utilities and hooks
    - Component tests for UI
    - Integration tests for API routes
  coverage: 78% overall, 90%+ for critical paths
  commands:
    test: npm test
    coverage: npm run test:coverage
```

3. **File Structure** (MEDIUM IMPACT)
```yaml
structure:
  src/: Source code
  src/app/: Next.js App Router pages
  src/components/: Reusable React components
  src/lib/: Utility functions
  src/api/: API route handlers
  public/: Static assets
```

4. **Build Information** (MEDIUM IMPACT)
```yaml
build:
  tool: Next.js (Turbopack)
  commands:
    dev: npm run dev
    build: npm run build
    start: npm start
  output: .next/ directory
```

5. **Development Setup** (LOW IMPACT)
```yaml
setup:
  prerequisites:
    - Node.js 18+
    - npm 9+
  install: npm install
  env: Copy .env.example to .env.local
  start: npm run dev
```

**Result:** Silver tier (55-69%) - Good AI understanding

### Reaching Gold (70%) from Silver (55-69%)

**Time Investment:** 1-2 hours
**Focus:** Completeness

**Essential Additions:**

1. **Architecture Decisions** (HIGH IMPACT)
```yaml
architecture_decisions:
  - decision: "Chose Next.js App Router over Pages Router"
    rationale: "Better performance, simpler data fetching, React Server Components"
  - decision: "TypeScript strict mode"
    rationale: "Catch errors at compile time, better IDE support"
  - decision: "Tailwind CSS over CSS-in-JS"
    rationale: "Faster build times, smaller bundle, better performance"
```

2. **API Documentation** (HIGH IMPACT if applicable)
```yaml
api:
  type: REST
  endpoints:
    - path: /api/users
      method: GET
      description: List all users
      auth: JWT required
    - path: /api/users/:id
      method: GET
      description: Get user by ID
```

3. **Database Schema** (HIGH IMPACT if applicable)
```yaml
database:
  type: PostgreSQL 15
  orm: Prisma
  schema:
    users: id, email, name, created_at
    posts: id, title, content, user_id, published
  migrations: prisma/migrations/
```

4. **Deployment Details** (MEDIUM IMPACT)
```yaml
deployment:
  platform: Vercel
  environment: Node.js 18
  build_command: npm run build
  output_directory: .next
  env_variables:
    - DATABASE_URL
    - JWT_SECRET
    - API_KEY
```

5. **Performance Considerations** (MEDIUM IMPACT)
```yaml
performance:
  - React Server Components for data fetching
  - Image optimization with next/image
  - Code splitting by route (automatic)
  - Caching strategy: ISR with 60s revalidation
```

**Result:** Gold tier (70-84%) - Excellent AI understanding

### Reaching Trophy (85%+) from Gold (70-84%)

**Time Investment:** 2-4 hours
**Focus:** Excellence

**Essential Additions:**

1. **Design Patterns** (HIGH IMPACT)
```yaml
design_patterns:
  - pattern: "Repository Pattern for data access"
    implementation: "lib/repositories/ directory"
    rationale: "Separates data logic from business logic"
  - pattern: "Composition over inheritance for components"
    implementation: "Compound components pattern"
    rationale: "More flexible, easier to test"
```

2. **Security Considerations** (HIGH IMPACT)
```yaml
security:
  authentication: JWT tokens (httpOnly cookies)
  authorization: Role-based access control (RBAC)
  data_validation: Zod schemas on all API inputs
  xss_prevention: React automatic escaping + DOMPurify for user HTML
  csrf_protection: SameSite cookies + token verification
  secrets_management: Environment variables (never committed)
```

3. **Monitoring & Observability** (MEDIUM IMPACT)
```yaml
monitoring:
  errors: Sentry integration
  analytics: Vercel Analytics
  performance: Web Vitals tracking
  logging: Pino logger (structured JSON)
  alerts: Slack webhooks for critical errors
```

4. **Advanced API Documentation** (MEDIUM IMPACT)
```yaml
api_advanced:
  authentication: "Bearer token in Authorization header"
  rate_limiting: "100 requests per minute per IP"
  pagination: "?page=1&limit=20 (max 100)"
  error_format:
    status: 400
    error: "validation_error"
    message: "Email is required"
    fields: {email: "Required"}
```

5. **Edge Cases & Gotchas** (MEDIUM IMPACT)
```yaml
gotchas:
  - issue: "Server components can't use useState/useEffect"
    solution: "Move to client component with 'use client'"
  - issue: "Environment variables must be prefixed NEXT_PUBLIC_ for client"
    solution: "Rename or use server-side only"
  - issue: "Dynamic routes require generateStaticParams for SSG"
    solution: "Export generateStaticParams function"
```

6. **Team Workflow** (LOW IMPACT)
```yaml
workflow:
  branching: "main (production), develop (staging), feature/*"
  commits: "Conventional Commits (feat:, fix:, docs:)"
  prs: "Require 1 approval, all tests passing"
  deployment: "Automatic on merge to main (Vercel)"
```

**Result:** Trophy tier (85-100%) - Elite AI understanding

## Interactive Enhancement Example

**User:** "Improve my AI-readiness score"

**Skill Activates:**

1. **Check current state:**
```bash
faf score
# Output: 🥈 Silver (58%)
# Gaps: Testing framework not documented, API endpoints not described
```

2. **Prioritize improvements:**
"You're at Silver (58%). To reach Gold (70%), focus on:
- Testing strategy documentation (+6%)
- API documentation (+4%)
- Architecture decisions (+2%)"

3. **Interactive questions:**

**Q:** "What testing framework are you using?"
**A:** "Jest with React Testing Library"

**Q:** "What's your testing approach?"
**A:** "Unit tests for utilities, component tests for UI"

**Q:** "What coverage do you have?"
**A:** "About 78% overall"

4. **Apply improvements:**
```yaml
testing:
  framework: Jest + React Testing Library
  approach: |
    - Unit tests for utilities and hooks (lib/ directory)
    - Component tests for UI (components/ directory)
    - Integration tests for API routes (api/ directory)
  coverage: 78% overall, 90%+ for critical paths
  commands:
    test: npm test
    coverage: npm run test:coverage
  location: __tests__/ and *.test.tsx files
```

5. **Verify progress:**
```bash
faf score
# Output: 🥈 Silver (64%) - 6% improvement!
# Next: Add API documentation to reach Gold (70%)
```

6. **Continue:**
"Great progress! You gained 6 points. Let's document your API endpoints to reach Gold tier..."

## Auto-Detection Strategies

When user doesn't know details, infer from project files:

### Detect Testing Framework

```bash
# Check package.json
grep -E "jest|vitest|mocha|ava|tape" package.json

# Check for config files
ls jest.config.js vitest.config.ts 2>/dev/null

# Check test files
ls **/*.test.ts **/*.spec.ts 2>/dev/null | head -3
```

### Detect Database

```bash
# Check dependencies
grep -E "prisma|sequelize|typeorm|mongoose|pg|mysql" package.json

# Check for schema files
ls prisma/schema.prisma schema.sql 2>/dev/null
```

### Detect Deployment Platform

```bash
# Check for platform-specific files
ls vercel.json netlify.toml railway.json render.yaml 2>/dev/null

# Check package.json scripts
grep -E "deploy|build" package.json
```

### Detect API Type

```bash
# Check for GraphQL
grep -E "graphql|apollo" package.json

# Check for REST
grep -E "express|fastify|koa|next" package.json

# Check for tRPC
grep -E "trpc" package.json
```

## Verification & Troubleshooting

### Success Indicators

✅ Score improved after enhancements
✅ Gaps identified and filled
✅ Next tier target clarified
✅ User understands improvements made
✅ Project.faf more complete

### Common Issues

**Issue: Score didn't improve after adding content**

```bash
# Solution: Validate format
faf validate

# Check for YAML errors
# Ensure sections are in correct locations
# Re-run score
faf score
```

**Issue: Don't know what to add**

```bash
# Solution: Use auto-detection
# Read package.json, config files
# Infer missing information
# Present to user for confirmation
```

**Issue: Improvement suggestions too generic**

```bash
# Solution: Be specific
# Instead of "Add testing info"
# Say "Document your Jest setup, test location, and coverage percentage"
```

## Supporting Files

This skill works with:
- **faf-cli** (v3.1.1+) - Enhancement engine
- **project.faf** - File being enhanced
- **faf score** - Progress measurement
- **faf validate** - Format verification

## Related Skills

Enhancement often triggers:
- **faf-score** - Measure improvements
- **faf-init** - Regenerate if starting over
- **faf-validate** - Ensure format correctness
- **faf-sync** - Sync improvements to CLAUDE.md

## Key Principles

**Guided, Not Automated:**
- Ask questions to understand project
- Don't guess or assume
- User provides information, skill structures it
- Interactive > batch updates

**Incremental Progress:**
- One section at a time
- Measure after each improvement
- Celebrate small wins ("+6%!")
- Clear path to next milestone

**Quality Over Quantity:**
- Better to have 5 complete sections than 20 incomplete ones
- Depth > breadth for scoring
- Specific details matter more than vague statements

**NO BS ZONE:**
- Don't add placeholder text
- Don't make up information
- Only add what user confirms
- Honest representation of project state

## Success Metrics

When this skill succeeds, users should:
1. Have improved their AI-readiness score
2. Understand what was added and why
3. Know their new Podium tier
4. Have clear next steps for further improvement
5. Feel motivated by visible progress
6. Have accurate, complete project.faf

## Enhancement Workflow Summary

```
1. faf score → Know current state (58% Silver)
2. faf enhance → Identify gaps
3. Interactive Q&A → Gather missing info
4. Edit project.faf → Add new sections
5. faf score → Measure improvement (64% Silver)
6. Repeat until target reached (70% Gold)
```

**Typical Session:**
- Start: 58% (Silver)
- +6% (testing docs) → 64% (Silver)
- +4% (API docs) → 68% (Silver)
- +2% (architecture) → 70% (Gold) ✨

**Time Investment:**
- Bronze → Silver: 30-60 min
- Silver → Gold: 1-2 hours
- Gold → Trophy: 2-4 hours

**ROI:**
Every percentage point saves ~15 seconds per AI session.
70% score = 5 sessions/day × 20 min saved = **100 min/day saved**

## References

- **faf enhance command:** https://faf.one/docs/enhance
- **Podium scoring criteria:** https://faf.one/docs/podium
- **Enhancement templates:** https://faf.one/docs/templates

---

**Generated by FAF Skill: faf-enhance v1.0.0**
**Podium Edition: Guided Improvement**
**"Incremental progress. Measurable results. Trophy-grade guidance."**
