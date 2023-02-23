local M = {}

function M.config()
  -- Buffer line setup
  require("bufferline").setup {
    options = {
      indicator = {
        style = "icon",
        icon = "▎",
      },
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      close_command = "bdelete %d",
      right_mouse_command = "bdelete! %d",
      left_trunc_marker = "",
      right_trunc_marker = "",
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          text_align = "center",
          padding = 1,
        },
      },
      show_tab_indicators = true,
      show_close_icon = false,
    },
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      -- background = {
      --     guifg = {attribute = "fg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "StatusLine"}
      -- },
      -- buffer_visible = {
      --     gui = "",
      --     guifg = {attribute = "fg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "Normal"}
      -- },
      -- buffer_selected = {
      --     gui = "",
      --     guifg = {attribute = "fg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "Normal"}
      -- },
      -- separator = {
      --     guifg = {attribute = "bg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "StatusLine"}
      -- },
      -- separator_selected = {
      --     guifg = {attribute = "fg", highlight = "Special"},
      --     guibg = {attribute = "bg", highlight = "Normal"}
      -- },
      -- separator_visible = {
      --     guifg = {attribute = "fg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "StatusLineNC"}
      -- },
      -- close_button = {
      --     guifg = {attribute = "fg", highlight = "Normal"},
      --     guibg = {attribute = "bg", highlight = "StatusLine"}
      -- },
      -- close_button_selected = {
      --     guifg = {attribute = "fg", highlight = "normal"},
      --     guibg = {attribute = "bg", highlight = "normal"}
      -- },
      -- close_button_visible = {
      --     guifg = {attribute = "fg", highlight = "normal"},
      --     guibg = {attribute = "bg", highlight = "normal"}
      -- }
    },
  }
end

function M.keymaps(leaderMappings)
  leaderMappings["h<TAB>"] = { "<cmd>BufferLinePick<cr>", "Buffers/Tabs" }
end

return M
