-- Frutiger Aero look'n'feel: burbujas, glass, blur profundo

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 6,
    border_size = 2,
    layout = "dwindle",
  },
})

hl.config({
  decoration = {
    rounding = 12,
    active_opacity = 1.0,
    inactive_opacity = 0.72,
    fullscreen_opacity = 1.0,
    dim_inactive = true,
    dim_strength = 0.08,

    shadow = {
      enabled = true,
      range = 6,
      render_power = 4,
      color = "rgba(0a162866)",
    },

    blur = {
      enabled = true,
      size = 10,
      passes = 5,
      special = true,
      ignore_opacity = false,
      new_optimizations = true,
      xray = true,
      noise = 0.01,
      contrast = 0.85,
      brightness = 0.75,
      vibrancy = 0.30,
      vibrancy_darkness = 0.0,
    },
  },
})

hl.config({
  animations = {
    enabled = true,
  },
})

-- Curvas suaves estilo Aero
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("overshoot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })

-- Animaciones de ventanas
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "overshoot", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "overshoot", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })

hl.config({
  layout = {
    single_window_aspect_ratio = { 1, 1 },
  },
})

hl.config({
  scrolling = {
    column_width = 0.97,
  },
})

-- Steam fixes
hl.config({
  windowrulev2 = {
    "noblur,class:^(steam)$",
    "rounding 0,class:^(steam)$",
    "noanim,class:^(steam)$",
  },
})

-- Opacidad para ventanas flotantes (más glass)
hl.config({
  windowrulev2 = {
    "opacity 0.88,floating:1",
  },
})
