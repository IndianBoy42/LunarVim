local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.make = {
    install_info = {
        url = "https://github.com/alemuller/tree-sitter-make", -- local path or git repo
        files = {"src/parser.c"},
        requires_generate_from_grammar = true
    }
}
parser_config.cmake = {
    install_info = {
        url = "https://github.com/uyha/tree-sitter-cmake", -- local path or git repo
        files = {"src/parser.c"},
        requires_generate_from_grammar = true
    }
}
-- parser_config.just = {
--     install_info = {
--         url = "~/dev/tree-sitter-just", -- local path or git repo
--         files = {"src/parser.c"}
--     }
--     -- filetype = "just", -- if filetype does not agrees with parser name
--     -- used_by = {"bar", "baz"} -- additional filetypes that use this parser
-- }

local textobj_prefixes = {
    goto_next = "]",
    goto_previous = "[",
    -- goto_next = "<leader>j",
    -- goto_previous = "<leader>J",
    inner = "i",
    outer = "a",
    swap = "<leader>a"
}
-- Next and previous respectively
local textobj_suffixes = {
    ["function"] = {"f", "F"},
    ["class"] = {"m", "M"},
    ["parameter"] = {"a", "A"},
    ["block"] = {"k", "K"},
    ["conditional"] = {"i", "I"},
    ["call"] = {"c", "C"},
    ["loop"] = {"l", "L"},
    ["statement"] = {"s", "S"},
    ["comment"] = {"/", "?"}
}
local textobj_sel_keymaps = {}
local textobj_swap_keymaps = {}
local textobj_move_keymaps = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {},
    goto_next_end = {},
    goto_previous_start = {},
    goto_previous_end = {}
}
for obj, suffix in pairs(textobj_suffixes) do
    textobj_move_keymaps["goto_next_start"][textobj_prefixes["goto_next"] ..
        suffix[1]] = '@' .. obj .. '.outer'
    textobj_move_keymaps["goto_next_end"][textobj_prefixes["goto_next"] ..
        suffix[2]] = '@' .. obj .. '.outer'
    textobj_move_keymaps["goto_previous_start"][textobj_prefixes["goto_previous"] ..
        suffix[2]] = '@' .. obj .. '.outer'
    textobj_move_keymaps["goto_previous_end"][textobj_prefixes["goto_previous"] ..
        suffix[1]] = '@' .. obj .. '.outer'

    textobj_sel_keymaps[textobj_prefixes["inner"] .. suffix[1]] = '@' .. obj ..
                                                                      '.inner'
    textobj_sel_keymaps[textobj_prefixes["outer"] .. suffix[1]] = '@' .. obj ..
                                                                      '.outer'

    textobj_swap_keymaps[textobj_prefixes["swap"] .. suffix[1]] = '@' .. obj ..
                                                                      '.outer'
end
local status, wk = pcall(require, "which-key")
if (status) then
    local normal = {
        mode = "n" -- Normal mode
    }
    local operators = {
        mode = "o" -- Operator mode
    }
    wk.register(textobj_sel_keymaps, operators)
    wk.register(textobj_swap_keymaps, normal)
    wk.register({
        [textobj_prefixes["swap"]] = "Swap"
        -- [textobj_prefixes["goto_next"]] = "Jump [",
        -- [textobj_prefixes["goto_previous"]] = "Jump ]"
    }, normal)
    wk.register(textobj_move_keymaps["goto_next_start"], normal)
    wk.register(textobj_move_keymaps["goto_next_end"], normal)
    wk.register(textobj_move_keymaps["goto_previous_start"], normal)
    wk.register(textobj_move_keymaps["goto_previous_end"], normal)
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = O.treesitter.ignore_install,
    matchup = {
        enable = true -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
        enable = O.treesitter.highlight.enabled, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
        disable = {"latex"}
    },
    context_commentstring = {
        enable = O.plugin.ts_context_commentstring,
        config = {css = '// %s'}
    },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    -- TODO seems to be broken
    indent = {enable = {"javascriptreact"}},
    autotag = {enable = true},
    textobjects = {
        swap = {
            enable = true,
            swap_next = textobj_swap_keymaps
            --     {
            --     ["<leader>aa"] = "@parameter.inner",
            --     ["<leader>af"] = "@function.inner",
            --     ["<leader>ac"] = "@class.inner",
            --     ["<leader>ak"] = "@block.inner",
            --     ["<leader>ai"] = "@conditional.inner",
            --     ["<leader>aC"] = "@call.inner",
            --     ["<leader>as"] = "@statement.inner",
            --     ["<leader>al"] = "@loop.inner"
            -- }
        },
        move = textobj_move_keymaps,
        --     {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --         ["]]"] = "@function.outer",
        --         ["]m"] = "@class.outer",
        --         ["]a"] = "@parameter.outer",
        --         ["]b"] = "@block.outer",
        --         ["]s"] = "@statement.outer"
        --     },
        --     goto_next_end = {
        --         ["]["] = "@function.outer",
        --         ["]M"] = "@class.outer",
        --         ["]A"] = "@parameter.outer",
        --         ["]B"] = "@block.outer",
        --         ["]S"] = "@statement.outer"
        --     },
        --     goto_previous_start = {
        --         ["[["] = "@function.outer",
        --         ["[m"] = "@class.outer",
        --         ["[a"] = "@parameter.outer",
        --         ["[b"] = "@block.outer",
        --         ["[s"] = "@statement.outer"
        --     },
        --     goto_previous_end = {
        --         ["[]"] = "@function.outer",
        --         ["[M"] = "@class.outer",
        --         ["[A"] = "@parameter.outer",
        --         ["[B"] = "@block.outer",
        --         ["[S"] = "@statement.outer"
        --     }
        -- } ,
        select = {
            enable = true,
            keymaps = textobj_sel_keymaps
            --     {
            --     -- You can use the capture groups defined in textobjects.scm
            --     ["af"] = "@function.outer",
            --     ["if"] = "@function.inner",
            --     ["aC"] = "@class.outer",
            --     ["iC"] = "@class.inner",
            --     ["aa"] = "@parameter.outer",
            --     ["ia"] = "@parameter.inner",
            --     ["ak"] = "@block.outer",
            --     ["ik"] = "@block.inner",
            --     ["ai"] = "@conditional.outer",
            --     ["ii"] = "@conditional.inner",
            --     ["ac"] = "@call.outer",
            --     ["ic"] = "@call.inner",
            --     ["al"] = "@loop.outer",
            --     ["il"] = "@loop.inner",
            --     ["as"] = "@statement.outer",
            --     ["is"] = "@statement.inner"
            -- }
        }
    },
    textsubjects = {
        enable = true,
        keymaps = {['.'] = 'textsubjects-smart', [';'] = 'textsubjects-big'}
    },
    playground = {
        enable = O.plugin.ts_playground.active,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?'
        }
    }
}
