require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

-- TODO create entire treesitter section

-- TODO support vim-sandwich in the which-key menus

local mappings = {
  -- [" "] = { "<cmd> lua require('telescope.builtin').commands()<cr>", "Commands" },
  [" "] = { "<cmd> lua require('telescope.builtin').buffers()<cr>", "Buffers" },
  [";"] = { "<cmd>Dashboard<CR>", "Dashboard" },
  ["/"] = { "<cmd> lua require('telescope.builtin').live_grep()<cr>", "Global search" },
  -- ["/"] = { "<cmd>lua require('spectre').open()<cr>", "Global search" },
  f = { "<cmd> lua require('telescope.builtin').find_files() <CR>", "Find File" },
  -- k = { "<cmd>lua require('lv-kakmode').enter()<cr>", "Kakoune" },
  j = { "]", "Jump next (])" },
  k = { "[", "Jump prev ([)" },
  -- w = { "<cmd>up<CR>", "Write" },
  w = { "<cmd>w<CR>", "Write" },
  o = {
    name = "Toggle window",
    f = { "<cmd>NvimTreeToggle<CR>", "File Sidebar" },
    u = { "<cmd>UndotreeToggle<CR>", "Undo tree" },
    r = { "<cmd>RnvimrToggle<cr>", "Ranger" },
    q = { [[call QuickFixToggle]], "Quick fixes" },
    o = { "<cmd>!open '%:p:h'<CR>", "Open File Explorer" },
    v = { "<cmd>Vista nvim_lsp<cr>", "Vista" },
    -- ["v"] = {"<cmd>Vista<CR>", "Vista"},
    m = { "<cmd>MinimapToggle<cr>", "Minimap" },
    b = { "<cmd>lua _G.ftopen('broot')<CR>", "Broot" },
    p = { "<cmd>lua _G.ftopen('python')<CR>", "Python" },
    M = { "<cmd>lua _G.ftopen('top')<CR>", "System Monitor" },
    S = { "<cmd>lua _G.ftopen('spt')<CR>", "Spotify" },
    t = { "<cmd>lua _G.ftopen('right')<CR>", "Terminal" },
  },
  t = {
    name = "Terminals",
    e = "Neoterm automap",
    -- TODO: Slime commands or replace slime with neoterm
    t = { "<cmd>Ttoggle<CR>", "Neoterm" },
    r = { "<cmd>TREPLSetTerm<CR> ", "Neoterm set repl..." },
    l = { "<cmd>Tls<CR>", "Neoterm list" },
    s = "Slime Line",
    M = { "<cmd>Tmap ", "Neoterm map a command" },
    b = { "<cmd>lua _G.ftopen('broot')<CR>", "Broot" },
    p = { "<cmd>lua _G.ftopen('python')<CR>", "Python" },
    T = { "<cmd>lua _G.ftopen('top')<CR>", "Top" },
    S = { "<cmd>lua _G.ftopen('spt')<CR>", "Spotify" },
    -- t = { "<cmd>lua _G.ftopen('right')<CR>", "Terminal" },
    -- t = { "<cmd>lua require'FTerm'.toggle()<CR>", "Terminal" },
  },
  T = {
    name = "Toggle Opts",
    w = { "<cmd>setlocal wrap!<CR>", "Wrap" },
    s = { "<cmd>setlocal spell!<CR>", "Spellcheck" },
    c = { "<cmd>setlocal cursorcolumn!<CR>", "Cursor column" },
    g = { "<cmd>setlocal signcolumn!<CR>", "Cursor column" },
    l = { "<cmd>setlocal cursorline!<CR>", "Cursor line" },
    h = { "<cmd>setlocal hlsearch<CR>", "hlsearch" },
    -- TODO: Toggle comment visibility
  },
  b = {
    name = "Buffers",
    j = { "<cmd> lua require('telescope.builtin').buffers()<cr>", "Jump to " },
    w = { "<cmd>w<CR>", "Write" },
    a = { "<cmd>wa<CR>", "Write All" },
    c = { "<cmd>bdelete!<CR>", "Close" },
    -- f = { "<cmd>Neoformat<cr>", "Format" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    -- n = { "<cmd>tabnew<CR>", "New" },
    n = { "<cmd>enew<CR>", "New" },
    -- W = {"<cmd>BufferWipeout<cr>", "wipeout buffer"},
    -- e = {
    --     "<cmd>BufferCloseAllButCurrent<cr>",
    --     "close all but current buffer"
    -- },
    h = { "<cmd>BufferLineCloseLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "close all BufferLines to the right" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "sort BufferLines automatically by language" },
    t = { "<cmd>vnew term://" .. O.termshell .. "<CR>", "Terminal" },
  },
  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- "
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- "
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  D = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.stop()<cr>", "Quit" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _G.ftopen('gitui')<CR>", "Gitui" },
    m = { "<cmd>!smerge '%:p:h'<CR>", "Sublime Merge" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    L = { "<cmd>GitBlameToggle<cr>", "Blame Toggle" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { "<cmd> lua require('telescope.builtin').git_status()<cr>", "Open changed file" },
    b = { "<cmd> lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" },
    c = { "<cmd> lua require('telescope.builtin').git_commits()<cr>", "Checkout commit" },
    C = { "<cmd> lua require('telescope.builtin').git_bcommits()<cr>", "Checkout commit(for current file)" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action (K)" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Code Action (gh)" },
    I = { "<cmd>LspInfo<cr>", "Info" },
    -- TODO: What is the replacement for this?
    -- f = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
    -- p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
    r = { "<cmd> lua require('telescope.builtin').lsp_references()<cr>", "References" },
    t = { "<cmd>lua vim.lsp.buf.type_definition() <cr>", "Type Definition" },
    s = { "<cmd>lua vim.lsp.buf.signature_help() <cr>", "Signature Help" },
    T = { "<cmd>TSConfigInfo<cr>", "Info" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
  },
  s = {
    name = "Search",
    b = { "<cmd> lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" },
    c = { "<cmd> lua require('telescope.builtin').colorscheme()<cr>", "Colorscheme" },
    s = { "<cmd> lua require('telescope.builtin').lsp_document_symbols()<cr>", "Document Symbols" },
    S = { "<cmd> lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", "Workspace Symbols" },
    d = { "<cmd> lua require('telescope.builtin').lsp_document_diagnostics()<cr>", "Document Diagnostics" },
    D = { "<cmd> lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", "Workspace Diagnostics" },
    m = { "<cmd> lua require('telescope.builtin').lsp_implementations()<cr>", "Workspace Diagnostics" },
    h = { "<cmd> lua require('telescope.builtin').help_tags()<cr>", "Find Help" },
    -- m = {"<cmd> lua require('telescope.builtin').marks()<cr>", "Marks"},
    M = { "<cmd> lua require('telescope.builtin').man_pages()<cr>", "Man Pages" },
    R = { "<cmd> lua require('telescope.builtin').oldfiles()<cr>", "Open Recent File" },
    -- R = { "<cmd>Telesope registers<cr>", "Registers" },
    t = { "<cmd> lua require('telescope.builtin').live_grep()<cr>", "Text" },
    k = { "<cmd> lua require('telescope.builtin').keymaps()<cr>", "Keymappings" },
    o = { "<cmd>TodoTelescope<cr>", "TODOs" },
    q = { "<cmd> lua require('telescope.builtin').quickfix()<cr>", "Quickfix" },
    i = "for (object)",
    r = "and Replace",
  },
  r = {
    name = "Replace/Refactor",
    n = { "<cmd>lua require('lsp.functions').rename()<CR>", "Rename" },
    t = "Rename TS",
    ["/"] = "Last search",
    ["+"] = "Last yank",
    ["."] = "Last insert",
    -- r = { [[<cmd>lua require("lv-utils").change_all_operator()<CR>]], "@Replace" },
    d = { "<cmd>DogeGenerate<cr>", "DogeGen" },
  },
  c = "Change all",
  d = {
    name = "Diagnostics",
    j = { [[<cmd>lua require("lsp.functions").diag_next()<cr>]], "Next" },
    k = { [[<cmd>lua require("lsp.functions").diag_prev()<cr>]], "Previous" },
    i = { "<cmd>lua require('lsp.functions').toggle_diagnostics()<CR>", "Toggle Inline" },
    l = { "<cmd>lua require('lsp.functions').diag_line()<CR>", "Line Diagnostics" },
  },
  P = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>luafile %<cr>", "Reload" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  a = {
    name = "+Swap",
    [" "] = { "<cmd>ISwap<cr>", "Interactive" },
    ["w"] = { "<cmd>ISwapWith<cr>", "I. With" },
  },
  -- m = "Multi",
  m = "which_key_ignore",
}

for k, v in pairs(O.plugin_which_keys) do
  mappings[k] = v
end
if O.plugin.symbol_outline.active then
  mappings["o"]["s"] = { "<cmd>SymbolsOutline<cr>", "Symbols Sidebar" }
end
if O.plugin.todo_comments.active then
  mappings["o"]["T"] = { "<cmd>TodoTrouble<cr>", "Todos Sidebar" }
end
if O.plugin.trouble.active then
  mappings["d"]["t"] = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" }
  mappings["d"]["d"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document" }
  mappings["d"]["w"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace" }
  mappings["d"]["r"] = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
  mappings["d"]["D"] = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" }
  mappings["d"]["q"] = { "<cmd>TroubleToggle quickfix<cr>", "Quick Fixes" }
  mappings["d"]["L"] = { "<cmd>TroubleToggle loclist<cr>", "Location List" }
  mappings["d"]["o"] = { "<cmd>TroubleToggle todo<cr>", "TODOs" }
end
if O.plugin.gitlinker.active then
  mappings["gy"] = "Gitlink"
end
if O.plugin.zen.active then
  mappings["z"] = {
    name = "Zen",
    -- z  = {"<cmd>ZenMode<CR>", "ZenMode"},
    z = { "<cmd>TZAtaraxis<CR>", "Ataraxis" },
    f = { "<cmd>TZFocus<CR>", "Focus" },
    m = { "<cmd>TZMinimalist<CR>", "Minimalist" },
  }
end
if O.plugin.telescope_project.active then
  mappings["p"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
end
if O.plugin.spectre.active then
  mappings["rf"] = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current File" }
  mappings["rp"] = { "<cmd>lua require('spectre').open()<cr>", "Project" }
end
if O.plugin.lazygit.active then
  mappings["gg"] = { "<cmd>LazyGit<CR>", "LazyGit" }
end
if O.lang.latex.active then
  mappings["L"] = {
    name = "Latex",
    f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
    i = { "<cmd>VimtexInfo<cr>", "Project Information" },
    s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
    t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
    v = { "<cmd>VimtexView<cr>", "View PDF" },
    c = { "<cmd>VimtexCompile<cr>", "Compile Project Latex" },
    o = { "<cmd>VimtexCompileOutput<cr>", "Compile Output Latex" },
  }
end
if O.lushmode then
  mappings["L"] = {
    name = "+Lush",
    l = { "<cmd>Lushify<cr>", "Lushify" },
    x = { "<cmd>lua require('lush').export_to_buffer(require('lush_theme.cool_name'))", "Lush Export" },
    t = { "<cmd>LushRunTutorial<cr>", "Lush Tutorial" },
    q = { "<cmd>LushRunQuickstart<cr>", "Lush Quickstart" },
  }
end
if O.plugin.magma.active then
  mappings["to"] = { "<CMD>MagmaShowOutput<CR>", "Magma Output" }
  mappings["tm"] = { "<CMD>MagmaInit<CR>", "Magma Init" }
end

local wk = require "which-key"
wk.register(mappings, opts)

--     local visualOpts = {
--         mode = "v", -- Visual mode
--         prefix = "<leader>",
--         buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--         silent = true, -- use `silent` when creating keymaps
--         noremap = true, -- use `noremap` when creating keymaps
--         nowait = false -- use `nowait` when creating keymaps
--     }
--     local visualMappings = {
--         ["/"] = {"<cmd>CommentToggle<cr>", "Comment"},
--         r = {
--             name = "Replace",
--             f = {
--                 "<cmd>lua require('spectre').open_visual({path = vim.fn.expand('%')})<cr>",
--                 "File"
--             },
--             p = {"<cmd>lua require('spectre').open_visual()<cr>", "Project"}
--         }
--     }
--     wk.register(visualMappings, visualOpts)

if O.plugin.surround.active then
  local ops = { mode = "o" }
  wk.register({ ["s"] = "Surround", ["S"] = "Surround Rest", ["ss"] = "Line" }, ops)
end
if O.plugin.lightspeed.active then
  local ops = { mode = "o" }
  wk.register({ ["z"] = "Light speed", ["Z"] = "Light speed bwd" }, ops)
end

local ops = { mode = "n" }
wk.register({ ["gy"] = "which_key_ignore", ["gyy"] = "which_key_ignore" }, ops)

-- FIXME: duplicate entries for some of the operators
