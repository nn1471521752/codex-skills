---
name: app-pre-dev-sync
description: Use when starting, resuming, or backfilling work in an app repository that syncs to Obsidian, especially if the repo already has unsynced changes or the current workday Daily has not been created yet.
---

# app-pre-dev-sync

## Purpose

Before changing code in an app repository, or when code was already changed before sync, compress the current goal, stage, blockers, likely code area, and likely Obsidian sync touchpoints.

This is the default entry point for app repository work. Prefer it over older vault-local pre-dev sync skills.

## When to use

- The user is about to start coding in an app repository
- The user wants to continue the previous round of app work
- The user asks to sync context before implementation
- The repository already has dirty files but this round has not been synced to Obsidian yet
- The current workday Daily does not exist yet and this round needs a minimal anchor before continuing

## When not to use

- The user is doing full-day planning; use the Daily planning workflow instead
- The user only wants to log a milestone into Daily; use `app-worklog-pulse`
- The user already finished implementation and needs documentation writeback; use `app-post-dev-sync`

## Inputs

- Current repository `AGENTS.md`
- Root project docs such as `README.md`, `package.json`, or other obvious entry docs
- Current workday Daily note if it already exists; otherwise create or backfill the minimal current workday Daily note first
- The Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` paths defined by the current repo `AGENTS.md`

## Steps

1. Read the current repository `AGENTS.md` first. Treat it as the source of truth for app name, related Obsidian paths, workday cutoff rules, and sync expectations.
2. Read the repository's most relevant local entry docs and inspect the current repo working state (for example current branch and dirty files) to understand runtime commands, code layout, and likely change surface before coding.
3. Read the Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` pages referenced by the repository `AGENTS.md`.
4. Determine the current workday Daily by the repo `AGENTS.md` rules. If the Daily does not exist, create a minimal Daily first using the Vault template when available; at minimum include correct frontmatter plus these sections: `今天最重要的任务`、`今天分配给哪个应用`、`今天内容线推进到哪一步`、`今日执行记录`、`收尾复盘`。
5. If the repository already has dirty files or other evidence that implementation started before sync, treat this as a backfill/resume round instead of blocking on “you should have planned first”. Use repo evidence to infer the likely current objective and call out uncertainty explicitly.
6. If the current workday Daily exists or was just created, check whether its focus is already aligned to this app; if not, call that out explicitly and note whether it is `已补建`、`待补齐`、or `已对齐`.
7. Infer the most likely code area to touch from the user's request and the repository structure.
8. If Obsidian project pages conflict with recent Daily facts or obvious repo state, call the conflict out explicitly instead of inventing a single clean story.
9. Output current goal, current stage, blockers, suggested scope, Daily alignment status, whether a minimal Daily had to be created, and the most likely Obsidian pages to sync after the work.
10. If blockers in `Hub.md` or `Sprint.md` are placeholder, missing, contradictory, or untrustworthy, output `未知/需确认` instead of inventing blockers.

## Outputs

- Current goal
- Current stage
- Current blockers, or `未知/需确认`
- Suggested implementation scope
- Whether the current workday Daily is aligned
- Whether the current workday Daily had to be created or backfilled
- The most likely Obsidian pages to update later
