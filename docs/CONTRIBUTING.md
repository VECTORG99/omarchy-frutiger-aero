# Contribuir

## Empezando

1. Fork el repositorio
2. Clona tu fork: `git clone https://github.com/<tu-usuario>/omarchy-frutiger-aero.git`
3. Crea una branch: `git checkout -b fix/mi-fix`
4. Haz tus cambios
5. Test: `shellcheck config/waybar/scripts/*.sh eww/scripts/*.sh` y `luac -p config/hypr/*.lua`
6. Commit: `git commit -m "fix: descripción del fix"`
7. Push: `git push origin fix/mi-fix`
8. Abre un PR a `master`

## Antes de contribuir

- Lee `AGENTS.md` y `CONTEXT.md` para entender el proyecto.
- Lee `docs/CONVENTIONS.md` para el estilo de código.
- Revisa los issues existentes para evitar duplicar trabajo.
- Un PR por issue — mantén los cambios atómicos.

## Reglas clave

- **No hardcodear** rutas personales (`/home/...`), valores de hardware (monitores, RAM, GPU), ni layouts de teclado.
- **No construir JSON por concatenación** — usar `jq -n --arg`.
- **No commitar** `config/omarchy/current/` ni binarios (wallpapers, `.wav`).
- **Usar helpers de Omarchy** en lua (`hl.config`, `o.bind`) — no sintaxis raw de Hyprland.
- **Testear** con `shellcheck` y `luac -p` antes de abrir PR.

## CI Checks

El CI ejecuta automáticamente:

- **shellcheck**: valida todos los scripts bash.
- **luac -p**: valida sintaxis de archivos lua.
- **jq**: valida archivos JSON/JSONC.

Tu PR debe pasar todos los checks antes de merge.

## Estructura de commits

Usar conventional commits:

- `fix:` — bug fix
- `feat:` — nueva feature o widget
- `docs:` — cambios en documentación
- `chore:` — mantenimiento, limpieza
- `refactor:` — refactor sin cambio de comportamiento

Ejemplo: `fix: escapar JSON en music.sh con jq`

## Reportar bugs

Usa el template de bug report en GitHub Issues. Incluye:

- Versión de Omarchy/Hyprland
- GPU (NVIDIA/AMD/Intel)
- Pasos para reproducir
- Logs relevantes (`hyprctl configerrors`, `shellcheck` output)

## Solicitar features

Usa el template de feature request. Describe el problema que resuelve y cómo debería funcionar. Si es visual, incluye un mockup o referencia al estilo Frutiger Aero.
