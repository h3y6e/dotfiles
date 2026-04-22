return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
            preview = require("md-render.snacks").preview(),
          },
          grep = {
            preview = require("md-render.snacks").preview(),
          },
        },
      },
    },
  },
}
