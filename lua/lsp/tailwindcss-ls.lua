-- TODO what is a tailwindcss filetype
local lspconfig = require "lspconfig"

lspconfig.tailwindcss.setup {
  cmd = {
    "node",
    DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/tailwindServer.js",
    "--stdio",
  },
  filetypes = O.lang.tailwindcss.filetypes,
  root_dir = require("lspconfig/util").root_pattern("tailwind.config.js", "postcss.config.ts", ".postcssrc"),
  on_attach = require("lsp.functions").common_on_attach,
  flags = O.lsp.flags
}
