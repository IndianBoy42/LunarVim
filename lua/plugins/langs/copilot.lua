return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = function()
          return {
            formatters = {
              insert_text = require("copilot_cmp.format").remove_existing,
            },
          }
        end,
        config = true,
      },
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources(vim.list_extend({
        { name = "copilot" },
      }, opts.sources))
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "zbirenbaum/copilot.lua",
      opts = {
        panel = {
          auto_refresh = false,
          layout = {
            position = "right", -- | top | left | right
            ratio = 0.4,
          },
        },
      },
      config = true,
    },
  },
}
-- return {
--   "zbirenbaum/copilot-cmp",
--   dependencies = {
--     "zbirenbaum/copilot.lua",
--   },
--   event = "InsertEnter",
--   cmd = "Copilot",
--   config = function()
--     -- vim.defer_fn(function()
--     require("copilot").setup {
--       panel = {
--         auto_refresh = false,
--         layout = {
--           position = "right", -- | top | left | right
--           ratio = 0.4,
--         },
--       },
--     }
--     -- end, 500)
--     require("copilot_cmp").setup {
--       formatters = {
--         insert_text = require("copilot_cmp.format").remove_existing,
--       },
--     }
--   end,
-- }
