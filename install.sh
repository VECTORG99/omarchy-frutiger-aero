#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$REPO_DIR/config"

echo "========================================"
echo "  Frutiger Aero — Omarchy Theme Install"
echo "========================================"

# ── Global configs ──────────────────────────────────────────

echo ":: Installing global configs..."

# Waybar
echo "   → waybar/"
mkdir -p ~/.config/waybar/scripts
cp "$CONFIG_DIR/waybar/style.css" ~/.config/waybar/style.css
cp "$CONFIG_DIR/waybar/config.jsonc" ~/.config/waybar/config.jsonc
for f in "$CONFIG_DIR/waybar/scripts/"*.sh; do
  cp "$f" ~/.config/waybar/scripts/
  chmod +x ~/.config/waybar/scripts/"$(basename "$f")"
done

# Remove waybar scripts that no longer ship in the repo (e.g. caffeine.sh,
# pomodoro.sh, playerctl-cover.sh removed in #12). Keeps the install
# idempotent: stale files from a previous version don't survive an upgrade.
for installed in ~/.config/waybar/scripts/*.sh; do
  [ -f "$installed" ] || continue
  name="$(basename "$installed")"
  if [ ! -f "$CONFIG_DIR/waybar/scripts/$name" ]; then
    rm "$installed"
    echo "   → removing stale waybar script: $name"
  fi
done

# Hyprland
echo "   → hypr/"
mkdir -p ~/.config/hypr
cp "$CONFIG_DIR/hypr/"* ~/.config/hypr/

# Alacritty
echo "   → alacritty/"
mkdir -p ~/.config/alacritty
cp "$CONFIG_DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

# Fontconfig
echo "   → fontconfig/"
mkdir -p ~/.config/fontconfig
cp "$CONFIG_DIR/fontconfig/fonts.conf" ~/.config/fontconfig/fonts.conf

# GTK
echo "   → gtk/"
mkdir -p ~/.config/gtk-3.0
cp "$CONFIG_DIR/gtk/settings.ini" ~/.config/gtk-3.0/settings.ini

# Helix
echo "   → helix/"
mkdir -p ~/.config/helix
cp "$CONFIG_DIR/helix/config.toml" ~/.config/helix/config.toml

# Fastfetch
echo "   → fastfetch/"
mkdir -p ~/.config/fastfetch
cp "$CONFIG_DIR/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

# Opencode
echo "   → opencode/"
mkdir -p ~/.config/opencode/themes
cp "$CONFIG_DIR/opencode/tui.json" ~/.config/opencode/tui.json 2>/dev/null || true
cp "$CONFIG_DIR/opencode/themes/"*.json ~/.config/opencode/themes/



# ── EWW Widgets ─────────────────────────────────────────────

echo ""
echo ":: Installing EWW widgets..."

EWW_DIR="$REPO_DIR/eww"
if [ -d "$EWW_DIR" ]; then
  mkdir -p ~/.config/eww/assets/icons ~/.config/eww/scripts
  cp "$EWW_DIR/eww.yuck" ~/.config/eww/eww.yuck
  cp "$EWW_DIR/eww-dark.scss" ~/.config/eww/eww-dark.scss
  cp "$EWW_DIR/eww-light.scss" ~/.config/eww/eww-light.scss
  ln -sf ~/.config/eww/eww-dark.scss ~/.config/eww/eww.scss
  cp "$EWW_DIR/scripts/"* ~/.config/eww/scripts/
  chmod +x ~/.config/eww/scripts/*.sh
  [ -d "$EWW_DIR/assets" ] && cp -r "$EWW_DIR/assets/"* ~/.config/eww/assets/
  echo "   → eww/ (weather, clock, calendar, music, sysmon, control panel)"
else
  echo "   → eww/ not found — skipping widgets"
fi

# ── Omarchy theme files ─────────────────────────────────────

echo ""
echo ":: Installing Omarchy themes..."

# Light variant lives at the repo root so the repo is installable via
# `omarchy theme install <url>` (omarchy-theme-install clones to
# ~/.config/omarchy/themes/<name> and omarchy-theme-set copies the root).
LIGHT_DST=~/.config/omarchy/themes/frutiger-aero
mkdir -p "$LIGHT_DST"
cp -r "$REPO_DIR"/colors.toml "$REPO_DIR"/hyprland.lua "$REPO_DIR"/hyprlock.conf \
      "$REPO_DIR"/icons.theme "$REPO_DIR"/light.mode "$REPO_DIR"/mako.ini \
      "$REPO_DIR"/preview.png "$REPO_DIR"/preview-unlock.png "$REPO_DIR"/swayosd.css \
      "$REPO_DIR"/unlock.png "$REPO_DIR"/walker.css "$REPO_DIR"/waybar.css \
      "$LIGHT_DST/"
echo "   → frutiger-aero"

# Dark variant stays under config/ (not installable via the URL route).
DARK_SRC="$CONFIG_DIR/omarchy/themes/frutiger-aero-dark"
DARK_DST=~/.config/omarchy/themes/frutiger-aero-dark
if [ -d "$DARK_SRC" ]; then
  mkdir -p "$DARK_DST"
  cp -r "$DARK_SRC"/* "$DARK_DST/"
  echo "   → frutiger-aero-dark"
fi

# ── Omarchy hooks ───────────────────────────────────────────

echo ""
echo ":: Installing Omarchy hooks..."

HOOK_SRC="$CONFIG_DIR/omarchy/hooks"
HOOK_DST=~/.config/omarchy/hooks
if [ -d "$HOOK_SRC" ]; then
  mkdir -p "$HOOK_DST/theme-set.d"
  for f in "$HOOK_SRC"/theme-set.d/*; do
    [ -f "$f" ] || continue
    cp "$f" "$HOOK_DST/theme-set.d/"
    chmod +x "$HOOK_DST/theme-set.d/$(basename "$f")"
    echo "   → theme-set.d/$(basename "$f")"
  done
else
  echo "   → hooks/ not found — skipping"
fi

# ── Apply theme ─────────────────────────────────────────────

echo ""
if command -v omarchy &>/dev/null; then
  echo ":: Applying Frutiger Aero theme..."
  omarchy theme set "Frutiger Aero" 2>/dev/null || echo "   (theme set command timed out — run manually: omarchy theme set \"Frutiger Aero\")"
else
  echo ":: omarchy not found — copy theme files manually:"
  echo "     cp -r ~/.config/omarchy/themes/frutiger-aero/* ~/.config/omarchy/current/theme/"
fi

# ── Reload ──────────────────────────────────────────────────

echo ""
echo ":: Reloading Hyprland and restarting Waybar..."
hyprctl reload 2>/dev/null || true
omarchy-restart-waybar 2>/dev/null || true

echo ""
echo "========================================"
echo "  Done! Frutiger Aero is installed."
echo "========================================"
echo ""
echo "To switch themes:  omarchy theme set \"Frutiger Aero\""
echo "                   omarchy theme set \"Frutiger Aero Dark\""
echo ""
echo "To reload SDDM:    sudo omarchy-refresh-sddm"
