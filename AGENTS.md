# Omarchy Frutiger Aero — AI Agent Directives

Audience: AI agents changing this repository. Keep this file as the entrypoint; use linked docs for full detail.

## Required Reading Order

1. `AGENTS.md` — execution rules, workflow, protected branches.
2. `CONTEXT.md` — required before architecture, theme, Hyprland, Waybar, EWW, or install changes.
3. `docs/CONVENTIONS.md` — required before code changes; shell, lua, CSS, Git/PR style.
4. `docs/CONTRIBUTING.md` — contributor recipes and PR quality gate.
5. `SECURITY.md` — required before security-related changes.

## Project Context

- Dotfiles/theme repo for [Omarchy](https://github.com/anomalyco/omarchy) on Hyprland; no build system, no package manager — files are copied to `~/.config/` by `install.sh`.
- Two theme variants: `frutiger-aero` (light) and `frutiger-aero-dark` (dark), swappable via `omarchy theme set`.
- Config domains: `config/hypr/` (Hyprland lua), `config/waybar/` (bar + scripts), `config/omarchy/themes/` (theme files), `eww/` (desktop widgets), `config/opencode/`, `config/helix/`, `config/alacritty/`, `config/fastfetch/`, `config/gtk/`, `config/fontconfig/`.
- Scripts are bash (`config/waybar/scripts/`, `eww/scripts/`) and python (`eww/scripts/calendar.sh` is python3).
- No tests currently; CI validates shell scripts (shellcheck), lua syntax, and JSON structure.
- Wallpapers and binary assets are gitignored (downloaded separately).

## Code Conventions Summary

- Bash scripts use `set -euo pipefail` where practical; never construct JSON by string concatenation — use `jq -n --arg`.
- Lua config uses Omarchy's `hl.config()`, `hl.env()`, `o.bind()`, `o.window()` helpers — do not use raw Hyprland conf syntax.
- CSS uses Omarchy theme variables (`@background`, `@foreground`, `@accent`) imported from `~/.config/omarchy/current/theme/waybar.css`.
- EWW widgets use `defpoll` for data and `defwidget` for rendering; scripts output JSON.
- No hardcoded personal paths (`/home/vector`, `/home/diego`); use `$HOME` or `~`.
- No hardcoded hardware values (monitor names, RAM totals, GPU vendor); detect at runtime or use defaults.
- Keep the smallest safe change; no new dependency, abstraction, or config unless needed now.

## AI Workflow

| Step      | Rule                                                                                                                  |
| --------- | --------------------------------------------------------------------------------------------------------------------- |
| Issue     | GitHub Issues are the only source of truth. Create/identify the issue and priority label before work.                 |
| Branch    | Base work on `origin/master`; use `fix/*`, `feat/*`, `docs/*`, or `chore/*`.                                          |
| Implement | Scope changes to the issue; no local tracking docs (`TODO.md`, `BACKLOG.md`) or drive-by refactors.                   |
| Test      | Run `shellcheck` on modified scripts, `luac -p` on modified lua, `jq` on modified JSON; run CI locally if possible.   |
| PR        | Push branch and open PR to `master` with `Closes #N`, summary, validation, deviations/blockers.                       |
| Review    | Inspect overlapping open PRs/issues before PR; resolve conflicts autonomously when safe.                              |
| Merge     | Merge only through `gh pr merge`; never push directly to `master`.                                                    |

## Testing Commands

Run from repository root.

| Command                                       | Use                                                        |
| --------------------------------------------- | ---------------------------------------------------------- |
| `shellcheck config/waybar/scripts/*.sh eww/scripts/*.sh install.sh` | Validate all bash scripts.                    |
| `luac -p config/hypr/*.lua hyprland.lua config/omarchy/themes/*/*.lua` | Validate lua syntax (does not check Omarchy helpers).     |
| `jq . config/waybar/config.jsonc`             | Validate waybar JSONC.                                     |
| `jq . config/opencode/themes/*.json`          | Validate opencode theme JSON.                              |
| `python3 -c "import json; json.load(open('config/fastfetch/config.jsonc'))"` | Validate fastfetch JSON.          |
| `bash -n install.sh`                          | Syntax check install script.                               |

## Useful Commands

| Command                                       | Use                                           |
| --------------------------------------------- | --------------------------------------------- |
| `git checkout -B <branch> origin/master`      | Start/reset an issue branch.                  |
| `git status --short`                          | Inspect pending changes.                      |
| `git diff`                                    | Review unstaged diff before commit/PR.        |
| `gh issue list -R VECTORG99/omarchy-frutiger-aero` | Check issue overlap.                     |
| `gh pr list -R VECTORG99/omarchy-frutiger-aero`   | Check PR overlap.                        |
| `gh pr create -R VECTORG99/omarchy-frutiger-aero` | Open required PR.                        |

## Rules

- No direct pushes to `master`; all changes go through PRs.
- Do not duplicate full docs here; extend `CONTEXT.md`, `docs/CONVENTIONS.md`, `docs/CONTRIBUTING.md` when detail belongs there.
- Do not create unnecessary docs or decorative README prose; agent docs stay direct, structured, path-specific.
- Tests/CI after changes are required; if a check cannot run, document the blocker in PR.
- Config/security changes require matching docs updates and no secret output.
- CI runs on all branches/PRs; fix failing checks before requesting merge.
- Destructive GitHub operations require confirmation: `gh repo delete`, `gh pr merge --admin`, `gh release delete`.
- Never commit binary assets (wallpapers, `.wav`, `.png` except preview screenshots) — they are gitignored.
- Never commit `config/omarchy/current/` — it is runtime-generated by Omarchy.

## GitHub CLI Permissions

Allowed without confirmation: `gh issue create/list/close/edit`, `gh pr create/list/view/diff/checks/edit/merge` without `--admin`, `gh run list/view/rerun`, `gh label create/list`.
