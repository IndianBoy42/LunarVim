local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  -- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
  -- compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "plugin", "packer_compiled.vim"),
  -- compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "plugin", "packer_compiled.lua"),
  compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  snapshot_path = vim.fn.stdpath "config" .. "/packer_snapshots",
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  auto_reload_compiled = true,
  ensure_dependencies = true,
}

-- vim.cmd "autocmd BufWritePost plugins.lua luafile %" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lv-config.lua luafile %" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost plugins.lua PackerSync" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lv-config.lua PackerSync" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lv-config.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return packer.startup(function(use)
  local use_rock = packer.use_rocks
  local BufRead
  -- local BufRead = "BufRead"
  -- Format: :%g/^\s*use {\s*$/normal J

  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"
  use "lewis6991/impatient.nvim" -- Will be merged in https://github.com/neovim/neovim/pull/15436
  use {
    "nathom/filetype.nvim",
    -- setup = function()
    --   vim.g.did_load_filetypes = 1
    -- end,
    config = function()
      require("filetype").setup {
        overrides = O.filetypes,
      }
    end,
  }

  use_rock { "f-strings", "penlight" }

  use {
    "rcarriga/nvim-notify",
    config = function()
      require("lv-ui.notify").config()
    end,
    disable = not O.plugin.notify,
  }
  use {
    "hood/popui.nvim",
    requires = "RishabhRD/popfix",
  }

  -- Lsp Configs
  use { "neovim/nvim-lspconfig" }
  -- use "williamboman/nvim-lsp-installer"
  use {
    -- "kabouzeid/nvim-lspinstall",
    "https://github.com/williamboman/nvim-lsp-installer", -- Use this
    -- https://github.com/alexaandru/nvim-lspupdate.git
    config = function()
      require "lv-lspinstall"
    end,
    cmd = { "LspInstall", "LspInstallInfo", "LspUninstall", "LspUninstallAll", "LspInstallLog", "LspPrintInstalled" },
    module = "nvim-lsp-installer",
  }

  -- Utilities
  use { "nvim-lua/plenary.nvim" }

  -- Telescope - search through things
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "lv-telescope"
    end,
  }
  -- Use fzy for telescope
  use { "nvim-telescope/telescope-fzy-native.nvim", disable = not O.plugin.telescope_fzy }
  -- Use fzf for telescope
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", disable = not O.plugin.telescope_fzf }
  -- Telescope sort by frecency
  use { -- FIXME: load_extension doesn't work
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      -- require("telescope").load_extension "frecency"
    end,
    requires = { "tami5/sqlite.lua" },
    disable = not O.plugin.telescope_frecency,
  }
  use { "nvim-telescope/telescope-hop.nvim", requires = "telescope.nvim" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- whichkey
  use {
    "folke/which-key.nvim",
    -- config = function()
    --   vim.cmd [[au VimEnter * ++once lua require("which-key").load()]]
    -- end,
  }

  -- Coq_nvim based Autocomplete and snippets
  use {
    "ms-jpq/coq_nvim",
    branch = "coq",
    config = function()
      require("lv-coq").config()
    end,
    run = ":COQdeps",
    disable = not O.plugin.coq,
  }
  use { "ms-jpq/coq.artifacts", branch = "artifacts", after = "coq_nvim", disable = not O.plugin.coq }

  -- Nvim cmp based completions and snippets
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("lv-cmp").setup()
    end,
    disable = not O.plugin.cmp,
  }
  use {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init(O.plugin.cmp.lspkind)
    end,
  }
  use { "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  -- use { "kdheepak/cmp-latex-symbols", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-calc", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-nvim-lua", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "hrsh7th/cmp-omni", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "f3fora/cmp-spell", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "petertriho/cmp-git", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  use { "dmitmel/cmp-cmdline-history", requires = "hrsh7th/nvim-cmp", disable = not O.plugin.cmp }
  -- https://github.com/davidsierradz/cmp-conventionalcommis
  -- https://github.com/lukas-reineke/cmp-under-comparator
  -- https://github.com/lukas-reineke/cmp-rg
  -- https://github.com/David-Kunz/cmp-npm
  -- https://github.com/hrsh7th/cmp-emoji
  -- https://github.com/jc-doyle/cmp-pandoc-references
  -- Tabout
  use {
    "abecodes/tabout.nvim",
    config = function()
      require("lv-pairs").tabout()
    end,
    after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
    disable = not O.plugin.cmp,
  }
  -- Snippets plugin
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("lv-luasnips").setup()
    end,
    disable = not O.plugin.cmp or not O.plugin.luasnip,
  }
  use {
    "saadparwaiz1/cmp_luasnip",
    requires = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" },
    disable = not O.plugin.cmp or not O.plugin.luasnip,
  }
  -- Common set of snippets
  use { "rafamadriz/friendly-snippets", disable = not O.plugin.luasnip }
  -- Tabnine
  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    disable = not O.plugin.cmp or not O.plugin.tabnine,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("lv-pairs").autopairs()
    end,
    -- after = { "nvim-compe", "telescope.nvim" },
    after = "nvim-cmp",
    event = "InsertEnter",
  }

  use {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("lv-nvimtree").config()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("lv-gitsigns").config()
    end,
    event = "VimEnter",
  }

  -- Comments
  -- use {
  --   -- "b3nj5m1n/kommentary",
  --   "terrortylor/nvim-comment",
  --   config = function()
  --     require("nvim_comment").setup {
  --       hook = function()
  --         require("ts_context_commentstring.internal").update_commentstring()
  --       end,
  --     }
  --   end,
  --   keys = {"gc", "gC"},
  -- }
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = {
          ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          basic = true,
          ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
          extended = true,
          ---Includes gco, gcO, gcA
          extra = true,
        },
        toggler = { line = "gcc", block = "gCC" },
        opleader = { line = "gc", block = "gC" },
        -- pre_hook = function()
        --   return require("ts_context_commentstring.internal").calculate_commentstring()
        -- end,
      }
    end,
    module = "Comment",
    keys = { "gc", "gC" },
  }

  -- Create pretty comment frames
  use {
    "s1n7ax/nvim-comment-frame",
    config = function()
      require("nvim-comment-frame").setup {
        keymap = "gcf",
        multiline_keymap = "gC",
      }
    end,
  }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status Line and Bufferline
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "lv-lualine"
    end,
  }
  use "nvim-lua/lsp-status.nvim"
  use "SmiteshP/nvim-gps"

  use {
    "akinsho/nvim-bufferline.lua",
    --         "romgrk/barbar.nvim",
    config = function()
      require("lv-bufferline").config()
      --             require 'lv-barbar'.config()
    end,
  }
  use { "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } }

  -- Better motions
  use {
    "phaazon/hop.nvim",
    config = function()
      require("lv-hop").config()
    end,
    -- cmd = { "HopChar2", "HopChar1", "HopWord", "HopLine", "HopPattern" },
    -- module = "hop",
    disable = not O.plugin.hop,
  }
  use {
    "IndianBoy42/hop-extensions",
    disable = not O.plugin.hop,
  }
  -- Enhanced increment/decrement
  use {
    "monaqa/dial.nvim",
    config = function()
      require("lv-dial").config()
    end,
    keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
    disable = not O.plugin.dial,
  }
  -- Dashboard
  use {
    "glepnir/dashboard-nvim",
    event = "BufWinEnter",
    cmd = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks" },
    setup = function()
      require("lv-dashboard").preconf()
    end,
    config = function()
      require("lv-dashboard").config()
    end,
    disable = not O.plugin.dashboard,
  }
  -- TODO: try https://github.com/goolord/alpha-nvim (new dashboard plugin)

  use {
    "is0n/fm-nvim",
    config = function()
      require("fm-nvim").setup {
        config = {
          border = "rounded",
          height = 0.8,
          width = 0.8,
        },
      }
    end,
    cmd = { "Ranger", "Xplr", "Vifm", "Nnn", "Lf" },
  }

  -- matchup
  use {
    "andymass/vim-matchup",
    event = BufRead,
    setup = function()
      require("lv-matchup").config()
    end,
    disable = not O.plugin.matchup,
  }
  use { "theHamsta/nvim-treesitter-pairs", event = BufRead, disable = not O.plugin.ts_matchup }

  -- Vim Doge Documentation Generator
  -- use {
  --   "kkoomen/vim-doge",
  --   run = ":call doge#install()",
  --   cmd = "DogeGenerate",
  --   disable = not O.plugin.doge,
  -- }
  -- use {
  --   "nvim-treesitter/nvim-tree-docs",
  --   config = function()
  --     require("lv-treesitter.docs").config()
  --   end,
  -- }
  use {
    "ziontee113/syntax-tree-surfer",
    config = function()
      require("lv-treesitter.surfer").config()
    end,
  }
  use {
    "danymat/neogen",
    config = function()
      require("lv-neogen").config()
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Colorizer?
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufWinEnter",
    config = function()
      require "lv-colorizer"
    end,
    disable = not O.plugin.colorizer,
  }
  -- LSP Colors
  use { "folke/lsp-colors.nvim", event = BufRead, disable = not O.plugin.lsp_colors }

  -- Jump/Peek line number
  use {
    "nacro90/numb.nvim",
    event = BufRead,
    config = function()
      require("numb").setup(O.plugin.numb)
    end,
    disable = not O.plugin.numb,
  }

  -- Treesitter playground
  use {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    disable = not O.plugin.ts_playground,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = BufRead,
    config = function()
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#000000 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#C678DD gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      -- vim.opt.list = true
      -- vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup {
        char = "▏",
        filetype_exclude = { "help", "terminal", "dashboard" },
        buftype_exclude = { "terminal", "nofile" },
        char_highlight = "LineNr",
        show_trailing_blankline_indent = false,
        -- show_first_indent_level = false,
        space_char_blankline = " ",
        show_current_context = false,
        show_current_context_start = true,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
        -- space_char_highlight_list = {
        --   "IndentBlanklineIndent1",
        --   "IndentBlanklineIndent2",
        -- },
      }
    end,
    disable = not O.plugin.indent_line,
  }

  -- comments in context
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = BufRead,
    disable = not O.plugin.ts_context_commentstring,
  }

  -- Symbol Outline
  use {
    "simrat39/symbols-outline.nvim",
    setup = function()
      require("lv-symbols-outline").preconf()
    end,
    cmd = "SymbolsOutline",
    disable = not O.plugin.symbol_outline,
  }
  -- Diagnostics
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    disable = not O.plugin.trouble,
    config = function()
      require("lv-trouble").config()
    end,
  }
  -- Call tree
  use { "ldelossa/litee.nvim" }
  use {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("lsp.calltree").config()
    end,
    requires = { "ldelossa/litee.nvim" },
  }
  -- TODO: https://github.com/stevearc/aerial.nvim/
  -- Vista viewer (symbols)
  use { "liuchengxu/vista.vim", disable = not O.plugin.vista, cmd = "Vista" }
  -- Generic sidebar plugin
  use {
    "GustavoKatel/sidebar.nvim",
    config = function()
      require("lv-sidebar").config()
    end,
    cmd = "SidebarNvimToggle",
    disable = not O.plugin.sidebarnvim,
  }
  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require("lv-dap").dap()
    end,
    module = "dap",
    disable = not O.plugin.debug,
  }
  use {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("lv-dap").dapui()
    end,
    module = "dapui",
    disable = not O.plugin.debug,
  }
  -- Debugger installing
  use {
    "Pocco81/DAPInstall.nvim",
    cmd = { "DIInstall", "DIList", "DIUninstall" },
    module = "dap-install",
    disable = not O.plugin.dap_install,
  }
  -- Better quickfix
  use {
    "kevinhwang91/nvim-bqf",
    event = "QuickFixCmdPre",
    -- cmd = "copen",
    disable = not O.plugin.bqf,
  }
  -- Floating terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufRead",
    config = function()
      require("lv-terms").fterm()
    end,
    disable = not O.plugin.floatterm,
  }
  -- Search & Replace
  use {
    "windwp/nvim-spectre",
    module = "spectre",
    config = function()
      require("lv-spectre").setup()
    end,
    disable = not O.plugin.spectre,
  }
  -- lsp root with this nvim-tree will follow you
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup(O.plugin.project_nvim)

      require("telescope").load_extension "projects"
    end,
    cmd = "ProjectRoot",
    disable = not O.plugin.project_nvim,
  }
  -- Markdown preview
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    -- "previm/previm",
    setup = function()
      require("lv-mkdp").config()
    end,
    ft = "markdown",
    disable = not O.plugin.markdown_preview,
  }
  use { "ellisonleao/glow.nvim", run = ":GlowInstall", cmd = "Glow" }

  -- Interactive scratchpad
  use { "metakirby5/codi.vim", cmd = "Codi", disable = not O.plugin.codi }
  -- Highlight TODO comments
  use {
    "folke/todo-comments.nvim",
    event = BufRead,
    config = function()
      require("todo-comments").setup()
    end,
    disable = not O.plugin.todo_comments,
  }
  -- Git Blame
  use {
    "f-person/git-blame.nvim",
    setup = function()
      vim.g.gitblame_enabled = 0
    end,
    cmd = "GitBlameToggle",
    disable = not O.plugin.git_blame,
  }
  use {
    "ruifm/gitlinker.nvim",
    keys = "<leader>gy",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup(O.plugin.gitlinker)
    end,
    disable = not O.plugin.gitlinker,
  }
  -- Octo.nvim
  use { "pwntester/octo.nvim", cmd = "Octo", disable = not O.plugin.octo }
  -- Diffview
  use {
    "sindrets/diffview.nvim",
    config = function()
      require("lv-diffview").config()
    end,
    ft = "diff",
    module = "diffview",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    disable = not O.plugin.diffview,
  }
  -- Easily Create Gists
  use {
    "mattn/vim-gist",
    cmd = "Gist",
    disable = not O.plugin.gist,
    requires = "mattn/webapi-vim",
  }
  -- HTML preview
  use {
    "turbio/bracey.vim",
    cmd = "Bracey",
    run = "npm install --prefix server",
    disable = not O.plugin.bracey,
  }

  -- Tmux navigator
  use { "christoomey/vim-tmux-navigator", disable = not O.plugin.tmux_navigator }

  use {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        vim.schedule(function()
          require("copilot").setup()
        end)
      end)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  }
  -- use {
  --   "github/copilot.vim",
  --   setup = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_enabled = true
  --     -- vim.g.copilot_filetypes = { ["*"] = false }
  --   end,
  --   config = function()
  --     local map = vim.keymap.set
  --     map("i", O.plugin.copilot.key, [[copilot#Accept("")]], { expr = true, silent = true })
  --   end,
  --   cmd = "Copilot",
  --   disable = not O.plugin.copilot,
  -- }

  -- LANGUAGE SPECIFIC GOES HERE

  use {
    "p00f/godbolt.nvim",
    config = function()
      require("godbolt").setup()
    end,
    cmd = { "Godbolt", "GodboltCompiler" },
  }

  -- Latex
  use {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require("lv-vimtex").config()
    end,
    disable = not O.plugin.vimtex,
  }
  -- use {
  --   "da-h/AirLatex.vim",
  --   setup = function()
  --     vim.g.AirLatexUsername = "cookies"
  --   end,
  --   run = ":UpdateRemotePlugins",
  --   ft = "tex",
  --   cmd = "AirLatex",
  -- }

  -- Rust tools
  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("lsp.rust").setup()
    end,
    ft = "rust",
    disable = not O.plugin.rust_tools,
  }
  use {
    "scalameta/nvim-metals",
    ft = "scala",
  }
  use {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("lsp.clangd").setup()
    end,
    ft = { "c", "cpp" },
  }
  use {
    "saecki/crates.nvim",
    branch = "main",
    config = function()
      require("lsp.rust").crates_setup()
    end,
    event = "BufRead Cargo.toml",
  }

  -- TODO: configure package-info.nvim
  use {
    "vuki656/package-info.nvim",
    config = function()
      require("lv-package-info").setup()
    end,
    event = "BufRead package.json",
  }

  -- Elixir
  use { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir", "euphoria3" } }

  -- Javascript / Typescript
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  }

  -- Flutter
  use {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "lv-flutter-tools"
    end,
    disable = not O.plugin.flutter_tools,
    ft = "dart",
  }

  -- Justfile
  use { "NoahTheDuke/vim-just", ft = "just" }
  use {
    "IndianBoy42/tree-sitter-just",
    config = function()
      require("tree-sitter-just").setup { ["local"] = true }
    end,
  }

  -- Fish shell
  -- use {"dag/vim-fish", ft = 'fish'} -- Treesitter highlighting is fine

  -- KMonad
  use { "kmonad/kmonad-vim", ft = "kmonad" }

  -- Json querying
  use { "gennaro-tedesco/nvim-jqx", ft = "json" }

  -- LSP get function signature
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup(O.plugin.lsp_signature)
    end,
  }

  -- Code action lightbulb
  use {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end,
    event = { "CursorHold", "CursorHoldI" },
    disable = not O.plugin.lightbulb,
  }

  -- Code action Menu
  use {
    "weilbith/nvim-code-action-menu",
    config = function()
      utils.augroup._lsputil_codeaction_list.Filetype["code-action-menu-menu"] = "nmap <buffer> K <CR>"
    end,
    cmd = "CodeActionMenu",
  }

  -- LSP Virtual Lines
  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").register_lsp_virtual_lines()
    end,
    disable = not O.plugin.lsp_lines,
  }

  -- See jumpable characters
  use {
    "unblevable/quick-scope",
    event = BufRead,
    setup = function()
      vim.g.qs_highlight_on_keys = O.plugin.quickscope.on_keys
    end,
    disable = not O.plugin.quickscope,
  }

  -- 2 letter find at lightspeed
  use {
    -- "ggandor/lightspeed.nvim",
    "ggandor/leap.nvim",
    config = function()
      require("lv-lightspeed").leap()
    end,
    disable = not O.plugin.lightspeed,
  }

  -- Multi cursor support
  use {
    "mg979/vim-visual-multi",
    setup = function()
      require("lv-visual-multi").preconf()
    end,
    event = BufRead,
    disable = not O.plugin.visual_multi,
  }

  -- Surround plugin
  use {
    "machakann/vim-sandwich",
    setup = function()
      require("lv-pairs").sandwich_setup()
    end,
    config = function()
      require("lv-pairs").sandwich()
    end,
    disable = not O.plugin.surround,
  }
  -- TODO: use surround.nvim

  -- fzf based search
  use { "junegunn/fzf", disable = not O.plugin.fzf } -- Telescope does most of this?
  use { "junegunn/fzf.vim", disable = not O.plugin.fzf }

  -- Run commands async
  -- use {"skywind3000/asyncrun.vim"}
  -- Build cmake projects from neovim
  -- use {"Shatur95/neovim-cmake"}

  -- Send to jupyter
  use {
    "dccsillag/magma-nvim",
    setup = function()
      require("lv-terms").magma()
    end,
    run = ":UpdateRemotePlugins",
    -- python3.9 -m pip install cairosvg pnglatex jupyter_client ipython ueberzug pillow
    -- cmd = "MagmaStart", -- see lv-terms
    disable = not O.plugin.magma,
  }
  -- Better neovim terminal
  use {
    "kassio/neoterm",
    config = function()
      require("lv-terms").neoterm()
    end,
    cmd = {
      "T",
      "Tmap",
      "Tnew",
      "Ttoggle",
      "Topen",
    },
    keys = {
      "<Plug>(neoterm-repl-send)",
      "<Plug>(neoterm-repl-send-line)",
    },
    disable = not O.plugin.neoterm,
  }
  -- Lua development helper
  use {
    "bfredl/nvim-luadev",
    config = function()
      require("lv-terms").luadev()
    end,
    cmd = "LuadevStart", -- see lv-terms
    disable = not O.plugin.luadev,
  }
  use { "rafcamlet/nvim-luapad", cmd = { "Luapad", "LuaRun" }, disable = not O.plugin.luapad }
  -- TODO: try these code running plugins
  use {
    "CRAG666/code_runner.nvim",
    config = function()
      require("lv-terms").coderunner()
    end,
    cmd = { "CRFileType", "CRProjects", "RunCode", "RunFile", "RunProject" },
    disable = not O.plugin.coderunner,
  }
  use {
    "jubnzv/mdeval.nvim",
    config = function()
      require("lv-terms").mdeval()
    end,
  }
  use { "goerz/jupytext.vim" }
  use {
    "untitled-ai/jupyter_ascending.vim",
    setup = function()
      vim.g.jupyter_ascending_default_mappings = false
    end,
  }
  use {
    "pianocomposer321/yabs.nvim",
    config = function()
      require("lv-yabs").config()
    end,
    module = { "yabs", "telescope._extensions.yabs" },
    disable = not O.plugin.yabs,
  }
  -- use { -- TODO: configure vs-tasks
  --   "EthanJWright/vs-tasks.nvim",
  --   config = function() end,
  -- }
  use {
    "michaelb/sniprun",
    run = "bash install.sh",
    config = function()
      require("lv-terms").sniprun()
    end,
    cmd = { "SnipRun", "SnipInfo" },
    disable = not O.plugin.sniprun,
  }
  use {
    "IndianBoy42/kitty-runner.nvim",
    config = function()
      require("lv-terms").kitty()
    end,
    cmd = {
      "KittyOpen",
      "KittyOpenLocal",
      "KittyReRunCommand",
      "KittySendLines",
      "KittyRunCommand",
      "KittyClearRunner",
      "KittyKillRunner",
    },
    disable = not O.plugin.kittyrunner,
  }

  -- Repeat plugin commands
  use "tpope/vim-repeat"

  -- Smart abbreviations, substitutions and case renaming
  use {
    "tpope/vim-abolish",
    event = "InsertEnter",
    config = function()
      require "lv-abolish"
    end,
    disable = not O.plugin.abolish,
  }

  -- See more character information in ga
  use { "tpope/vim-characterize", keys = { "ga" } }

  -- mkdir
  use {
    "jghauser/mkdir.nvim",
    config = function()
      require "mkdir"
    end,
  }

  -- Sudo write files
  use { "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } }

  -- Helper for lists
  -- FIXME: fucks up coq_nvim handling of <CR>
  use {
    "dkarter/bullets.vim",
    ft = { "txt", "markdown" }, -- TODO: what filetypes?
    disable = not O.plugin.bullets,
  }
  -- Render latex math as ASCII (FIXME: doesn't seem to work??)
  use { "jbyuki/nabla.nvim", module = "nabla", disable = not O.plugin.nabla }

  -- 'smooth' scrolling
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup(O.plugin.neoscroll)
    end,
    disable = not O.plugin.neoscroll,
  }

  -- Code Minimap
  -- use {
  --   "wfxr/minimap.vim",
  --   cmd = "MinimapToggle",
  --   run = "cargo install --locked code-minimap",
  --   config = function()
  --     table.insert(vim.g.minimap_block_filetypes, "dashboard")
  --     vim.g.minimap_width = 5 -- Like a scrollbar
  --     -- vim.g.minimap_highlight_search = true
  --     -- vim.g.minimap_highlight_range = true
  --   end,
  -- }
  use {
    "rinx/nvim-minimap",
    setup = function()
      vim.g["minimap#window#width"] = 5
      vim.g["minimap#window#height"] = 10000
    end,
    cmd = "MinimapToggle",
  }

  -- Session Management
  use { "rmagatti/auto-session" }
  use {
    "rmagatti/session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup { --[[your custom config--]]
      }
      require("telescope").load_extension "session-lens"
    end,
    cmd = "SearchSession",
  }
  -- https://github.com/tpope/vim-obsession

  -- treesitter extensions
  use { -- "jacfger/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-textobjects",
    disable = not O.plugin.ts_textobjects,
  }
  -- use { "indianboy42/ts-textobjects", disable = not O.plugin.ts_textobjects }
  use { "RRethy/nvim-treesitter-textsubjects", disable = not O.plugin.ts_textsubjects }
  use {
    "David-Kunz/treesitter-unit",
    config = function()
      vim.keymap.set("v", "x", require("treesitter-unit").select)
      -- vim.keymap.set("o", "x", '<cmd><c-u>lua require"treesitter-unit".select()<CR>')
      vim.keymap.set("o", "x", require("treesitter-unit").select)
    end,
    disable = not O.plugin.ts_textunits,
  }
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    config = function()
      local labels = {}
      O.hint_labels:gsub(".", function(c)
        vim.list_extend(labels, { c })
      end)
      require("tsht").config.hint_keys = labels -- Requires https://github.com/mfussenegger/nvim-ts-hint-textobject/pull/2
    end,
    module = "tsht",
    disable = not O.plugin.ts_hintobjects,
  }
  use {
    "mizlan/iswap.nvim",
    config = function()
      require("iswap").setup(O.plugin.ts_iswap)
    end,
    cmd = { "ISwap", "ISwapWith" },
    disable = not O.plugin.ts_iswap,
  }
  use { "tommcdo/vim-exchange" } -- TODO: may not actually need a whole plugin for this
  use {
    "windwp/nvim-ts-autotag",
    event = BufRead,
    ft = { "html", "php", "tsx", "javascript", "typescript" },
    disable = not O.plugin.ts_autotag,
  }
  use {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
    event = "WinScrolled",
    disable = not O.plugin.ts_context,
  }
  use { "p00f/nvim-ts-rainbow", disable = not O.plugin.ts_rainbow }
  use { "nvim-treesitter/nvim-treesitter-refactor" }
  use { "haringsrob/nvim_context_vt" }

  -- Startup profiler
  use {
    "dstein64/vim-startuptime",
    setup = function()
      vim.g.startuptime_exe_args = { "~/.config/nvim/plugins.lua" }
    end,
    cmd = "StartupTime",
    disable = not O.plugin.startuptime,
  }

  -- Visual undo tree
  use { "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeShow" }, disable = not O.plugin.undotree }

  -- Null ls, for hooking local plugins into lsp
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("lv-null-ls").config()
    end,
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }

  -- 'Smarter' pasting
  use {
    "IndianBoy42/nvim-anywise-reg.lua", -- AckslD
    -- AckslD/nvim-anywise-reg.lua
    event = BufRead,
    config = function()
      require("anywise_reg").setup(O.plugin.anywise_reg)
    end,
    disable = not O.plugin.anywise_reg,
  }

  -- Editorconfig support
  use {
    "editorconfig/editorconfig-vim",
    event = BufRead,
    config = function()
      require "lv-editorconfig"
    end,
    disable = not O.plugin.editorconfig,
  }

  -- Doesn't work?
  -- use {
  --   "famiu/nvim-reload",
  --   cmd = { "Reload", "Restart" },
  --   config = function()
  --     local reload = require "nvim-reload"
  --     reload.modules_reload_external = { "packer" }
  --     reload.vim_reload_dirs = { CONFIG_PATH, PLUGIN_PATH }
  --     reload.lua_reload_dirs = { CONFIG_PATH, PLUGIN_PATH }
  --     reload.post_reload_hook = function()
  --       vim.cmd "noh"
  --     end
  --   end,
  -- }

  use {
    "AndrewRadev/splitjoin.vim",
    setup = function()
      vim.g.splitjoin_split_mapping = "gs"
      vim.g.splitjoin_join_mapping = "gj"
    end,
    keys = { "gs", "gj" },
  }

  use {
    "Iron-E/nvim-libmodal",
    config = function()
      require("keymappings").libmodal_setup()
    end,
  }
  -- use { "Iron-E/nvim-tabmode", after = "nvim-libmodal" }

  -- Command line autocomplete
  use {
    "gelguy/wilder.nvim",
    config = function()
      require("lv-wilder").config()
    end,
    run = ":UpdateRemotePlugins",
    disable = not O.plugin.wilder,
    -- event = "CmdlineEnter",
  }

  -- Primeagens refactoring plugin
  use {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("lv-refactoring").setup()
    end,
    disable = not O.plugin.primeagen_refactoring,
  }

  -- Lowlight code outside the current context
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end,
    cmd = "Twilight",
    disable = not O.plugin.twilight,
  }
  -- Auto split management
  use {
    "beauwilliams/focus.nvim",
    config = function()
      local focus = require "focus"
      local conf = O.plugin.splitfocus
      focus.setup {
        winhighlight = conf.winhighlight,
        hybridnumber = conf.hybridnumber,
        relativenumber = conf.relative_number == nil and O.relative_number or conf.relative_number,
        number = conf.number == nil and O.number or conf.number,
        cursorline = conf.cursorline == nil and O.cursorline or conf.cursorline,
        signcolumn = conf.signcolumn,
      }
    end,
    disable = not O.plugin.splitfocus,
  }

  -- Unix style vim commands
  use {
    "tpope/vim-eunuch",
    cmd = {
      "Delete",
      "Unlink",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Wall",
      "SudoWrite",
      "SudoEdit",
    },
  }

  -- Orgmode clone
  use {
    "vhyrro/neorg",
    config = function()
      require("neorg").setup {
        -- Tell Neorg what modules to load
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.norg.concealer"] = {}, -- Allows for use of icons
          ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = "~/neorg",
              },
            },
          },
        },
      }
    end,
    ft = "norg",
    requires = "nvim-lua/plenary.nvim",
    disable = not O.plugin.neorg,
  }

  use {
    "notomo/gesture.nvim",
    config = function()
      require("lv-gestures").config()
    end,
    module = "gesture",
    disable = not O.plugin.gesture,
  }

  -- TODO: add and configure these packages
  -- Git
  use {
    "tpope/vim-fugitive",
    config = function()
      require("lv-fugitive").setup()
    end,
    cmd = { "G", "Git", "Gdiffsplit", "Gdiff" },
    disable = not O.plugin.fugitive,
  }
  -- use { "tpope/vim-rhubarb" }

  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup(O.plugin.better_escape)
    end,
    event = "InsertEnter",
    disable = not O.plugin.better_escape,
  }

  -- TODO: http://neovimcraft.com/plugin/chipsenkbeil/distant.nvim/index.html
  use {
    "chipsenkbeil/distant.nvim",
    config = function()
      require("lv-distant").config()
    end,
    cmd = "DistantLaunch",
  }
  -- TODO: https://github.com/jbyuki/instant.nvim (collaborative editing)
  use {
    "jbyuki/instant.nvim",
    cmd = {
      "InstantStartServer",
      "InstantStartSingle",
      "InstalJoinSingle",
      "InstantStartSession",
      "InstantJoinSession",
    },
  }
  use {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
    module = "substitute",
  }
  use {
    "booperlv/nvim-gomove",
    config = function()
      require("gomove").setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = false,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = true,
      }
    end,
  }
  use "antoinemadec/FixCursorHold.nvim"

  -- Colorschemes/Themes
  -- Lush - Create Color Schemes
  use {
    "rktjmp/lush.nvim",
    cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify" },
    module = "lush",
    disable = not O.plugin.lush,
  }
  use {
    "themercorp/themer.lua",
    branch = "dev",
  }
  use { "mangeshrex/uwu.vim" }
  -- Colorbuddy colorscheme helper
  use { "tjdevries/colorbuddy.vim", module = "colorbuddy" }
  -- Colorschemes -- https://github.com/folke/lsp-colors.nvim
  use { "Yagua/nebulous.nvim" }
  -- use { "christianchiarulli/nvcode-color-schemes.vim", opt = true }
  -- use {
  --   "catppuccin/nvim",
  --   config = function()
  --     local trues = utils.else_true {
  --       native_lsp = {
  --         enabled = true,
  --         virtual_text = {
  --           errors = "italic",
  --           hints = "italic",
  --           warnings = "italic",
  --           information = "italic",
  --         },
  --         underlines = {
  --           errors = "underline",
  --           hints = "underline",
  --           warnings = "underline",
  --           information = "underline",
  --         },
  --       },
  --       nvimtree = {
  --         enabled = true,
  --         show_root = true,
  --       },
  --       which_key = true,
  --       indent_blankline = {
  --         enabled = true,
  --         colored_indent_levels = true,
  --       },
  --     }
  --     require("catppuccin").setup {
  --       colorscheme = "dark_catppuccino", -- neon_latte
  --       term_colors = true,
  --       styles = {
  --         comments = "italic",
  --         functions = "NONE",
  --         keywords = "italic",
  --         strings = "NONE",
  --         variables = "NONE",
  --       },
  --       integrations = trues,
  --     }
  --   end,
  -- }
  -- use "mcchrish/zenbones.nvim"
  -- use "plan9-for-vimspace/acme-colors"
  -- use "preservim/vim-colors-pencil"
  use "YorickPeterse/vim-paper"
  -- use "ajgrf/parchment"
  -- use "pgdouyon/vim-yin-yang"
  -- use {
  --   "sainnhe/sonokai",
  --   setup = function()
  --     vim.g.sonokai_style = "atlantis" -- andromeda
  --   end,
  -- }
  use "tanvirtin/monokai.nvim"
  -- use "RishabhRD/nvim-rdark"
  use {
    "marko-cerovac/material.nvim",
  }
  -- use "Shatur/neovim-ayu"
  -- use "folke/tokyonight.nvim"
  -- use "dracula/vim"
  use "tomasiser/vim-code-dark"
  -- use "glepnir/zephyr-nvim"
  -- use "Th3Whit3Wolf/onebuddy" -- require('colorbuddy').colorscheme('onebuddy')
  use "ishan9299/modus-theme-vim"
  -- use "Th3Whit3Wolf/one-nvim"
  use "ray-x/aurora"
  -- use "tanvirtin/nvim-monokai"
  -- -- use "nekonako/xresources-nvim"
  -- use "bluz71/vim-moonfly-colors"
  -- use "klooj/noogies"
  -- use { "kuznetsss/meadow-nvim" }
  -- use {
  --   "olimorris/onedark.nvim",
  --   as = "olimorris-onedark-nvim",
  --   requires = "rktjmp/lush.nvim",
  -- }
  -- use { "navarasu/onedark.nvim", as = "navarasu-onedark-nvim" }
  -- use { "ful1e5/onedark.nvim", as = "ful1e5-onedark-nvim" }
  use {
    "rafamadriz/neon",
    setup = function()
      vim.g.neon_style = "dark"
      vim.g.neon_italic_keyword = true
      vim.g.neon_italic_function = true
      vim.g.neon_transparent = false
    end,
  }
  -- use {
  --   "adisen99/codeschool.nvim",
  --   config = function()
  -- local trues = setmetatable({}, { -- Return always true
  --   __index = function(tbl, key)
  --     return  true
  --   end,
  -- })
  --     require("codeschool").setup {
  --       plugins = trues,
  --       langs = trues,
  --     }
  --   end,
  --   requires = { "rktjmp/lush.nvim" },
  -- }

  -- https://github.com/rockerBOO/awesome-neovim -- collection

  -- alt nvim ide
  -- https://github.com/ibhagwan/nvim-lua
  -- https://github.com/lvim-tech/lvim
  -- https://github.com/NTBBloodbath/doom-nvim
  -- https://github.com/MenkeTechnologies/zpwr#zpwr-features

  -- Plugins
  -- https://github.com/kevinhwang91/nvim-hlslens
  -- use { "vim-scripts/tar.vim" }
  -- https://github.com/neomake/neomake
  -- https://github.com/justinmk/vim-dirvish -- netrw/nvim-tree alternative

  -- local metatable = {
  --   __newindex = function(table, repo, options)
  --     options[1] = table[1] .. "/" .. repo
  --     use(options)
  --   end,
  -- }
  -- local plugins_table = setmetatable({}, {
  --   __index = function(table, user)
  --     return setmetatable({ user }, metatable)
  --   end,
  -- })

  use { "seandewar/nvimesweeper", cmd = "Nvimesweeper" }

  -- stabilize.nvim
end)
