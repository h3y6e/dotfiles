require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>rc", function()
  require("base46").load_all_highlights()
end, { desc = "Reload chadrc" })
