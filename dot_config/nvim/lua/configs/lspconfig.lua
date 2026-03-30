require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "vtsls" }
vim.lsp.enable(servers)
