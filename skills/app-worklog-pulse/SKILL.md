---
name: app-worklog-pulse
description: Use when logging a clear in-progress milestone from an app repository into the current workday Daily note, using the current repo AGENTS.md as the source of truth for app identity and Obsidian paths.
---

# app-worklog-pulse

## Purpose

Record a meaningful in-progress milestone into the current workday Daily note before the whole task is finished.

## When to use

- A small feature or clear subtask is done
- A blocker was identified
- A reproducible experiment finished
- A decision is important enough to leave a trace today

## When not to use

- The user has not started implementation yet; use `app-pre-dev-sync`
- The user finished the round and needs broader writeback; use `app-post-dev-sync`
- The update is too vague to be worth logging

## Inputs

- The current repository `AGENTS.md`
- A short milestone summary
- Relevant code paths
- The current workday Daily note

## Steps

1. Read the current repository `AGENTS.md` first and use it to identify the app name, the related Obsidian Daily, and the sync rules.
2. Confirm the milestone is concrete enough to log.
3. Write the milestone into the same `今日执行记录` section of the current workday Daily note. Do not create project-named supplement sections.
4. Add a `[AppName]` prefix when needed to keep the shared Daily timeline readable.
5. If the milestone already changes project stage, blockers, or externally visible behavior, explicitly say that `app-post-dev-sync` should follow.

## Outputs

- Updated Daily note
- The milestone record that was added
- Whether `app-post-dev-sync` should run next
