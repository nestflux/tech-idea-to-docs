# Session 3 — Prototype (Full Guide)

**Goal:** Produce an interactive HTML prototype that shows every key screen and flow in the product. Someone should be able to click through it and understand exactly what the product does and how it works.

**Read first:** The masterplan (for UX flows, screen architecture, and design system) and the build plan (to confirm scope).

**Output:** `[product]_prototype.html`

## How to run Session 3

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

## Verification Gate (required before the session is done)

The prototype is the one artifact that is easy to declare "done" from general impression. Don't. Run both passes below and fix every FAIL before marking the session complete.

### Pass 1 — Screen Architecture cross-reference

Use the element-extraction method from the `masterplan-cross-reference-audit` skill, applied to the prototype HTML instead of production code:

1. Open the masterplan's Screen Architecture section and extract every discrete element: every screen, every major component on each screen, every state (empty/loading/populated/error), every navigation link in the screen flow diagram.
2. For each element, check the prototype implements it. Search the HTML — do not rely on memory of what you built.
3. Report per element: `[CLEAN]` or `[GAP] [what the masterplan specifies] → [what is missing in the prototype]`.
4. Fix all gaps, then re-check the previously-failed elements.

### Pass 2 — Browser walkthrough

Open the prototype in a browser (it's a static HTML file — open it directly, no dev server needed) and apply the `browser-verification` skill's evidence-based method:

1. Walk each core user flow from the masterplan end-to-end, clicking through the actual navigation.
2. Toggle each data-driven screen through its four states and confirm each renders as specified.
3. Spot-check the design system: key colours, typography, and spacing match the masterplan's values.
4. Check the console for errors.
5. Record `[PASS]`/`[FAIL]` per check **with evidence** — what you observed, not what you implemented. "I implemented it" is not evidence.
6. Fix all FAILs and re-verify.

## Quality bar

The prototype is done when every criterion below holds. Before declaring the session done, verify each item explicitly, one by one — general impression is not verification.

- Every screen from the masterplan's screen architecture exists in the prototype (Pass 1 clean)
- All four states (empty, loading, populated, error) are implemented for data-driven screens (Pass 1 clean)
- A first-time user could navigate through the core flow without getting stuck (Pass 2 verified)
- The visual design matches the design system in the masterplan (Pass 2 verified)
- The content is specific enough to communicate what the product actually does
- The screen navigation matches the screen flow diagram in the masterplan (Pass 1 + Pass 2 verified)

## Closing the session

1. Confirm both verification passes are clean.
2. Update `[product]_docs_status.md` (Session 3 complete, next: Session 4).
3. Proceed per the recorded mode: straight-through → continue to Session 4; checkpoint-each → report and wait.
