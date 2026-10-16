# Session 4 — CLAUDE.md (Full Guide)

**Goal:** Produce the session rules file that governs every Claude Code session for this product. This file lives in the project root and is read at the start of every build session. It includes five-gate autonomous review, auto-advance, and epic smoke test protocol.

**Read first:** The masterplan (for stack and architecture), the build plan (for issue sequence and current status), and the traceability matrix (to confirm full coverage).

**Output:** `CLAUDE.md`

## What CLAUDE.md Is

CLAUDE.md is the session rules file that governs every Claude Code session for the product. It lives in the project root. Claude Code reads it at the start of every session.

Its job is to prevent the most common and costly Claude Code failure modes:
- Using the wrong library or framework ("helpfully" substituting something familiar)
- Skipping to the next issue before the current one is done
- Hardcoding values that should be environment variables
- Making architectural decisions that contradict the masterplan
- Exposing credentials or sensitive values to the wrong layer
- Self-assessing acceptance criteria without actually verifying them
- Missing masterplan specifications during implementation

## How to run Session 4

The CLAUDE.md is not a long document. It should be tight, direct, and specific to this product. Every rule should be there because violating it would cause real problems during the build.

Work through the masterplan and identify:
- The non-negotiable stack choices (what Claude Code must use and must never substitute)
- The architectural constraints that apply to every issue
- The credential and environment variable pattern
- The quality standard expected
- The five-gate issue completion protocol
- The auto-advance protocol
- The epic smoke test protocol

Set the current status to reflect where the build actually is.

## Required Sections

**1. Header and Reference Documents**

```markdown
# [Product Name] — Claude Code Session Rules

These rules apply to every session, every issue, without exception.
Do not deviate from them unless explicitly told to in the chat.

## Reference Documents

| Shorthand | Full Name | File |
|-----------|-----------|------|
| MP | Master Plan | `[product]_masterplan.md` |
| BP | Build Plan | `[product]_buildplan.md` |
| TM | Traceability Matrix | `[product]_traceability_matrix.md` |

When an issue says "MP §7" — open `[product]_masterplan.md` and find
Section 7. Never assume you know what the document says. Read it.
```

**2. Rule 1 — Read Before You Code**

```
Every issue in the build plan lists masterplan section refs.
Read those sections BEFORE writing a single line of code.

The documents contain exact field names, enum values, component structures,
and constraints that are NOT repeated in the issue description.
Skipping them causes drift and rework.
```

**3. Rule 2 — Stack**

List every non-negotiable technology choice. Be exhaustive and unambiguous. For each area (frontend, backend, database, auth, AI), name what to use AND what not to use.

```
**[Area]:** [Technology]. Not [common alternative]. Not [other alternative].

Environment variables live in `.env`:
- `VARIABLE_NAME` — [what it's for]

Never hardcode credentials. Never expose [sensitive variable] to [wrong layer].
```

**4. Rule 3 — One Issue at a Time, Then Auto-Advance**

```
Work through issues sequentially. Do not skip ahead.
After completing all five gates for an issue, auto-advance to the next issue.
Do NOT stop and wait for permission between issues.

Critical path: E1-01 -> E1-02 -> E1-03 -> ...

EXCEPTION: Stop and report after completing an Epic Smoke Test (E[n]-SMOKE).
Wait for explicit go-ahead before starting the next epic.
```

Include the actual critical path from the build plan.

**5. Rule 4 — Five-Gate Autonomous Review**

```
After finishing an issue, run all five gates IN ORDER before advancing.
If any gate fails, fix the issue and re-run that gate.
Only advance when all five pass.
```

**Gate 1 — Automated Checks (self)**

```
Run every automated command listed in the issue's Gate 1 acceptance criteria.
All must exit with code 0.

Report format:
[PASS] `npm run build` — exited 0, zero errors
[FAIL] `npm run lint` — 3 errors in captures.ts (list them)

All items must PASS before proceeding to Gate 2.
```

**Gate 2 — Command Verification (self)**

```
Run every command listed in the issue's Gate 2 acceptance criteria.
Check the output matches the expected result.

Report format:
[PASS] `curl -s localhost:5173/api/captures | jq '.length'` — returned 0 as expected
[FAIL] `curl -s localhost:5173/api/captures` — returned 404, endpoint not registered

All items must PASS before proceeding to Gate 3.
```

**Gate 3 — Browser Verification (self, using browser-verification skill)**

```
Use the browser-verification skill to verify every Gate 3 acceptance criteria item.
Take screenshots, inspect elements, check accessibility snapshots.

Report format:
[PASS] /captures page — empty state shows "No captures yet" (screenshot confirmed)
[FAIL] /captures page — loading skeleton not implemented (screenshot shows flash of empty content)

All items must PASS before proceeding to Gate 4.
Skip this gate for issues with no Gate 3 criteria.
```

**Gate 4 — Masterplan Cross-Reference Audit (agent)**

```
Dispatch an agent to re-read every masterplan section referenced by the issue.
Use the masterplan-cross-reference-audit skill.
The agent's sole job: compare what masterplan specifies against what was actually implemented.
It looks for missed columns, behaviors, constraints, tables, edge cases —
anything in the masterplan not reflected in code.

Report format:
[CLEAN] — no gaps found between masterplan and implementation
[GAP] [what masterplan says] → [what is missing or wrong in code]

All gaps must be fixed before proceeding to Gate 5.
```

**Gate 5 — Code Review (agent)**

```
Dispatch a general-purpose agent to review all code changes for the issue.
Give it this prompt: "Review all code changes for issue [ID] against:
(1) the issue's acceptance criteria in [product]_buildplan.md,
(2) CLAUDE.md rules (stack, production quality, technical constraints),
(3) general code quality (error handling, types, no TODOs, no hardcoded
values, no console.log).
Report [APPROVED] or [ISSUE] [severity] [description] → [suggested fix]."

Report format:
[APPROVED] — no issues found
[ISSUE] [severity] [description] → [suggested fix]

All issues must be resolved before the issue is considered complete.
```

**6. Rule 5 — Production Quality**

```
This is a launch-grade product, not a prototype. Every issue is built to
production standard — full stop.

- Handle all edge cases and errors gracefully
- [Product-specific quality constraint]
- Implement all screen states specified in the masterplan's screen architecture:
  empty state, loading state, populated state, error state
- Zero hackathon shortcuts, zero TODOs left in code, zero hardcoded values
- Match the design system exactly: [specific values from masterplan]

You are the technical co-founder on this project. Own it.
```

**7. Rule 6 — Standing Technical Constraints**

List every constraint that applies to every issue. How to identify them — read the masterplan architecture section and ask: "What would go wrong if Claude Code didn't know this?"

Constraints worth including:
- Database conventions (primary key format, timestamp type, RLS requirement)
- Security boundaries (what must never reach the frontend)
- Async patterns (Realtime pattern, forbid polling)
- Prompt handling (if prompts must come from a registry)
- Performance requirements that affect implementation choices
- Testing requirements (what must have tests)

Only include constraints that are: (a) specific to this product's architecture, and (b) likely to be violated if not stated.

**8. Rule 7 — Epic Smoke Test Protocol**

```
At the end of each epic (after completing the E[n]-SMOKE issue):

1. Start the application
2. Walk through the core user flow for this epic using browser-verification
3. Walk through ALL previous epic flows to check for regressions
4. Run the full test suite: `npm test`
5. Report results

If any regression is found:
- Fix it immediately
- Re-run the full smoke test
- Do NOT proceed to the next epic until all flows work

After a passing smoke test, STOP and report to the user.
Wait for explicit go-ahead before starting the next epic.
```

**9. Rule 8 — Update Current Status**

```
When all five gates for an issue pass, before advancing:

1. Open `CLAUDE.md`
2. Update the `## Current Status` section:
   - Move the completed issue to "Last completed"
   - Set "Currently working" to the next issue
   - Set "Next up" to the issue after that
3. Save the file
4. Auto-advance to the next issue (do NOT wait for permission)

EXCEPTION: After an Epic Smoke Test, stop and report.
```

**10. Rule 9 — Masterplan Update Protocol**

```
When you discover mid-build that the masterplan needs to change
(new approach, revised architecture, scope change, new data source):

1. Update the masterplan sections directly — it is always the single source of truth
2. Add a row to the masterplan's § Changelog table:
   | [date] | [sections modified] | [what changed] | [why] |
3. Re-run the traceability-matrix skill for ONLY the affected sections
4. Update any build plan issues whose acceptance criteria reference the changed sections
5. Commit the updated masterplan with a message referencing the changelog entry

NEVER create supplementary plan documents. NEVER maintain multiple sources of truth.
The masterplan is THE spec. If something changes, the masterplan changes.
```

**11. Current Status**

```
## Current Status

Last completed: —
Currently working: E1-01 ([First issue title])
Next up: E1-02 ([Second issue title])
```

## Tone and Style

- **Direct.** Not "please consider" — "never do X"
- **Specific.** Not "use the right database conventions" — "primary keys are UUID via gen_random_uuid()"
- **Short.** If a rule requires three paragraphs, break it into two rules
- **Technical.** Written for Claude Code, not a human user.

## What to Leave Out

- Generic software engineering best practices (Claude Code already knows these)
- Rules about things that can't go wrong for this specific product
- Explanations of how the product works (that's the masterplan's job)
- Encouragement or positive framing
- Anything that repeats something already enforced by a build plan acceptance criteria item

## CLAUDE.md Length

A good CLAUDE.md is typically 120-200 lines. Treat this as a diagnostic signal, not a target: much shorter suggests important constraints are missing; much longer suggests it's including things that don't need to be standing rules.

## Quality bar

The CLAUDE.md is done when every criterion below holds. Before declaring the session done, verify each item explicitly, one by one — general impression is not verification.

- Every standing constraint reflects a real risk specific to this product's architecture
- The stack rules are unambiguous — no room for Claude Code to "helpfully" substitute something
- The five-gate review protocol is complete with all gate definitions
- Auto-advance is enabled with explicit instructions
- Epic smoke test protocol is defined
- The current status accurately reflects the build state
- Nothing in it contradicts the masterplan, build plan, or traceability matrix (spot-check the stack rules and constraints against MP's architecture section one final time)

## Closing the session

1. Verify the quality bar item by item (above).
2. Update `[product]_docs_status.md`: mark ALL sessions complete and note that the docs phase is finished — from here the build phase is governed by the generated CLAUDE.md.
3. Report to the person: the five documents are complete, and what their next step is (complete Human Setup Requirements from MP §11, then start the build at issue E1-01).
