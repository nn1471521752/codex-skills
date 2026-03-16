# Codex Skills Repo Design

Date: 2026-03-16

## Goal

Create one git-managed repository that acts as the source of truth for the user's Codex global skills across home and work environments.

## Decisions

1. Use a dedicated repository at `E:\codex-skills`.
2. Mirror the current global skill roots:
   - `C:\Users\Administrator\.codex\skills`
   - `C:\Users\Administrator\.codex\superpowers`
3. Add reusable app-level global skills so project repositories no longer need their own duplicated `pre-dev-sync`, `worklog-pulse`, and `post-dev-sync`.
4. Keep machine-local config, auth, logs, sqlite, and session state out of git.
5. Use an install script to sync repository content back into the local Codex home on each machine.

## Migration Plan

1. Snapshot current global skill directories into this repository.
2. Add generic app-level global skills:
   - `app-pre-dev-sync`
   - `app-worklog-pulse`
   - `app-post-dev-sync`
3. Install those skills into `C:\Users\Administrator\.codex\skills`.
4. Update project `AGENTS.md` files to reference the new global skills.
5. Remove duplicated project-local skill folders.

## Tradeoffs

- This repository now controls the local snapshot of `.system` and `superpowers` skill content.
- If upstream Codex updates those built-in skills, the user must choose when to re-sync or merge those changes into this repository.
- The benefit is deterministic cross-machine reproducibility.
