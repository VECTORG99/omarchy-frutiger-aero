#!/usr/bin/env bash
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

# ── SDDM (optional, requires sudo) ──────────────────────────

if [ -f "$CONFIG_DIR/sddm/Main.qml" ] && command -v sudo &>/dev/null; then
  echo ""
  echo ":: SDDM theme detected."
  if [ -w /usr/share/sddm/themes/omarchy/ ] 2>/dev/null; then
    cp "$CONFIG_DIR/sddm/Main.qml" /usr/share/sddm/themes/omarchy/Main.qml
    echo "   → sddm/  installed"
  else
    echo "   → Run the following to install the SDDM greeter:"
    echo "     sudo cp $CONFIG_DIR/sddm/Main.qml /usr/share/sddm/themes/omarchy/"
  fi
fi

# ── Omarchy theme files ─────────────────────────────────────

echo ""
echo ":: Installing Omarchy themes..."

for variant in frutiger-aero frutiger-aero-dark; do
  SRC="$CONFIG_DIR/omarchy/themes/$variant"
  DST=~/.config/omarchy/themes/"$variant"
  if [ -d "$SRC" ]; then
    mkdir -p "$DST"
    cp -r "$SRC"/* "$DST/"
    echo "   → $variant"
  fi
done

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
killall waybar 2>/dev/null || true
sleep 1
waybar &>/dev/null & disown

echo ""
echo "========================================"
echo "  Done! Frutiger Aero is installed."
echo "========================================"
echo ""
echo "To switch themes:  omarchy theme set \"Frutiger Aero\""
echo "                   omarchy theme set \"Frutiger Aero Dark\""
echo ""
echo "To reload SDDM:    sudo omarchy-refresh-sddm"
