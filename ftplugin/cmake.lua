if require("lv-utils").check_lsp_client_active "cmake" then
  return
end

require("lsp.functions").lspconfig "cmake" {
  cmd = { DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server" },
  on_attach = require("lsp.functions").common_on_attach,
  filetypes = { "cmake" },
  flags = O.lsp.flags,
}
