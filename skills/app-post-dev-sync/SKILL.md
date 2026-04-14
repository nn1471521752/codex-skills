---
name: app-post-dev-sync
description: Use when an app repository has real implementation or state changes and those changes need to be written back to the current workday Daily note and the matching Obsidian app pages defined in the repo AGENTS.md.
---

# app-post-dev-sync

## Purpose

After real implementation or project-state changes, sync the necessary facts back to Obsidian.

Use repository evidence before summaries. This is the default writeback step for app repository work.

## When to use

- Code is changed
- Behavior, stage, blockers, or scope changed
- The user asks to sync the app result back to Obsidian

## When not to use

- The user is still planning
- No real code or state change happened
- The user only wants a single milestone logged; use `app-worklog-pulse`

## Inputs

- Current repository `AGENTS.md`
- Change summary
- Repository evidence such as current branch/working tree state, changed code paths, or the relevant commit for this round
- Validation commands or validation method, plus their actual result
- Current workday Daily note
- The related `Hub.md`, `Sprint.md`, and `Changelog.md` paths defined in the current repo `AGENTS.md`

## Steps

1. Read the current repository `AGENTS.md` first. Use it as the source of truth for app identity, Obsidian paths, and sync boundaries.
2. Collect concrete repo evidence first: current working tree state, changed files, and when relevant the commit or branch that contains the round's result.
3. Confirm that the round includes real implementation or project-state changes. If there is no concrete evidence, say so explicitly and do not invent documentation updates from chat summary alone.
4. Check the validation evidence for this round. Treat missing or weak verification as something to report, not something to hide.
5. Check the current workday Daily note first. If the result, blocker, or decision is not recorded yet, write it into the same `今日执行记录` section instead of creating project-named supplement sections.
6. Decide page updates by scope:
   - `Sprint.md`: default for current-round progress, blocker movement, priority changes, or implementation direction changes
   - `Changelog.md`: when behavior, workflow, API, UI, or other downstream-visible result changed
   - `Hub.md`: only when project-level goal, stage, blocker framing, or release direction actually changed
7. If existing project pages conflict with recent Daily facts or repo evidence, prefer repo evidence plus recent Daily and correct stale wording instead of copying it forward.
8. If the round ends a phase or exposes a repeating issue, check whether a review page should also be updated.
9. Report which pages were updated, which pages were checked but left unchanged, and why.

## Outputs

- Updated pages
- Why each page changed
- Repository evidence used
- Validation commands or validation method used
- Pages checked but left unchanged, and why
- Any pages that probably should still be updated
