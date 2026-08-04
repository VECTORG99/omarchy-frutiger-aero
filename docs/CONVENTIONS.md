# Convenciones

## Estructura del repositorio

```
config/
  hypr/           — Hyprland config (lua, usa helpers hl.config, hl.env, o.bind, o.window)
  waybar/         — Barra de estado (config.jsonc + style.css + scripts/)
  omarchy/themes/ — Archivos de tema (colors.toml, hyprland.lua, waybar.css, etc.)
  opencode/       — Temas TUI
  helix/          — Editor config
  alacritty/      — Terminal config
  fastfetch/      — System info config
  gtk/            — GTK settings
  fontconfig/     — Font rendering
eww/              — Widgets EWW (eww.yuck + scripts/ + assets/)
install.sh        — Instalador de un comando
AGENTS.md         — Directivas para agentes IA
CONTEXT.md        — Contexto del proyecto
docs/             — Documentación
```

## Bash

- Usar `set -euo pipefail` al inicio de scripts.
- **Nunca** construir JSON por concatenación de strings. Usar `jq -n --arg`:
  ```bash
  jq -n --arg t "$TITLE" '{title:$t}'
  ```
- Usar `$HOME` o `~`, nunca rutas personales como `/home/vector`.
- Detectar hardware en runtime, no hardcodear (ej: `command -v nvidia-smi`).
- Escapar input externo antes de procesarlo.
- Para escritura de cache, usar archivo temporal + `mv` atómico:
  ```bash
  echo "$data" > "$CACHE.tmp" && mv "$CACHE.tmp" "$CACHE"
  ```

## Lua (Hyprland)

- Usar helpers de Omarchy: `hl.config()`, `hl.env()`, `hl.monitor()`, `o.bind()`, `o.window()`.
- No usar sintaxis raw de Hyprland conf.
- Antes de rebindear una tecla existente, usar `hl.unbind()` primero.
- Comentarios en español o inglés, mantener estilo del archivo.

## CSS (Waybar/EWW)

- Waybar: importar variables de tema desde `~/.config/omarchy/current/theme/waybar.css`.
- Usar variables `@background`, `@foreground`, `@accent` — no hardcodear colores.
- EWW: usar `eww-light.scss`/`eww-dark.scss` con variables, no estilos inline.

## JSON

- `config/waybar/config.jsonc` es JSONC (JSON con comentarios) — válido con `jq`.
- `config/opencode/themes/*.json` es JSON estándar.
- `config/fastfetch/config.jsonc` es JSONC.

## Git/PR

- Branches: `fix/*`, `feat/*`, `docs/*`, `chore/*`.
- Commits: usar formato conventional (`fix:`, `feat:`, `docs:`, `chore:`).
- Un PR por issue — mantener cambios atómicos.
- PRs target `master`.
- No push directo a `master`.
- No commitar `config/omarchy/current/` (runtime-generated).
- No commitar binarios (wallpapers, `.wav`) — están en `.gitignore`.

## Testing

- `shellcheck` en todos los scripts bash modificados.
- `luac -p` en todos los archivos lua modificados.
- `jq .` en todos los archivos JSON/JSONC modificados.
- CI ejecuta estos checks automáticamente en PRs.
