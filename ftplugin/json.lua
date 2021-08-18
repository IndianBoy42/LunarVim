if require("lv-utils").check_lsp_client_active "jsonls" then
  return
end

-- npm install -g vscode-json-languageserver
require("lsp.functions").lspconfig "jsonls" {
  cmd = {
    "node",
    DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
    "--stdio",
  },
  on_attach = require("lsp.functions").common_on_attach,

  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },

  flags = O.lsp.flags,
}

if O.lang.json.autoformat then
  require("lv-utils").define_augroups {
    _json_format = {
      {
        "BufWritePre",
        "*.json",
        "lua vim.lsp.buf.formatting_sync(nil, 1000)",
      },
    },
  }
end
