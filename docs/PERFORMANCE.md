# Performance — Buenas Prácticas

## Métricas medidas

Todas las mediciones con `time` en hardware real (Ryzen + NVIDIA).

| Script | Antes | Después | Mejora |
|---------|-------|---------|--------|
| `eww/scripts/clock.sh` | 10ms (9 forks) | 4ms (1 fork) | 60% |
| `eww/scripts/sysmon-data.sh` | 305ms (top) | 163ms (/proc/stat) | 47% |
| `eww/scripts/weather.sh` | sin timeout | 10s max | bloqueo eliminado |

## Reglas de optimización

### Scripts bash

1. **Una sola llamada a binarios externos** cuando sea posible.
   ```bash
   # MAL — 9 forks
   hour=$(date +'%H')
   minute=$(date +'%M')
   second=$(date +'%S')

   # BIEN — 1 fork
   read -r hour minute second <<< "$(date +'%H %M %S')"
   ```

2. **Leer `/proc` directo en vez de comandos pesados**.
   - `top -bn1` = 223ms → `awk '/^cpu /' /proc/stat` = 0.5ms (446x)
   - `free` lee `/proc/meminfo` — OK, ya es rápido
   - `df` usa `statvfs` syscall — OK

3. **`curl` siempre con `--max-time`**.
   ```bash
   curl -sf --max-time 10 "url" 2>/dev/null || fallback
   ```

4. **`set -euo pipefail`** en todos los scripts — fail fast, no procesos zombies.

5. **Construir JSON con `jq -n --arg`** — nunca concatenación de strings.

### Intervals de polling

| Componente | Interval | Razón |
|------------|----------|-------|
| Clock (segundos visibles) | 1s | necesita segundos |
| Music playerctl | 3s | metadata no cambia en <3s |
| Sysmon CPU/RAM | 3s | métricas no cambian en <3s |
| Weather | 1800s | clima no cambia en <30min |
| Widget status | 5s | toggle state, no necesita 1s |
| Opacity slider | 1s | feedback del slider |
| Waybar mpris | 2s | D-Bus signals complementan |
| Waybar network | 5s | signal icon no cambia en <5s |
| Waybar network-speed | 3s | diferencia de 1s imperceptible |

### Hyprland blur

```lua
blur = {
  enabled = true,
  size = 8,        -- era 10
  passes = 3,      -- era 5 (50 samples → 24 samples, 52% menos GPU)
  new_optimizations = true,  -- mantener
  xray = true,     -- mantener (big win para ventanas sólidas)
}
```

- `passes > 3` es marginal visualmente pero lineal en GPU cost.
- `xray = true` es el optimization más importante — evita re-blur en ventanas sólidas.
- `new_optimizations = true` usa el algoritmo optimizado de Hyprland.

### CSS

- `box-shadow` y `linear-gradient` son GPU-composited — no crítico.
- Evitar `backdrop-filter` en waybar (no soportado bien en layer-shell).
- Múltiples layers con transparency = más composite work. Frutiger Aero necesita glass, así que se mantiene.

### EWW

- `defpoll` spawnea un proceso bash por interval. Minimizar intervals.
- `deflisten` es más eficiente que `defpoll` para data impulsada por eventos (ej: music).
- Widgets cerrados no ejecutan sus `defpoll` — solo abrir widgets pesados cuando se necesitan.

## Anti-patrones

- `top -bn1` para CPU% — usar `/proc/stat` directo.
- Múltiples calls a `date` — usar una sola con formato multi-campo.
- `curl` sin `--max-time` — puede colgar indefinidamente.
- `nvidia-smi` sin fallback — rompe en AMD/Intel.
- `defpoll` a 1s para data que cambia en minutos.
- `passes = 5` en blur — marginal visual, 66% más GPU que passes=3.
