---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work
---

# Finishing a Development Branch

## Overview

Guide completion of development work by presenting clear options and handling the chosen workflow.

**Core principle:** verify tests, present options, execute the choice, clean up only what actually exists.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## The Process

### Step 1: Verify Tests

**Before presenting options, verify tests pass:**

```bash
# Run the project's test suite
npm test / cargo test / pytest / go test ./...
```

**If tests fail:**

```text
Tests failing (<N> failures). Must fix before completing:

[Show failures]

Cannot proceed with merge or PR until tests pass.
```

Stop. Do not proceed to Step 2.

### Step 2: Determine Base Branch

```bash
# Try common base branches
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask: "This branch split from main - is that correct?"

### Step 3: Present Options

Present exactly these 4 options:

```text
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

Do not add explanation.

### Step 4: Execute Choice

#### Option 1: Merge Locally

```bash
# Switch to base branch
git checkout <base-branch>

# Pull latest
git pull

# Merge feature branch
git merge <feature-branch>

# Verify tests on merged result
<test command>

# If tests pass
git branch -d <feature-branch>
```

Then: Cleanup any auxiliary worktree if one was used (Step 5)

#### Option 2: Push and Create PR

```bash
# Push branch
git push -u origin <feature-branch>

# Create PR
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

Then: Cleanup any auxiliary worktree if one was used (Step 5)

#### Option 3: Keep As-Is

Report: "Keeping branch <name> as-is."

If an auxiliary worktree was used, keep it.

#### Option 4: Discard

**Confirm first:**

```text
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Auxiliary worktree at <path> (if one exists)

Type 'discard' to confirm.
```

Wait for exact confirmation.

If confirmed:

```bash
git checkout <base-branch>
git branch -D <feature-branch>
```

Then: Cleanup any auxiliary worktree if one was used (Step 5)

### Step 5: Cleanup Any Auxiliary Worktree

For Options 1, 2, and 4:

```bash
git worktree list
```

If the feature branch is checked out in an auxiliary path, remove that worktree:

```bash
git worktree remove <worktree-path>
```

If the branch only exists in the main project directory, there is no worktree cleanup step.

For Option 3: keep the branch, and keep the auxiliary worktree too if one was used.

## Quick Reference

| Option | Merge | Push | Keep Auxiliary Worktree | Cleanup Branch |
|--------|-------|------|-------------------------|----------------|
| 1. Merge locally | yes | no | no | yes |
| 2. Create PR | no | yes | no | no |
| 3. Keep as-is | no | no | only if one exists | no |
| 4. Discard | no | no | no | yes (force) |

## Common Mistakes

**Skipping test verification**
- **Problem:** Merge broken code or create a failing PR
- **Fix:** Always verify tests before offering options

**Open-ended questions**
- **Problem:** "What should I do next?" is ambiguous
- **Fix:** Present exactly 4 structured options

**Assuming every branch has a worktree**
- **Problem:** Tells the human about paths or cleanup steps that do not exist in a current-directory branch workflow
- **Fix:** Only mention worktree cleanup when an auxiliary worktree was actually used

**No confirmation for discard**
- **Problem:** Accidentally delete work
- **Fix:** Require typed `discard` confirmation

## Red Flags

**Never:**
- Proceed with failing tests
- Merge without verifying tests on the merged result
- Delete work without confirmation
- Force-push without explicit request

**Always:**
- Verify tests before offering options
- Present exactly 4 options
- Get typed confirmation for Option 4
- Clean up auxiliary worktrees only when they actually exist

## Integration

**Called by:**
- **subagent-driven-development** - After all tasks complete
- **executing-plans** - After all batches complete

**Pairs with:**
- **using-git-worktrees** - Cleans up any auxiliary project-local worktree created by that skill
