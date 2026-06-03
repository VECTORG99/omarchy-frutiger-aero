# Omarchy Frutiger Aero

A fully swappable **Frutiger Aero** theme set for [Omarchy](https://github.com/anomalyco/omarchy) on Hyprland.

This theme is built on top of [Omarchy on CachyOS](https://github.com/roboff/omarchy-on-cachyos) by [Mr. Roboff](https://github.com/roboff) — my Omarchy system base. All Frutiger Aero customizations are layered on top of that foundation.

Includes light and dark variants with glassmorphism, blurred translucent windows, Vista/7-style Waybar, Alacritty terminal glass, authentic FA wallpapers (Asadal + Perfect Hue), SDDM Frutiger Aero greeter, Vista startup chime, matching cursor/icon themes, and Opencode TUI themes.

Both themes are fully swappable via `omarchy theme set` — includes preview images for the theme switcher UI. One-command install with `install.sh`.

## Preview

| Light (`frutiger-aero`) | Dark (`frutiger-aero-dark`) |
|------------------------|-----------------------------|
| Teal `#5AACA0` bg, `#1A3344` fg | Navy `#0A1A2E` bg, `#C8F0F0` fg |
| Medium saturated teal + dark text | Deep navy + light teal text |

### Light palette

| Token | Color | Hex |
|-------|-------|-----|
| Background | Medium teal | `#5AACA0` |
| Foreground | Dark navy | `#1A3344` |
| Accent | Blue | `#1299CA` |
| Yellow (ANSI 3) | Amber | `#A08020` |
| Comments | Dark blue-gray | `#1A3A48` |

### Dark palette

| Token | Color | Hex |
|-------|-------|-----|
| Background | Deep navy | `#0A1A2E` |
| Foreground | Light teal | `#C8F0F0` |
| Accent | Cyan-blue | `#35BCDE` |

## Visual features

### Waybar (Vista/7-style pill bar)

- **Height**: 36px (auto-expands to 39px min with margin)
- **Background**: Translucent teal at 40% opacity with FA decorative gradient overlay (purple → blue → green → blue → purple)
- **Shape**: Pill modules with `border-radius: 14px`, individual glass gradient backgrounds with white shine (`inset 0 1px 0`)
- **Hover**: Glow effect on all modules (box-shadow + brighter gradient)
- **Workspaces**: Pulse animation (`orb-pulse` 3s) on occupied workspaces
- **Start button**: Radial-gradient omarchy icon on left
- **Bar decorative**: FA bubble gradient visible through translucent background

**Modules:**
- `custom/omarchy` — Start menu button
- `hyprland/workspaces` — Workspace indicators with pulse
- `custom/clock` — Custom script (12h, English locale, AM/PM) horizontal + vertical
- `mpris` — Media player with player-icons (Spotify , mpv/vlc , Firefox ), position via `{dynamic}`
- `idle_inhibitor` — Toggle idle (lock/unlock icons, green glow when active)
- `custom/weather` — Current weather
- `custom/update` — Package update indicator
- `custom/uptime` — System uptime
- `custom/power-profile` — Cycle power modes (power-saver/balanced/performance)
- `custom/audio-eq` — Unicode bar audio visualizer (PipeWire detection via `Corked: no`)
- `custom/network-speed` — Download/upload via `/proc/net/dev`
- `custom/voxtype` — Voice recording/transcription indicator
- `custom/screenrecording-indicator` — Screen recording status
- `custom/notification-silencing-indicator` — DND toggle
- `tray`, `bluetooth`, `network`, `pulseaudio`, `cpu`, `battery` — System indicators

### Hyprland

- **Border**: 3px width, `rounding_power: 2.5`
- **Active window**: 3-color gradient border (teal → cyan → aqua)
- **Inactive windows**: `opacity 0.72` with blur
- **Shadow**: Teal glow, `range: 14`
- **Animations**: `faBounce` custom bezier curve for windows
- **Workspaces**: Slide animation
- **Layer blur**: Enabled for mako notifications

### Hyprlock (lockscreen)

- **Frutiger Aero redesign**: Rounded input field (16px radius) with teal glow shadow
- **Live clock/date**: Middle of screen
- **"Welcome back"**: Greeting above input
- **Blur**: 4 passes, size 12, over current wallpaper

### Hypridle

- 5min → Brightness 10%
- 10min → Lock screen
- 15min → DPMS off
- 20min → Suspend

### Alacritty (terminal)

- **Opacity**: 85% (wallpaper shows through)
- **Font**: JetBrainsMono Nerd Font 10.5px
- **Theme**: Imports omarchy active theme colors

### SDDM (login screen)

- **Frutiger Aero glass design**: FastBlur radius 48
- **Glass panel**: Gradient translucent panel with teal border `#1299CA`
- **Header shine**: White gradient highlight
- **Clock**: Fira Sans, Spanish date
- **Password field**: Rounded (14px) with teal glow
- **Login button**: Hover/pressed states with teal gradient
- **Session selector**: Available in panel
- **Footer**: "Frutiger Aero" branding

### Opencode TUI

| Theme | Background | Text |
|-------|-----------|------|
| `frutiger-aero` | Dark navy `#0A1A2E` | Light teal `#C8F0F0` |
| `frutiger-aero-light` | Light teal `#5AACA0` | Dark navy `#1A3344` |

### Startup sound

Vista startup chime plays 2s after login via `paplay --volume=45000` (autostart.lua).

### Icons & Cursors

- **Icons**: Yaru-prussiangreen (dark teal-green glossy, Frutiger Aero match)
- **Cursor**: Bibata-Modern-Ice (ice blue glass)

### Fonts

- **System**: [Fira Sans](https://fonts.google.com/specimen/Fira+Sans) 10px
- **Terminal/editor**: [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)
- **Fontconfig**: `hintslight`, `rgba=rgb`, `lcdfilter=default`

### Fastfetch

- Modified `keyColor` from `magenta` to `yellow` for contrast on teal backgrounds

### Wallpapers

14 authentic Frutiger Aero wallpapers per theme:

| Source | Count | Resolution |
|--------|-------|------------|
| Asadal (blue water, teal aura, green valley, mountain lake, sunset forest) | 9 | 4000×2000+ |
| Perfect Hue | 5 | 3840×2160 (true 4K) |

Active wallpaper set via `~/.config/omarchy/current/background` symlink.

## What's included

```
config/
├── hypr/
│   ├── hyprland.lua        # WM configuration
│   ├── hyprlock.conf        # Lockscreen
│   ├── hypridle.conf        # Idle daemon
│   ├── looknfeel.lua        # Visual (borders, shadows, blur, cursor)
│   ├── monitors.lua         # Display layout
│   ├── input.lua            # Input devices
│   ├── bindings.lua         # Keybindings
│   └── autostart.lua        # Auto-start programs + startup sound
├── waybar/
│   ├── config.jsonc         # Module layout
│   ├── style.css            # Frutiger Aero styles
│   └── scripts/
│       ├── clock.sh         # Custom clock (12h, English)
│       ├── uptime.sh        # System uptime
│       ├── power-profile.sh # Power mode cycling
│       ├── audio-eq.sh      # Unicode audio visualizer
│       └── network-speed.sh # Network speed monitor
├── alacritty/
│   └── alacritty.toml       # 85% opacity terminal
├── fontconfig/
│   └── fonts.conf           # Fira Sans, hinting
├── gtk/
│   └── settings.ini         # GTK icon/cursor theme
├── opencode/
│   ├── tui.json             # TUI config
│   └── themes/
│       ├── frutiger-aero.json
│       └── frutiger-aero-light.json
├── helix/
│   └── config.toml          # Editor colors
├── fastfetch/
│   └── config.jsonc         # System info display
├── sddm/
│   └── Main.qml             # Frutiger Aero SDDM greeter
└── omarchy/
    ├── themes/
    │   ├── frutiger-aero/       # Light theme (colors, backgrounds, styles)
    │   └── frutiger-aero-dark/  # Dark theme
    └── current/theme/           # Active generated theme
scripts/
└── analyze-screenshot.sh    # ImageMagick + Tesseract color/text analyzer

install.sh                   # One-command installer
```

## Installation

### Quick install (recommended)

```bash
git clone https://github.com/VECTORG99/omarchy-frutiger-aero.git
cd omarchy-frutiger-aero
./install.sh
```

### Manual install

```bash
# Clone
git clone https://github.com/VECTORG99/omarchy-frutiger-aero.git
cd omarchy-frutiger-aero

# Global configs
cp config/waybar/*.css ~/.config/waybar/
cp config/waybar/*.jsonc ~/.config/waybar/
cp -r config/waybar/scripts ~/.config/waybar/
cp config/hypr/* ~/.config/hypr/
cp config/alacritty/* ~/.config/alacritty/
cp config/opencode/* ~/.config/opencode/
cp -r config/opencode/themes ~/.config/opencode/
cp config/helix/* ~/.config/helix/
cp config/gtk/* ~/.config/gtk-3.0/
cp config/fontconfig/* ~/.config/fontconfig/
cp config/fastfetch/* ~/.config/fastfetch/

# Theme files (swappable via omarchy theme set)
cp -r config/omarchy/themes/frutiger-aero* ~/.config/omarchy/themes/

# SDDM (requires sudo)
sudo cp config/sddm/Main.qml /usr/share/sddm/themes/omarchy/

# Apply
omarchy theme set "Frutiger Aero"
hyprctl reload
pkill waybar && waybar
sudo omarchy-refresh-sddm
```

## System

- **OS**: CachyOS (Arch-based)
- **WM**: Hyprland 0.55 (Lua config)
- **GPU**: NVIDIA RTX 3060 (12 GB)
- **CPU**: AMD Ryzen 5 5500
- **Displays**: LG 27" 1440p (DP-2) + Samsung 24" 1080p (DP-3)
- **Audio**: PipeWire
- **Terminal**: Alacritty
- **Editor**: Helix
- **Shell**: Fish

## License

MIT
