return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
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
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
}
