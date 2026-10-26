# Omarchy Frutiger Aero

A light Frutiger Aero theme for [Omarchy](https://github.com/omacom/omarchy): a teal and sky-blue
palette, glossy Waybar pills and a matching lockscreen.

![Frutiger Aero](preview.png)

## Install

```bash
omarchy theme install https://github.com/VECTORG99/omarchy-frutiger-aero
```

This repository holds only theme files, so that command is all there is to it.
Switch back and forth with `omarchy theme set`.

## What's in it

| File | What it styles |
|------|----------------|
| `colors.toml` | Palette (accent, background, foreground, color0–15) |
| `waybar.css`, `waybar.style` | Bar colors and the pill style |
| `walker.css` | App launcher |
| `mako.ini` | Notifications |
| `swayosd.css` | Volume and brightness OSD |
| `hyprlock.conf`, `unlock.png` | Lockscreen |
| `icons.theme` | Icon theme name |
| `light.mode` | Marks this as a light theme |
| `preview.png`, `preview-unlock.png` | Previews for the theme switcher |

### Palette

| Token | Hex |
|-------|-----|
| Background | `#5AACA0` |
| Foreground | `#1A3344` |
| Accent | `#1299CA` |

## Wallpapers

No wallpapers are bundled. The Frutiger Aero wallpapers this theme was made with
are not freely licensed, so they were removed. Add your own to
`~/.config/omarchy/backgrounds/frutiger-aero/`.

## Extras

The dark variant, the Vista-style Hyprland and Waybar configs and the EWW desktop
widgets are code, so they live in their own repository with their own installer:
[omarchy-frutiger-aero-extras](https://github.com/VECTORG99/omarchy-frutiger-aero-extras).
Read it before you run it; it replaces files in `~/.config`.

## Credits

- [Omarchy](https://github.com/omacom/omarchy)
- [Omarchy on CachyOS](https://github.com/roboff/omarchy-on-cachyos) by [Mr. Roboff](https://github.com/roboff), the base this was built on

## License

The theme files are [MIT](LICENSE), Copyright (c) 2026 Diego Hernandez.
