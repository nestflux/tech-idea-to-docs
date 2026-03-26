---
name: tech-idea-to-docs
description: Transforms a raw tech product idea into production-ready documents through a structured multi-session process — masterplan, build plan, traceability matrix, HTML prototype, and CLAUDE.md. Use when someone has a software product idea and wants to go from concept to implementation-ready documentation.
argument-hint: describe your product idea or specify a session number
---

# Tech Idea to Docs

This skill transforms a raw tech product idea into five production-ready documents through a structured six-session process. Each session builds on the previous one. Do not compress sessions or skip ahead.

User's input: $ARGUMENTS

## The Six Sessions

| Session | Output | Purpose |
|---------|--------|---------|
| Session 0 | No document — raw material | Discovery: understand the idea deeply before speccing anything |
| Session 1 | `[product]_masterplan.md` | Complete product specification |
| Session 2 | `[product]_buildplan.md` | Claude Code implementation guide |
| Session 2.5 | `[product]_traceability_matrix.md` | Verification that build plan fully covers masterplan |
| Session 3 | `[product]_prototype.html` | Interactive prototype of all key screens |
| Session 4 | `CLAUDE.md` | Claude Code session rules file with five-gate autonomous review |

**The golden rule:** Each session ends with a complete, high-quality document. The next session opens that document and builds on it. Never start a session without reading the output of the previous one.

---

## SESSION 0 — Discovery

**Goal:** Deeply understand the idea before writing a single spec. Surface the core problem, the user, the unique insight, and the constraints. Produce raw material that makes Session 1 fast and sharp.

**This session produces no document.** It produces clarity.

### How to run Session 0

Start by asking the person to describe their idea in their own words — however formed or unformed. Don't prompt them with a structure yet. Just listen.

Then work through the following areas through genuine back-and-forth conversation. These are not a form to fill out. They are the things you need to understand. Ask follow-up questions. Push back. Explore tangents that seem promising.

**The problem**
- What specific moment of frustration is this solving? Can you describe a concrete scenario where someone hits this problem?
- Who has tried to solve this before and why did their solution fall short?
- Is this a problem people know they have, or one they don't realise they have until you show them?

**The user**
- Who is the person most likely to use this every day? Give them a name and a job title.
- What does their current day look like without this product?
- What does their day look like with it?
- Are there 2-3 distinct user types worth naming separately?

**The unique insight**
- What is the one thing this product does that nothing else does?
- If you had to explain the core insight in one sentence to a smart friend, what would you say?
- What assumption does every competitor make that this product rejects?

**The constraints**
- What platform? (desktop, web, mobile, API)
- Any non-negotiable technical choices? (specific stack, existing infrastructure, integrations required)
- What's the scope for an MVP versus the full vision?

**The name and category**
- Does the product have a name yet?
- How would you describe the category? What words would you use — and what words would you explicitly avoid?

### When Session 0 is done

You should be able to answer these five questions confidently:
1. What is the specific problem this solves, in one sentence?
2. Who is the primary user, described concretely?
3. What is the unique insight — the thing no competitor has done?
4. What platform and rough stack?
5. What is the MVP scope?

Write a brief Session 0 Summary (not a formal document — a few paragraphs) and confirm it with the person before moving to Session 1. This summary becomes the opening context for Session 1.

---

## SESSION 1 — Masterplan

**Goal:** Produce a complete product specification that covers everything needed to make architectural, design, and screen-level decisions during the build.

**Read first:** The Session 0 Summary.

**Output:** `[product]_masterplan.md`

### How to run Session 1

The masterplan is not produced by asking the person a list of questions and filling in a template. It is produced through a genuine collaborative process where you contribute expertise and they contribute product vision.

Your job is to:
- Make proposals and let them react ("Here's how I'd structure the database — does this match your mental model?")
- Surface decisions they haven't made yet and help them make them ("You haven't mentioned how the free tier works — let's figure that out now")
- Push back on things that seem architecturally risky ("This approach will work but creates a problem later when you want to add X — want to think through an alternative?")
- Name things they're describing but haven't labelled ("What you're describing is essentially an event sourcing pattern — here's what that means for the schema")

The masterplan should feel like it was written by someone who has thought deeply about this specific product, not like a filled-in template. Vary the structure to fit the product. Not every product needs every section.

### Core sections every masterplan needs

Every masterplan must cover these areas, in whatever order and depth makes sense for the product:

- **Product vision** — the problem, the insight, what success looks like
- **User personas** — named, concrete, described with their current pain and future gain
- **Core user flows** — the key journeys through the product, described in enough detail to design from
- **Feature set** — what the product does, what it explicitly does not do
- **Screen architecture** — every distinct screen/view, what it contains, how screens connect to each other
- **Architecture** — how the product is built (frontend, backend, data, AI if applicable)
- **Database schema** — all tables, fields, types, relationships, constraints
- **API design** — all endpoints or edge functions, request/response shapes
- **Design system** — visual language, component philosophy, key UI patterns
- **Testing strategy** — what framework, what coverage level, key scenarios that must have tests
- **Human setup requirements** — API keys, accounts, services, MCP tools, and manual steps the human must complete before the agent can build
- **Revenue model** — pricing tiers, what each tier includes
- **GTM strategy** — positioning, initial channels, launch approach

### Quality bar

The masterplan is done when:
- A senior engineer could read it and make every major architectural decision without asking questions
- The database schema is complete enough to write migrations from
- Every user-facing flow is described in enough detail to build from
- Every screen in the product is catalogued with its components, states, and connections
- The design system is specific enough that a designer could produce consistent mockups
- The testing strategy specifies what to test and how to run tests
- All human setup requirements are catalogued — every API key, account, service, and MCP tool the human needs to set up before the agent can build
- There are no unresolved "TBD" sections on anything in the critical path

### Masterplan Guide — Full Reference

#### What a Masterplan Is

A masterplan is the complete product specification. It is the single source of truth for every decision made during the build. It is written before a line of code is written, and it answers every question a senior engineer, designer, or product manager would need answered before starting work.

It is not a pitch deck. It is not a PRD. It is a detailed technical and product document written for the people who will build the thing.

#### Section Structure

The sections below are a guide, not a rigid template. Adjust the order and depth to fit the product.

**1. Product Vision**
- The specific problem being solved — described with a concrete scenario, not an abstraction
- The unique insight — the one thing this product does that nothing else does, and why that matters
- What the category is, and what words to use / avoid when describing it
- What success looks like at 6 months, 1 year, 3 years
- Depth: 3-5 paragraphs. Specific enough that someone reading it understands not just what the product does but why it exists.
- Common mistake: Describing the product instead of the problem. The vision section should make the reader feel the problem before they understand the solution.

**2. User Personas**
- 2-4 named personas, each representing a distinct user type
- For each: name, job title, the specific pain they experience today, what their day looks like without the product, what their day looks like with it
- Which persona is the primary target (the one the product is optimised for)
- Depth: One substantial paragraph per persona. Give them texture — specific details that make them feel real, not marketing archetypes.
- Common mistake: Personas that are too similar to each other, or so broad they describe everyone and therefore no one.

**3. Core User Flows**
- Every distinct journey a user takes through the product
- For each flow: the trigger (what causes the user to start), the steps, the outcome
- The happy path in full detail, plus the key failure/edge cases
- Format: Numbered steps. Be specific about what the user sees and does at each step, not just what the system does.
- Depth: As detailed as it needs to be for a designer to produce wireframes from it without asking questions. For the core flow, this might be 15-20 steps.
- Common mistake: Describing flows at the feature level ("user completes the onboarding") rather than the interaction level ("user sees a three-field form, fills in name and work type, clicks Continue, sees the confirmation screen").

**4. Feature Set**
- Every feature the product ships with at launch
- Explicit list of what the product does NOT do (just as important)
- Post-launch roadmap items (brief — this is not a roadmap document)
- Format: Group features by area. For each feature, one sentence describing what it does and why it exists.
- Common mistake: Including every possible future feature in the launch scope. Be ruthless.

**5. Screen Architecture**

This section catalogs every distinct screen/view in the product — what it contains, what states it has, and how it connects to other screens.

- **Screen inventory:** A complete list of every screen, grouped by area (auth, onboarding, core, settings, admin, etc.)
- **For each screen:**
  - Screen name and route/path (e.g., `/dashboard`, `/captures/:id`)
  - Purpose — what the user accomplishes on this screen
  - Components — every major UI element on the screen (cards, tables, forms, modals, sidebars, etc.)
  - States — what the screen looks like in each state:
    - **Empty state:** No data yet. What does the user see? What CTA guides them?
    - **Loading state:** Data is being fetched. Skeleton? Spinner? Progressive loading?
    - **Populated state:** Normal usage with representative data
    - **Error state:** Something went wrong. What error message? What recovery action?
    - **Edge states:** Any screen-specific states (e.g., "processing" for AI-heavy screens, "offline" for real-time features)
  - Navigation — what screens link here, what screens this links to, what actions trigger navigation
  - Responsive behavior — how the layout changes on mobile/tablet if applicable

- **Screen flow diagram:** A text-based diagram showing how screens connect:
  ```
  Login → Dashboard → [Capture Detail | Settings | New Capture]
                    → New Capture → Processing → Capture Detail
  Settings → [Profile | Billing | Prompts]
  ```

- Format: Table or structured list per screen. Be exhaustive — every screen, every component, every state.
- Depth: Enough that a frontend developer knows every view they need to build, what goes on each one, and how they connect. No screen should be "discovered" during implementation.
- Common mistake: Listing screens without specifying their states. Every data-driven screen has at least four states (empty, loading, populated, error). Missing states are the #1 source of incomplete implementations.

**6. Architecture**
- Frontend: framework, state management, styling, key libraries
- Backend: runtime, hosting, key services
- Database: type, hosting (usually Supabase/Postgres)
- Auth: approach and provider
- AI/ML: which models, how they're called, from where
- Real-time: if applicable, how it works
- File storage: if applicable
- Key architectural decisions and the reasoning behind them (not just what was chosen, but why)
- Depth: Enough that a senior engineer could set up the project structure without making any architectural guesses. Include specific version numbers or library names where they matter.
- Common mistake: Listing the stack without explaining the decisions. "We use Tauri instead of Electron because..." is more useful than just "Desktop: Tauri".

**7. Database Schema**
- Every table, every column, its type, constraints (NOT NULL, DEFAULT, CHECK), and what it represents
- All foreign key relationships
- Any indexes worth calling out
- Enums or constrained value sets
- Format: SQL CREATE TABLE statements are the clearest format. Annotate with comments where the purpose of a field isn't obvious.
- Depth: Complete. Every field. No placeholders. The build plan's database migrations should be writable directly from this section.
- Common mistake: Leaving out junction tables, audit fields (created_at, updated_at), or soft-delete patterns.

**8. API Design**
- Every endpoint or edge function
- For each: method, path, auth requirement, request body shape, response shape, error cases
- Any shared patterns (error format, pagination, auth headers)
- For AI-heavy products: Include the prompt structure for every AI call — not the full prompt text, but the shape.
- Depth: Enough to implement from. Request and response shapes should have actual field names and types.
- Common mistake: Documenting only the happy path. Error responses matter as much as success responses.

**9. Design System**
- Visual language: colour palette (with hex values), typography (typefaces, scale, weights), spacing system, border radius, shadows
- Component philosophy: what principles govern the UI decisions
- Key components: describe the most important UI components and how they behave
- Interaction principles: loading states, empty states, error states, transitions
- Depth: Specific enough for a designer or frontend developer to produce consistent UI without making style decisions. Hex codes, not "warm grey". Specific typefaces, not "sans-serif".
- Common mistake: Vague principles without concrete values. "Clean and minimal" is not a design system.

**10. Testing Strategy**
- Testing framework (e.g., Vitest, Jest, Playwright, Cypress)
- What level of test coverage is expected:
  - **Unit tests:** Which modules/functions must have unit tests
  - **Integration tests:** Which API endpoints and data flows need integration tests
  - **E2E tests:** Which critical user flows need end-to-end tests
- Key scenarios that MUST have tests (the non-negotiable list)
- How to run the test suite — the exact commands (`npm test`, `npm run test:e2e`, etc.)
- Test data strategy — how test fixtures and seed data are managed
- Common mistake: Specifying a framework but not specifying WHAT to test. "Use Vitest" is not a testing strategy.

**11. Human Setup Requirements**

This section catalogs everything the human must do before the agent can start building. The agent cannot create accounts, generate API keys, or configure external services — these are blockers that must be resolved by the human first.

- **Accounts to create:** Every third-party service the product depends on. For each: service name, what it's used for, which tier/plan to sign up for, and the URL to sign up.
  - Example: "Supabase — database and auth — Free tier — https://supabase.com"
  - Example: "OpenAI — AI completions — Pay-as-you-go — https://platform.openai.com"
  - Example: "Resend — transactional email — Free tier (100 emails/day) — https://resend.com"

- **API keys to generate:** Every key or secret the project needs. For each: which service, what the key is called, where to find it in the service dashboard, and what `.env` variable name to store it as.
  - Example: "OpenAI → API Keys → Create new secret key → store as `OPENAI_API_KEY`"
  - Example: "Supabase → Project Settings → API → anon public key → store as `NEXT_PUBLIC_SUPABASE_ANON_KEY`"

- **MCP tools to connect:** Every MCP server the agent needs during the build. For each: the MCP server name, what it provides, and connection instructions.
  - Example: "Supabase MCP — database management and migrations — connect via `npx supabase-mcp`"
  - Example: "GitHub MCP — PR creation and issue management — connect via settings"

- **Local tools to install:** Any CLI tools, runtimes, or system dependencies that must be installed on the machine.
  - Example: "Node.js >= 20 — required runtime"
  - Example: "Supabase CLI — `brew install supabase/tap/supabase`"

- **Manual configuration steps:** Any setup that requires human judgment or manual action in a dashboard.
  - Example: "Supabase: Enable Google OAuth in Auth → Providers → Google. Requires Google Cloud OAuth credentials."
  - Example: "Stripe: Create products and price IDs in the Stripe Dashboard for each pricing tier."
  - Example: "DNS: Point domain to Vercel via CNAME record."

- **`.env` template:** A complete list of every environment variable the project needs, grouped by service, with placeholder values and comments:
  ```
  # Supabase
  NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
  NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxxxxxx
  SUPABASE_SERVICE_ROLE_KEY=eyJxxxxxxx

  # OpenAI
  OPENAI_API_KEY=sk-xxxxxxx

  # Resend
  RESEND_API_KEY=re_xxxxxxx
  ```

- Format: Checklist. The human should be able to go through this section top to bottom and complete every item before handing off to the agent.
- Depth: Exhaustive. If the agent will hit an error because a key is missing or a service isn't configured, it must be listed here.
- Common mistake: Assuming the agent will figure out what accounts are needed. If it's not listed, the human won't set it up, and the build will fail at runtime with a cryptic auth error.

**12. Revenue Model (if applicable)**
- Pricing tiers and what each includes
- Free tier limits (if applicable)
- Billing cadence (monthly/annual)
- B2B vs B2C approach
- Revenue projections (rough — directional, not a financial model)
- Expansion motion (how a customer grows from first purchase to larger contract)
- Depth: Enough to build the billing/paywall logic from. What features are gated? What are the limits?

**13. GTM Strategy**
- Positioning: what category, what message leads, what words to use and avoid
- Target customer: who is the first person to pay, described specifically
- Launch channels: which 2-3 channels to focus on first and why
- Initial motion: self-serve, founder-led sales, or hybrid
- Depth: Enough to make the positioning decisions that affect the product itself.

**14. Changelog**

This section is empty at initial creation. It becomes active during the build when the masterplan is updated to reflect new approaches, revised architecture, or scope changes discovered during implementation.

```markdown
## Changelog

| Date | Sections Modified | Summary | Reason |
|------|-------------------|---------|--------|
| — | — | Initial masterplan creation | — |
```

When the masterplan is updated mid-build:
1. Make the changes directly in the relevant sections (the masterplan is always the single source of truth)
2. Add a row to the changelog documenting what changed, which sections were affected, and why
3. Re-run the traceability matrix for the affected sections only (use the `traceability-matrix` skill with the `--sections` scope)
4. Update any build plan issues whose acceptance criteria reference the changed sections
5. Commit the masterplan with a descriptive message referencing the changelog entry

The changelog serves two purposes:
- **Audit trail:** Anyone can see what changed and when, and `git diff` shows the full before/after
- **Re-audit trigger:** When a section appears in the changelog, the traceability matrix must be re-run for that section

- Format: Table with date, sections, summary, and reason columns
- Depth: One row per change event. Summary should be specific enough to understand the change without reading the diff.
- Common mistake: Updating the masterplan without adding a changelog entry. This makes it impossible to know which traceability matrix sections need re-auditing.

#### Masterplan Quality Criteria

**Completeness:** Every section is present and substantive. No "TBD" on anything in the critical path.

**Specificity:** A senior engineer reading it could make every major decision without asking a question. Colour values are hex codes. Field types are actual SQL types. API responses have actual field names.

**Screen coverage:** Every screen referenced in user flows appears in the screen architecture section, with all four states (empty, loading, populated, error) specified.

**Consistency:** The database schema matches the data referenced in the user flows. The features described in the feature set all appear in the flows. The design system values match the component descriptions. The screens in screen architecture match the screens referenced in user flows.

**Testability:** The testing strategy specifies concrete scenarios and exact commands to run tests.

**Honesty about scope:** What the product does NOT do is as clearly specified as what it does.

**Coherence:** The product described in the masterplan is the same product described in the vision.

#### Masterplan Length

A thorough masterplan for a medium-complexity product is typically 3,000-6,000 lines of Markdown (the screen architecture and testing strategy sections add material). Shorter usually means important things are missing. Longer usually means scope creep or unnecessary repetition. Don't pad. Don't abbreviate. Write to the complexity of the product.

---

## SESSION 2 — Build Plan

**Goal:** Produce a complete Claude Code implementation guide that breaks the masterplan into epics, issues, and tiered acceptance criteria — ordered by dependency — that Claude Code can execute sequentially with autonomous verification.

**Read first:** The full masterplan from Session 1.

**Output:** `[product]_buildplan.md`

### How to run Session 2

Open the masterplan. Work through it systematically and identify every discrete unit of work that needs to happen. Group them into epics (major phases or areas of the product). Within each epic, sequence the issues by dependency — nothing should require something that hasn't been built yet.

**Critical change from previous approach:** Issues must be scoped as "agent work units," not "human work units." Each issue should have a single concern. If an issue touches backend logic, database writes, real-time subscriptions, AND error handling, it's too big. Split it. An agent loses track when an issue has too many moving parts.

For each issue, write:
- A clear title
- The type of work (Setup, Schema, Backend, Frontend, Integration)
- What it depends on
- Which masterplan sections it implements
- A file manifest — which files to create or modify
- A description of what needs to be built
- Implementation notes (specific enough that Claude Code doesn't have to make architectural decisions)
- Tiered acceptance criteria — grouped by verification method

### Issue Template

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

**Gate 5 — Code review (dispatch code-reviewer agent):**
- [ ] Code reviewed against acceptance criteria, CLAUDE.md rules, and general quality
```

### Tiered Acceptance Criteria — Why This Matters

The old approach listed all acceptance criteria as undifferentiated text. The agent treated "npm run build passes" and "the overlay closes within 200ms" the same way — by self-assessment. Most "didn't implement" failures come from this.

The tiered approach forces different verification methods:

| Gate | What it checks | How the agent verifies | Skill used |
|------|---------------|----------------------|------------|
| Gate 1 — Automated | Build, lint, tests | Run commands, check exit codes | None — just run the command |
| Gate 2 — Command | API responses, data correctness | Run curl/CLI commands, check output | None — just run the command |
| Gate 3 — Browser | UI rendering, navigation, states | Use preview tools to screenshot/inspect | `browser-verification` |
| Gate 4 — Masterplan | Spec compliance, completeness | Re-read masterplan sections, compare to code | `masterplan-cross-reference-audit` |
| Gate 5 — Code review | Code quality, patterns, no TODOs | Dispatch code-reviewer agent | Built-in agent dispatch |

**Not every issue needs all five gates.** Schema-only issues don't need Gate 3 (browser). Backend-only issues might skip Gate 3. But Gates 1, 4, and 5 apply to every issue.

### The critical path

Every build plan has a critical path — the sequence of issues that everything else depends on. Identify it explicitly. Environment setup -> database -> auth -> core backend logic -> core frontend -> secondary features -> polish -> distribution.

### Epic Checkpoint

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

### Quality bar

The build plan is done when:
- Every feature in the masterplan has at least one corresponding issue
- Every screen in the masterplan's screen architecture has corresponding frontend issues
- Every issue has tiered acceptance criteria with specific verification commands
- Every issue has a file manifest specifying files to create/modify
- No issue requires something not yet built at that point in the sequence
- The critical path is explicit and unambiguous
- Every epic ends with a smoke test issue
- Issues are scoped to a single concern (backend OR frontend, not both, unless trivially small)
- Claude Code could start at issue 1 and work through to the last issue without needing to ask architectural questions

### Build Plan Guide — Full Reference

#### What a Build Plan Is

A build plan is a complete Claude Code implementation guide. It breaks the masterplan into a sequenced list of discrete work units — epics and issues — that Claude Code can execute one at a time, in order, without needing to make architectural decisions.

It is not a Jira board. It is not a project plan with dates. It is a technical specification of work, ordered by dependency, with objectively verifiable completion criteria for each unit.

#### Structure

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

#### How to Identify Epics

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

#### How to Scope Issues for Agent Execution

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

#### How to Write File Manifests

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

#### How to Write Tiered Acceptance Criteria

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

**Gate 5 — Code review:** Dispatch the code-reviewer agent to review all changes.

```markdown
**Gate 5 — Code review:**
- [ ] Code reviewed against acceptance criteria and CLAUDE.md rules
- [ ] No TODOs, no hardcoded values, no console.log, proper error handling
```

#### Dependency Ordering

This is the most important structural rule: **no issue should require something that hasn't been built yet.**

Common dependency traps:
- A frontend component that uses a Supabase table that hasn't been created yet
- An edge function that queries a prompt registry that hasn't been seeded
- An onboarding flow that requires auth that hasn't been set up
- A feature that depends on real-time subscriptions before the subscription pattern is established

#### The Critical Path

The critical path is the sequence of issues where each one blocks the next. Identify it explicitly. It usually looks like:

`E1-01 -> E1-02 -> E1-03 -> E2-01 -> E2-02 -> E2-03 -> ...`

#### Epics Overview Table

Include a table at the top summarising all epics:

| Epic | Title | Issues | Description |
|------|-------|--------|-------------|
| E1 | Development Environment | 3 | Dev environment working end to end |
| E2 | Database & Auth | 6 | All tables, RLS, auth flow, and initial seed data |

#### How to Use This Document Section

Include at the top of the build plan:
1. Read the referenced masterplan sections before writing any code
2. For each issue, pass all five gates in order before moving to the next issue
3. Never proceed to the next issue if any gate is failing
4. Issues within an epic are ordered by dependency — do not skip ahead
5. At the end of each epic, run the Epic Smoke Test
6. Use the `browser-verification` skill for Gate 3 checks
7. Use the `masterplan-cross-reference-audit` skill for Gate 4 checks
8. Dispatch the code-reviewer agent for Gate 5 checks

#### Build Plan Quality Criteria

**Coverage:** Every feature described in the masterplan has at least one corresponding issue. Every screen in the screen architecture has corresponding issues.

**Verifiability:** Every acceptance criteria item has an explicit verification method — a command to run, a URL to visit, a masterplan section to cross-reference.

**Dependency integrity:** No issue requires something not yet built.

**Specificity:** Implementation notes are specific enough that Claude Code doesn't have to make architectural decisions. File manifests specify exact paths.

**Completeness:** No placeholders. No "details TBD". Every issue is fully written.

**Masterplan alignment:** Every issue references the correct masterplan sections.

**Agent-sized scope:** No issue has more than one primary concern. Issues that touch both backend and frontend are split unless trivially small.

#### Build Plan Length

A thorough build plan for a medium-complexity product (10-15 epics, 50-80 issues — more than before because issues are smaller) is typically 2,500-4,000 lines. Each issue averages 30-50 lines. Do not abbreviate acceptance criteria to save space.

---

## SESSION 2.5 — Traceability Matrix

**Goal:** Systematically verify that the build plan fully and faithfully covers every discrete specification element in the masterplan. Identify gaps before a single line of code is written.

**Read first:** The full masterplan AND the full build plan.

**Output:** `[product]_traceability_matrix.md`

**Important:** This session should ideally be run in a fresh context (new conversation) to avoid the "same agent checking its own work" problem. The agent reading both documents cold will catch things the original author is blind to.

### How to run Session 2.5

Walk through every section of the masterplan and extract every discrete, implementable element. For each element, check whether the build plan has a corresponding issue with acceptance criteria that would verify its implementation.

Use the `traceability-matrix` skill for the systematic methodology.

### Structure

```markdown
# Traceability Matrix — [Product Name]

## Summary
- Total masterplan elements: [N]
- Covered by build plan: [N] (X%)
- Partially covered: [N] (X%)
- Missing from build plan: [N] (X%)

## §1 Product Vision
[No implementable elements — skip]

## §2 User Personas
[No implementable elements — skip]

## §3 Core User Flows

| # | Masterplan Element | Build Plan Issue | AC Reference | Status |
|---|-------------------|-----------------|--------------|--------|
| 1 | Onboarding flow step 1: user sees three-field form | E4-01 | Gate 3 AC #1 | COVERED |
| 2 | Onboarding flow step 2: validation on email field | E4-01 | Gate 3 AC #3 | COVERED |
| 3 | Onboarding flow error: duplicate email shows message | **—** | **—** | **GAP** |

## §5 Screen Architecture

| # | Masterplan Element | Build Plan Issue | AC Reference | Status |
|---|-------------------|-----------------|--------------|--------|
| 1 | Dashboard: empty state shows CTA | E5-01 | Gate 3 AC #2 | COVERED |
| 2 | Dashboard: loading skeleton | **—** | **—** | **GAP** |
| 3 | Dashboard: error state | **—** | **—** | **GAP** |
| 4 | Captures list: populated state | E5-03 | Gate 3 AC #1 | COVERED |

## §7 Database Schema

| # | Masterplan Element | Build Plan Issue | AC Reference | Status |
|---|-------------------|-----------------|--------------|--------|
| 1 | `captures` table — 14 columns as specified | E2-03 | Gate 4 AC #1 | COVERED |
| 2 | `captures.status` enum: pending, processing, complete, failed | E2-03 | Gate 2 AC #2 | COVERED |
| 3 | `prompt_registry` table — 6 columns | **—** | **—** | **GAP** |

[Continue for every masterplan section with implementable elements]

## Gap Resolution

For each GAP found, one of:
1. **Add issue:** Create a new issue in the build plan to cover this element
2. **Extend issue:** Add acceptance criteria to an existing issue
3. **Intentional omission:** Document why this element is being deferred (with person's approval)
```

### Quality bar

The traceability matrix is done when:
- Every section of the masterplan with implementable elements has been audited
- Every discrete element (table column, API endpoint, screen state, flow step, constraint) has a row
- Every GAP has been resolved — either by updating the build plan or by documenting intentional omission
- The build plan has been updated to reflect all new issues/criteria discovered
- Coverage is at 100% (all elements either COVERED or intentionally omitted with documented reason)

---

## SESSION 3 — Prototype

**Goal:** Produce an interactive HTML prototype that shows every key screen and flow in the product. Someone should be able to click through it and understand exactly what the product does and how it works.

**Read first:** The masterplan (for UX flows, screen architecture, and design system) and the build plan (to confirm scope).

**Output:** `[product]_prototype.html`

### How to run Session 3

The prototype is a single self-contained HTML file. No external dependencies except fonts (Google Fonts via CDN is fine). All CSS and JavaScript inline.

The prototype must:
- Show every distinct screen listed in the masterplan's screen architecture section
- Make all navigation between screens interactive (clicking buttons, links, and CTAs should go somewhere)
- Implement the design system from the masterplan (colours, typography, spacing)
- Show real, representative content — not "Lorem ipsum" or "Item 1, Item 2"
- Handle the core user flows end-to-end (the happy path at minimum)
- Show all four key states for data-driven screens: empty state, loading state, populated state, error state
- Match the screen flow diagram from the screen architecture section

The prototype does not need to:
- Connect to any backend
- Persist data between page refreshes
- Handle every edge case

### Quality bar

The prototype is done when:
- Every screen from the masterplan's screen architecture exists in the prototype
- All four states (empty, loading, populated, error) are implemented for data-driven screens
- A first-time user could navigate through the core flow without getting stuck
- The visual design matches the design system in the masterplan
- The content is specific enough to communicate what the product actually does
- The screen navigation matches the screen flow diagram in the masterplan

---

## SESSION 4 — CLAUDE.md

**Goal:** Produce the session rules file that governs every Claude Code session for this product. This file lives in the project root and is read at the start of every build session. It includes five-gate autonomous review, auto-advance, and epic smoke test protocol.

**Read first:** The masterplan (for stack and architecture), the build plan (for issue sequence and current status), and the traceability matrix (to confirm full coverage).

**Output:** `CLAUDE.md`

### How to run Session 4

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

### Quality bar

The CLAUDE.md is done when:
- Every standing constraint reflects a real risk specific to this product's architecture
- The stack rules are unambiguous — no room for Claude Code to "helpfully" substitute something
- The five-gate review protocol is complete with all gate definitions
- Auto-advance is enabled with explicit instructions
- Epic smoke test protocol is defined
- The current status accurately reflects the build state

### CLAUDE.md Guide — Full Reference

#### What CLAUDE.md Is

CLAUDE.md is the session rules file that governs every Claude Code session for the product. It lives in the project root. Claude Code reads it at the start of every session.

Its job is to prevent the most common and costly Claude Code failure modes:
- Using the wrong library or framework ("helpfully" substituting something familiar)
- Skipping to the next issue before the current one is done
- Hardcoding values that should be environment variables
- Making architectural decisions that contradict the masterplan
- Exposing credentials or sensitive values to the wrong layer
- Self-assessing acceptance criteria without actually verifying them
- Missing masterplan specifications during implementation

#### Required Sections

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
Dispatch the code-reviewer agent to review all code changes for the issue against:
- The acceptance criteria
- CLAUDE.md rules (stack, production quality, technical constraints)
- General code quality (error handling, types, no TODOs, no hardcoded values, no console.log)

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

#### CLAUDE.md Tone and Style

- **Direct.** Not "please consider" — "never do X"
- **Specific.** Not "use the right database conventions" — "primary keys are UUID via gen_random_uuid()"
- **Short.** If a rule requires three paragraphs, break it into two rules
- **Technical.** Written for Claude Code, not a human user.

#### What to Leave Out

- Generic software engineering best practices (Claude Code already knows these)
- Rules about things that can't go wrong for this specific product
- Explanations of how the product works (that's the masterplan's job)
- Encouragement or positive framing
- Anything that repeats something already enforced by a build plan acceptance criteria item

#### CLAUDE.md Length

A good CLAUDE.md is typically 120-200 lines (longer than before due to the five-gate protocol and epic smoke test). Much shorter suggests important constraints are missing. Much longer suggests it's including things that don't need to be standing rules.

---

## Handoff Between Sessions

At the end of each session, before closing:

1. Confirm the output document is complete and saved
2. Write a one-paragraph handoff note: what was decided, what the next session needs to know, any open questions to resolve
3. Tell the person what to bring to the next session (usually just the output document, but sometimes a decision they need to make first)

The handoff note is not a separate document. Say it in the conversation.

---

## How to Begin

If the user has provided an idea or context with their input, start with Session 0 — Discovery. Ask them to describe their idea and begin the genuine back-and-forth conversation to understand it deeply.

If the user specifies a particular session (e.g. "run session 2"), read the required input documents first, then proceed with that session.

If no input is provided, ask the user to describe their tech product idea to kick off Session 0.
