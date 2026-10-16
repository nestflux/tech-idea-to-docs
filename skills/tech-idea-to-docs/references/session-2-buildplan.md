# Session 2 — Build Plan (Full Guide)

**Goal:** Produce a complete Claude Code implementation guide that breaks the masterplan into epics, issues, and tiered acceptance criteria — ordered by dependency — that Claude Code can execute sequentially with autonomous verification.

**Read first:** The full masterplan from Session 1.

**Output:** `[product]_buildplan.md`

## What a Build Plan Is

A build plan is a complete Claude Code implementation guide. It breaks the masterplan into a sequenced list of discrete work units — epics and issues — that Claude Code can execute one at a time, in order, without needing to make architectural decisions.

It is not a Jira board. It is not a project plan with dates. It is a technical specification of work, ordered by dependency, with objectively verifiable completion criteria for each unit.

## How to run Session 2

Open the masterplan. Work through it systematically and identify every discrete unit of work that needs to happen. Group them into epics (major phases or areas of the product). Within each epic, sequence the issues by dependency — nothing should require something that hasn't been built yet.

**Issues must be scoped as "agent work units," not "human work units."** Each issue should have a single concern. If an issue touches backend logic, database writes, real-time subscriptions, AND error handling, it's too big. Split it. An agent loses track when an issue has too many moving parts.

For each issue, write:
- A clear title
- The type of work (Setup, Schema, Backend, Frontend, Integration)
- What it depends on
- Which masterplan sections it implements
- A file manifest — which files to create or modify
- A description of what needs to be built
- Implementation notes (specific enough that Claude Code doesn't have to make architectural decisions)
- Tiered acceptance criteria — grouped by verification method

## Structure

```
Build Plan
+-- Header (version, purpose, how to use)
+-- Epics Overview (table of all epics)
+-- Epics (in order)
    +-- Issues (in dependency order within each epic)
        +-- Metadata (type, depends on, masterplan refs)
        +-- File Manifest (files to create/modify)
        +-- Description
        +-- Implementation Notes
        +-- Tiered Acceptance Criteria (Gates 1-5)
    +-- Epic Smoke Test (final issue in each epic)
```

## Issue Template

Every issue in the build plan must follow this structure:

```markdown
## E[epic]-[issue] — [Title]

**Type:** [Setup | Schema | Backend | Frontend | Integration | Polish]
**Depends on:** [Previous issue ID, or "Nothing" for first issue]
**Masterplan:** [Section reference, e.g. "§7 API Design → POST /captures, §6 Database → captures table"]

### Files
- Create: `path/to/new/file.ts`
- Create: `path/to/another/file.ts`
- Modify: `path/to/existing/file.ts` (add Capture type)
- Create: `tests/captures.test.ts`

### Description
[One paragraph describing what needs to be built and why it exists in the product.]

### Implementation Notes
[Specific technical guidance — which library/pattern to use, configuration values,
how this connects to other parts of the system. Specific enough that there's one
obvious correct implementation.]

### Acceptance Criteria

**Gate 1 — Automated (must pass before any manual check):**
- [ ] `npm run build` — zero errors
- [ ] `npm run lint` — zero errors
- [ ] `npm test -- [relevant test file]` — all tests pass

**Gate 2 — Verifiable by command:**
- [ ] `curl -X POST localhost:[port]/api/captures -d '{"text":"test"}' -H 'Content-Type: application/json'` returns 201 with capture ID
- [ ] `curl localhost:[port]/api/captures` returns array containing the created capture

**Gate 3 — Verifiable by browser (use browser-verification skill):**
- [ ] Navigate to /captures — the created capture appears in the list
- [ ] The capture shows status badge "pending"
- [ ] Empty state shows correct CTA when no captures exist

**Gate 4 — Masterplan cross-reference (use masterplan-cross-reference-audit skill):**
- [ ] All columns from §6 captures table are present in migration
- [ ] Response shape matches §7 API design specification
- [ ] Screen states match §5 Screen Architecture for this view

**Gate 5 — Code review (dispatch a general-purpose review agent):**
- [ ] Code reviewed against acceptance criteria, CLAUDE.md rules, and general quality
```

## Tiered Acceptance Criteria — Why This Matters

If all acceptance criteria are listed as undifferentiated text, the agent treats "npm run build passes" and "the overlay closes within 200ms" the same way — by self-assessment. Most "didn't implement" failures come from this.

The tiered approach forces different verification methods:

| Gate | What it checks | How the agent verifies | Skill used |
|------|---------------|----------------------|------------|
| Gate 1 — Automated | Build, lint, tests | Run commands, check exit codes | None — just run the command |
| Gate 2 — Command | API responses, data correctness | Run curl/CLI commands, check output | None — just run the command |
| Gate 3 — Browser | UI rendering, navigation, states | Use browser tools to screenshot/inspect | `browser-verification` |
| Gate 4 — Masterplan | Spec compliance, completeness | Re-read masterplan sections, compare to code | `masterplan-cross-reference-audit` |
| Gate 5 — Code review | Code quality, patterns, no TODOs | Dispatch a general-purpose agent with a review prompt | Agent dispatch |

**Not every issue needs all five gates.** Schema-only issues don't need Gate 3 (browser). Backend-only issues might skip Gate 3. But Gates 1, 4, and 5 apply to every issue.

## How to Identify Epics

An epic is a major phase or area of the product. Epics should be:
- Independently meaningful (completing an epic produces something real)
- Sequenceable (later epics depend on earlier ones)
- Not too granular (5-15 issues per epic is typical)

**Standard epic sequence for most products:**

| Epic | What it covers |
|------|---------------|
| E1 | Development Environment |
| E2 | Database & Auth |
| E3 | Core Backend / AI Infrastructure |
| E4 | Onboarding |
| E5-En | Core Feature Epics (product-specific) |
| En+1 | Design System Implementation |
| En+2 | System Integration & Polish |
| En+3 | Distribution & Launch Prep |

Adjust to fit the product. A product with no AI has no AI infrastructure epic.

## How to Scope Issues for Agent Execution

**The golden rule: one concern per issue.** An issue that says "build the capture pipeline" with 8 acceptance criteria spanning database, backend, frontend, and error handling is a human work unit. An agent needs it split:

| Human work unit | Agent work units |
|----------------|-----------------|
| "Build capture pipeline" | E3-04a: Create captures table and migration |
| | E3-04b: Implement POST /api/captures endpoint |
| | E3-04c: Implement GET /api/captures endpoint |
| | E3-04d: Build captures list UI |
| | E3-04e: Build capture detail view |

**How to tell if an issue is too big:**
- It touches more than 3-4 files
- Its acceptance criteria span more than one gate type (e.g., both command-verifiable AND browser-verifiable items that are independent)
- It takes more than one paragraph to describe what needs to happen
- You can identify two or more independent concerns within it

**How to tell if an issue is too small:**
- It's a single line change with no verification needed
- It would be absorbed into a related issue without adding complexity

## How to Write File Manifests

The file manifest tells the agent exactly which files to create or modify. This prevents:
- Files created in wrong locations
- Wrong file structure decisions
- Missing test files

```markdown
### Files
- Create: `src/lib/server/captures.ts` — capture CRUD operations
- Create: `src/routes/api/captures/+server.ts` — REST endpoint handler
- Modify: `src/lib/types.ts` — add Capture and CaptureStatus types
- Create: `tests/unit/captures.test.ts` — unit tests for capture operations
```

Rules:
- Use the actual paths from the project structure established in E1
- Always include test files when the issue creates testable logic
- When modifying, note what's being added/changed in parentheses
- Group by create/modify for clarity

## How to Write Tiered Acceptance Criteria

**Gate 1 — Automated:** Commands that can be run and must exit with code 0. Always include build, lint, and relevant tests. These are non-negotiable for every issue.

```markdown
**Gate 1 — Automated:**
- [ ] `npm run build` — zero errors
- [ ] `npm run lint` — zero errors
- [ ] `npm test -- tests/unit/captures.test.ts` — all tests pass
```

**Gate 2 — Command-verifiable:** Things you can check by running a command and inspecting output. Mostly for backend/API issues.

```markdown
**Gate 2 — Verifiable by command:**
- [ ] `curl -s localhost:5173/api/captures | jq '.length'` returns 0 (empty array, not error)
- [ ] After POST, GET returns the created resource with matching ID
```

**Gate 3 — Browser-verifiable:** Things that require looking at the running application. Frontend and integration issues. The agent uses the `browser-verification` skill for these.

```markdown
**Gate 3 — Verifiable by browser:**
- [ ] Navigate to /captures — page loads without console errors
- [ ] Empty state shows "No captures yet" message with "Create your first capture" CTA
- [ ] After creating a capture, it appears in the list without page refresh
```

**Gate 4 — Masterplan cross-reference:** Systematic comparison of implemented code against masterplan specification. The agent uses the `masterplan-cross-reference-audit` skill. Always reference specific masterplan sections.

```markdown
**Gate 4 — Masterplan cross-reference:**
- [ ] All columns from §7 captures table specification are present
- [ ] API response shape matches §8 POST /api/captures specification
- [ ] UI matches §5 captures list screen specification (all states)
```

**Gate 5 — Code review:** Dispatch a general-purpose agent to review all changes. (Do not reference a named "code-reviewer" agent — dispatch a general-purpose agent with an explicit review prompt: "Review all code changes for issue [ID] against (1) the issue's acceptance criteria in the build plan, (2) the rules in CLAUDE.md, (3) general quality — error handling, types, no TODOs, no hardcoded values, no console.log. Report [APPROVED] or [ISSUE] [severity] [description] → [suggested fix].")

```markdown
**Gate 5 — Code review:**
- [ ] Code reviewed against acceptance criteria and CLAUDE.md rules
- [ ] No TODOs, no hardcoded values, no console.log, proper error handling
```

## Dependency Ordering

This is the most important structural rule: **no issue should require something that hasn't been built yet.**

Common dependency traps:
- A frontend component that uses a Supabase table that hasn't been created yet
- An edge function that queries a prompt registry that hasn't been seeded
- An onboarding flow that requires auth that hasn't been set up
- A feature that depends on real-time subscriptions before the subscription pattern is established

## The Critical Path

Every build plan has a critical path — the sequence of issues where each one blocks the next. Identify it explicitly. It usually looks like:

`E1-01 -> E1-02 -> E1-03 -> E2-01 -> E2-02 -> E2-03 -> ...`

Environment setup -> database -> auth -> core backend logic -> core frontend -> secondary features -> polish -> distribution.

## Epic Checkpoint

At the end of each epic, include an **Epic Smoke Test** issue:

```markdown
## E[n]-SMOKE — Epic [n] Smoke Test

**Type:** Integration
**Depends on:** All issues in this epic

### Description
Start the application and verify the core user flow for this epic works end-to-end.
This catches cross-issue regressions that individual issue gates miss.

### Acceptance Criteria

**Automated:**
- [ ] `npm run build` — zero errors
- [ ] `npm test` — ALL tests pass (not just this epic's tests)

**Browser verification (full flow):**
- [ ] [Step-by-step walkthrough of the epic's core user flow]
- [ ] [Each step verified with browser-verification skill]
- [ ] [Previous epic flows still work — no regressions]
```

## Epics Overview Table

Include a table at the top summarising all epics:

| Epic | Title | Issues | Description |
|------|-------|--------|-------------|
| E1 | Development Environment | 3 | Dev environment working end to end |
| E2 | Database & Auth | 6 | All tables, RLS, auth flow, and initial seed data |

## How to Use This Document Section

Include at the top of the build plan:
1. Read the referenced masterplan sections before writing any code
2. For each issue, pass all five gates in order before moving to the next issue
3. Never proceed to the next issue if any gate is failing
4. Issues within an epic are ordered by dependency — do not skip ahead
5. At the end of each epic, run the Epic Smoke Test
6. Use the `browser-verification` skill for Gate 3 checks
7. Use the `masterplan-cross-reference-audit` skill for Gate 4 checks
8. Dispatch a general-purpose review agent for Gate 5 checks

## Quality bar

The build plan is done when every criterion below holds. Before declaring the session done, verify each item explicitly, one by one — general impression is not verification.

**Coverage:** Every feature described in the masterplan has at least one corresponding issue. Every screen in the screen architecture has corresponding frontend issues.

**Verifiability:** Every acceptance criteria item has an explicit verification method — a command to run, a URL to visit, a masterplan section to cross-reference.

**Dependency integrity:** No issue requires something not yet built at that point in the sequence. The critical path is explicit and unambiguous.

**Specificity:** Implementation notes are specific enough that Claude Code doesn't have to make architectural decisions. File manifests specify exact paths.

**Completeness:** No placeholders. No "details TBD". Every issue is fully written. Every epic ends with a smoke test issue.

**Masterplan alignment:** Every issue references the correct masterplan sections.

**Agent-sized scope:** No issue has more than one primary concern. Issues that touch both backend and frontend are split unless trivially small.

**Executability:** Claude Code could start at issue 1 and work through to the last issue without needing to ask architectural questions.

## Build Plan Length

A thorough build plan for a medium-complexity product (10-15 epics, 50-80 issues) typically lands around 2,500-4,000 lines, with each issue averaging 30-50 lines. Treat this as a diagnostic signal, not a target — far below it, check for missing issues or abbreviated acceptance criteria; far above it, check for redundancy. Do not abbreviate acceptance criteria to save space.

## Closing the session

1. Verify the quality bar item by item (above).
2. Update `[product]_docs_status.md` (Session 2 complete, next: Session 2.5).
3. Proceed per the recorded mode: straight-through → dispatch Session 2.5 immediately; checkpoint-each → report and wait.
