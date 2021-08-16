if require("lv-utils").check_lsp_client_active "dockerls" then
  return
end

-- npm install -g dockerfile-language-server-nodejs
require("lsp.functions").lspconfig("dockerls") {
  cmd = {
    DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
    "--stdio",
  },
  on_attach = require("lsp.functions").common_on_attach,
  root_dir = vim.loop.cwd,
  flags = O.lsp.flags,
}
