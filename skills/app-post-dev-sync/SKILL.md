---
name: app-post-dev-sync
description: Use when an app repository has real implementation or state changes and those changes need to be written back to the current workday Daily note and the matching Obsidian app pages defined in the repo AGENTS.md.
---

# app-post-dev-sync

## Purpose

After real implementation or project-state changes, sync the necessary facts back to Obsidian.

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
- Changed code paths
- Validation commands or validation method
- Current workday Daily note
- The related `Hub.md`, `Sprint.md`, and `Changelog.md` paths defined in the current repo `AGENTS.md`

## Steps

1. Read the current repository `AGENTS.md` first. Use it as the source of truth for app identity, Obsidian paths, and sync boundaries.
2. Confirm that the round includes real implementation or state changes.
3. Check the current workday Daily note first. If the result is not recorded yet, write it into the same `今日执行记录` section instead of creating project-named supplement sections.
4. Decide whether the round affects project-level goal, stage, blockers, or externally visible behavior.
5. Update `Sprint.md` and `Changelog.md` for concrete implementation progress by default.
6. Only update `Hub.md` when project-level goal, stage, blockers, or release direction actually changed.
7. If the round ends a phase or exposes a repeating issue, check whether a review page should also be updated.
8. Report which pages were updated and why.

## Outputs

- Updated pages
- Why each page changed
- Validation commands or validation method used
- Any pages that probably should still be updated
