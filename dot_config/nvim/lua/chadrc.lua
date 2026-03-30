---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  integrations = { "markview" },
  hl_override = {
    ["@comment"] = { fg = "#7f849c", italic = true },
    LineNr = { fg = "#7f849c" },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },
}

M.term = {
  float = {
    width = 0.8,
    height = 0.7,
    row = 0.15,
    col = 0.1,
  },
}

return M
