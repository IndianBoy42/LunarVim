if not require("lv-utils").check_lsp_client_active "cssls" then
  -- npm install -g vscode-css-languageserver-bin
  require("lsp.functions").lspconfig "cssls" {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp.functions").common_on_attach,
    flags = O.lsp.flags,
  }
end

vim.cmd "setl ts=2 sw=2"
