# Tech Idea to Docs

Transform a raw tech product idea into production-ready documents through a structured six-session process. Four skills work together to plan, verify, build, and audit.

## What It Produces

| Session | Output | Purpose |
|---------|--------|---------|
| Session 0 | No document | Discovery — understand the idea deeply |
| Session 1 | `[product]_masterplan.md` | Complete product specification |
| Session 2 | `[product]_buildplan.md` | Claude Code implementation guide with five-gate review |
| Session 2.5 | `[product]_traceability_matrix.md` | Verification that build plan covers the masterplan |
| Session 3 | `[product]_prototype.html` | Interactive prototype of all key screens |
| Session 4 | `CLAUDE.md` | Session rules with autonomous five-gate review |

## Install

```bash
git clone https://github.com/nestflux/tech-idea-to-docs.git
cd tech-idea-to-docs
bash setup.sh
```

## Usage

Open any Claude Code session and run:

```
/tech-idea-to-docs describe your product idea here
```

Or specify a session directly:

```
/tech-idea-to-docs run session 2
```

## The Four Skills

| Skill | When | Purpose |
|-------|------|---------|
| `/tech-idea-to-docs` | Planning (Sessions 0-4) | Orchestrates the entire pipeline |
| `/traceability-matrix` | Planning (Session 2.5) | Catches gaps in the plan before code is written |
| `/masterplan-cross-reference-audit` | Build time (Gate 4) | Catches gaps in code after it's written |
| `/browser-verification` | Build time (Gate 3) | Proves the UI works with screenshots and snapshots |

## How It Works During the Build

Once the five documents exist, `CLAUDE.md` governs every build session. For each issue, the agent runs five gates:

```
Gate 1: Automated ──── build, lint, test (exit code 0)
Gate 2: Command ────── curl, CLI verification
Gate 3: Browser ────── /browser-verification (screenshot + inspect)
Gate 4: Masterplan ─── /masterplan-cross-reference-audit (spec vs code)
Gate 5: Code Review ── dispatch code-reviewer agent
```

All five gates must pass before the agent advances to the next issue. After each epic, the agent runs a smoke test and waits for approval.

## Two Coverage Checks

The system prevents "agent didn't implement something" at two stages:

```
PLANNING TIME                          BUILD TIME

Masterplan ◄── traceability-matrix     Masterplan ◄── masterplan-cross-ref-audit
    │          "Does the plan               │          "Does the code
    ▼           cover the spec?"            ▼           match the spec?"
Build Plan                             Code
```

## Uninstall

```bash
cd tech-idea-to-docs
bash uninstall.sh
```

## Works With

- [memory-stack](https://github.com/nestflux/memory-stack) — persistent session state, git context injection, behavioral learning, and pre-action gates for Claude Code

## License

MIT
