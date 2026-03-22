---
name: publish
description: Multi-platform publishing for FAF releases. Generates blog post + social/dev platform content, then distributes everywhere. Absorbs /pubblog. Covers faf.one blog, Dev.to, X, Bluesky, Reddit, HN, LinkedIn.
user_invocable: true
---

# /publish - FAF Multi-Platform Publisher

**Write once. Publish everywhere.**

Generate a blog post and distribute release announcements across all platforms in one flow.

## Usage

```
/publish                     # Interactive - pick what to publish
/publish faf-cli v4.5.0      # Publish release announcement for specific version
/publish blog-only           # Just the blog post (legacy /pubblog behavior)
```

## Platform Registry

| Platform | Method | Auth | Char Limit | Content Type |
|----------|--------|------|------------|--------------|
| **faf.one blog** | File write + git push | None | Unlimited | Full Svelte page |
| **Dev.to** | API (`curl`) | API key | Unlimited | Markdown article |
| **X/Twitter** | Web intent (`open`) | None | 280 chars | Short hook + link |
| **Bluesky** | Web intent (`open`) | None | 300 chars | Short hook + link |
| **Reddit** | Web intent (`open`) | None | 40K chars | Title + self-text |
| **HN** | Web intent (`open`) | None | Title only | Title + URL |
| **LinkedIn** | Paste-ready text | None | ~300 words | Professional post |

## The Protocol

### Step 0: Determine What to Publish

If no argument provided, use **AskUserQuestion**:

```
Question: "What are you publishing?"
Header: "Release"
Options:
  - label: "faf-cli"
    description: "FAF CLI release announcement"
  - label: "claude-faf-mcp"
    description: "MCP server release announcement"
  - label: "mcpaas"
    description: "MCPaaS Radio Protocol release"
  - label: "faf-rust-sdk"
    description: "Rust SDK release announcement"
```

Then ask which platforms:

```
Question: "Where should we publish?"
Header: "Platforms"
multiSelect: true
Options:
  - label: "Full Distribution (Recommended)"
    description: "Blog + Dev.to + X + Bluesky + Reddit + HN + LinkedIn"
  - label: "Blog + Social"
    description: "Blog + X + Bluesky + LinkedIn"
  - label: "Blog Only"
    description: "Just the faf.one blog post (same as /pubblog)"
  - label: "Social Only"
    description: "Skip blog, just social posts (blog already exists)"
```

### Step 1: Read Context

Automatically gather from the project directory:
- `CHANGELOG.md` — current version section
- `package.json` or `Cargo.toml` — name, version, description
- `project.faf` — context and metadata
- `README.md` — for feature details

Determine:
- **Feature name** (e.g., "The Desktop Edition")
- **Slug** (kebab-case: `desktop-edition`)
- **Version** (e.g., `5.0.0`)
- **Key changes** (bullet points from CHANGELOG)
- **Test count** (from project.faf or CLAUDE.md)
- **Download count** (from npm/crates.io if available)

### Step 2: Generate All Content

Generate platform-specific content in one pass. Present ALL drafts to user for review before executing anything.

#### 2a: Blog Post (faf.one)

Create Svelte file at:
```
/Users/wolfejam/FAF/faf-one-svelte-new/src/routes/blog/[slug]/+page.svelte
```

**Template:**

```svelte
<script lang="ts">
	import { onMount } from 'svelte';
	let mounted = false;
	onMount(() => { mounted = true; });
</script>

<svelte:head>
	<title>[Feature Name] Edition - [package] v[X.X.X] | FAF</title>
	<meta name="description" content="[TL;DR - 1-2 sentences]" />
	<meta property="og:title" content="[Feature Name] Edition - [package] v[X.X.X]" />
	<meta property="og:description" content="[TL;DR shortened]" />
	<meta property="og:type" content="article" />
	<meta name="twitter:card" content="summary_large_image" />
</svelte:head>

<div class="blog-post">
	<header class="post-header">
		<div class="breadcrumb">
			<a href="/">Home</a> / <a href="/blog">Blog</a> / [Feature Name] Edition
		</div>
		<h1>[Feature Name] Edition</h1>
		<p class="subtitle">[Subtitle - benefit focused]</p>
		<div class="meta">
			<time datetime="[YYYY-MM-DD]">[Month DD, YYYY]</time>
			<span class="separator">•</span>
			<span class="category [category-class]">[Category]</span>
		</div>
	</header>

	<article class="post-content">
		<section class="intro">
			<p class="lead">
				<strong>TL;DR:</strong> [1-2 sentence hook - user benefit, not technical]
			</p>
		</section>

		<section>
			<h2>What's New</h2>
			<!-- Feature content here -->
		</section>

		<section>
			<h2>Try It</h2>
			<div class="terminal-block">
				<code>[install command]</code>
			</div>
		</section>

		<section>
			<h2>The Numbers</h2>
			<ul>
				<li><strong>v[X.X.X]</strong> - Released [Date]</li>
				<li><strong>[XXX]/[XXX]</strong> - Tests passing</li>
				<li><strong>[XX]%</strong> - [Tier] score</li>
				<li><strong>[XX,XXX]+</strong> - Downloads</li>
			</ul>
		</section>

		<section class="footer-note">
			<p>Built with .faf</p>
		</section>
	</article>
</div>

<style>
	/* Copy styles from existing blog post - see context-intelligence for reference */
</style>
```

**Blog index entry** — add to TOP of `posts` array in:
`/Users/wolfejam/FAF/faf-one-svelte-new/src/routes/blog/+page.svelte`

```javascript
{
    slug: 'blog/[slug]',
    title: '[Feature Name] Edition',
    date: '[Month DD, YYYY]',
    timestamp: '[YYYY-MM-DD]',
    excerpt: '[TL;DR]',
    emoji: '[emoji]',
    category: '[Category]'
},
```

**Blog Categories (11 total — use ONLY these):**

| Category | Color (hex) | Use For |
|----------|-------------|---------|
| Release | `#00B8B8` (dark cyan) | Version releases, updates, patches |
| Launch | `#FF6B35` (orange) | New products, first releases |
| Foundation | `#1D8348` (dark green) | Architecture, format philosophy |
| Research | `#4A90E2` (blue) | Papers, academic, ArXiv |
| Milestone | `#FFD700` (gold, **black text**) | Download milestones |
| Interop | `#7D3C98` (purple) | Cross-platform, IDE integration |
| Story | `#8B5A2B` (warm brown) | Case studies, origin stories |
| Grok | `#111` (black) | xAI/Grok content |
| WJTTC | `#E74C3C` (red) | Testing certification |
| Engineering | `#4A5568` (slate) | Technical deep-dives |
| Press Release | `#666` (medium gray) | Formal announcements |

**Reference post for styles:**
`/Users/wolfejam/FAF/faf-one-svelte-new/src/routes/blog/context-intelligence/+page.svelte`

#### 2b: Dev.to Article

Generate markdown article with:

```markdown
---
title: "[Feature Name] Edition - [package] v[X.X.X]"
published: false
description: "[TL;DR - 1-2 sentences]"
tags: faf, [up to 3 more relevant tags]
canonical_url: https://faf.one/blog/[slug]
---

[Full article content in markdown - adapted from blog post]
[Remove Svelte-specific markup, keep content]
[Include install commands, feature highlights, numbers]

---

*Originally published on [faf.one/blog/[slug]](https://faf.one/blog/[slug])*
```

**Important:** Set `published: false` (draft) so user can review on Dev.to before going live.

#### 2c: X/Twitter Post (280 chars max)

Generate a tweet-sized hook. Format:

```
[Hook - what's new and why it matters] [emoji]

[install command or key stat]

[link to blog post]

#faf #[relevant hashtags]
```

**Example:**
```
faf-cli v4.5.0 — define once in .faf, generate AGENTS.md + .cursorrules + CLAUDE.md + GEMINI.md. One source of truth.

npx faf-cli@latest init

https://faf.one/blog/agents-md-edition

#faf #ai #devtools
```

**Rules:**
- Lead with the benefit, not the version number
- Include one actionable command if possible
- 2-3 hashtags max
- Always link to blog post
- Count characters — MUST be under 280

#### 2d: Bluesky Post (300 chars max)

Similar to X but slightly more room. Format:

```
[Hook - benefit focused] [emoji]

[Key stat or install command]

[link to blog post]
```

**Rules:**
- No hashtags (Bluesky doesn't use them the same way)
- 300 char limit (Unicode Grapheme Clusters)
- Link at end

#### 2e: Reddit Post

Generate for relevant subreddits. Format:

**Title:** `[Package] v[X.X.X] - [Feature Name]: [1-line benefit]`

**Self-text (markdown):**
```markdown
## What's New

[3-5 bullet points of key changes]

## Try It

```bash
[install command]
```

## The Numbers

- [test count] tests passing
- [download count]+ downloads
- [score]% AI-readiness

[Blog post link for full details](https://faf.one/blog/[slug])

---

Built with [.faf](https://faf.one) - project DNA for any AI
```

**Target subreddits** (suggest based on content):
- `r/rust` — Rust SDK releases
- `r/node` — npm releases
- `r/programming` — major releases
- `r/MachineLearning` — AI-context features
- `r/ChatGPTPro` — AI tooling

#### 2f: Hacker News

**BEFORE generating HN content, answer this gate question:**

> **"Is this worth posting to HN? Why would an HN reader care?"**

Present the assessment to the user using **AskUserQuestion**:

```
Question: "HN Gate Check — is this worth posting?"
Header: "HN"
Options:
  - label: "Yes, post it"
    description: "[1-line reason why HN would care]"
  - label: "Skip HN this time"
    description: "Save the ammo for something stronger"
```

**What HN cares about:**
- Novel technical ideas (not product launches)
- Things they can try RIGHT NOW (`npx`, live demo, playground)
- Problems they personally feel
- "How I built X" deep-dives
- Measured results with real numbers

**What HN ignores or roasts:**
- Product launches without technical depth
- Marketing language, drift tax claims, pricing pages
- "Yet another AI tool" (fatigue is real)
- Repos that depend on someone else's server without self-host option
- READMEs that read like landing pages

**Good HN angles:**
- Technical blog post explaining architecture decisions
- Benchmark results comparing approaches
- Novel protocol design (Radio Protocol IS interesting — but needs a technical write-up)
- Open-source tool that works locally with zero dependencies

**If posting, generate:**

**Title:** Clean, no emoji, no marketing speak. HN-style. Max 80 chars.

```
[Package] v[X.X.X]: [Technical description of what it does]
```
or
```
Show HN: [What it does in plain English]
```

**URL:** GitHub repo for Show HN, blog post for regular submissions. Never link faf.one for Show HN.

**Follow-up Comment 1** (post immediately after submission):
```
What's new in v[X.X.X]:
- [Change 1]
- [Change 2]
- [Change 3]

[Brief technical context about why this matters]
```

**HN title rules:**
- Max 80 characters
- Factual, not promotional
- No emoji
- Show HN links to GitHub, regular posts can link to blog

#### 2g: LinkedIn Post (paste-ready text)

Generate a **paste-ready text block** for LinkedIn. User copies and pastes directly into a new LinkedIn post — faster and more control than the URL share intent.

Format:

```
[Hook - professional, outcome-focused]

[2-3 sentences explaining what it does and why it matters]

[Key stat or achievement]

[Link to blog post or repo]

#[relevant hashtags - LinkedIn style]
```

**Example:**
```
We just shipped mcpaas on crates.io — a Rust SDK for persistent AI context.

The problem: every time you switch AI tools, you re-explain your entire stack. Claude, Gemini, Grok — each one starts from zero. mcpaas broadcasts your context once and every AI receives it via WebSocket frequencies.

46 tests passing. 3-tier championship-grade coverage. Tokio async.

https://faf.one/blog/mcpaas-crates-io

#rust #ai #developer #devtools #opensource
```

**Rules:**
- Professional tone — LinkedIn is not X
- Lead with what you shipped, not the version number
- Include a "why it matters" sentence
- 3-5 hashtags (LinkedIn uses them more than X)
- Always include the blog post link
- Keep under ~300 words (LinkedIn truncates long posts behind "see more")

**Also generate the URL share intent as fallback:**
```
https://www.linkedin.com/shareArticle?mini=true&url=[ENCODED_BLOG_URL]&title=[ENCODED_TITLE]&summary=[ENCODED_SUMMARY]
```

### Step 3: Present All Drafts for Review

Display all generated content in a clear format:

```
## Publish Plan for [package] v[X.X.X]

### 1. Blog Post (faf.one)
[Show title, TL;DR, and file path]

### 2. Dev.to Article
[Show full markdown]

### 3. X/Twitter ([X] chars)
[Show tweet text with char count]

### 4. Bluesky ([X] chars)
[Show post text with char count]

### 5. Reddit (r/[subreddit])
[Show title + first 3 lines of body]

### 6. Hacker News
[Show title + Comment 1]

### 7. LinkedIn (paste-ready)
[Show full text block to copy-paste]

---

Review above. Want to edit anything before publishing?
```

Use **AskUserQuestion** to confirm:

```
Question: "Content looks good? Ready to publish?"
Header: "Approve"
Options:
  - label: "GO! Publish all"
    description: "Execute the full distribution plan"
  - label: "Edit first"
    description: "I want to change some content before publishing"
  - label: "Blog only for now"
    description: "Just deploy the blog, I'll do social later"
```

### Step 4: Execute Publishing

Execute in this order (dependencies matter):

**Phase 1: Blog (must be first — other platforms link to it)**

1. Create blog post Svelte file
2. Add entry to blog index
3. Git add, commit, push to deploy
4. Verify blog is live (auto-deploys on push to main)

**Phase 2: API Publishing**

5. **Dev.to** (if selected and API key available):
```bash
curl -s -X POST https://dev.to/api/articles \
  -H "api-key: ${DEVTO_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{"article":{"title":"...","body_markdown":"...","published":false,"tags":["faf","..."],"canonical_url":"https://faf.one/blog/[slug]"}}'
```
If no `DEVTO_API_KEY` env var, skip and tell user how to set it up.

**Phase 3: Web Intents (open browser tabs)**

6. **X/Twitter:**
```bash
open "https://twitter.com/intent/tweet?text=[ENCODED_TEXT]"
```

7. **Bluesky:**
```bash
open "https://bsky.app/intent/compose?text=[ENCODED_TEXT]"
```

8. **Reddit:**
```bash
open "https://www.reddit.com/submit?url=[ENCODED_URL]&title=[ENCODED_TITLE]"
```

9. **Hacker News:**
```bash
open "https://news.ycombinator.com/submitlink?u=[ENCODED_URL]&t=[ENCODED_TITLE]"
```

10. **LinkedIn** (paste-ready — display the text block for user to copy):
```
Output the LinkedIn text block directly. User copies and pastes into linkedin.com/feed.
No web intent needed — paste is faster.
```
Optionally also open the URL share intent as fallback:
```bash
open "https://www.linkedin.com/shareArticle?mini=true&url=[ENCODED_URL]&title=[ENCODED_TITLE]&summary=[ENCODED_SUMMARY]"
```

**URL Encoding:** Use `python3 -c "import urllib.parse; print(urllib.parse.quote('...'))"` for encoding.

### Step 5: Post-Publish Checklist

Display completion status:

```
## Distribution Status for [package] v[X.X.X]

| Platform | Status | Link |
|----------|--------|------|
| faf.one blog | [done/pending] | https://faf.one/blog/[slug] |
| Dev.to | [done/skipped/no key] | [link if done] |
| X/Twitter | [opened in browser] | User confirms |
| Bluesky | [opened in browser] | User confirms |
| Reddit | [opened in browser] | User confirms |
| HN | [opened in browser] | User confirms |
| LinkedIn | [opened in browser] | User confirms |
```

### Step 6: Optional Extras

**Ticker Entry** (for faf.one homepage):
```
v[X.X.X]: [1-line benefit] →
```

**JustShipped Popup** (major releases only):
File: `/Users/wolfejam/FAF/faf-one-svelte-new/src/lib/components/JustShipped.svelte`

Only add for:
- Major version releases (X.0.0)
- New platform support
- Milestone achievements
- First-of-kind features

Card template:
```svelte
<div class="chrome-featured [theme]-featured">
	<div class="chrome-header">
		<div class="chrome-title">
			<h3>[emoji] [package] v[X.X.X] - [Feature Name] Edition</h3>
			<span class="chrome-badge [theme]-badge">Just Shipped</span>
		</div>
	</div>
	<p class="chrome-description">[1-2 sentence benefit]</p>
	<a href="/blog/[slug]" class="chrome-install [theme]-cta">
		Read the Blog Post →
	</a>
</div>
```

**Themes:** gemini, boris, bun, zig, rust, grok, wjttc, xai, or default (cyan)

## Credentials Setup

### Dev.to (Optional — enables API publishing)

1. Go to https://dev.to/settings/extensions
2. Under "DEV Community API Keys", generate a key
3. Set environment variable:
```bash
export DEVTO_API_KEY="your-key-here"
```
Add to `~/.zshrc` for persistence.

### All Other Platforms

No credentials needed. Web intents open the browser and the user confirms before posting.

## Tone Guidelines

- **F1-Inspired:** Championship energy, precision, speed
- **Technical but accessible:** Developers understand, non-devs get the gist
- **User-focused:** Benefits over features, outcomes over implementation
- **NO BS:** Real facts only, no inflated claims
- **Platform-native:** Match each platform's culture (HN = technical, X = punchy, Reddit = detailed)

## Platform Culture Guide

| Platform | Tone | Avoid | Works Well |
|----------|------|-------|-----------|
| **faf.one** | F1-inspired, technical | Dry corporate speak | Numbers, emoji, energy |
| **Dev.to** | Tutorial-ish, helpful | Pure marketing | Code examples, "try it" focus |
| **X** | Punchy, direct | Threads (keep to 1 tweet) | One killer stat + link |
| **Bluesky** | Conversational, dev-friendly | Corporate tone | Casual but technical |
| **Reddit** | Detailed, honest | Self-promotion vibes | Show the code, answer questions |
| **HN** | Technical, understated | Marketing speak, emoji | Factual title, context in comments |
| **LinkedIn** | Professional, outcome-focused | Too casual | Business value, team achievements |

## Notes

- Blog MUST deploy before social posts (they link to it)
- faf-one-svelte-new auto-deploys on git push to main
- Always use `canonical_url` on Dev.to pointing to faf.one (SEO)
- HN: never link faf.one for Show HN — use GitHub instead
- Reddit: pick ONE subreddit, don't cross-post spam
- X web intent: user can edit text before posting
- All web intents require user to be logged in to the platform
- Slug must be kebab-case feature name
- Date format: "Month DD, YYYY" for display, "YYYY-MM-DD" for timestamp
