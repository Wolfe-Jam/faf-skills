# FAF Skills

**A Skill a Day — one genuinely-tested skill, daily this week.**

Quality over quantity, and proof over promises. Every skill ships only after it's **run end-to-end and receipt-proven** — not just written. `faf-context` is the reference standard the rest conform to. Built on the FAF ecosystem (`application/vnd.faf+yaml` — IANA-registered).

---

## Live now

### faf-context — `/faf-context`
The builder's quickstart **and the reference standard**: hand the AI the underivable context (a sharp goal + the 6 Ws) and reach **100% ✪ AI-readiness**, fast.

> **Receipt:** a real project taken from `29%` → **`100% ✪` (19/19 slots)** by following exactly the model this skill teaches — `faf auto` to detect + seed, fill the gaps the AI can't source, `slotignored` what doesn't apply, re-score to Trophy. Deterministic and falsifiable. *(FAF don't lie.)*

```bash
# Plugin marketplace
/plugin marketplace add Wolfe-Jam/faf-skills
/plugin install faf@faf-skills

# Or manual
git clone https://github.com/Wolfe-Jam/faf-skills.git && cp -r faf-skills/skills/* ~/.claude/skills/
```

---

## Dropping this week — one a day, each receipt-proven before it lands

| Skill | What it'll do | Ships when… |
|-------|---------------|-------------|
| **faf-expert** | The mechanic's manual — scoring internals, MCP config, the full 21-slot model | …it's proven genuinely expert |
| **faf-wizard** | Done-for-you `.faf` generator | …it's proven the fastest path to 100% |
| **faf-go** | Guided AskUserQuestion interview to 100% | …a live run hits a verified Trophy |
| **wjttc-builder** · **wjttc-tester** | Generate + run championship-grade test suites (F1 tiers + Signal Integrity) | …a real plan→test→TAF receipt |
| **mcp-builder** | Build high-quality MCP servers (with FAF's Core-tier discipline) | …a server scaffolds clean |
| **skill-creator** | Author Claude Code skills to the FAF Skill Standard | …a full create→validate→package run |
| **repo-maintainer** | Multi-phase repository health audit | …a live repo audit runs |

Each is held to the **FAF Skill Standard** (accurate · on-brand · genuinely procedural) and gated before it goes live. The hub grows daily; every entry is earned.

---

## Tier System

| Score | Tier | Symbol |
|-------|------|--------|
| 100% | Trophy | ✪ |
| 99% | Gold | ★ |
| 95% | Silver | ◆ |
| 85% | Bronze | ◇ |
| 70% | Green | ● |
| 55% | Yellow | ● |
| 1% | Red | ○ |
| 0% | White | ♡ |

> **✪ = 🏆 = 100%** — the same Trophy, two surfaces: **✪** is the FAF-at-Work mark (code · skills · CLI · this hub); **🏆** is the social mark (X · blogs).

---

## Prerequisites

```bash
npm install -g faf-cli           # required
npm install -g claude-faf-mcp    # optional: MCP server
```

> `skills.json` is **generated** from the SKILL.md frontmatters and verified in CI — never edit it by hand (`node scripts/build-skills-json.mjs`).

---

## Resources

- **Website:** https://faf.one · **Skills hub:** https://skills.faf.one
- **faf-cli:** https://github.com/Wolfe-Jam/faf-cli · **npm:** https://npmjs.com/package/faf-cli
- **claude-faf-mcp:** https://github.com/Wolfe-Jam/claude-faf-mcp
- **IANA:** `application/vnd.faf+yaml`

---

If `faf-skills` has been useful, consider starring the repo — it helps others find it.

## License

MIT License

---

*By [@Wolfe-Jam](https://github.com/Wolfe-Jam) · curated, not collected · proof over promises.*
