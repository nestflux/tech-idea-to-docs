---
name: memory-stack
description: Sets up a 5-layer memory architecture for Claude Code -- persistent session state, git context injection, behavioral learning, pre-action gates, and optional knowledge base mounting. Use when starting a new project and want Claude Code to remember across sessions, or when you want to install/update the memory system. Trigger for phrases like "set up memory", "install memory stack", "add recall", "configure hooks", "set up gates", "add obsidian vault", or any time someone wants Claude Code to persist state and learn across sessions.
argument-hint: "setup" to install, "gates add [description]" to add a gate, "status" to check installation, "update" to update hooks/skill
---

# Memory Stack v1.0.0

A 5-layer memory architecture for Claude Code that persists state across sessions, injects live context, learns from corrections, and physically blocks known-bad actions.

User's input: $ARGUMENTS

## How It Works

```
[Session starts]
  |
Layer 1  CLAUDE.md loads             --> "how should I behave?"
Layer 2  primer.md loads             --> "where did we leave off?"
Layer 3  SessionStart hook fires     --> "what changed in the codebase?"
Layer 4  Hindsight recall fires      --> "what patterns should I follow?"
Layer 5  Obsidian vault mounts       --> "what's in the knowledge base?"
  |
Claude sees everything before you type a word.
  ...you work...
  ...primer.md auto-rewrites after each completed task...
  ...primer.md "Currently Working On" updates at task start...
  |
[Context compacts mid-session]
  |
PostCompact hook fires               --> re-injects git context + patterns
Active gates reminded                --> Claude knows what is blocked
  |
[Tool call attempted]
  |
PreToolUse gate fires                --> checks global + project gates.json
  blocked? deny + stderr message     --> physically prevented
  allowed? proceed                   --> normal execution
  activation logged to gate-log.json --> session-end includes summary
  |
[Session ends]
  |
Layer 4  Hindsight retain fires      --> stores enriched session summary
  (includes: diff stat, lessons, gate activations)
Auto-failure tracker runs            --> scans lessons.md for corrections
  3+ same mistake?                   --> auto-promotes to warning gate
Gate log cleared                     --> fresh for next session
```

## The 5 Layers

| # | Layer | What it does | How it loads | Updates |
|---|-------|-------------|--------------|---------|
| 1 | **CLAUDE.md** | Permanent rules, preferences, agent behavior | Auto, every session | You edit manually |
| 2 | **primer.md** | Active project, currently working on, last task, next step, blockers | Auto (imported by CLAUDE.md) | Rewrites after each task |
| 3 | **Git Context** | Branch, commits, modified files, commit log | SessionStart hook | Fresh every launch |
| 4 | **Hindsight** | Behavioral learning from past sessions | SessionStart + SessionEnd hooks | Learns automatically |
| 5 | **Obsidian** | Full knowledge base as context | Shell alias or OBSIDIAN_VAULT env var | You add notes |
| -- | **Gates** | Blocks known-bad actions before execution (global + project) | PreToolUse hook | Auto-promotes from corrections |
| -- | **Gate Log** | Records all gate activations (block/warn) | Pre-action gate hook | Cleared at session end |

---

## Routing -- What to Do Based on User Input

**If input is "setup" or "install" or empty:** Run the full setup process (below).

**If input is "status":** Check installation status -- which layers are installed, which are missing, whether hooks are configured, whether Hindsight is running, whether gates are loaded, version check.

**If input starts with "gates":** Manage gates -- "gates add [description]" to add a new gate, "gates list" to show current gates, "gates remove [name]" to disable a gate.

**If input is "obsidian [path]":** Configure the Obsidian vault layer with the given path.

**If input is "hindsight":** Guide through Hindsight (Docker) setup.

**If input is "update":** Re-run setup, updating hooks and gates without overwriting CLAUDE.md or primer.md. Check version against installed version.

---

## Version Checking

The current version is **1.0.0**. The installed version is stored at `~/.claude/memory-stack.version`.

On "status" or "update" commands:
1. Read `~/.claude/memory-stack.version`
2. Compare against the VERSION variable in this skill (1.0.0)
3. If the installed version is older, prompt: "Memory Stack update available (installed: X, latest: Y). Run `setup.sh` from the memory-stack repo to update."
4. If the file is missing, report version as "unknown (pre-versioning install)"

---

## Full Setup Process

Run these steps in order. Check what already exists before creating anything -- never overwrite existing files without asking.

### Step 1: Detect Current State

Check for existing installations:

```
~/.claude/CLAUDE.md            -- global agent rules (Layer 1)
~/.claude/primer.md            -- session state (Layer 2)
~/.claude/hooks/               -- hook scripts (Layers 3+4)
~/.claude/gates.json           -- pre-action gates (global)
~/.claude/failures.json        -- failure tracker
~/.claude/gate-log.json        -- gate activation log
~/.claude/memory-stack.version -- installed version
~/.claude/settings.json        -- hook configuration
```

Also detect the current project's documentation:
- Look for `CLAUDE.md` in the project root (project-level rules)
- Look for `.claude/gates.json` in the project root (project-level gates)
- Look for `*_masterplan.md`, `*_buildplan.md`, `*_traceability_matrix.md` in `docs/` or project root
- Look for `.env`, `.env.example` to identify sensitive variable names for gates
- Check if the project is a git repository

Report what was found before proceeding.

### Step 2: Layer 1 -- Global CLAUDE.md

If `~/.claude/CLAUDE.md` does not exist, create it with the following content. If it already exists, check whether it contains the primer.md import and agent rules -- add only what's missing.

```markdown
@primer.md

# PREFERENCES
- One clear next action per response, not a list
- Flag anything uncertain with [UNCLEAR]
- Remind me to commit at session end

# AGENT RULES
- Read primer.md before doing anything else
- If primer.md is empty or missing, ask what we're working on
- Keep primer.md under 100 lines
- Never ask for context that exists in imported files
- Before starting any task, update the "Currently Working On" field in primer.md. This survives crashes.
- After completing any task (not just session end), silently overwrite ~/.claude/primer.md with: active project, what's been completed, exact next step, open blockers. Keep under 100 lines. This ensures primer.md survives abrupt exits.
- Before closing, check for uncommitted changes and remind me to commit.
- When the conversation reaches 70% of the context window, automatically rewrite ~/.claude/primer.md with the current state, then tell me to run /compact before continuing.

# SELF-LEARNING
- After any correction from me, immediately add an entry to tasks/lessons.md
- Format: [date] | what went wrong | rule to follow next time
- Read tasks/lessons.md at the start of every session before doing anything
- Apply every rule before touching any code

# WORKFLOW
- Enter plan mode for any non-trivial task (3+ steps)
- If something goes wrong mid-task, stop and re-plan
- Never mark a task complete without proving it works
- When given a bug: just fix it, no hand-holding
- Commit at logical checkpoints, not just at the end
```

**Important:** The global CLAUDE.md contains behavior rules that apply to ALL projects. Project-specific rules (stack, constraints, critical path) stay in the project-level CLAUDE.md. Do not mix them.

### Step 3: Layer 2 -- primer.md

If `~/.claude/primer.md` does not exist, create it:

```markdown
# Active Project: (auto-populated after first session)

## Currently Working On
- (updates at task start, before work begins)

## Completed This Session
- (none yet)

## Exact Next Step
Run your first Claude Code session. This file will rewrite itself automatically.

## Open Blockers
- None
```

If it already exists, leave it alone -- it contains live session state. However, if the "Currently Working On" section is missing, add it after the "Active Project" line.

### Step 4: Layers 3+4 -- Hook Scripts

Create `~/.claude/hooks/` directory if it doesn't exist, then write these four scripts:

- **session-start.sh** -- Injects git context + Hindsight recall + Obsidian vault check + version display
- **session-end.sh** -- Enriched Hindsight retain (diff stat, lessons, gate log) + auto-failure tracking
- **post-compact.sh** -- Re-injects git context, Hindsight patterns, active gates (global + project)
- **pre-action-gate.sh** -- Checks global + project gates.json, logs activations to gate-log.json

Make all hook scripts executable with `chmod +x ~/.claude/hooks/*.sh`.

### Step 5: Gates

**Global gates** at `~/.claude/gates.json` -- if it does not exist, create it with starter gates. If it exists, do NOT overwrite (user may have custom gates).

**Project-level gates** at `.claude/gates.json` (relative to git root) -- these are optional. The pre-action-gate.sh hook will check both files and merge them at runtime. Project gates are checked AFTER global gates. If either blocks, the action is blocked.

To create project-level gates, create `.claude/gates.json` in the project root with project-specific patterns.

Then, detect project-specific gates to add. Scan the project for:

1. **Project-level CLAUDE.md rules that should become gates.** Look for "never" and "always" rules that can be enforced by pattern matching.
2. **`.env` or `.env.example` variable names.** Any variable containing KEY, SECRET, TOKEN, or PASSWORD should be added to the credentials gate pattern.
3. **Stack prohibitions.** Only create gates for things that can be pattern-matched in tool inputs.

Ask the user before adding project-specific gates. Show them what you'd add and let them approve.

### Step 6: Merge Hook Configuration into settings.json

Read the existing `~/.claude/settings.json`. Merge the hooks configuration INTO the existing file, preserving all existing keys (permissions, plugins, etc.).

The hooks to add:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume",
        "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/hooks/session-start.sh\"", "timeout": 15 }]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "",
        "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/hooks/pre-action-gate.sh\"", "timeout": 5 }]
      }
    ],
    "PostCompact": [
      {
        "matcher": "",
        "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/hooks/post-compact.sh\"", "timeout": 10 }]
      }
    ],
    "SessionEnd": [
      {
        "matcher": "",
        "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/hooks/session-end.sh\"", "timeout": 10 }]
      }
    ]
  }
}
```

**Critical:** Do NOT replace the settings.json. MERGE the `hooks` key into the existing object. Use a read-modify-write approach.

### Step 7: Failures & Gate Log Tracker

If `~/.claude/failures.json` does not exist, create it: `{"failures":{}}`
If `~/.claude/gate-log.json` does not exist, create it: `{"log":[]}`

### Step 8: Version File

Write `~/.claude/memory-stack.version` with the current version: `1.0.0`

### Step 9: Layer 5 -- Obsidian (Optional)

Ask the user if they have an Obsidian vault they want to mount. If yes:

1. Get the vault path
2. Set OBSIDIAN_VAULT env var in shell rc
3. Detect their shell rc file (`~/.zshrc` or `~/.bashrc`)
4. Check if a `claude` alias already exists
5. If not, add: `alias claude='claude --add-dir "/path/to/vault"'`
6. Tell them to open a new terminal for the alias to take effect

If no, skip this step.

### Step 10: Layer 4 -- Hindsight (Optional)

Ask the user if they want to set up Hindsight (requires Docker). If yes, guide them:

1. Check if Docker is installed and running
2. Check if a `hindsight` container already exists
3. If not, check for `ANTHROPIC_API_KEY` environment variable
4. Run the Docker container or provide the command to run
5. Create the memory bank

If no, skip -- the hooks gracefully degrade without Hindsight.

### Step 11: Verify Installation

After setup, run a verification check:

```
Layer 1 (CLAUDE.md):     [INSTALLED / MISSING]
Layer 2 (primer.md):     [INSTALLED / MISSING]
  - "Currently Working On" field: [PRESENT / MISSING]
Layer 3 (Git hooks):     [INSTALLED / MISSING]
Layer 4 (Hindsight):     [RUNNING / NOT RUNNING / SKIPPED]
Layer 5 (Obsidian):      [CONFIGURED / SKIPPED]
Gates (global):          [N gates active]
Gates (project):         [N gates active / NONE]
Gate Log:                [INITIALIZED / MISSING]
Hooks in settings.json:  [SessionStart / PreToolUse / PostCompact / SessionEnd]
Failures tracker:        [INITIALIZED / MISSING]
Version:                 [X.X.X / MISSING]
```

Tell the user to start a new `claude` session to activate the hooks.

---

## Gate Management

### Adding a Gate

When the user says "gates add [description]", create a gate entry:

1. Parse the description to identify: what tool, what pattern, block or warn
2. Generate the gate JSON object
3. Read `~/.claude/gates.json`, append to the `gates` array, write back
4. Confirm what was added

### Listing Gates

Read `~/.claude/gates.json` and display all gates in a table. Also check for project-level gates at `.claude/gates.json` (relative to git root).

```
### Global Gates (~/.claude/gates.json)
| Name | Tool | Pattern | Level | Enabled |
|------|------|---------|-------|---------|
| no-force-push | Bash | push.*--force | block | yes |

### Project Gates (.claude/gates.json)
| Name | Tool | Pattern | Level | Enabled |
|------|------|---------|-------|---------|
| (none) |
```

### Removing/Disabling a Gate

Set `"enabled": false` on the gate. Do not delete it -- the user might re-enable it later.

---

## What Survives What

| Event | Layers 1-2 | Layer 3 | Layer 4 | Layer 5 | Gates | Gate Log |
|-------|-----------|---------|---------|---------|-------|----------|
| New session | Loaded fresh | Loaded fresh | Loaded fresh | Loaded fresh | Active | Persists |
| Context compaction | Safe (system prompt) | **Re-injected by PostCompact** | **Re-injected by PostCompact** | Safe (system prompt) | Active (hook-level) | Persists |
| Terminal crash | primer.md has last state | Lost (re-injected next session) | Lost (re-injected next session) | Safe | Active | Persists |
| Session end | Safe | Safe | Summarized to Hindsight | Safe | Active | Cleared |
| Model switch | Safe | Safe | Safe | Safe | Active | Persists |

---

## Adapting to Any Project

The memory-stack is project-agnostic by design. Here's how each layer adapts:

- **Layer 1 (CLAUDE.md):** Global rules live at `~/.claude/CLAUDE.md`. Project-specific rules live in the project's own `CLAUDE.md`. Both load automatically. No conflict.
- **Layer 2 (primer.md):** Rewrites itself based on whatever project is active. "Currently Working On" updates before each task begins.
- **Layer 3 (Git context):** Reads from whatever git repo the session is launched in. Automatically adapts.
- **Layer 4 (Hindsight):** One memory bank stores patterns from all projects. Enriched retain payloads include diff stats, lessons, and gate activations.
- **Layer 5 (Obsidian):** Your vault is your vault -- it mounts regardless of which project you're in. Detected via OBSIDIAN_VAULT env var or shell alias.
- **Gates (global):** `~/.claude/gates.json` applies everywhere.
- **Gates (project):** `.claude/gates.json` in the project root applies only to that project. Checked after global gates.
- **Gate Log:** `~/.claude/gate-log.json` records all activations across projects, cleared at session end.

---

## How to Begin

If the user provided "setup" or no argument, start the full setup process from Step 1.

If the user provided "status", run Step 11 (verification) only, including version check.

If the user provided "gates [subcommand]", handle gate management.

If the user provided "obsidian [path]", run Step 9 only.

If the user provided "hindsight", run Step 10 only.

If the user provided "update", re-run Steps 4-8 (hooks, gates, settings merge, failures tracker, version) without touching Layers 1-2. Compare versions and report what changed.
