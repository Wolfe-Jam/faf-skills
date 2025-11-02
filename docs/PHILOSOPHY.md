# FAF Architecture Philosophy

**Technical documentation for developers, contributors, and maintainers**

---

## Core Principle: Foundation First

> **".faf has no reverse. Always start at the foundation, not a level."**

The foundation is the format itself - everything else builds UP from there. You cannot skip the foundation.

---

## The Three Foundational Principles

### 1. Foundation First (No Reverse)

**The foundation is `project.faf` - an IANA-registered format.**

```
FOUNDATION (Must exist - no reverse)
└── project.faf
    └── application/vnd.faf+yaml (IANA-registered)

TOOLS (Build on foundation)
├── faf-cli (adjusts variables in foundation)
└── Validation, scoring, enhancement

INTERFACES (Access foundation)
├── Skills (natural language → foundation)
├── Plugins (visual UI → foundation)
├── MCP (programmatic → foundation)
└── Agents (autonomous → foundation)
```

**Why no reverse?**
- Like `package.json` for npm - the file must exist
- Like `.git` for version control - the data structure comes first
- Like database schema - you can't query without structure

**In practice:**
- Skills don't replace the format - they guide users to create it
- MCP doesn't bypass the format - it reads/writes it
- CLI doesn't abstract the format - it validates and enhances it

**Foundation first means:**
1. `project.faf` file exists in repo (IANA format)
2. Tools read/write this file (foundation as source of truth)
3. Interfaces make foundation accessible (CLI, MCP, Skills, Plugins)
4. No tool operates without foundation (no reverse)

---

### 2. Variables, Not Complexity

> **"Changes are really variables exposed in projects with simple tools to adjust them."**

**Users interact with variables. Complexity stays hidden.**

#### Example: AI-Readiness Score

**What user sees (variable):**
```bash
$ faf score
68% (Silver tier)
```

**What happens behind the scenes (complexity):**
```typescript
// TURBO-CAT™ format discovery (153 formats)
// IANA validation (schema compliance)
// Podium scoring algorithm (weighted calculations)
// Cross-platform compatibility checks
// Bi-sync verification (CLAUDE.md ↔ project.faf)
// Performance benchmarks (<50ms target)
```

**User never sees this. They only see: 68%**

#### Example: Improving Score

**What user sees (simple adjustment):**
```bash
$ faf enhance
? What's your main tech stack? TypeScript
? Do you have tests? Yes
? API documentation? No

✓ Added API docs section
Score: 68% → 72% (Gold tier!)
```

**What happens behind the scenes (complexity):**
```typescript
// Template selection based on stack
// Schema validation for new sections
// Dependency graph analysis
// Re-scoring with weighted algorithms
// Bi-sync updates (CLAUDE.md sync)
// Format migration if needed (v2 → v3)
// IANA compliance verification
```

**User only adjusts variables. Complexity is available but hidden.**

---

### 3. Complexity Available, Never Required

> **"Brakes stop very fast cars, and most people will never know how."**
> **"Google does 'allsorts' of things behind-the-scenes to tell you where to grab that nearest coffee."**

**The F1 Brake Analogy:**

| Layer | F1 Brakes | FAF |
|-------|-----------|-----|
| **User sees** | One pedal | `faf score` command |
| **Simple interface** | Press pedal → car slows | Run command → get score |
| **Hidden complexity** | Carbon ceramic discs, hydraulic systems, thermal management, ABS | TURBO-CAT™, IANA validation, Podium algorithms, format discovery |
| **Expert access** | Engineers tune brake balance, pressure curves | Developers can access raw format, extend validators, build custom tools |
| **Result** | Driver focuses on racing, not brake engineering | User focuses on project, not AI-readiness algorithms |

**The Google Coffee Analogy:**

| Layer | Google Search | FAF |
|-------|---------------|-----|
| **User sees** | Search box | `faf init` command |
| **Simple query** | "coffee near me" | "Initialize project context" |
| **Hidden complexity** | ML ranking, location services, crawlers, knowledge graph, business APIs | Format templates, stack detection, dependency analysis, IANA schema, bi-sync |
| **Result** | Map to nearest coffee shop | Initialized project.faf file |

**Complexity is available to those who need it:**
- **Format spec** - Read IANA registration, extend for custom needs
- **CLI source code** - Contribute validators, add commands
- **MCP tools** - Build custom integrations
- **Testing frameworks** - WJTTC protocols for championship-grade validation

**But never required:**
- Casual users run `faf init` and get a working file
- Power users run `faf enhance` and improve their score
- No one needs to understand Podium algorithms to benefit

---

## Architectural Decisions Explained

### Why Skills Over Always-On MCP Tools?

**Decision:** Build markdown Skills instead of loading all MCP tools constantly

**Foundation-first reasoning:**
- Foundation (`project.faf`) is static until user acts
- Skills activate on-demand (natural language trigger)
- MCP tools load constantly (token cost whether used or not)

**Variables exposed:**
- Skill: "What's my AI-readiness score?" → Activates faf-score skill
- Result: 68% shown to user
- Behind: Skill calls `faf score`, parses output, formats response

**Complexity available:**
- Power users can call `faf score --json` directly
- Developers can extend scoring algorithms
- But casual users just ask in natural language

**Token efficiency (variable we optimize):**
- Skills: 30-50 tokens idle, full content when activated
- MCP: All tool schemas loaded always (higher cost)
- Result: 99%+ token savings for idle state

### Why Multiple Interfaces to Same Foundation?

**Decision:** CLI, MCP, Skills, Plugins all touch `project.faf`

**Foundation-first reasoning:**
- Foundation is single source of truth
- Interfaces are access patterns, not data stores
- No interface "owns" the data

**In practice:**
```
project.faf (foundation - one file)
    ↑
    ├── faf-cli (bash interface)
    ├── MCP server (Claude Desktop interface)
    ├── Skills (natural language interface)
    └── Chrome Extension (visual extraction interface)

All read/write same file. No duplication. No sync issues.
```

**Why this works:**
- Foundation has no reverse (file must exist first)
- Tools adjust variables (score, completeness, validation status)
- Complexity hidden (users don't see IANA schemas, just their project info)

### Why Demand-Driven Plugin Development?

**Decision:** Chrome Extension built, VS Code/JetBrains on-demand

**Variables exposed:**
- Chrome Extension: Click button → Extract context → Download project.faf
- VS Code (future): Status bar shows score → Click to enhance

**Complexity available:**
- Chrome Extension uses content scripts, DOM parsing, metadata extraction
- VS Code would use Language Server Protocol, TreeSitter, workspace APIs
- Users just see: Click button → Get result

**Why demand-driven:**
- Chrome Extension proves concept (foundation can be extracted from web)
- Additional plugins require weeks of development (complexity to build)
- Users can already access foundation through CLI/MCP/Skills
- Build plugins when user demand justifies engineering time

**Foundation-first:** Plugins extract TO foundation, not replace it

---

## Case Study: The "faf enhance" Flow

**This demonstrates all three principles in one command.**

### User Experience (Variables)
```bash
$ faf enhance
? What's your main tech stack? TypeScript
? Do you have tests? Yes
? API documentation? No

✓ Added API docs section
Score: 68% → 72% (Gold tier!)
```

### Behind the Scenes (Complexity)

**Foundation First:**
1. Check `project.faf` exists (no reverse)
2. Read current foundation state
3. Validate IANA format compliance

**Variables Exposed:**
- Current score: 68%
- Missing sections: API docs
- Target tier: Gold (70%+)

**Complexity Available:**
```typescript
// Template Selection Engine
const template = selectTemplate({
  stack: 'TypeScript',
  hasTests: true,
  currentScore: 68,
  targetScore: 70
});

// TURBO-CAT™ Format Discovery
const existingFormats = discoverFormats(projectRoot);
// Found: package.json, tsconfig.json, jest.config.js

// Schema Validation
const isValid = validateIANA(currentFAF);
// Validates against application/vnd.faf+yaml

// Weighted Scoring Algorithm
const newScore = calculatePodiumScore({
  architecture: 8,
  dependencies: 7,
  testing: 9,
  documentation: 6, // Was 4, added API docs
  // ... 20 more weighted factors
});

// Bi-Sync (Context-Mirroring)
await syncCLAUDEmd(projectFAF);
// 8ms sync time, zero conflicts

// Format Migration (if needed)
if (isOldVersion(currentFAF)) {
  await migrate('2.x', '3.0.0');
}
```

**User sees none of this. They see:**
- Question prompts (variables to adjust)
- Progress indicator
- New score (result)

---

## Design Patterns

### Pattern 1: Foundation as Source of Truth

**Good:**
```typescript
// Read from foundation
const faf = readProjectFAF();
const score = calculateScore(faf);
return score;
```

**Bad:**
```typescript
// Store score separately from foundation
const scoreDB = new Database();
scoreDB.set('project-123', 68);
// Now foundation and DB can drift
```

**Why:** Foundation first. Derived values (like score) are calculated from foundation, not stored separately.

### Pattern 2: Expose Variables, Hide Algorithms

**Good:**
```typescript
// User adjusts simple variable
await enhance({
  addSection: 'api-documentation'
});
// Complexity hidden in enhance() function
```

**Bad:**
```typescript
// User must understand algorithm
await updateScore({
  weights: { docs: 0.15, tests: 0.20 },
  normalization: 'z-score',
  threshold: 70
});
// Exposed complexity, required knowledge
```

**Why:** Variables not complexity. Users adjust what they want, not how it's calculated.

### Pattern 3: Complexity Available Through Layers

**Good:**
```typescript
// Layer 1: Simple (most users)
faf.init();

// Layer 2: Configured (power users)
faf.init({ stack: 'typescript', tier: 'gold' });

// Layer 3: Advanced (developers)
faf.init({
  template: customTemplate,
  validators: [customValidator],
  scoring: customAlgorithm
});
```

**Bad:**
```typescript
// Only one way - forces complexity on all users
faf.init({
  template: required,
  validators: required,
  scoring: required
});
```

**Why:** Complexity available (Layer 3 exists) but never required (Layer 1 is default).

---

## Philosophy in Practice: Skills Architecture

**Skills embody all three principles.**

### Foundation First
- Skills don't replace `project.faf` - they guide users to create/modify it
- Skill activates → Calls `faf-cli` → Modifies foundation
- No skill operates without foundation existing

### Variables Exposed
```yaml
# skills/faf-score/SKILL.md
When user asks: "What's my AI-readiness score?"

SHOW USER:
- Current score: 68%
- Current tier: Silver
- Next tier: Gold (70%+)

HIDE FROM USER:
- TURBO-CAT™ format discovery
- Podium scoring algorithms
- IANA validation checks
- Weighted factor calculations
```

### Complexity Available
- Users: Natural language ("What's my score?")
- Power users: Direct CLI (`faf score --json --verbose`)
- Developers: Extend scoring algorithm in faf-cli source

**Skills are the simplest interface to the foundation.**

---

## Anti-Patterns (What NOT to Do)

### Anti-Pattern 1: Level Before Foundation
```typescript
// WRONG: Tool doesn't verify foundation exists
async function getScore() {
  // Assumes project.faf exists
  const score = await calculateFromCache();
  return score;
}

// RIGHT: Foundation first
async function getScore() {
  if (!projectFAFExists()) {
    throw new Error('Foundation missing. Run: faf init');
  }
  const faf = readProjectFAF();
  return calculateScore(faf);
}
```

**Why wrong:** Violates "no reverse" - trying to score without foundation

### Anti-Pattern 2: Expose Complexity to Users
```typescript
// WRONG: User must understand internals
console.log('Calculating z-score normalized Podium algorithm...');
console.log('TURBO-CAT™ discovered 153 formats');
console.log('Applying weighted factors: docs=0.15, tests=0.20...');

// RIGHT: Show variable, hide complexity
console.log('Score: 68%');
```

**Why wrong:** Violates "variables not complexity" - user sees algorithm details

### Anti-Pattern 3: Require Complexity
```typescript
// WRONG: User must provide algorithmic details
faf.enhance({
  scoringWeights: { docs: 0.15, tests: 0.20 },
  validationRules: [rule1, rule2],
  migrationStrategy: 'conservative'
});

// RIGHT: Simple default, complexity optional
faf.enhance(); // Uses smart defaults
faf.enhance({ target: 'gold' }); // Optional simple variable
```

**Why wrong:** Violates "complexity available, never required"

---

## Quotes (Foundational Principles)

> **"Always start at the foundation, not a level."**
> `.faf` has no reverse. The format comes first.

> **"Changes are really variables exposed in projects with simple tools to adjust them."**
> Users adjust what they want (score, completeness). Complexity calculates how.

> **"Brakes stop very fast cars, and most people will never know how."**
> Users press one pedal. Engineers tune carbon ceramic systems behind the scenes.

> **"Google does 'allsorts' of things behind-the-scenes to tell you where to grab that nearest coffee."**
> Users see simple results. Complexity makes simplicity possible.

---

## For Contributors

**When building on FAF, ask:**

1. **Foundation First:** Does this require `project.faf` to exist?
2. **Variables:** What simple variable am I exposing to users?
3. **Complexity:** What complexity am I hiding behind that variable?

**Good contribution:**
- Adds new skill that guides users to adjust foundation
- Exposes simple variable (e.g., "project category")
- Hides complexity (format detection, validation, schema checks)

**Questionable contribution:**
- Bypasses foundation (stores data elsewhere)
- Exposes algorithm details to users
- Requires users to understand internals

**When in doubt:** Follow the brake pedal model. One simple action, complex system behind it.

---

## Summary

**Three principles:**
1. **Foundation First** - `project.faf` has no reverse, always start there
2. **Variables Not Complexity** - Expose adjustments, hide algorithms
3. **Complexity Available** - Never required, always accessible

**In practice:**
- Skills guide users to create foundation (`faf init`)
- Tools let users adjust variables (`faf score`, `faf enhance`)
- Complexity works behind scenes (TURBO-CAT™, Podium algorithms, IANA validation)
- Power users can access complexity if needed (CLI flags, source code, extensions)

**Result:**
- Simple for most (press brake pedal)
- Powerful for some (tune brake system)
- Foundation for all (`project.faf` as source of truth)

---

**This is the FAF way. Foundation first. Variables exposed. Complexity hidden.**
