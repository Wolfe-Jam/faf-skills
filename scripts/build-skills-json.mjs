#!/usr/bin/env node
// build-skills-json.mjs — generate skills.json from the SKILL.md frontmatters.
//
// Single source of truth = the skills/*/SKILL.md files. This emits the manifest
// the hub (skills.faf.one) fetches at runtime, so the hub's list can never drift
// from the repo. Re-run after adding/removing/renaming a skill:
//
//   node scripts/build-skills-json.mjs
//
// Output: skills.json at repo root — [{ name, category, description }, ...]

import { readdirSync, readFileSync, writeFileSync, statSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..');
const SKILLS_DIR = join(ROOT, 'skills');

// Category is not a SKILL.md frontmatter field (repo convention is lean:
// name/description/license). It's editorial grouping, kept in this ONE place.
// Unknown skills default to 'faf' with a warning — graceful, never breaks the build.
const CATEGORY = {
  'faf-context': 'faf', 'faf-wizard': 'faf', 'faf-expert': 'faf', 'faf-go': 'faf',
  'faf-teacher': 'faf', 'faf-score': 'faf', 'faf-enhance': 'faf', 'faf-sync': 'faf',
  'faf-validate': 'faf', 'faf-migrate': 'faf', 'faf-docs': 'faf', 'faf-git': 'faf',
  'faf-platforms': 'faf', 'faf-format-inspector': 'faf',
  'mcp-builder': 'mcp', 'wjttc-builder': 'mcp', 'wjttc-tester': 'mcp',
  'sys-reqs-builder': 'docs', 'prd-builder': 'docs', 'arch-builder': 'docs',
  'commit': 'dev', 'pr': 'dev', 'review': 'dev',
  'skill-creator': 'utility', 'gif-recorder': 'utility', 'repo-maintainer': 'utility',
  'n8n-builder': 'integration', 'n8n-debugger': 'integration',
};
// Render order for the hub (faf first; then the rest).
const CATEGORY_ORDER = ['faf', 'mcp', 'docs', 'dev', 'integration', 'utility'];

// Optional curated card taglines — override the mechanical first-sentence extraction
// for skills where a positioning-led card beats the trigger description. Single place
// to curate; falls back to shorten(description) when a skill isn't listed here.
// (Keeps the generator NON-DESTRUCTIVE: re-running never clobbers curated card copy.)
const TAGLINE = {
  'faf-context': '100% 🏆 AI-readiness, fast — typed, portable context you own (IANA-registered .faf)',
};

// Pull a frontmatter scalar (single-line) from the leading --- block.
function frontmatter(md, key) {
  const m = md.match(/^---\n([\s\S]*?)\n---/);
  if (!m) return null;
  const line = m[1].split('\n').find((l) => l.startsWith(key + ':'));
  if (!line) return null;
  return line.slice(key.length + 1).trim().replace(/^["']|["']$/g, '');
}

// Card descriptions want a short tagline, not the full trigger sentence.
// Prefer the whole first sentence; only truncate (on a WORD boundary, never
// mid-word) if there's no sentence break within the cap.
function shorten(desc, cap = 160) {
  if (!desc) return '';
  const dot = desc.indexOf('. ');
  const firstSentence = dot > 0 ? desc.slice(0, dot) : desc;
  if (firstSentence.length <= cap) return firstSentence;       // clean whole sentence
  let s = desc.slice(0, cap);                                  // too long: cut back to a word boundary
  const sp = s.lastIndexOf(' ');
  if (sp > 40) s = s.slice(0, sp);
  return s.trimEnd() + '…';
}

const dirs = readdirSync(SKILLS_DIR).filter((d) => {
  try { return statSync(join(SKILLS_DIR, d)).isDirectory(); } catch { return false; }
});

const skills = [];
for (const dir of dirs) {
  const path = join(SKILLS_DIR, dir, 'SKILL.md');
  let md;
  try { md = readFileSync(path, 'utf8'); } catch { console.warn(`⚠ no SKILL.md in ${dir} — skipped`); continue; }
  const name = frontmatter(md, 'name') || dir;
  const description = TAGLINE[name] || shorten(frontmatter(md, 'description'));
  let category = CATEGORY[name];
  if (!category) { console.warn(`⚠ no category mapping for "${name}" — defaulting to "faf"`); category = 'faf'; }
  skills.push({ name, category, description });
}

skills.sort((a, b) => {
  const c = CATEGORY_ORDER.indexOf(a.category) - CATEGORY_ORDER.indexOf(b.category);
  return c !== 0 ? c : a.name.localeCompare(b.name);
});

writeFileSync(join(ROOT, 'skills.json'), JSON.stringify(skills, null, 2) + '\n');
console.log(`✓ skills.json written — ${skills.length} skills, ${new Set(skills.map((s) => s.category)).size} categories`);
