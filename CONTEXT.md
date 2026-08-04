# Omarchy Frutiger Aero — Project Context

Updated: 2026-08-04

## State

- Dotfiles/theme repo for [Omarchy](https://github.com/anomalyco/omarchy) on Hyprland (CachyOS base). No build system, no package manager — `install.sh` copies files to `~/.config/`.
- Two theme variants: `frutiger-aero` (light, teal `#5AACA0` bg) and `frutiger-aero-dark` (dark, navy `#0A1A2E` bg), swappable via `omarchy theme set "Frutiger Aero"|"Frutiger Aero Dark"`.
- Built on top of [Omarchy on CachyOS](https://github.com/roboff/omarchy-on-cachynos) by Mr. Roboff — Frutiger Aero customizations are layered on top of that foundation.
- Config domains: `config/hypr/` (Hyprland lua), `config/waybar/` (bar + scripts), `config/omarchy/themes/` (theme files), `eww/` (desktop widgets), `config/opencode/`, `config/helix/`, `config/alacritty/`, `config/fastfetch/`, `config/gtk/`, `config/fontconfig/`.
- Scripts: bash (`config/waybar/scripts/*.sh`, `eww/scripts/*.sh`, `install.sh`) and python3 (`eww/scripts/calendar.sh`).
- CI: GitHub Actions with shellcheck, lua syntax (`luac -p`), and JSON validation (`jq`).
- Wallpapers and binary assets are gitignored (`.gitignore` excludes `*.jpg`, `*.png` except previews, `backgrounds/`, `current/`).

## What Works

- Theme system: `config/omarchy/themes/frutiger-aero/` and `frutiger-aero-dark/` contain `colors.toml`, `hyprland.lua`, `waybar.css`, `walker.css`, `swayosd.css`, `mako.ini`, `hyprlock.conf`, `icons.theme`, `light.mode`. Omarchy generates `~/.config/omarchy/current/theme/` from these.
- Hyprland config: `config/hypr/hyprland.lua` sources Omarchy defaults then loads `monitors.lua`, `input.lua`, `bindings.lua`, `looknfeel.lua`, `autostart.lua`. Uses Omarchy's `hl.config()`, `hl.env()`, `o.bind()`, `o.window()` helpers.
- Waybar: Vista/7-style pill bar at 36px height with glassmorphism. `config/waybar/config.jsonc` defines modules; `style.css` imports theme from `~/.config/omarchy/current/theme/waybar.css`. Custom scripts: `clock.sh`, `uptime.sh`, `power-profile.sh`, `network-speed.sh`.
- EWW widgets: 6 widgets (weather, clock, calendar, music, sysmon, widget-ctl) defined in `eww/eww.yuck`. Scripts in `eww/scripts/`. Light/dark themes via `eww-light.scss`/`eww-dark.scss` symlinked to `eww.scss`.
- Opencode TUI: themes in `config/opencode/themes/`; hook `config/omarchy/hooks/theme-set.d/opencode-theme` auto-switches on theme change.
- Hyprlock: FA redesign with rounded input field, live clock, "Welcome back" greeting, blur over wallpaper.
- Hypridle: 5min brightness 10%, 10min lock, 15min DPMS off, 20min suspend.

## Known Limitations

- `config/hypr/monitors.lua` hardcodes DP-2/DP-3 at specific resolutions — personal hardware config (issue #15).
- `eww/scripts/sysmon-data.sh` requires `nvidia-smi` — no AMD/Intel fallback (issue #14).
- `eww/eww.yuck` sysmon widget hardcodes "/ 32GB" RAM and "/ 1TB" disk totals (issue #16).
- `config/hypr/autostart.lua` references `vista-startup.wav` which is not included in the repo (copyright concerns) (issue #11).
- `config/hypr/input.lua` uses `kb_layout = "latam"` — personal keyboard layout.
- No SDDM theme included despite README mentioning it (issue #8).
- `config/omarchy/current/theme/` was committed to git but is runtime-generated (issue #10).

## Constraints

- Follow `AGENTS.md`: GitHub Issues are source of truth; PRs target `master`; do not push directly to `master`.
- Do not implement local tracking docs (`TODO.md`, backlog files) for pending work.
- Keep docs for agents direct, structured, and file/path-specific.
- Never construct JSON by string concatenation in bash — use `jq -n --arg`.
- Never hardcode personal paths, hardware values, or monitor names — detect at runtime.
- Wallpapers and binary assets are gitignored; do not commit them.
- `config/omarchy/current/` is runtime-generated; do not commit it.
- Lua config must use Omarchy helpers (`hl.config`, `hl.env`, `o.bind`, `o.window`) — not raw Hyprland conf syntax.

## Module Dependency Graph

```text
install.sh
  -> config/waybar/{config.jsonc, style.css, scripts/*.sh}
  -> config/hypr/*.lua
  -> config/alacritty/alacritty.toml
  -> config/fontconfig/fonts.conf
  -> config/gtk/settings.ini
  -> config/helix/config.toml
  -> config/fastfetch/config.jsonc
  -> config/opencode/{tui.json, themes/*.json}
  -> config/omarchy/themes/{frutiger-aero, frutiger-aero-dark}/*
  -> config/omarchy/hooks/theme-set.d/opencode-theme
  -> eww/{eww.yuck, eww-light.scss, eww-dark.scss, scripts/*.sh, assets/}

config/hypr/hyprland.lua
  -> $OMARCHY_PATH/default/hypr/omarchy.lua  (Omarchy defaults)
  -> config/hypr/{monitors, input, bindings, looknfeel, autostart}.lua

config/waybar/style.css
  -> ~/.config/omarchy/current/theme/waybar.css  (theme variables)

eww/eww.yuck
  -> eww/scripts/{weather, clock, calendar, music, sysmon-data, widget-status, widget-ctl, widget-screen}.sh
  -> eww/eww.scss  (symlink to eww-light.scss or eww-dark.scss)
```

## Critical Paths

- Install: `install.sh` copies all config to `~/.config/`, then runs `omarchy theme set "Frutiger Aero"`, `hyprctl reload`, `omarchy-restart-waybar`.
- Theme switch: `omarchy theme set` reads `config/omarchy/themes/<name>/`, generates `~/.config/omarchy/current/theme/`, runs hooks in `~/.config/omarchy/hooks/theme-set.d/`.
- EWW theme sync: `eww/scripts/eww-theme.sh auto` detects light/dark from `omarchy theme current` and symlinks `eww.scss` to the matching `.scss`.
- Widget toggle: `config/hypr/bindings.lua` binds `SUPER+SHIFT+{T,K,L,R,U,Q}` to `eww open <widget> --toggle`.

## Do Not Touch / High-Risk Zones

- `config/omarchy/themes/frutiger-aero/colors.toml` and `frutiger-aero-dark/colors.toml` — palette is the theme contract; changing colors affects all downstream configs.
- `config/hypr/looknfeel.lua` — blur/shadow/animation parameters are tuned for the FA aesthetic; changes affect performance and visual identity.
- `config/waybar/style.css` — glassmorphism gradients and `@keyframes orb-pulse` are the visual signature; changes affect all modules.
- `eww/eww.yuck` — widget geometry and `defpoll` intervals affect EWW daemon stability.
- `.gitignore` — controls which binary assets are excluded; incorrect patterns could commit large files.

## Non-Goals

- Do not add a build system or package manager — this is a dotfiles repo copied by `install.sh`.
- Do not commit wallpapers, `.wav` files, or other binary assets — they are gitignored.
- Do not commit `config/omarchy/current/` — it is runtime-generated.
- Do not hardcode personal hardware values (monitor names, RAM totals, GPU vendor).
- Do not add SDDM theme unless the file is actually included in the repo.
- Do not expand `AGENTS.md` into a full conventions/contributing guide here.

## How To Update This Document

- Update this file in the same PR that changes architecture, theme structure, install flow, or widget architecture.
- Keep entries machine-readable: short bullets, explicit paths, concrete file names, no narrative history.
- Update the `Updated:` line with the edit date.
- If theme file structure changes, keep `config/omarchy/themes/`, `install.sh`, and `docs/CONVENTIONS.md` in sync.
- Run at least `shellcheck` and `luac -p` after editing this document.
