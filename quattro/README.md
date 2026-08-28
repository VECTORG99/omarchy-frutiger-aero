# Frutiger Aero — Quattro/Quickshell Theme

This directory contains the **Quattro (v5) compatible** version of the Frutiger Aero theme.
It targets the **Quickshell bar** (`shell/plugins/bar/`) used in Omarchy `omarchy-4` branch.

## Structure

```
quattro/
├── colors.toml          # Light variant color palette
├── colors-dark.toml     # Dark variant color palette
├── shell.json           # Bar layout: widgets, position, plugins
├── waybar.css           # Light: Waybar colors (for manual Waybar installs)
├── waybar-dark.css      # Dark: Waybar colors (for manual Waybar installs)
└── README.md            # This file
```

## Installation

### Via Omarchy (recommended)

```bash
# Clone to Omarchy themes directory
git clone https://github.com/VECTORG99/omarchy-frutiger-aero ~/.config/omarchy/themes/frutiger-aero

# Apply light variant
omarchy theme set "Frutiger Aero"

# Apply dark variant
omarchy theme set "Frutiger Aero Dark"
```

### What gets applied

| File | Target | Purpose |
|------|--------|---------|
| `colors.toml` | `~/.config/omarchy/current/theme/` | Color palette for shell.toml template |
| `colors-dark.toml` | (dark variant) | Same for dark mode |
| `shell.json` | `~/.config/omarchy/shell.json` | Bar layout, widgets, position |

## Features

### Color Palette (Frutiger Aero Signature)
| Token | Light | Dark |
|-------|-------|------|
| Accent (cyan) | `#1299CA` | `#35BCDE` |
| Foreground | `#1A3344` | `#C8F0F0` |
| Background | `#5AACA0` (teal, 40% alpha via template) | `#0A1A2E` (navy, 40% alpha via template) |
| Hyprland border | `rgba(18,153,202,1) → rgba(53,188,222,1) 45deg` | Same |

The template `default/themed/shell.toml.tpl` uses these colors for:
- Bar background/text/active module colors
- Control states (normal/hover/focus/selected)
- Popup, tooltip, notification, launcher, menu, lock surfaces
- Hyprland active border gradient

### Bar Layout (`shell.json`)
- **Position**: Top, transparent (`background-alpha = 1.0` in template, actual transparency via Hyprland)
- **Left**: Workspaces
- **Center**: Clock, Weather, MPRIS, Updates, Screen Recording, Voxtype, Idle
- **Right**: Tray, Bluetooth, Network, Audio, CPU, Battery

### Optional Pill Containers (PR #7251)
When PR #7251 merges, the template will support optional per-section pill containers. Frutiger Aero will automatically get glassmorphism capsules via:

```toml
section-background       = "{{ background }}"
section-background-alpha = 0.40
section-border           = "rgba(18, 153, 202, 1)"
section-border-alpha     = 0.18
section-radius           = 16
section-padding-x        = 8
section-padding-y        = 4
```

## Waybar (Optional)

If you prefer Waybar over Quickshell bar on Quattro:

```bash
pacman -S waybar
# The theme includes waybar.css / waybar-dark.css
# Copy to ~/.config/waybar/ and configure manually
```

## Compatibility

| Omarchy Channel | Bar System | Theme Source |
|-----------------|------------|--------------|
| `stable` / `rc` / `dev` | Waybar | Repo root + `config/omarchy/themes/frutiger-aero*` |
| `omarchy-4` (Quattro) | **Quickshell** | `quattro/` directory |

## Development

The Quattro version uses the **same color palette** as the Waybar version — ensuring visual consistency across both bar systems.

To test on Quattro:
1. Switch to omarchy-4: `cd ~/.local/share/omarchy && git checkout omarchy-4`
2. Update: `omarchy update -y`
3. Install theme: `omarchy theme install https://github.com/VECTORG99/omarchy-frutiger-aero`
4. Apply: `omarchy theme set "Frutiger Aero"`