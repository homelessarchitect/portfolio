# Skill Registry

**Delegator use only.** Any agent that launches sub-agents reads this registry to resolve compact rules, then injects them directly into sub-agent prompts. Sub-agents do NOT read this registry or individual SKILL.md files.

See `_shared/skill-resolver.md` for the full resolution protocol.

## User Skills

| Trigger | Skill | Path |
|---------|-------|------|
| Creating a PR, preparing changes for review | branch-pr | ~/.claude/skills/branch-pr/SKILL.md |
| Cloudflare Workers/Pages, wrangler commands, KV/R2/D1 config | cloudflare-wrangler | ~/.claude/skills/cloudflare-wrangler/SKILL.md |
| Writing cold outreach emails or first-contact messages | cold-email | ~/.claude/skills/cold-email/SKILL.md |
| Creating multi-touchpoint outreach sequences or drip campaigns | email-sequence | ~/.claude/skills/email-sequence/SKILL.md |
| Writing Go tests, Bubbletea TUI testing, table-driven tests | go-testing | ~/.claude/skills/go-testing/SKILL.md |
| Creating a GitHub issue, reporting a bug, requesting a feature | issue-creation | ~/.claude/skills/issue-creation/SKILL.md |
| "judgment day", "dual review", "juzgar", adversarial review | judgment-day | ~/.claude/skills/judgment-day/SKILL.md |
| Deploying to Railway, railway CLI commands, Railway databases | railway-deploy | ~/.claude/skills/railway-deploy/SKILL.md |
| Lead lifecycle, pipeline stages, lead scoring, marketing-to-sales | revops | ~/.claude/skills/revops/SKILL.md |
| Sales collateral: pitch decks, one-pagers, objection handling | sales-enablement | ~/.claude/skills/sales-enablement/SKILL.md |
| Creating a new skill, adding agent instructions, documenting patterns | skill-creator | ~/.claude/skills/skill-creator/SKILL.md |

## Compact Rules

Pre-digested rules per skill. Delegators copy matching blocks into sub-agent prompts as `## Project Standards (auto-resolved)`.

### branch-pr
- Every PR MUST link an issue with `status:approved` label — no exceptions
- Every PR MUST have exactly one `type:*` label
- Branch naming: `type/description` — lowercase, only `a-z0-9._-` in description
- Valid types: feat, fix, chore, docs, style, refactor, perf, test, build, ci, revert
- Run shellcheck on modified scripts before opening PR
- Blank PRs without issue linkage are blocked by CI

### cloudflare-wrangler
- Install per-project: `npm i -D wrangler@latest` — NEVER global
- Use `wrangler.jsonc` (preferred) over `.toml` for new projects
- In CI: authenticate via `CLOUDFLARE_API_TOKEN` + `CLOUDFLARE_ACCOUNT_ID` env vars — never `wrangler login`
- Never commit `.dev.vars` — add to `.gitignore`
- Bindings accessed via `env.BINDING_NAME` — case-sensitive, must match `wrangler.jsonc` exactly
- Pages projects must be created BEFORE first CI deploy

### cold-email
- Framework: Observation → Problem → Proof → Ask
- One ask per email — never multiple CTAs
- Subject lines: curiosity-gap or specificity — never generic
- Personalize the Observation with something real about the recipient
- Keep under 150 words — respect their time

### email-sequence
- One email, one job — single clear CTA per message
- Value before ask — don't pitch until trust is established
- Space early touches 2-3 days apart, longer for later touches
- Never repeat the same CTA in consecutive emails
- Each email must stand alone — assume they haven't read previous ones

### go-testing
- Table-driven tests: `tests := []struct{name, input, expected, wantErr}{}` pattern
- Use `t.Run(tt.name, ...)` for all subtests
- Bubbletea TUI testing: use `teatest` package — not manual model.Update() chains
- `t.Helper()` in assertion helpers to get correct line numbers
- Never use `time.Sleep` in tests — use channels or `Eventually` helpers

### issue-creation
- Every issue MUST use a template (bug report or feature request) — blank issues disabled
- Issues auto-get `status:needs-review` on creation
- Maintainer MUST add `status:approved` before any PR can be opened
- Questions → Discussions, not issues
- Search for duplicates before filing

### judgment-day
- Launch TWO sub-agent judges simultaneously (parallel, async) — never sequential
- Neither judge knows about the other — no cross-contamination
- Orchestrator synthesizes: Confirmed (both found it), Suspect A/B (one only), Contradiction (disagree)
- Resolve skill registry BEFORE launching judges — inject compact rules into BOTH judge prompts
- Apply fixes after synthesis — re-judge until both pass or escalate after 2 iterations
- NEVER review yourself as orchestrator — coordinate only

### railway-deploy
- CLI v3+: `railway add --database postgres`, `railway variable set KEY=value` (no plural)
- ALWAYS run `railway service` BEFORE `railway variable set` — vars are service-scoped
- Monorepo: navigate to service subdirectory → `railway service` → `railway up`
- Set Root Directory in Railway dashboard for auto-deploys on git push
- `railway up --detach` to deploy without streaming logs

### revops
- Define lifecycle stages and scoring rules BEFORE automating anything
- Lead status must always reflect actual pipeline position — no stale states
- Route leads based on score + source, not just score
- Document handoff criteria between marketing and sales explicitly

### sales-enablement
- Every asset has one job: move the buyer one step forward
- One-pagers: problem → proof → next step — under one page
- Objection handling: acknowledge before reframing — never dismiss
- Demo scripts: show outcomes first, then how it works

### skill-creator
- SKILL.md required; assets/ and references/ optional
- Frontmatter must have: name, description (with Trigger:), license, metadata.author, metadata.version
- Required sections: When to Use, Critical Patterns
- Compact rules: 5-15 lines, actionable only — no motivation, no full code blocks
- Don't create skills for trivial or self-explanatory patterns

## Project Conventions

| File | Path | Notes |
|------|------|-------|
| Global CLAUDE.md | ~/.claude/CLAUDE.md | Global AI conventions — persona, language, behavior rules |

No project-level convention files detected (CLAUDE.md, AGENTS.md, .cursorrules).
