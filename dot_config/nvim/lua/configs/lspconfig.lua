require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "vtsls", "copilot" }
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "copilot" then
      return
    end

    if not client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, args.buf) then
      return
    end

    vim.lsp.inline_completion.enable(true, {
      bufnr = args.buf,
      client_id = client.id,
    })

    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("i", "<M-l>", vim.lsp.inline_completion.get, opts)
    vim.keymap.set("i", "<M-]>", function()
      vim.lsp.inline_completion.select { count = 1 }
    end, opts)
    vim.keymap.set("i", "<M-[>", function()
      vim.lsp.inline_completion.select { count = -1 }
    end, opts)
  end,
})
