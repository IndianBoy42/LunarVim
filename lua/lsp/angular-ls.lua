-- TODO find correct root filetype
-- :LspInstall angular
require("lspconfig").angularls.setup {
  cmd = {
    DATA_PATH .. "/lspinstall/angular/node_modules/@angular/language-server/bin/ngserver",
    "--stdio",
  },
  on_attach = require("lsp.functions").common_on_attach,
  flags = O.lsp.flags
}
