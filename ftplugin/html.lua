if not require("lv-utils").check_lsp_client_active "html" then
  -- npm install -g vscode-html-languageserver-bin
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require("lsp.config").lspconfig  "html" {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp.functions").common_on_attach,
    capabilities = capabilities,
    flags = O.lsp.flags,
  }
end

vim.cmd "setl ts=2 sw=2"
