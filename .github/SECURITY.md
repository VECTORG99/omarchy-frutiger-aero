# Política de Seguridad

## Reportar vulnerabilidades

Si encuentras un problema de seguridad — como una credencial filtrada, un script inseguro, o exposición de datos personales — **no abras un issue público**.

Repórtalo privadamente via GitHub Security Advisories:

https://github.com/VECTORG99/omarchy-frutiger-aero/security/advisories/new

O contacta directamente al mantenedor. Acusaremos recibo dentro de 48 horas.

## Expectativas

- Acusaremos recibo dentro de 48 horas
- Proveeremos una evaluación inicial dentro de 5 días
- Trabajaremos en una corrección según la criticidad
- Mantendremos la comunicación abierta durante el proceso

## Alcance

Aplica al código fuente, scripts de instalación, configs de Hyprland/Waybar/EWW, y hooks de Omarchy. No incluye servicios externos, dependencias del sistema, o configuraciones de hardware del usuario.

## Buenas prácticas

- No commitar tokens, API keys ni secretos en configs
- No usar rutas personales hardcodeadas (`/home/usuario`)
- Validar input de scripts externos (playerctl, sensors, curl) antes de procesar
- Usar `set -euo pipefail` en scripts bash
- Construir JSON con `jq` en vez de concatenación de strings
