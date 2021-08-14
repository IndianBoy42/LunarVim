---  HELPERS  ---
local cmd = vim.cmd
local opt = vim.opt

---  VIM ONLY COMMANDS  ---

cmd "filetype plugin on"
cmd "set iskeyword+=-"
cmd "set sessionoptions+=globals"
cmd "set whichwrap+=<,>,[,],h,l"
if O.transparent_window then
  cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
  cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
end

--- COLORSCHEME ---

vim.cmd "hi Conceal ctermfg=223 ctermbg=235 guifg=#ebdbb2 guibg=#282828"

---  SETTINGS  ---
-- https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
opt.inccommand = O.inc_subs -- Incremental substitution style
opt.backspace = "indent,eol,start"
opt.backup = false -- creates a backup file
opt.clipboard = O.clipboard -- allows neovim to access the system clipboard
opt.cmdheight = O.cmdheight -- more space in the neovim command line for displaying messages
opt.colorcolumn = O.colorcolumn
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hidden = O.hidden_files -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = O.hl_search -- highlight all matches on previous search pattern
opt.ignorecase = O.ignore_case -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs
opt.smartcase = O.smart_case -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = O.timeoutlen -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.undofile = true -- enable persisten undo
opt.updatetime = 300 -- faster completion
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = O.shift_width -- the number of spaces inserted for each indentation
opt.shortmess:append "c"
opt.tabstop = O.tab_stop -- insert 4 spaces for a tab
opt.cursorline = O.cursorline -- highlight the current line
opt.number = O.number -- set numbered lines
opt.relativenumber = O.relative_number -- set relative numbered lines
opt.numberwidth = O.number_width -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = O.wrap_lines -- display lines as one long line
opt.linebreak = true -- dont linebreak in the middle of words
opt.spell = O.spell
opt.spelllang = O.spelllang
opt.scrolloff = O.scrolloff -- Scrolloffset to block the cursor from reaching the top/bottom
opt.breakindent = true -- Apply indentation for wrapped lines
opt.breakindentopt = "sbr" -- Apply indentation for wrapped lines
opt.pastetoggle = "<F3>" -- Enter Paste Mode with
opt.foldlevelstart = 99 -- Don't fold on startup
opt.foldcolumn = O.fold_columns -- Add fold indicators to number column
opt.foldmethod = "indent" -- Set default fold method as indent, although will be overriden by treesitter soon anyway
opt.lazyredraw = true -- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
opt.autowriteall = true -- auto write on focus lost
opt.sidescroll = 1
opt.sidescrolloff = 10
opt.listchars = { extends = ">", precedes = "<", trail = "_" }
opt.background = "dark"
vim.g.python3_host_prog = O.python_interp
