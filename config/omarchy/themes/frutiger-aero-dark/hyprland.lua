local active_border_color = { colors = { "rgba(18, 153, 202, 0.9)", "rgba(53, 188, 222, 0.9)" }, angle = 45 }

hl.config({
  general = {
    col = {
      active_border = active_border_color,
    },
  },
  group = {
    col = {
      border_active = active_border_color,
    },
  },
})
