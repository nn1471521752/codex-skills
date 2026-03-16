---
name: app-pre-dev-sync
description: Use when starting or resuming work in an app repository that syncs to Obsidian and whose AGENTS.md defines the app's documentation paths, current workflow, and Daily rules.
---

# app-pre-dev-sync

## Purpose

Before changing code in an app repository, compress the current goal, stage, blockers, likely code area, and likely Obsidian sync touchpoints.

## When to use

- The user is about to start coding in an app repository
- The user wants to continue the previous round of app work
- The user asks to sync context before implementation

## When not to use

- The user is doing full-day planning; use the Daily planning workflow instead
- The user only wants to log a milestone into Daily; use `app-worklog-pulse`
- The user already finished implementation and needs documentation writeback; use `app-post-dev-sync`

## Inputs

- Current repository `AGENTS.md`
- Root project docs such as `README.md`, `package.json`, or other obvious entry docs
- Current workday Daily note if it already exists
- The Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` paths defined by the current repo `AGENTS.md`

## Steps

1. Read the current repository `AGENTS.md` first. Treat it as the source of truth for app name, related Obsidian paths, workday cutoff rules, and sync expectations.
2. Read the repository's most relevant local entry docs to understand runtime commands, code layout, and likely change surface.
3. Read the Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` pages referenced by the repository `AGENTS.md`.
4. If the current workday Daily exists, check whether its focus is already aligned to this app; if not, call that out explicitly.
5. Infer the most likely code area to touch from the user's request and the repository structure.
6. Output current goal, current stage, blockers, suggested scope, Daily alignment status, and the most likely Obsidian pages to sync after the work.
7. If blockers in `Hub.md` or `Sprint.md` are placeholder, missing, contradictory, or untrustworthy, output `未知/需确认` instead of inventing blockers.

## Outputs

- Current goal
- Current stage
- Current blockers, or `未知/需确认`
- Suggested implementation scope
- Whether the current workday Daily is aligned
- The most likely Obsidian pages to update later
