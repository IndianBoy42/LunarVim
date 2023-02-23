local M = {}
M.setup = function()
  vim.defer_fn(function()
    require("copilot").setup {
      panel = {
        auto_refresh = false,
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4,
        },
      },
    }
  end, 500)
end
M.setup_cmp = function()
  require("copilot_cmp").setup {
    formatters = {
      insert_text = require("copilot_cmp.format").remove_existing,
    },
  }
end
return M
