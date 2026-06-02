# Omarchy Frutiger Aero

A fully swappable **Frutiger Aero** theme set for [Omarchy](https://github.com/VECTORG99/omarchy-on-cachyos) on CachyOS/Hyprland.

Includes light and dark variants with glassmorphism, transparent windows, strong blur, and authentic Frutiger Aero wallpapers.

## Preview

| Light (`frutiger-aero`) | Dark (`frutiger-aero-dark`) |
|------------------------|-----------------------------|
| Teal background, dark text | Navy background, light text |

### Light palette

| Token | Color | Hex |
|-------|-------|-----|
| Background | Teal | `#5AACA0` |
| Foreground | Dark teal | `#1A3344` |
| Accent | Blue | `#1299CA` |
| Yellow (ANSI 3) | Amber | `#A08020` |
| Comments | Dark blue-gray | `#2A4A58` |

### Dark palette

| Token | Color | Hex |
|-------|-------|-----|
| Background | Navy | `#0A1A2E` |
| Foreground | Light teal | `#C8F0F0` |
| Accent | Cyan-blue | `#35BCDE` |

## What's included

```
config/
├── hypr/              # Hyprland: blur, opacity, gaps, keybinds, monitors
├── waybar/            # Vista/7-style pill modules, 36px, glass backgrounds
├── alacritty/         # Terminal: 85% opacity, JetBrainsMono 10.5px
├── omarchy/
│   ├── themes/
│   │   ├── frutiger-aero/      # Light theme
│   │   └── frutiger-aero-dark/ # Dark theme
│   └── current/theme/          # Active generated theme
├── opencode/          # Opencode TUI frutiger-aero dark theme
├── helix/             # Editor syntax colors
├── gtk/               # Fira Sans 10
└── fontconfig/        # Fira Sans default, hintslight, antialiasing
scripts/
└── analyze-screenshot.sh  # ImageMagick + Tesseract color/text analyzer
```

## Visual features

- **Windows**: Active fully opaque (1.0), inactive transparent (0.72) with blur
- **Blur**: Size 10, passes 5, vibrancy 0.30, `ignore_opacity=true`
- **Terminal glass**: Alacritty at 85% opacity with wallpaper peeking through
- **Waybar**: 36px height, pill-shaped modules (border-radius 14px), individual glass backgrounds with gradients
- **Opencode TUI**: Dark theme matching the Aero palette, readable code blocks

## Installation

```bash
# Clone into omarchy themes
git clone https://github.com/VECTORG99/omarchy-frutiger-aero.git
cp -r omarchy-frutiger-aero/config/omarchy/themes/frutiger-aero* ~/.config/omarchy/themes/
cp omarchy-frutiger-aero/config/waybar/* ~/.config/waybar/
cp omarchy-frutiger-aero/config/hypr/* ~/.config/hypr/
cp omarchy-frutiger-aero/config/alacritty/* ~/.config/alacritty/
cp omarchy-frutiger-aero/config/opencode/* ~/.config/opencode/
cp omarchy-frutiger-aero/config/helix/* ~/.config/helix/
cp omarchy-frutiger-aero/config/gtk/* ~/.config/gtk-3.0/
cp omarchy-frutiger-aero/config/fontconfig/* ~/.config/fontconfig/

# Set theme via omarchy
omarchy theme set "Frutiger Aero"

# Reload Hyprland + restart Waybar
hyprctl reload
pkill waybar && waybar
```

## Fonts

- **System**: [Fira Sans](https://fonts.google.com/specimen/Fira+Sans) — clean, modern sans-serif
- **Terminal/editor**: [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads) — developer-friendly monospace
- Fontconfig configured with `hintslight`, `rgba=rgb`, `lcdfilter=default`

## Wallpapers

6 authentic 4K Frutiger Aero wallpapers per theme (blue water, teal aura, green valley, mountain lake, sunset forest). Sourced from [Wallhaven](https://wallhaven.cc/).

## System

- **OS**: CachyOS (Arch-based)
- **WM**: Hyprland 0.55
- **GPU**: NVIDIA RTX 3060
- **Displays**: LG 27" 1440p (DP-2) + Samsung 24" 1080p (DP-3)
- **Terminal**: Alacritty
- **Editor**: Helix

## License

MIT
