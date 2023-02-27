return {
  {
    dir = _G.CONFIG_PATH .. "/kitty.lua",
    config = function()
      local K = require "kitty"
      K.setup()
      vim.api.nvim_create_user_command("Kitty", function(args)
        local program = args.args
        if program == "" then
          program = O.termshell
        end
        K.open(program)
        vim.keymap.set("n", "<localleader>c", K.send_current_line, { desc = "Kitty Cell" })
        vim.keymap.set("n", "<localleader>k", function()
          vim.ui.input({
            prompt = "Kitty: K",
            default = K.last_cmd()[2],
          }, function(input)
            K.send(input)
          end)
        end, { desc = "Kitty Cmd" })
        -- vim.keymap.set("n", "", require("kitty").send_cell, { buffer = 0 })
      end, {})
    end,
    cmd = "Kitty",
    keys = {
      {
        "<leader>ok",
        "<cmd>Kitty<cr>",
        desc = "Kitty Open",
      },
    },
  },
  -- https://github.com/Olical/conjure
  {
    "michaelb/sniprun",
    build = "bash ./install.sh 1",
    opts = {
      selected_interpreters = { "Python3_fifo" },
      repl_enable = { "Python3_fifo" },

      display = { "Terminal", "VirtualTextOk", "LongTempFloatingWindowErr", "NvimNotifyErr" },
      live_mode_toggle = "enable",
    },
    cmd = "SnipRun",
    keys = {
      { "<leader>xx", "<Plug>SnipRun", desc = "SnipRun Line" },
      { "<leader>x", "<Plug>SnipRunOperator", desc = "SnipRun" },
      { "<leader>x", "<Plug>SnipRun", desc = "SnipRun", mode = "x" },
      { "<leader>tQ", "<Plug>SnipReset", desc = "SnipRun Reset" },
      { "<leader>tq", "<Plug>SnipReplMemoryClean", desc = "SnipRun Clean" },
      { "<leader>ti", "<Plug>SnipInfo", desc = "SnipRun Info" },
      { "<leader>tl", "<Plug>SnipLive", desc = "SnipRun Live" },
      { "<leader>tc", "<Plug>SnipClose", desc = "SnipRun Close" },
    },
  },
  -- TODO: Figure all this bullshit out
  -- {
  --   "numToStr/FTerm.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lv-terms").fterm()
  --   end,
  --   disable = not O.plugin.floatterm,
  -- },
  -- use {
  --   "dccsillag/magma-nvim",
  --   setup = function()
  --     require("lv-terms").magma()
  --   end,
  --   run = ":UpdateRemotePlugins",
  --   -- python3.9 -m pip install cairosvg pnglatex jupyter_client ipython ueberzug pillow
  --   -- cmd = "MagmaStart", -- see lv-terms
  --   disable = not O.plugin.magma,
  -- }
  -- -- Better neovim terminal
  -- use {
  --   "kassio/neoterm",
  --   config = function()
  --     require("lv-terms").neoterm()
  --   end,
  --   cmd = {
  --     "T",
  --     "Tmap",
  --     "Tnew",
  --     "Ttoggle",
  --     "Topen",
  --   },
  --   keys = {
  --     "<Plug>(neoterm-repl-send)",
  --     "<Plug>(neoterm-repl-send-line)",
  --   },
  --   disable = not O.plugin.neoterm,
  -- }
  -- use {
  --   "CRAG666/code_runner.nvim",
  --   config = function()
  --     require("lv-terms").coderunner()
  --   end,
  --   cmd = { "CRFileType", "CRProjects", "RunCode", "RunFile", "RunProject" },
  --   disable = not O.plugin.coderunner,
  -- }
  -- use {
  --   "jubnzv/mdeval.nvim",
  --   config = function()
  --     require("lv-terms").mdeval()
  --   end,
  -- }
  -- use { "goerz/jupytext.vim" }
  -- use {
  --   "untitled-ai/jupyter_ascending.vim",
  --   setup = function()
  --     vim.g.jupyter_ascending_default_mappings = false
  --   end,
  -- }
  -- use {
  --   "pianocomposer321/yabs.nvim",
  --   config = function()
  --     require("lv-yabs").config()
  --   end,
  --   module = { "yabs", "telescope._extensions.yabs" },
  --   disable = not O.plugin.yabs,
  -- }
  -- -- use { -- TODO: configure vs-tasks
  -- --   "EthanJWright/vs-tasks.nvim",
  -- --   config = function() end,
  -- -- }
  -- use {
  --   "michaelb/sniprun",
  --   run = "bash install.sh",
  --   config = function()
  --     require("lv-terms").sniprun()
  --   end,
  --   cmd = { "SnipRun", "SnipInfo" },
  --   disable = not O.plugin.sniprun,
  -- }
  -- use {
  --   "IndianBoy42/kitty-runner.nvim",
  --   config = function()
  --     require("lv-terms").kitty()
  --   end,
  --   cmd = {
  --     "KittyOpen",
  --     "KittyOpenLocal",
  --     "KittyReRunCommand",
  --     "KittySendLines",
  --     "KittyRunCommand",
  --     "KittyClearRunner",
  --     "KittyKillRunner",
  --   },
  --   disable = not O.plugin.kittyrunner,
  -- }
  -- https://github.com/lpoto/telescope-tasks.nvim
}
