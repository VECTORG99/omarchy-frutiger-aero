-- Configuración de monitores — edita según tu hardware
-- Omarchy detecta monitores automáticamente si no se especifican.
-- Descomenta y edita las líneas de abajo para configuración manual:

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Ejemplo de configuración manual (descomenta y edita):
-- hl.monitor({ output = "DP-2", mode = "2560x1440@180", position = "0x0", scale = 1 })
-- hl.monitor({ output = "DP-3", mode = "1920x1080@180", position = "2560x0", scale = 1 })

-- Si tienes monitores adicionales, usa el mismo formato que arriba para agregarlos.
-- Si algún monitor necesita otro refresh rate (Hz), ajusta el modo en consecuencia.
