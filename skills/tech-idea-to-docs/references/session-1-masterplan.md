# Session 1 — Masterplan (Full Guide)

**Goal:** Produce a complete product specification that covers everything needed to make architectural, design, and screen-level decisions during the build.

**Read first:** `[product]_discovery.md` (the Session 0 Summary).

**Output:** `[product]_masterplan.md`

## What a Masterplan Is

A masterplan is the complete product specification. It is the single source of truth for every decision made during the build. It is written before a line of code is written, and it answers every question a senior engineer, designer, or product manager would need answered before starting work.

It is not a pitch deck. It is not a PRD. It is a detailed technical and product document written for the people who will build the thing.

## How to run Session 1

The masterplan is not produced by asking the person a list of questions and filling in a template. It is produced through a genuine collaborative process where you contribute expertise and they contribute product vision.

Your job is to:
- Make proposals and let them react ("Here's how I'd structure the database — does this match your mental model?")
- Surface decisions they haven't made yet and help them make them ("You haven't mentioned how the free tier works — let's figure that out now")
- Push back on things that seem architecturally risky ("This approach will work but creates a problem later when you want to add X — want to think through an alternative?")
- Name things they're describing but haven't labelled ("What you're describing is essentially an event sourcing pattern — here's what that means for the schema")

The masterplan should feel like it was written by someone who has thought deeply about this specific product, not like a filled-in template. Vary the structure to fit the product. Not every product needs every section.

## Section Structure

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
3. Re-run the traceability matrix for the affected sections only (use the `traceability-matrix` skill with the partial re-audit scope)
4. Update any build plan issues whose acceptance criteria reference the changed sections
5. Commit the masterplan with a descriptive message referencing the changelog entry

The changelog serves two purposes:
- **Audit trail:** Anyone can see what changed and when, and `git diff` shows the full before/after
- **Re-audit trigger:** When a section appears in the changelog, the traceability matrix must be re-run for that section

- Format: Table with date, sections, summary, and reason columns
- Depth: One row per change event. Summary should be specific enough to understand the change without reading the diff.
- Common mistake: Updating the masterplan without adding a changelog entry. This makes it impossible to know which traceability matrix sections need re-auditing.

## Quality bar

The masterplan is done when every criterion below holds. Before declaring the session done, verify each item explicitly, one by one — general impression is not verification.

**Completeness:** Every section is present and substantive. No "TBD" on anything in the critical path.

**Specificity:** A senior engineer reading it could make every major decision without asking a question. Colour values are hex codes. Field types are actual SQL types. API responses have actual field names. The database schema is complete enough to write migrations from.

**Screen coverage:** Every screen referenced in user flows appears in the screen architecture section, with all four states (empty, loading, populated, error) specified.

**Flow coverage:** Every user-facing flow is described in enough detail to build from.

**Consistency:** The database schema matches the data referenced in the user flows. The features described in the feature set all appear in the flows. The design system values match the component descriptions. The screens in screen architecture match the screens referenced in user flows.

**Testability:** The testing strategy specifies concrete scenarios and exact commands to run tests.

**Setup coverage:** All human setup requirements are catalogued — every API key, account, service, and MCP tool the human needs to set up before the agent can build.

**Honesty about scope:** What the product does NOT do is as clearly specified as what it does.

**Coherence:** The product described in the masterplan is the same product described in the vision.

## Masterplan Length

A thorough masterplan for a medium-complexity product typically lands around 3,000-6,000 lines of Markdown. Treat this as a diagnostic signal, not a target: if you're far below it, check for missing sections; far above it, check for scope creep or repetition. Don't pad. Don't abbreviate. Write to the complexity of the product.

## Closing the session

1. Verify the quality bar item by item (above).
2. Get the person's explicit approval of the masterplan — this is a hard human checkpoint; do not proceed to Session 2 without it.
3. Update `[product]_docs_status.md` (Session 1 complete, next: Session 2) and record the key decisions made.
4. Ask once: "Run Sessions 2 → 2.5 → 3 → 4 straight through, or checkpoint after each document?" Record the answer as `mode:` in the status file.
