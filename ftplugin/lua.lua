-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
require("lsp.config").lspconfig "lua_ls" {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "O", "utils", "mappings", "DATA_PATH", "CONFIG_PATH", "require" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 1000,
      },
    },
  },
}

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

-- vim.keymap.setl("x", "is", "?[[<cr>o/]]<cr>")
require("lv-pairs.sandwich").add_local_recipe {
  buns = { "function()\n", "\nend" },
  quoteescape = true,
  expand_range = false,
  nesting = false,
  input = { "F" },
}
require("lv-pairs.sandwich").add_local_recipe {
  buns = { "if then\n", "\nend" },
  quoteescape = true,
  expand_range = false,
  nesting = false,
  input = { "I" },
}
require("lv-pairs.sandwich").add_local_recipe {
  buns = { "[[", "]]" },
  quoteescape = true,
  expand_range = false,
  nesting = false,
  input = { "s" },
}

require("lv-cmp").add_sources { { name = "nvim_lua" } }
