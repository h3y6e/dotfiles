local is_dark = vim.o.background == "dark"

return {
  {
    "catppuccin/nvim",
    opts = {
      auto_integrations = true,
      background = {
        light = "latte",
        dark = "frappe",
      },
      transparent_background = is_dark,
      float = {
        transparent = is_dark,
        solid = true,
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay0 },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
}
