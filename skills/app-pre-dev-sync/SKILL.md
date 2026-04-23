---
name: app-pre-dev-sync
description: Use when starting, resuming, or backfilling work in an app repository that syncs to Obsidian, especially if the repo already has unsynced changes or the current workday Daily has not been created yet.
---

# app-pre-dev-sync

## Purpose

Before changing code in an app repository, or when code was already changed before sync, first make sure the current workday Daily has a usable same-day plan, then compress the current goal, stage, blockers, likely code area, and likely Obsidian sync touchpoints.

This is the default entry point for app repository work. Prefer it over older vault-local pre-dev sync skills.

## When to use

- The user is about to start coding in an app repository
- The user wants to continue the previous round of app work
- The user asks to sync context before implementation
- The repository already has dirty files but this round has not been synced to Obsidian yet
- The current workday Daily does not exist yet and this round needs a minimal anchor before continuing
- The current workday Daily exists but still has no usable same-day plan for this app round

## When not to use

- The user is explicitly doing full-day planning from the Vault perspective; use the Daily planning workflow instead
- The user only wants to log a milestone into Daily; use `app-worklog-pulse`
- The user already finished implementation and needs documentation writeback; use `app-post-dev-sync`

## Inputs

- Current repository `AGENTS.md`
- Root project docs such as `README.md`, `package.json`, or other obvious entry docs
- Current workday Daily note if it already exists; otherwise create it from the Vault template first
- The most recent previous workday Daily with real execution evidence when today's plan must be backfilled
- The Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` paths defined by the current repo `AGENTS.md`

## Steps

1. Read the current repository `AGENTS.md` first. Treat it as the source of truth for app name, related Obsidian paths, workday cutoff rules, and sync expectations.
2. Read the repository's most relevant local entry docs and inspect the current repo working state (for example current branch and dirty files) to understand runtime commands, code layout, and likely change surface before coding.
3. Read the Obsidian `Hub.md`, `Sprint.md`, and `Changelog.md` pages referenced by the repository `AGENTS.md`.
4. Determine the current workday Daily by the repo `AGENTS.md` rules. If the Daily does not exist, create it from the Vault template first. At minimum preserve correct frontmatter plus these sections: `今天最重要的任务`、`今天分配给哪个应用`、`今天内容线推进到哪一步`、`今日执行记录`、`收尾复盘`。
5. Treat today's Daily as blocked until it contains a usable same-day plan. A usable plan means the note is not just placeholder text and already has concrete content for `今天最重要的任务` and `今天分配给哪个应用`; if those sections are missing, empty, or obviously still placeholder, backfill the day's plan before continuing app sync.
6. When backfilling the day's plan from an app repository context, use the current app as the default focus app, infer the top tasks from repo evidence plus `Hub.md` / `Sprint.md`, and keep the plan narrow: at most 3 important tasks, one current content-line status, and the most likely pages to sync later. Do not invent a fake full-day story beyond the evidence you have.
7. If the repository already has dirty files or other evidence that implementation started before sync, treat this as a backfill/resume round instead of blocking on “you should have planned first”. Use repo evidence to infer the likely current objective, write that objective into the Daily plan gate, and call out uncertainty explicitly.
8. If the current workday Daily exists or was just created, check whether its focus is already aligned to this app; if not, call that out explicitly and note whether it is `已补建`、`已补计划`、`待补齐`、or `已对齐`.
9. All Daily creation or rewrite must use explicit UTF-8. Do not rely on PowerShell default encoding or `>` / `>>` / `Out-File` / `Set-Content` defaults. After writing, immediately re-open the Daily and verify key Chinese headings did not degrade into `?`. If a newly created untracked Daily is clearly corrupted and cannot be reconstructed from trustworthy evidence, delete that broken file and recreate it cleanly instead of preserving the corrupted content.
10. Infer the most likely code area to touch from the user's request and the repository structure.
11. If Obsidian project pages conflict with recent Daily facts or obvious repo state, call the conflict out explicitly instead of inventing a single clean story.
12. Output current goal, current stage, blockers, suggested scope, Daily alignment status, whether the Daily had to be created, whether the day's plan had to be backfilled, and the most likely Obsidian pages to sync after the work.
13. If blockers in `Hub.md` or `Sprint.md` are placeholder, missing, contradictory, or untrustworthy, output `未知/需确认` instead of inventing blockers.

## Outputs

- Current goal
- Current stage
- Current blockers, or `未知/需确认`
- Suggested implementation scope
- Whether the current workday Daily is aligned
- Whether the current workday Daily had to be created
- Whether the same-day plan had to be backfilled before app sync
- The most likely Obsidian pages to update later
