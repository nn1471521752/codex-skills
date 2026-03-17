---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from the current branch or an explicit parallel checkout in the same repository
---

# Using Branch Isolation

## Overview

Default to staying inside the current project directory and creating or switching to a dedicated git branch there.

Only create a git worktree when the human explicitly asks for a second checkout, or when parallel directories are necessary.

**Core principle:** branch first in the current workspace. Use a project-local worktree only for explicit parallel checkout. Never default to a global worktree directory.

**Announce at start:** "I'm using the using-git-worktrees skill to set up branch isolation."

## Decision Process

Follow this order:

1. If the human wants all work to stay in the current project directory, or did not ask for parallel checkouts:
   - Stay in the current repository directory.
   - Create or switch to a dedicated branch there.

2. If the human explicitly wants two checkouts at once, or wants to keep one branch open while implementing in another directory:
   - Create a project-local worktree under `.worktrees/<branch>` or `worktrees/<branch>`.

3. Never use `~/.config/superpowers/worktrees/...` as the default location.

## Safety Checks

Before changing anything:

```bash
git branch --show-current
git status --short
```

**If the current directory is dirty:**
- Do not blindly switch branches if that would mix unrelated changes.
- Ask whether the existing changes should move onto the new branch, or whether a project-local worktree is safer.

**If the current branch is `main` or `master`:**
- Create or switch to a dedicated development branch before implementing, unless the human explicitly approved working directly on the base branch.

## Default Setup: Current Directory Branch

Use this by default.

```bash
# Create a new branch in the current project directory
git switch -c codex/<topic>

# Or switch if it already exists
git switch codex/<topic>
```

Then run project setup and baseline verification appropriate for the repository:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

Run the project-appropriate tests or minimal verification before implementation.

Report:

```text
Branch ready at <repo-path> on <branch-name>
Baseline verification complete
Ready to implement <feature-name>
```

## Explicit Parallel Checkout: Project-Local Worktree

Use this only when the human explicitly wants a second checkout.

### Directory Selection

Follow this priority order:

1. Use `.worktrees/` if it already exists.
2. Else use `worktrees/` if it already exists.
3. Else create `.worktrees/` inside the project root.

### Ignore Verification

Project-local worktree directories must be ignored before use.

```bash
git check-ignore -q .worktrees || git check-ignore -q worktrees
```

If the chosen directory is not ignored:
- Prefer adding it to `.git/info/exclude` for a local-only preference.
- Only edit `.gitignore` if the repository already uses a shared project-local worktree convention or the human asked for a repo-wide rule.

### Create Worktree

```bash
git worktree add .worktrees/<branch-name> -b <branch-name>
cd .worktrees/<branch-name>
```

Run the same setup and baseline verification there.

Report:

```text
Project-local worktree ready at <repo-path>/.worktrees/<branch-name>
Baseline verification complete
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| Human did not ask for parallel checkout | Stay in current repo directory and create a branch |
| Human wants all work inside project directory | Stay in current repo directory and create a branch |
| Human explicitly wants two checkouts | Create `.worktrees/<branch>` or `worktrees/<branch>` |
| Project-local worktree directory not ignored | Add local ignore first, then create worktree |
| Current checkout is dirty | Ask before switching branches |
| Current branch is `main` or `master` | Switch to a dedicated branch first |

## Common Mistakes

### Defaulting to a worktree

- **Problem:** Creates an extra checkout when the human only wanted a git branch.
- **Fix:** Branch in the current project directory unless parallel checkout was explicitly requested.

### Using a global worktree path

- **Problem:** Spreads one project across unrelated filesystem locations.
- **Fix:** Never default to `~/.config/superpowers/worktrees/...`.

### Switching branches in a dirty checkout without checking

- **Problem:** Carries unrelated changes onto the new branch or blocks the switch.
- **Fix:** Inspect `git status --short` first and ask if the intent is unclear.

### Creating a project-local worktree that is not ignored

- **Problem:** Worktree contents pollute repository status.
- **Fix:** Add a local ignore rule before creating the worktree.

## Example Workflow

```text
You: I'm using the using-git-worktrees skill to set up branch isolation.

[Check current branch and git status]
[Create branch: git switch -c codex/auth-fix]
[Run baseline verification]

Branch ready at /path/to/repo on codex/auth-fix
Baseline verification complete
Ready to implement auth fix
```

## Red Flags

**Never:**
- Default to creating a separate worktree when the human only asked for a branch
- Default to a global worktree directory
- Start implementation on `main` or `master` without explicit approval
- Switch branches in a dirty checkout without checking intent
- Create a project-local worktree before confirming it is ignored

**Always:**
- Prefer the current project directory
- Use a dedicated branch by default
- Reserve worktrees for explicit parallel checkout
- Keep any auxiliary worktree under the project root

## Integration

**Called by:**
- **brainstorming** - When design is approved and implementation follows
- **subagent-driven-development** - Before executing implementation tasks
- **executing-plans** - Before executing a written plan
- Any workflow that needs branch isolation

**Pairs with:**
- **finishing-a-development-branch** - Cleans up the branch, and any auxiliary worktree if one was used
