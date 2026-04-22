return {
  {
    "delphinus/md-render.nvim",
    version = "*",
    dependencies = {
      { "delphinus/budoux.lua", version = "*" },
    },
    ft = "markdown",
    keys = {
      { "<leader>md", "<Plug>(md-render-preview)",     desc = "Markdown preview" },
      { "<leader>mt", "<Plug>(md-render-preview-tab)", desc = "Markdown preview in tab" },
    },
  }
}
