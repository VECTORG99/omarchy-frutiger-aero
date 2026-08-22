# Security Policy

## Scope

This repository is a dotfiles/theme pack for [Omarchy](https://github.com/anomaly/omarchy) on Hyprland. It ships config files (`~/.config/`), bash/python scripts, and theme assets. It is not a networked application or library.

Security-relevant areas:

- **`install.sh`** — copies files into `~/.config/`. Review for path traversal or unsafe `cp`/`rm` operations.
- **`config/waybar/scripts/*.sh`** and **`eww/scripts/*.sh`** — shell scripts that may consume external data (network state, weather APIs, system metrics). Review for command injection via untrusted input.
- **`config/hypr/*.lua`** — Hyprland config. No direct security surface, but bindings and window rules affect input handling.
- **Theme files** (`colors.toml`, `*.css`, `*.ini`) — static config, no execution surface.

## Reporting a vulnerability

Open a private security advisory on GitHub:

1. Go to the [Security tab](https://github.com/VECTORG99/omarchy-frutiger-aero/security/advisories/new).
2. Click **Report a vulnerability**.
3. Describe the issue, affected file(s), and reproduction steps.

Do not open a public issue for security vulnerabilities.

## Hardening notes

- Scripts use `set -euo pipefail` where practical.
- JSON is constructed with `jq -n --arg` (no string concatenation).
- No hardcoded credentials, API keys, or personal paths in the repo.
- `install.sh` operates only under `$HOME/.config/` and `$HOME/.local/`.
