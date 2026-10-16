---
name: tech-idea-to-docs
description: Transforms a raw tech product idea into production-ready documents through a structured multi-session process — masterplan, build plan, traceability matrix, HTML prototype, and CLAUDE.md. Use when someone has a software product idea and wants to go from concept to implementation-ready documentation, OR when they want to resume/continue an in-progress docs process (says "resume", "continue the docs", or names a session).
argument-hint: describe your product idea, say "resume", or specify a session number
---

# Tech Idea to Docs

This skill transforms a raw tech product idea into five production-ready documents through a structured six-session process. Each session builds on the previous one. Do not compress sessions or skip ahead.

User's input: $ARGUMENTS

## The Six Sessions

| Session | Output | Purpose |
|---------|--------|---------|
| Session 0 | `[product]_discovery.md` | Discovery: understand the idea deeply before speccing anything |
| Session 1 | `[product]_masterplan.md` | Complete product specification |
| Session 2 | `[product]_buildplan.md` | Claude Code implementation guide |
| Session 2.5 | `[product]_traceability_matrix.md` | Verification that build plan fully covers masterplan |
| Session 3 | `[product]_prototype.html` | Interactive prototype of all key screens |
| Session 4 | `CLAUDE.md` | Claude Code session rules file with five-gate autonomous review |

**The golden rule:** Each session ends with a complete, high-quality document. The next session opens that document and builds on it. Never start a session without reading the output of the previous one.

**The reference rule:** Each session below has a full guide in `references/`. Do NOT begin a session without reading its reference file in full — it contains required structures, templates, and quality criteria that are NOT repeated here. The summaries below are deliberately too thin to run a session from.

## How to Begin (entry and resume logic)

1. Look in the working directory for `*_docs_status.md` and the output documents above.
2. **Status file found** → read it plus the most recent output document, announce the resume point ("Masterplan complete — resuming at Session 2"), and continue from there. Never ask the user which session they're on.
3. **Status file shows all sessions complete** → don't run a session. Report that the docs phase is done and the build phase is governed by the generated CLAUDE.md.
4. **No status file, no documents** → this is a new idea. Start Session 0.
5. **User names a session explicitly** → honor it, but read its required inputs first, and warn if the status file disagrees with their stated position.

## Status File Protocol

`[product]_docs_status.md` is the persistent memory of this process. Create it at the end of Session 0; overwrite it at the end of every session. This replaces any spoken handoff — if it isn't in the file, it didn't happen. Format:

```markdown
# Docs Status — [Product Name]
**File prefix:** [product]
**Sessions completed:** [e.g. 0, 1]
**Next session:** [e.g. 2]
**Mode:** [checkpoint-each | straight-through | not yet chosen]
**Key decisions:** [bullets — decisions that shape later sessions]
**Open questions:** [bullets — things to resolve, or "none"]
**Handoff note:** [1 paragraph — what the next session needs to know]
```

## Auto-Advance Policy

- **Sessions 0 and 1 always end with a human checkpoint.** They are collaborative by design — a wrong assumption there compounds through all five documents. Never auto-advance past them.
- **At the end of Session 1**, after masterplan approval, ask once: "Run Sessions 2 → 2.5 → 3 → 4 straight through, or checkpoint after each document?" Record the answer as `Mode:` in the status file and honor it.
- In straight-through mode, still update the status file at every session boundary, and still dispatch Session 2.5 as a fresh agent (below) — auto-advance never skips verification.

---

## SESSION 0 — Discovery

**Goal:** Deeply understand the idea before writing a single spec — the problem, the user, the unique insight, the constraints.
**Read first:** Nothing (this is the start).
**Output:** `[product]_discovery.md` — an informal few-paragraph summary, confirmed with the person. Also create the status file.
**Done when:** You can confidently answer the five discovery questions (problem, user, insight, platform/stack, MVP scope) — verified one by one.

Do NOT begin without reading `references/session-0-discovery.md` in full.

## SESSION 1 — Masterplan

**Goal:** Complete product specification — the single source of truth for every build decision.
**Read first:** `[product]_discovery.md`.
**Output:** `[product]_masterplan.md` (14-section structure defined in the reference).
**Done when:** The quality bar in the reference passes item by item, and the person explicitly approves the masterplan. Then ask the straight-through-or-checkpoint question and record the mode.

This is a collaborative session — propose, push back, surface unmade decisions; don't template-fill. Do NOT begin without reading `references/session-1-masterplan.md` in full.

## SESSION 2 — Build Plan

**Goal:** Break the masterplan into dependency-ordered epics and agent-sized issues with five-gate tiered acceptance criteria.
**Read first:** The full masterplan.
**Output:** `[product]_buildplan.md` (issue template, gate definitions, and scoping rules in the reference).
**Done when:** The quality bar in the reference passes item by item — full masterplan coverage, dependency integrity, one concern per issue, epic smoke tests.

Do NOT begin without reading `references/session-2-buildplan.md` in full.

## SESSION 2.5 — Traceability Matrix

**Goal:** Systematically verify the build plan covers every implementable element of the masterplan — find gaps before any code is written.
**Read first:** The full masterplan AND the full build plan.
**Output:** `[product]_traceability_matrix.md`.

**Run this as a dispatched fresh-context agent** — the entity that audits should not be the entity that authored. Dispatch a general-purpose agent instructed to use the `traceability-matrix` skill (which contains the full methodology — that skill is this session's reference; there is no file in `references/` for it), reading both documents cold. Running it in a separate new conversation is an equally valid alternative.

**Done when:** Every implementable element is COVERED or documented as intentionally omitted (with the person's approval), and the build plan has been updated to close every gap.

## SESSION 3 — Prototype

**Goal:** A single self-contained interactive HTML file showing every screen, all four states per data-driven screen, and the core flows.
**Read first:** The masterplan (screen architecture, flows, design system) and the build plan (scope).
**Output:** `[product]_prototype.html`.
**Done when:** BOTH verification passes in the reference are clean — the screen-architecture cross-reference AND the evidence-based browser walkthrough. Self-assessment is not acceptance.

Do NOT begin without reading `references/session-3-prototype.md` in full.

## SESSION 4 — CLAUDE.md

**Goal:** The tight, product-specific session rules file that governs every build session — stack rules, standing constraints, five-gate review, auto-advance, smoke test protocol.
**Read first:** The masterplan, the build plan, and the traceability matrix.
**Output:** `CLAUDE.md` (full required-section templates in the reference).
**Done when:** The quality bar in the reference passes item by item. Then mark the status file fully complete and hand off to the build phase.

Do NOT begin without reading `references/session-4-claudemd.md` in full.

---

## Handoff Between Sessions

At the end of each session, before closing:

1. Confirm the output document is complete and saved.
2. Overwrite `[product]_docs_status.md` per the Status File Protocol — including the handoff note (what was decided, what the next session needs to know, open questions).
3. In checkpoint-each mode (and always after Sessions 0 and 1): tell the person what to bring to the next session. In straight-through mode (Sessions 2 onward): continue directly.
