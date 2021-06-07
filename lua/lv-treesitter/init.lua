require'nvim-treesitter.configs'.setup {
    ensure_installed = O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = O.treesitter.ignore_install,
    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
        enable = O.treesitter.highlight.enabled, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
        disable = {"latex"},
    },
    context_commentstring = {
        enable = true,
        config = {
          css = '// %s'
        }
      },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    -- TODO seems to be broken
    indent = {enable = {"javascriptreact"}},
    autotag = {enable = true},
    textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>aa"] = "@parameter.inner",
            ["<leader>af"] = "@function.inner",
            ["<leader>ac"] = "@class.inner",
            ["<leader>ak"] = "@block.inner",
            ["<leader>ai"] = "@conditional.inner",
            ["<leader>aC"] = "@call.inner",
            ["<leader>al"] = "@loop.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]a"] = "@parameter.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
            ["]A"] = "@parameter.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
            ["]a"] = "@parameter.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
            ["]a"] = "@parameter.outer",
          },
        },
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ak"] = "@block.outer",
            ["ik"] = "@block.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["aC"] = "@call.outer",
            ["iC"] = "@call.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",

            -- Or you can define your own textobjects like this
            ["iF"] = {
              python = "(function_definition) @function",
              cpp = "(function_definition) @function",
              c = "(function_definition) @function",
              java = "(method_declaration) @function",
            },
          },
        },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
        }
    },
    tree_docs = {
        enable = true,
        mapping = {
            doc_node_at_cursor = "zd",
            doc_all_in_range = "zd",
        }
    }
}
