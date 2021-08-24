if require("lv-utils").check_lsp_client_active "svelte" then
  return
end

require("lsp.config").lspconfig  "svelte" {
  cmd = { DATA_PATH .. "/lspinstall/svelte/node_modules/.bin/svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
  on_attach = require("lsp.functions").common_on_attach,
  flags = O.lsp.flags,
}
