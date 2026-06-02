-- Configuración neutral para monitores FHD y QHD (~27 pulgadas)
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "DP-2", mode = "2560x1440@180", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@180", position = "2560x0", scale = 1 })

-- Si tienes monitores adicionales, usa el mismo formato que arriba para agregarlos.
-- Si algún monitor necesita otro refresh rate (Hz), ajusta el modo en consecuencia.
