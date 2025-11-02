# Skills vs MCP vs Agent-SDK

**A Complete Guide to Claude's Extensibility Options**

---

## Executive Summary

Claude offers four distinct ways to extend its capabilities:

1. **Claude Code Skills** - Markdown instructions (this repository)
2. **Plugins** - Extensions that plug into host applications
3. **MCP (Model Context Protocol)** - Server-based tools
4. **Agent-SDK** - Autonomous agent framework

**This document explains when to use each, how they differ, why plugins exist, and FAF's strategy for each.**

---

## The Four Approaches

### 1. Claude Code Skills

**What they are:**
- Markdown files with YAML frontmatter
- Live in `~/.config/claude-code/skills/`
- Activate automatically on natural language triggers
- Contain instructions Claude interprets

**Example:**
```yaml
---
name: faf-init
description: Initialize project.faf files when user mentions "project context"
allowed-tools: Read, Write, Bash
---

# FAF Init - Project Initialization

## Purpose
Create project.faf files automatically...
```

**Characteristics:**
- **Format:** YAML frontmatter + Markdown content
- **Activation:** Natural language pattern matching
- **Complexity:** Simple (just text files)
- **Token usage:** 30-50 tokens idle, full content when active
- **Maintenance:** Edit markdown, reload
- **Distribution:** Copy files to skills directory
- **Platform:** Claude Code only

---

### 2. Plugins

**What they are:**
- Extensions that plug into host applications
- Add functionality to existing software (IDE, browser, etc.)
- Become part of the application's UI and feature set
- Installed through application-specific marketplaces

**Example:**
```json
// VS Code extension (manifest)
{
  "name": "faf-vscode",
  "displayName": "FAF Project Context",
  "description": "View and edit project.faf files in VS Code",
  "contributes": {
    "commands": [{
      "command": "faf.score",
      "title": "FAF: Show AI-Readiness Score"
    }],
    "languages": [{
      "id": "faf",
      "extensions": [".faf"]
    }]
  }
}
```

**Characteristics:**
- **Format:** Application-specific code (varies by platform)
- **Activation:** User clicks, keyboard shortcuts, UI elements
- **Complexity:** Moderate to High (depends on host API)
- **Token usage:** N/A (runs in host application, not LLM)
- **Maintenance:** Update through marketplace/store
- **Distribution:** Host-specific marketplace (VS Code, Chrome, etc.)
- **Platform:** Tied to specific host application

**Where they plugin:**
- **VS Code** - Extensions marketplace (100K+ extensions)
- **Chrome/Firefox** - Browser extensions (200K+ Chrome extensions)
- **JetBrains IDEs** - Plugin marketplace (IntelliJ, WebStorm, etc.)
- **Obsidian** - Community plugins
- **Figma** - Plugins and widgets
- **Slack** - App directory
- **Other IDEs/tools** - Application-specific extension systems

**Why they exist:**
1. **Host applications can't anticipate every need**
   - Core app stays lean
   - Community fills gaps

2. **Specialized workflows**
   - Language-specific tools
   - Industry-specific features
   - Personal productivity hacks

3. **Ecosystem growth**
   - Third-party developers extend platform
   - Network effects (more plugins = more users)
   - Monetization opportunities

4. **User choice**
   - Install only what you need
   - Customize your environment
   - Avoid bloat

**FAF Chrome Extension (Real Example):**
```
FAF Chrome Extension (LIVE in Chrome Web Store)
├── Purpose: Extract project context from web pages
├── Stack: Svelte + TypeScript + Vite
├── Status: Google-approved, published
├── Integration: Plugs into Chrome browser
└── Feature: One-click .faf generation from GitHub repos
```

**FAF Strategy for Plugins:**

**Existing:**
- ✅ **Chrome Extension** (published, Google-approved)
  - Extract context from web pages
  - One-click .faf generation
  - Works in Chrome Web Store ecosystem

**Future Possibilities:**

**1. VS Code Extension (Potential)**
```yaml
Purpose: Native .faf editing in VS Code
Features:
  - Syntax highlighting for .faf files
  - AI-readiness score in status bar
  - Quick actions (init, score, enhance)
  - Bi-sync with CLAUDE.md
  - IntelliSense for .faf schema
Distribution: VS Code Marketplace
Status: Not built (evaluate demand first)
```

**2. JetBrains Plugin (Potential)**
```yaml
Purpose: .faf support in IntelliJ, WebStorm, PyCharm
Features:
  - File type recognition
  - Quick score display
  - Integration with IDE features
Distribution: JetBrains Marketplace
Status: Not built (evaluate demand first)
```

**3. Browser Extension Expansion (Potential)**
```yaml
Current: Chrome only
Expansion: Firefox, Edge, Safari
Features: Same as Chrome (context extraction)
Status: Chrome proven, others on demand
```

**Why NOT Build All Plugins Now:**

**Reasoning:**
- **95% positioning, 5% code** applies here too
- **Chrome Extension proves concept** (already published)
- **Limited resources** - focus on core format adoption
- **Unknown demand** - wait for user requests
- **Skills > Plugins** for FAF use cases (for now)

**When to Build Plugins:**

**Triggers:**
1. **User demand** - Multiple requests for specific IDE
2. **Format adoption** - Critical mass of .faf users
3. **Competitive advantage** - Plugin solves unique problem
4. **Monetization** - Premium plugin features viable

**Current Focus:**
- ✅ Chrome Extension (done, proven)
- ✅ Skills (done, simple, token-efficient)
- ✅ MCP (done, official Anthropic steward)
- ⏳ Plugins (future, demand-driven)

**Plugins vs Skills for FAF:**

| Aspect | Plugins | Skills |
|--------|---------|--------|
| **Complexity** | High (host API integration) | Low (markdown files) |
| **Development time** | Weeks to months | Hours to days |
| **Distribution** | Marketplace approval process | Copy files |
| **Maintenance** | Updates, compatibility, reviews | Edit markdown |
| **User installation** | Click install (easy) | Copy to directory (easy) |
| **Platform lock-in** | Tied to host app | Claude Code only |
| **FAF priority** | Low (Chrome done, others on-demand) | High (active focus) |

**Decision Matrix for FAF:**

```
Need native IDE integration? → Consider Plugin
Need simple workflow guidance? → Use Skill
Need external tool access? → Use MCP
Need autonomous workflows? → Use Agent-SDK (maybe)
```

---

### 3. MCP (Model Context Protocol)

**What it is:**
- Server-based protocol for exposing tools to Claude
- Runs as background process
- Tools called explicitly by Claude
- Bridges external systems to Claude Desktop

**Example:**
```json
{
  "mcpServers": {
    "faf": {
      "command": "npx",
      "args": ["-y", "claude-faf-mcp"]
    }
  }
}
```

**Characteristics:**
- **Format:** Server process (Node.js/Python/etc.)
- **Activation:** Claude decides when to call tools
- **Complexity:** Moderate (requires server code)
- **Token usage:** Higher (tool descriptions always loaded)
- **Maintenance:** Code changes require restart
- **Distribution:** npm package or binary
- **Platform:** Claude Desktop (+ API in future)

---

### 4. Agent-SDK

**What it is:**
- Framework for building autonomous agents
- Handles tool orchestration, looping, error recovery
- Designed for complex multi-step workflows
- General-purpose (not Claude-specific)

**Example (Hypothetical):**
```typescript
import { Agent } from '@anthropic/agent-sdk';

const enhanceAgent = new Agent({
  name: "faf-enhance-autonomous",
  tools: [fafScore, fafEnhance, fafValidate],
  goal: "Improve project.faf to Gold tier (70%+)",
  maxIterations: 10
});

// Agent autonomously:
// 1. Scores current FAF
// 2. Identifies gaps
// 3. Adds missing sections
// 4. Re-scores
// 5. Repeats until Gold tier or max iterations
```

**Characteristics:**
- **Format:** TypeScript/Python framework code
- **Activation:** Programmatic (code invocation)
- **Complexity:** High (full application logic)
- **Token usage:** Variable (depends on implementation)
- **Maintenance:** Full software development lifecycle
- **Distribution:** npm package or application
- **Platform:** Any (not Claude-specific)

---

## Side-by-Side Comparison

| Aspect | Skills | Plugins | MCP | Agent-SDK |
|--------|--------|---------|-----|-----------|
| **What is it?** | Markdown instructions | IDE/browser extensions | Server-based tools | Autonomous agent framework |
| **File format** | `.md` (YAML + Markdown) | Host-specific code | Server code (JS/Python) | Application code (TS/Python) |
| **Installation** | Copy to `~/.config/claude-code/skills/` | Marketplace install | npm install + config | npm install + code |
| **Complexity** | Low (text files) | Moderate to High | Moderate (server code) | High (full framework) |
| **Coding required** | None (markdown only) | Yes (host API integration) | Yes (server implementation) | Yes (agent logic) |
| **Token usage (idle)** | 30-50 tokens | N/A (not LLM-based) | Higher (tool schemas) | N/A (not integrated) |
| **Activation** | Natural language patterns | User clicks, shortcuts | Claude decides | Programmatic |
| **Platform** | Claude Code only | Tied to host app | Claude Desktop (+ API) | Any (standalone) |
| **Use case** | Guided workflows | IDE/browser features | External tool integration | Autonomous multi-step tasks |
| **Examples** | faf-init, faf-score | Chrome ext, VS Code ext | Database access, API calls | Self-directed research |
| **Distribution** | GitHub repo (copy files) | Marketplace/store | npm package | Application framework |
| **Updates** | Edit markdown, reload | Store update | Update server, restart | Redeploy application |
| **Community** | Emerging (new in 2024) | Mature (100K+ plugins) | Active (MCP ecosystem) | Enterprise focus |

---

## When to Use Each

### Use Claude Code Skills When:

✅ **Guiding Claude through workflows**
- Example: "Initialize project context" → faf-init skill
- Pattern: User requests → Skill activates → Instructions guide Claude

✅ **Calling existing CLI tools**
- Example: Skills call `faf-cli` commands
- Pattern: Skill → Execute bash → Parse results

✅ **Token efficiency is critical**
- 30-50 tokens idle vs full tool schemas
- Only loads full content when needed

✅ **Simple, fast iteration**
- Edit markdown, reload Claude Code
- No compilation or server restarts

✅ **Terminal-based workflow**
- Claude Code is your primary interface
- Direct bash command access

**FAF Skills Use Case:**
```
User: "What's my AI-readiness score?"
→ faf-score skill activates
→ Claude runs: faf score
→ Shows: 68% (Silver tier)
```

---

### Use Plugins When:

✅ **Native IDE/browser integration needed**
- Want features in VS Code, Chrome, JetBrains, etc.
- Example: Syntax highlighting, status bar widgets

✅ **UI/UX enhancements required**
- Visual components in host application
- Example: Sidebar panels, custom buttons

✅ **Host application features**
- Leverage IDE capabilities (autocomplete, refactoring)
- Example: IntelliSense for .faf schema

✅ **One-click workflows**
- User-triggered actions (not AI-driven)
- Example: "Extract context from this GitHub page"

✅ **Cross-session persistence**
- Plugin stays installed across restarts
- Example: Always available in Chrome toolbar

**FAF Plugin Use Case:**
```
User browsing GitHub repo
→ Clicks FAF extension icon
→ Extension extracts repo metadata
→ Generates project.faf
→ Downloads file
→ No AI involved (pure browser automation)
```

---

### Use MCP When:

✅ **Integrating external systems**
- Databases, APIs, cloud services
- Example: PostgreSQL MCP, GitHub MCP

✅ **Persistent connections needed**
- Long-running processes
- Example: File watchers, webhooks

✅ **Claude Desktop is primary interface**
- GUI preference over terminal
- Multiple projects in one session

✅ **Reusable across conversations**
- Tools available in all chats
- Example: Database queries in any project

✅ **Official MCP ecosystem distribution**
- Listed in Anthropic's MCP registry
- Community discovery

**FAF MCP Use Case:**
```
User: "Check my FAF score"
→ Claude calls faf_score tool (MCP)
→ Returns: {"score": 68, "tier": "Silver"}
→ Claude formats response
```

---

### Use Agent-SDK When:

✅ **Autonomous multi-step workflows**
- Agent decides next steps
- Example: Research tasks with backtracking

✅ **Complex decision trees**
- Conditional logic based on outcomes
- Example: "Try approach A, if fails, try B, then C"

✅ **Self-directed goal achievement**
- Given goal, agent plans execution
- Example: "Improve FAF to Gold tier" (autonomous)

✅ **Enterprise automation**
- Scheduled tasks, background jobs
- Example: Nightly data processing

✅ **Tool orchestration**
- Combining multiple tools intelligently
- Example: Search → Analyze → Report → Email

**Hypothetical FAF Agent Use Case:**
```typescript
const goal = "Improve project.faf to Gold tier";
const agent = new Agent({ goal, tools: [...] });

// Agent autonomously:
// - Runs faf score (58%)
// - Identifies: Need testing + API docs
// - Adds testing docs (+6%)
// - Re-scores (64%)
// - Adds API docs (+4%)
// - Re-scores (68%)
// - Adds architecture (+2%)
// - Re-scores (70% - Gold!) ✓
```

---

## Skills + Plugins + MCP + Agent-SDK: Can They Work Together?

**Yes! They're complementary, not competitive.**

### Scenario 1: Skills Call MCP Tools

```yaml
# faf-init skill (markdown)
description: Initialize project.faf using MCP tools

# Skill activates, then:
# 1. Calls faf_init MCP tool
# 2. Formats results for user
```

**Use case:** Skills provide guidance, MCP provides tools

---

### Scenario 2: Skills Guide Agent-SDK Agents

```yaml
# faf-enhance-autonomous skill
description: Launch autonomous enhancement agent

# Skill activates, then:
# 1. Launches Agent-SDK agent
# 2. Agent runs autonomously
# 3. Skill reports final results
```

**Use case:** Skills as entry point, Agent-SDK for execution

---

### Scenario 3: Full Stack

```
User Request (Natural Language)
        ↓
Claude Code Skill (Guidance Layer)
        ↓
Agent-SDK Agent (Orchestration Layer)
        ↓
MCP Tools (Execution Layer)
        ↓
External Systems (faf-cli, databases, APIs)
```

**Use case:** Complex enterprise workflows

---

## Why FAF Chose Skills (Not MCP, Not Agent-SDK)

### Decision Context

**FAF ecosystem already has:**
- `faf-cli` - 41 commands, 173 tests
- `claude-faf-mcp` - 33 MCP tools, 730 tests
- 2+ years of development

**Question:** What's missing?

**Answer:** Easy onboarding for new users

---

### Why Skills Won

**1. Simplicity**
- ✅ No TypeScript code needed
- ✅ No server management
- ✅ No compilation step
- ✅ Just markdown files

**2. Accessibility**
- ✅ Anyone can write markdown
- ✅ Easy to customize
- ✅ Easy to share (copy files)
- ✅ Easy to understand

**3. Token Efficiency**
- ✅ 30-50 tokens idle
- ✅ Full content only when activated
- ✅ 99%+ savings vs always-loaded tools

**4. Proven Approach**
- ✅ Simon Willison: "Skills > MCP for simplicity"
- ✅ Natural language activation
- ✅ Emerging ecosystem

**5. Leverages Existing Code**
- ✅ Skills call `faf-cli` (already built)
- ✅ Skills work with `claude-faf-mcp` (already built)
- ✅ 95% positioning, 5% code

---

### Why NOT MCP (For FAF Skills)

**Already have it:**
- `claude-faf-mcp` exists
- 33 tools published
- Official Anthropic registry

**Skills complement MCP:**
- Skills = Guidance (how to use tools)
- MCP = Tools (what tools exist)

**No duplication:**
- MCP for Claude Desktop users
- Skills for Claude Code users

---

### Why NOT Plugins (For FAF Skills)

**Already have one:**
- Chrome Extension exists (published, Google-approved)
- Proven concept for browser-based context extraction

**Different use case:**
- Plugins = IDE/browser features (UI-driven)
- Skills = AI workflow guidance (language-driven)

**Demand-driven approach:**
- Chrome Extension proves viability
- Build additional plugins (VS Code, JetBrains) when users request
- Focus on format adoption first

**Resource allocation:**
- Skills: Markdown files (hours to build)
- Plugins: Full development (weeks to months)
- ROI: Skills provide better onboarding ROI

---

### Why NOT Agent-SDK (For FAF Skills)

**Overkill for FAF use cases:**
- FAF operations are mostly single-step
- `faf init` → Done
- `faf score` → Done
- `faf enhance` → Guided, not autonomous

**Definition unclear:**
- "I don't fully buy-in easily to Agents (definition is important)"
- What IS an agent? (Still being defined)
- RAG assignments? Maybe.

**Future possibility:**
- `faf-agents` repository (if RAG warrants it)
- Keep separate from Skills
- Wait for definition clarity

---

## The FAF Ecosystem Strategy

```
LAYER 1: FORMAT
├── project.faf (IANA-registered)
└── application/vnd.faf+yaml

LAYER 2: CLI TOOLING
├── faf-cli (41 commands)
└── Works standalone

LAYER 3: PLUGINS
├── Chrome Extension (published)
└── IDE plugins (on-demand)

LAYER 4: MCP INTEGRATION
├── claude-faf-mcp (33 tools)
└── For Claude Desktop

LAYER 5: SKILLS (THIS REPO)
├── 11 skills (markdown)
└── For Claude Code

LAYER 6: AGENTS (FUTURE)
├── faf-agents (maybe)
└── For RAG assignments (definition TBD)
```

**Each layer serves distinct purpose. No duplication.**

---

## Real-World Comparison

### Example Task: "Improve my project.faf to Gold tier"

**Using Skills (FAF Approach):**
```
User: "Improve my score"
→ faf-enhance skill activates
→ Claude asks questions
→ User provides answers
→ Claude runs: faf enhance
→ Score improves: 58% → 70%
→ User guided throughout
```

**Time:** 5-10 minutes (interactive)
**Control:** User in control
**Complexity:** Low (markdown skill)

---

**Using MCP (Hypothetical):**
```
User: "Improve my score"
→ Claude calls faf_score tool
→ Claude calls faf_enhance tool
→ Claude calls faf_validate tool
→ Score improves: 58% → 70%
→ Results shown to user
```

**Time:** 1-2 minutes (automated)
**Control:** Claude in control
**Complexity:** Moderate (MCP server)

---

**Using Agent-SDK (Hypothetical):**
```
User: "Improve to Gold tier"
→ Agent launches
→ Agent loops:
  - Score (58%)
  - Add testing docs (+6%)
  - Score (64%)
  - Add API docs (+4%)
  - Score (68%)
  - Add architecture (+2%)
  - Score (70% - Gold!) ✓
→ Agent terminates
→ Report generated
```

**Time:** 30 seconds (autonomous)
**Control:** Agent in control
**Complexity:** High (full framework)

---

## Decision Matrix

| Your Situation | Recommendation |
|----------------|----------------|
| **Terminal-based workflow, want guidance** | ✅ Skills |
| **Desktop app, want tools** | ✅ MCP |
| **Need external system integration** | ✅ MCP |
| **Want autonomous multi-step workflows** | ✅ Agent-SDK |
| **Building for Claude Code** | ✅ Skills |
| **Building for Claude Desktop** | ✅ MCP |
| **Building standalone application** | ✅ Agent-SDK |
| **Need native IDE/browser integration** | ✅ Plugins |
| **Want UI features in VS Code/Chrome/etc** | ✅ Plugins |
| **Token efficiency critical** | ✅ Skills |
| **Simplicity > features** | ✅ Skills |
| **Features > simplicity** | ✅ MCP or Plugins or Agent-SDK |
| **One-click browser automation** | ✅ Plugins (Chrome Extension) |

---

## Future: Will They Converge?

**Possible future state:**

```typescript
// Skill that launches Agent that uses MCP tools

// skills/autonomous-enhance/SKILL.md
---
name: autonomous-enhance
description: Autonomously improve project.faf to target tier
---

When activated:
1. Launch Agent-SDK agent
2. Agent uses MCP tools (faf_score, faf_enhance)
3. Agent loops until goal achieved
4. Report results to user
```

**This would combine all four:**
- **Skill** - Entry point (natural language)
- **Plugin** - UI integration (status bar, buttons)
- **Agent-SDK** - Orchestration (autonomous loops)
- **MCP** - Execution (tool calls)

**But for now:** Keep it simple. Skills work great.

---

## Quotes from Industry

**Simon Willison (Oct 2025):**
> "Claude Skills are potentially more impactful than MCP because of their simplicity and efficiency."

**Anthropic (MCP Launch):**
> "MCP enables Claude to connect to external data sources and tools."

**Agent-SDK Positioning:**
> "Build sophisticated agents that can autonomously achieve complex goals."

**FAF Philosophy:**
> "95% positioning, 5% code. Ship simple, iterate based on need."

---

## Conclusion

**Skills, Plugins, MCP, and Agent-SDK are NOT competing - they're complementary.**

**Choose based on your needs:**
- **Simple guidance?** → Skills
- **IDE/browser features?** → Plugins
- **External tools?** → MCP
- **Autonomous workflows?** → Agent-SDK

**FAF chose Skills (primarily) because:**
- Simplest for users
- Token efficient
- Leverages existing code (faf-cli)
- Natural language activation
- Easy to share and customize

**FAF also has:**
- **Chrome Extension** (plugin) - Proven browser integration
- **MCP Server** (official Anthropic steward) - Tool layer
- **Skills** (this repo) - Guidance layer
- **Agents** (future, maybe) - Autonomy layer (if needed)

**Future is multi-layered:**
- Plugins for UI integration
- Skills for entry points
- MCP for tool access
- Agent-SDK for autonomy (when needed)

**Start simple. Add complexity only when necessary.**

---

## Resources

**Claude Code Skills:**
- This repository: https://github.com/Wolfe-Jam/faf-skills
- Claude Code docs: https://docs.claude.com/claude-code

**MCP (Model Context Protocol):**
- Anthropic MCP: https://modelcontextprotocol.io
- FAF MCP: https://github.com/Wolfe-Jam/claude-faf-mcp
- Official Registry: https://github.com/anthropics/mcp-servers

**Agent-SDK:**
- Anthropic Agent-SDK: (Coming soon)
- General Agent frameworks: LangChain, AutoGPT, etc.

**FAF Ecosystem:**
- faf-cli: https://github.com/Wolfe-Jam/faf-cli
- Documentation: https://faf.one/docs

---

**Generated by FAF Skills v1.0.0**
**"Simple tools. Clear purpose. Championship results."**
