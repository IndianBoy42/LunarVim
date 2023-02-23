local M = {}

local eval_line = "xx"
local eval_op = "x"
local eval_cell = "x<cr>"

local bmap = vim.keymap.setl

local feedkeys = vim.api.nvim_feedkeys
local termcodes = vim.api.nvim_replace_termcodes
function M.Tmem(cmd)
  vim.cmd("Tmap " .. cmd)
  feedkeys(termcodes(vim.g.neoterm_automap_keys, true, true, true), "m", false)
end

function M.sniprun()
  require("sniprun").setup {
    -- TODO: customize these displays
    --# you can combo different display modes as desired
    display = {
      "Classic", --# display results in the command-line  area
      "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)

      -- "VirtualTextErr",          --# display error results as virtual text
      -- "TempFloatingWindow",      --# display results in a floating window
      -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
      -- "Terminal",                --# display results in a vertical split
      -- "NvimNotify",              --# display with the nvim-notify plugin
      -- "Api"                      --# return output to a programming interface
    },

    --# You can use the same keys to customize whether a sniprun producing
    --# no output should display nothing or '(no output)'
    show_no_output = {
      "Classic",
      "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
    },

    --# customize highlight groups (setting this overrides colorscheme)
    snipruncolors = {
      SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
      SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
      SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
      SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
    },

    --# miscellaneous compatibility/adjustement settings
    inline_messages = 0, --# inline_message (0/1) is a one-line way to display messages
    --# to workaround sniprun not being able to display anything

    borders = O.lsp.border, --# display borders around floating windows
    --# possible values are 'none', 'single', 'double', or 'shadow'
  }
end

local function right(cmd)
  return function()
    require("FTerm.terminal"):new():setup {
      cmd = cmd,
      dimensions = { height = 0.95, width = 0.4, x = 1.0, y = 0.5 },
    }
  end
end

local function under(cmd)
  return function()
    require("FTerm.terminal"):new():setup {
      cmd = cmd,
      dimensions = { height = 0.4, width = 0.6 },
    }
  end
end

local function popup(cmd)
  return function()
    require("FTerm.terminal"):new():setup {
      cmd = cmd,
      dimensions = { height = 0.9, width = 0.9 },
    }
  end
end

-- FIXME: broot unable to open files correctly
local fterms = setmetatable({
  down = under(nil),
  right = right(nil),
  term = popup(nil),
}, {
  __index = function(tbl, key)
    local new = popup(key)
    tbl[key] = new
    return new
  end,
})

function M.ftopen(name)
  return function()
    fterms[name]():open()
  end
end

function M.fterm()
  require("FTerm").setup {
    dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 },
    border = "single", -- or 'double'
  }

  vim.keymap.set("n", "<M-i>", require("FTerm").toggle)
  vim.keymap.set("t", "<M-i>", require("FTerm").toggle)
  -- map("t", "<Esc>", '<C-\\><C-n><CMD>lua require("FTerm").close()<CR>', nore)
  vim.cmd [[
    command! -nargs=1 FtOpen lua ftopen('<args>')
    command! -nargs=1 FtRun lua require'FTerm'.run('<args>\n')
    command! -nargs=1 FtScratch lua require'FTerm'.scratch({cmd='<args>'})
  ]]

  require("lv-utils").define_augroups {
    _close_fterm = {
      { "FileType", "FTerm", "nnoremap <silent> <buffer> q <CMD>q<CR>" },
      -- { "FileType", "FTerm", "tnoremap <silent> <buffer> <esc> <nop>" },
      -- { "FileType", "FTerm", "tnoremap <silent> <buffer> <M-e> <C-\\><C-n>" },
      { "FileType", "FTerm", "tnoremap <silent> <buffer> <C-h> <C-\\><C-n><CMD>q<CR>" },
      { "FileType", "FTerm", "tnoremap <silent> <buffer> <C-j> <C-\\><C-n><CMD>q<CR>" },
      { "FileType", "FTerm", "tnoremap <silent> <buffer> <C-k> <C-\\><C-n><CMD>q<CR>" },
      { "FileType", "FTerm", "tnoremap <silent> <buffer> <C-l> <C-\\><C-n><CMD>q<CR>" },
    },
  }

  return fterms
end

function M.neoterm()
  vim.g.neoterm_default_mod = "FocusSplitNicely"
  vim.g.neoterm_autoinsert = 1
  vim.g.neoterm_autoscroll = 1
  vim.g.neoterm_shell = O.termshell
  vim.g.neoterm_bracketed_paste = 1
  vim.g.neoterm_repl_python = { "ipython" }
  vim.g.neoterm_repl_lua = { "croissant" }
  --vim.g.neoterm_repl_python = "['conda activate venv', 'clear', 'ipython']"
end

function M.magma()
  vim.g.magma_automatically_open_output = false
  utils.define_augroups {
    _magma_start = {
      -- { "User", "MagmaInitPre", [[lua require("lv-terms").activate_magma("<args>")]] },
      { "User", "MagmaInitPost", [[lua require("lv-terms").activate_magma("<args>")]] },
      -- { "User", "MagmaDeinitPre", [[lua require("lv-terms").activate_magma("<args>")]] },
      -- { "User", "MagmaDeinitPost", [[lua require("lv-terms").activate_magma("<args>")]] },
    },
  }
end

function M.activate_magma(kernel)
  -- vim.cmd("MagmaInit " .. (vim.b.lv_magma_kernel or ""))
  mappings.localleader {
    x = "Magma",
    ["xx"] = { "<cmd>MagmaEvaluateLine<CR>", "Run Line" },
    ["x<CR>"] = { ",rij", "Run Line" },
    ["X"] = { "<cmd>MagmaReevaluateCell<CR>", "Rerun Cell" },
    ["xd"] = { "<cmd>MagmaDelete<CR>", "Magma Delete" },
    t = "Terminal",
    ["to"] = { "<cmd>MagmaShowOutput<cr>", "Magma Output" },
    r = { ":MagmaEvaluateOperator<CR>g@", "Magma Run" },
  }
  mappings.vlocalleader {
    r = { "<ESC>,rgv", "Magma Run" },
  }
end

function M.luadev()
  utils.new_command.LuadevStart = M.activate_luadev
  -- vim.cmd [[ command LuadevStart :lua require("lv-terms").activate_luadev() ]]
end

function M.activate_luadev()
  vim.cmd "Luadev"
  mappings.localleader {
    x = "Luadev",
    xx = { "<Plug>(Luadev-RunLine)", "Run Line" },
    xw = { "<Plug>(Luadev-RunWord)", "Run Word" },
    r = { "<Plug>(Luadev-Run)", "Luadev Run" },
  }
  mappings.vlocalleader {
    r = { "<Plug>(Luadev-Run)", "Luadev Run" },
  }
  -- bmap("i", "", "<Plug>(Luadev-Complete)", { silent = true })
end

function M.kitty()
  require("kitty-runner").setup {
    use_keymaps = false, --use keymaps
  }
  utils.new_command.KittyOpen = function()
    M.activate_kitty()
  end
  utils.new_command.KittyOpenLocal = function()
    M.activate_kitty "<local>"
  end
  -- vim.cmd [[ command! KittyOpen :lua require("lv-terms").activate_kitty() ]]
  -- vim.cmd [[ command! KittyOpenLocal :lua require("lv-terms").activate_kitty('<local>') ]]
end

function M.activate_kitty(port)
  port = port or ""
  local ops = port == "<local>" and {
    prefix = "<localleader>",
    buffer = 0,
  } or {
    prefix = "<leader>",
    -- buffer = 0,
  }
  require("kitty-runner").open_new_runner(port)

  -- Once we start the kitty-runner we override (some) of the neoterm stuff
  mappings.whichkey({
    [vim.g.neoterm_automap_keys] = { "<cmd>KittyReRunCommand " .. port .. "<CR>", "Rerun" },
    tt = { "<cmd>KittyRunCommand " .. port .. "<CR>", "Run new" },
    ["t<space>"] = { "<cmd>KittyRunCommandOnce" .. port .. "<CR>", "Run once" },
  }, ops)
  bmap("x", "<localleader>k", "<cmd>KittySendLines " .. port .. "<CR>", { silent = true })
  bmap("n", "<localleader>k", utils.operatorfunc_keys("kitty_exec", "<localleader>k"), { silent = true })
end

function M.mdeval()
  require("mdeval").setup {
    -- Don't ask before executing code blocks
    require_confirmation = false,
    -- Change code blocks evaluation options.
    eval_options = {
      -- Set custom configuration for C++
      cpp = {
        command = { "clang++", "-std=c++20", "-O0" },
        default_header = [[
    #include <iostream>
    #include <vector>
    using namespace std;
      ]] ,
      },
    },
  }
end

function M.mdeval_keymaps()
  mappings.localleader {
    -- ["c"] = { "<cmd>lua require 'mdeval'.eval_code_block()<CR>", "Eval Code Block" },
    ["c"] = {
      function()
        require("mdeval").eval_code_block()
      end,
      "Eval Code Block",
    },
  }
end

function M.jupyter_ascending()
  vim.keymap.setl("n", "<localleader>j", "<Plug>JupyterExecute")
  -- mappings.localleader {
  --   ["j"] = { "<Plug>JupyterExecute", "Execute Cell" },
  --   ["J"] = { "<Plug>JupyterExecuteAll", "Execute All" },
  -- }
end

function M.keymaps(leaderMappings, vLeaderMappings)
  local cmd = utils.cmd
  local map = vim.keymap.set
  if O.plugin.neoterm then
    utils.new_command.Tmem = {
      rhs = function(opts)
        M.Tmem(opts.args)
      end,
      nargs = "+",
    }
    -- vim.cmd [[ command -nargs=+ Tmem :lua require("lv-terms").Tmem("<args>") ]]

    vim.g.neoterm_automap_keys = "<leader>x<cr>"
    leaderMappings["x<cr>"] = "Neoterm AutoMap"

    map("n", "<leader>t<space>", ":Tmem ")
    leaderMappings["t<space>"] = "Tmem ..."
    leaderMappings["tt"] = { "<cmd>Tnew<CR>", "T ..." }
    leaderMappings["t<cr>"] = { "<cmd>T k<CR>", "Neoterm rerun" }
    leaderMappings["t<tab>"] = { cmd "Ttoggle", "Neoterm Toggle" }
    leaderMappings["tl"] = { cmd "Tls", "Neoterm list" }

    leaderMappings["xm"] = { "<Plug>(neoterm-repl-send)", "Neoterm Send" }
    leaderMappings["xn"] = { "<Plug>(neoterm-repl-send-line)", "Neoterm Line" }
    vLeaderMappings["xn"] = { "<Plug>(neoterm-repl-send)", "Neoterm Send" }
  end

  if O.plugin.kittyrunner then
    leaderMappings["tko"] = { "<cmd>KittyOpen<CR>", "Kitty Open" }
    leaderMappings["tkl"] = { "<cmd>KittyOpenLocal<CR>", "Kitty Local" }
    leaderMappings["xk"] = { "<cmd>KittyReRunCommand<CR>", "Kitty Rerun" }
    leaderMappings["xK"] = { "<cmd>KittyRunCommand<CR>", "Kitty Run" }
    leaderMappings["xl"] = { "<cmd>KittySendLines<CR>", "Kitty Send" }
    vLeaderMappings["xl"] = { "<cmd>KittySendLines<CR>", "Kitty Send" }
    -- TODO: add operator mapping
  end

  if O.plugin.floatterm then
    map("n", "<leader>tf", ":FtScratch ", {})
    map("n", "<leader>tF", ":FtRun ", {})
    leaderMappings["tf"] = "Scratch ..."
    leaderMappings["tF"] = "(F)Run ..."
  end

  if O.plugin.sniprun then
    leaderMappings["tp"] = { "<Plug>SnipClose", "SnipRun Close" }
    leaderMappings["tP"] = { "<cmd>SnipReset<cr>", "SnipRun Reset" }
    leaderMappings["tC"] = { "<Plug>SnipReplMemoryClean", "SnipRun Clean" }

    vLeaderMappings["xs"] = { "<cmd>SnipRun<cr>", "SnipRun" }
    leaderMappings["xs"] = { "<Plug>SnipRun", "SnipRun Line" }
    leaderMappings["xc"] = { "<Plug>SnipRun", "SnipRun" }
  end

  if O.plugin.code_runner then
    leaderMappings["<leader>xc"] = { "<cmd>RunCode<CR>", "RunCode" }
    leaderMappings["<leader>xf"] = { "<cmd>RunFile<CR>", "RunFile" }
    leaderMappings["<leader>xP"] = { "<cmd>RunProject<CR>", "RunProject" }
    -- vim.api.nvim_set_keymap("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
    -- vim.api.nvim_set_keymap("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
  end
  -- Can use: "!", "&", "gt", "gx"
end

function M.coderunner()
  require("code_runner").setup {
    filetype_path = vim.fn.expand "~/.config/nvim/code_runner.json",
    project_path = vim.fn.expand "~/.config/nvim/projects.json",
  }
end

return M
