---
name: app-worklog-pulse
description: Use when logging a clear in-progress milestone from an app repository into the current workday Daily note, including cases where the round already started but the Daily note has not been created yet.
---

# app-worklog-pulse

## Purpose

Record a meaningful in-progress milestone into the current workday Daily note before the whole task is finished.

This is the default mid-round logging step for app repository work.

## When to use

- A small feature or clear subtask is done
- A blocker was identified
- A reproducible experiment finished
- A decision is important enough to leave a trace today
- Code already changed before Daily planning, and this round now needs a concrete trace in Daily

## When not to use

- The user has not started implementation yet; use `app-pre-dev-sync`
- The user finished the round and needs broader writeback; use `app-post-dev-sync`
- The update is too vague to be worth logging

## Inputs

- The current repository `AGENTS.md`
- A short milestone summary
- Relevant code paths
- The current workday Daily note, or enough context to create the minimal current workday Daily first

## Steps

1. Read the current repository `AGENTS.md` first and use it to identify the app name, the related Obsidian Daily, and the sync rules.
2. Confirm the milestone is concrete enough to log, based on changed files, a reproducible experiment, a blocker with evidence, or a user-confirmed decision.
3. If the current workday Daily note does not exist yet, create a minimal one first using the Vault template/rules, then continue. Do not block on the fact that `daily-planner` did not run earlier.
4. Write the milestone into the same `今日执行记录` section of the current workday Daily note. Do not create project-named supplement sections.
5. Add a `[AppName]` prefix when needed to keep the shared Daily timeline readable.
6. If the milestone already changes project stage, blocker framing, or externally visible behavior, explicitly say that `app-post-dev-sync` should follow and point to the likely project pages.

## Outputs

- Updated or newly created Daily note
- The milestone record that was added
- Whether `app-post-dev-sync` should run next
