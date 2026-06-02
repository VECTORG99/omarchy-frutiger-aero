local active_border_color = {
  colors = {
    "rgba(18, 153, 202, 0.95)",
    "rgba(144, 224, 239, 0.8)",
    "rgba(90, 172, 160, 0.6)",
  },
  angle = 60,
}

local inactive_border_color = "rgba(26, 51, 68, 0.4)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },
  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
    groupbar = {
      text_color = "rgba(200, 228, 224, 0.9)",
      height = 22,
    },
  },
})
