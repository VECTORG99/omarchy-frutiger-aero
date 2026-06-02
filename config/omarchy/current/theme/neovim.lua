return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#1e1e2e",
        dark_bg    = "#171723",
        darker_bg  = "#0f0f17",
        lighter_bg = "#353543",

        fg         = "#cdd6f4",
        dark_fg    = "#9aa1b7",
        light_fg   = "#d5dcf6",
        bright_fg  = "#dae0f7",
        muted      = "#45475a",

        red        = "#f38ba8",
        yellow     = "#f9e2af",
        orange     = "#f59cb5",
        green      = "#a6e3a1",
        cyan       = "#94e2d5",
        blue       = "#89b4fa",
        purple     = "#cba6f7",
        brown      = "#935e6d",

        bright_red    = "#f38ba8",
        bright_yellow = "#f9e2af",
        bright_green  = "#a6e3a1",
        bright_cyan   = "#94e2d5",
        bright_blue   = "#89b4fa",
        bright_purple = "#cba6f7",

        accent               = "#89b4fa",
        cursor               = "#cdd6f4",
        foreground           = "#cdd6f4",
        background           = "#1e1e2e",
        selection             = "#353543",
        selection_foreground = "#cdd6f4",
        selection_background = "#353543",
      },
    },
    -- set up hot reload
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
