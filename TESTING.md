# Testing & Quality

Every skill in this repo is **receipt-proven before it ships** — run end-to-end on a real task, not just written. Quality is gated, not assumed.

## The bar — the FAF Skill Standard

Each skill must pass four dimensions before it's listed:

- **A · Accuracy** — every CLI command + MCP tool is verified against source (no ghosts); the `.faf` schema, tier table, and claims are correct; no fabricated metrics.
- **B · Brand** — the `✪` work mark + `★ ◆ ◇ ● ○ ♡` tiers; no unearned status claims; correct paths (`~/.claude/skills/`).
- **C · Craft** — lean frontmatter (`name` / `description` / `license`), progressive disclosure, bundled files that actually ship.
- **D · Differentiation** — genuinely procedural (teaches a task, not a CLI restatement); not redundant; on-brand.

## Automated checks

- **`skills.json` drift guard** — `.github/workflows/skills-json-sync.yml` regenerates the manifest from the `SKILL.md` frontmatters on every push and **fails the build if it drifts**. The skills.faf.one listing can't go stale.
- **Manifest validation** — `claude plugin validate .` checks `.claude-plugin/plugin.json` + `marketplace.json`.

## Test a skill locally

```bash
# install one skill (or the whole plugin)
cp -r skills/<name> ~/.claude/skills/<name>
# or: /plugin marketplace add Wolfe-Jam/faf-skills  →  /plugin install faf@faf-skills
```

Restart Claude Code, then confirm the skill **activates on its trigger description, runs its procedure, and produces the result it claims.** If any step doesn't hold, it isn't ready.

## After changing any skill

```bash
node scripts/build-skills-json.mjs   # regenerate skills.json (CI enforces sync)
```

---

*Quality over quantity · proof over promises. A skill ships only when it's earned its place.*
