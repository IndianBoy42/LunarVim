local M = {}
-- TODO: unify tabout, autopairs and sandwiches

function M.tabout()
  local pairs = { "''", '""', "``", "()", "{}", "[]", "||" }
  local opts = {
    tabkey = "<C-l>", -- key to trigger tabout
    backwards_tabkey = "<C-S-l>", -- key to trigger tabout
    act_as_tab = true, -- shift content if tab out is not possible
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {},
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  }
  for i, v in ipairs(pairs) do
    opts.tabouts = vim.list_extend(opts.tabouts, { { open = v:sub(1, 1), close = v:sub(2) } })
  end
  require("tabout").setup(opts)
end

function M.autopairs()
  local npairs = require "nvim-autopairs"
  local R = require "nvim-autopairs.rule"

  -- if package.loaded["compe"] then
  if O.plugin.cmp then
    if true then
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    else
      require("nvim-autopairs.completion.cmp").setup {
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
        -- auto_select = true,
        -- insert = false,
        map_char = {
          all = "(",
          tex = "{",
        },
      }
    end
  end

  npairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string" }, -- it will not add pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  }

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  npairs.add_rules {
    -- R("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    -- R("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
    R("|", "|", "rust"),
    -- R("if ", " then\nend", "lua"):with_pair(ts_conds.is_not_ts_node { "comment", "string" }),
    -- R("for ", " in", "lua"):with_pair(ts_conds.is_not_ts_node { "comment", "string" }),
    -- R("in ", " do", "lua"):with_pair(ts_conds.is_not_ts_node { "comment", "string" }),
    -- R("do ", " end", "lua"):with_pair(ts_conds.is_not_ts_node { "comment", "string" }),
  }

  -- press % => %% is only inside comment or string
  -- TODO:move all of this to luasnip autosnippets cos why not?
  local texmods = {
    ["\\left"] = "\\right",
    -- ["\\big"] = "\\big",
    -- ["\\bigg"] = "\\bigg",
    -- ["\\Big"] = "\\Big",
    -- ["\\Bigg"] = "\\Bigg",
  }
  local texpairs = {
    ["\\("] = "\\)",
    ["\\["] = "\\]",
    ["\\{"] = "\\}",
    ["\\|"] = "\\|",
    ["\\langle "] = "\\rangle",
    ["\\lceil "] = "\\rceil",
    ["\\lfloor "] = "\\rfloor",
  }
  local basicpairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
  }
  for lm, rm in pairs(texmods) do
    for lp, rp in pairs(texpairs) do
      npairs.add_rule(R(lm .. lp, " " .. rm .. rp, "tex"))
    end
    for lp, rp in pairs(basicpairs) do
      npairs.add_rule(R(lm .. lp, " " .. rm .. rp, "tex"))
    end
  end
  for lp, rp in pairs(texpairs) do
    -- npairs.add_rule(R(lp, " " .. rp, "tex"))
    npairs.add_rule(R(lp, rp, "tex"))
  end

  -- lua utils.dump(MPairs.state.rules)
end

function M.sandwich_setup()
  vim.g.sandwich_no_default_key_mappings = 1
  vim.g.operator_sandwich_no_default_key_mappings = 1
  vim.g.textobj_sandwich_no_default_key_mappings = 1
end
function M.sandwich()
  -- vim.cmd "runtime macros/sandwich/keymap/surround.vim"
  vim.cmd [[
  nmap ys <Plug>(operator-sandwich-add)
  onoremap <Plug>(sandwich-line-helper) :normal! ^vg_<CR>
  nmap <silent> yss <Plug>(operator-sandwich-add)<Plug>(sandwich-line-helper)
  nmap yS ysg_

  nmap ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap dss <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  nmap cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap css <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  xmap S <Plug>(operator-sandwich-add)

  runtime autoload/repeat.vim
  if hasmapto('<Plug>(RepeatDot)')
    nmap . <Plug>(operator-sandwich-predot)<Plug>(RepeatDot)
  else
    nmap . <Plug>(operator-sandwich-dot)
  endif
  ]]

  -- recipes = vim.g["sandwich#recipes"]

  local add_recipes = require("lv-pairs.sandwich").add_recipes
  local add_recipe = require("lv-pairs.sandwich").add_recipe
  -- TODO: use inline_text_input for sandwich function
  --   M.add_recipe {
  --     buns = { "lua require('lv-pairs.sandwich').fname()", '")"' },
  --     expr = true,
  --     kind = { "add", "replace" },
  --     action = { "add" },
  --     input = { "f" },
  --   }
  add_recipes {
    {
      ["buns"] = { "s+", "s+" },
      ["regex"] = 1,
      ["kind"] = { "delete", "replace", "query" },
      ["input"] = { " " },
    },

    {
      ["buns"] = { "", "" },
      ["action"] = { "add" },
      ["motionwise"] = { "line" },
      ["linewise"] = 1,
      ["input"] = { "<CR>" },
    },

    {
      ["buns"] = { "^$", "^$" },
      ["regex"] = 1,
      ["linewise"] = 1,
      ["input"] = { "<CR>" },
    },

    {
      ["buns"] = { "<", ">" },
      ["expand_range"] = 0,
      ["input"] = { ">", "a" },
    },

    {
      ["buns"] = { "`", "`" },
      ["quoteescape"] = 1,
      ["expand_range"] = 0,
      ["nesting"] = 0,
      ["linewise"] = 0,
    },

    {
      ["buns"] = { '"', '"' },
      ["quoteescape"] = 1,
      ["expand_range"] = 0,
      ["nesting"] = 0,
      ["linewise"] = 0,
    },

    {
      ["buns"] = { "'", "'" },
      ["quoteescape"] = 1,
      ["expand_range"] = 0,
      ["nesting"] = 0,
      ["linewise"] = 0,
    },

    {
      ["buns"] = { "{", "}" },
      ["nesting"] = 1,
      ["skip_break"] = 1,
      ["input"] = { "{", "}", "B" },
    },

    {
      ["buns"] = { "[", "]" },
      ["nesting"] = 1,
      ["input"] = { "[", "]", "r" },
    },

    {
      ["buns"] = { "(", ")" },
      ["nesting"] = 1,
      ["input"] = { "(", ")", "b" },
    },

    {
      ["buns"] = "sandwich#magicchar#t#tag()",
      ["listexpr"] = 1,
      ["kind"] = { "add" },
      ["action"] = { "add" },
      ["input"] = { "t", "T" },
    },

    {
      ["buns"] = "sandwich#magicchar#t#tag()",
      ["listexpr"] = 1,
      ["kind"] = { "replace" },
      ["action"] = { "add" },
      ["input"] = { "T", "<" },
    },

    {
      ["buns"] = "sandwich#magicchar#t#tagname()",
      ["listexpr"] = 1,
      ["kind"] = { "replace" },
      ["action"] = { "add" },
      ["input"] = { "t" },
    },

    {
      ["external"] = { "<Plug>(textobj-sandwich-tag-i)", "<Plug>(textobj-sandwich-tag-a)" },
      ["noremap"] = 0,
      ["kind"] = { "delete", "textobj" },
      ["expr_filter"] = { 'operator#sandwich#kind() !=# "replace"' },
      ["linewise"] = 1,
      ["input"] = { "t", "T", "<" },
    },

    {
      ["external"] = { "<Plug>(textobj-sandwich-tag-i)", "<Plug>(textobj-sandwich-tag-a)" },
      ["noremap"] = 0,
      ["kind"] = { "replace", "query" },
      ["expr_filter"] = { 'operator#sandwich#kind() ==# "replace"' },
      ["input"] = { "T", "<" },
    },

    {
      ["external"] = { "<Plug>(textobj-sandwich-tagname-i)", "<Plug>(textobj-sandwich-tagname-a)" },
      ["noremap"] = 0,
      ["kind"] = { "replace", "textobj" },
      ["expr_filter"] = { 'operator#sandwich#kind() ==# "replace"' },
      ["input"] = { "t" },
    },

    {
      ["buns"] = { "sandwich#magicchar#f#fname()", '")"' },
      ["kind"] = { "add", "replace" },
      ["action"] = { "add" },
      ["expr"] = 1,
      ["input"] = { "f" },
    },

    {
      ["external"] = { "<Plug>(textobj-sandwich-function-ip)", "<Plug>(textobj-sandwich-function-i)" },
      ["noremap"] = 0,
      ["kind"] = { "delete", "replace", "query" },
      ["input"] = { "f" },
    },

    {
      ["external"] = { "<Plug>(textobj-sandwich-function-ap)", "<Plug>(textobj-sandwich-function-a)" },
      ["noremap"] = 0,
      ["kind"] = { "delete", "replace", "query" },
      ["input"] = { "F" },
    },

    {
      ["buns"] = 'sandwich#magicchar#i#input("operator")',
      ["kind"] = { "add", "replace" },
      ["action"] = { "add" },
      ["listexpr"] = 1,
      ["input"] = { "i" },
    },

    {
      ["buns"] = 'sandwich#magicchar#i#input("textobj", 1)',
      ["kind"] = { "delete", "replace", "query" },
      ["listexpr"] = 1,
      ["regex"] = 1,
      ["input"] = { "i" },
    },

    {
      ["buns"] = 'sandwich#magicchar#i#lastinput("operator", 1)',
      ["kind"] = { "add", "replace" },
      ["action"] = { "add" },
      ["listexpr"] = 1,
      ["input"] = { "I" },
    },

    {
      ["buns"] = 'sandwich#magicchar#i#lastinput("textobj")',
      ["kind"] = { "delete", "replace", "query" },
      ["listexpr"] = 1,
      ["regex"] = 1,
      ["input"] = { "I" },
    },

    {
      external = { "ic", "ac" },
      noremap = false,
      kind = { "delete", "replace", "query" },
      input = { "c" },
    },
    {
      external = { "ii", "ai" },
      noremap = false,
      kind = { "delete", "replace", "query" },
      input = { "i" },
    },
    {
      external = { "if", "af" },
      noremap = false,
      kind = { "delete", "replace", "query" },
      input = { "af" },
    },
    -- {
    --   buns = { {[']], [[']} },
    --   quoteescape = true,
    --   expand_range = false,
    --   nesting = false,
    --   input = { "q" },
    -- },
    -- {
    --   buns = { {["]], [["]} },
    --   quoteescape = true,
    --   expand_range = false,
    --   nesting = false,
    --   input = { "Q" },
    -- },
    {
      buns = { "{'`\"]", "['`\"}" },
      kind = { "delete", "replace", "query" },
      quoteescape = true,
      expand_range = false,
      nesting = false,
      input = { "q" },
      regex = 1,
    },
  }

  local map = mappings.sile
  map("x", "is", "<Plug>(textobj-sandwich-query-i)")
  map("x", "as", "<Plug>(textobj-sandwich-query-a)")
  map("o", "is", "<Plug>(textobj-sandwich-query-i)")
  map("o", "as", "<Plug>(textobj-sandwich-query-a)")
  map("x", "iq", "isq")
  map("x", "aq", "asq")
  map("o", "iq", "isq")
  map("o", "aq", "asq")
  map("x", "s", "<Plug>(operator-sandwich-add)") --
end

return M
