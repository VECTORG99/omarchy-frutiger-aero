-- Frutiger Aero look'n'feel: burbujas, glass, blur profundo

-- Cursor theme
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 6,
    border_size = 3,
    layout = "dwindle",
    resize_on_border = true,
  },
})

hl.config({
  decoration = {
    rounding = 12,
    rounding_power = 2.5,
    active_opacity = 1.0,
    inactive_opacity = 0.72,
    fullscreen_opacity = 1.0,
    dim_inactive = true,
    dim_strength = 0.08,

    shadow = {
      enabled = true,
      range = 14,
      render_power = 4,
      color = "rgba(18,153,202,0.40)",
      color_inactive = "rgba(10,26,46,0.30)",
    },

    blur = {
      enabled = true,
      size = 8,
      passes = 3,
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

-- FA elastic bounce curve (Vista-style stronger overshoot)
hl.curve("faBounce", { type = "bezier", points = { { 0.11, 0.9 }, { 0.1, 1.15 } } })

-- Animaciones de ventanas
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "faBounce", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "overshoot", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
-- Gradual opacity/blur transition on focus change (fadeSwitch) and dim easing (fadeDim).
-- With blur.ignore_opacity = false, fadeSwitch also animates blur visibility through inactive_opacity.
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "easeOutQuint", style = "slide" })
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

-- Capa de notificaciones con blur
hl.layer_rule({
  match = { namespace = "mako" },
  blur = true,
  ignore_alpha = 0.2,
})

-- Steam + CS2 fixes
hl.config({
  windowrulev2 = {
    "noblur,class:^(steam)$",
    "rounding 0,class:^(steam)$",
    "noanim,class:^(steam)$",
    "noblur,class:^(cs2)$",
    "rounding 0,class:^(cs2)$",
    "noanim,class:^(cs2)$",
    "fullscreen,class:^(cs2)$",
  },
})

-- XWayland apps heredan rounding FA
hl.config({
  windowrulev2 = {
    "rounding 12,xwayland:1",
    "border_size 3,xwayland:1",
  },
})

-- Opacidad para ventanas flotantes (más glass)
hl.config({
  windowrulev2 = {
    "opacity 0.88,floating:1",
  },
})
