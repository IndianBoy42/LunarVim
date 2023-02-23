--- COLORSCHEME ---

-- My fav/common themes
utils.new_command.Zenbones = "colorscheme zenbones"
utils.new_command.Kanagawa = "colorscheme kanagawa"
utils.new_command.Nordbones = "colorscheme nordbones"
utils.new_command.LightMelya = "colorscheme light_melya"
utils.new_command.Nebulous = "lua require'theme'.nebulous()"
utils.new_command.Onedark = "lua require'theme'.theme('onedark')"
utils.new_command.Kurai = "lua require'theme'.theme('kurai')"
utils.new_command.Material = "lua require'theme'.material()"
utils.new_command.Rdark = "lua require('colorbuddy').colorscheme('nvim-rdark')"
utils.new_command.DarkCatppuccino = "colorscheme catppuccin"
utils.new_command.Acme = "colorscheme acme"
utils.new_command.Pencil = "colorscheme pencil"
utils.new_command.Paper = "colorscheme paper"
utils.new_command.Parchment = "colorscheme parchment"
utils.new_command.ModusOperandi = "colorscheme modus-operandi"
utils.new_command.ModusVivendi = "colorscheme modus-vivendi"
utils.new_command.Writing = "lua vim.cmd(O.lighttheme)"

utils.augroup._nebulous_patches.Colorscheme.nebulous = function()
  vim.cmd [[
    hi Conceal ctermfg=223 ctermbg=235 guifg=#ebdbb2 guibg=#282828
    hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
    hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
]]
end

local M = {
  nebulous = function()
    require("nebulous").setup {
      variant = "night",
      italic = {
        comments = true,
        keywords = false,
        functions = false,
        variables = false,
      },
      custom_colors = { -- FIXME: custom colors not bound
        -- Conceal = { ctermfg = "223", ctermbg = "235 ", guifg = "#ebdbb2", guibg = "#282828" },
        LspReferenceRead = { style = "bold", bg = "#464646" },
        LspReferenceText = { style = "bold", bg = "#464646" },
        LspReferenceWrite = { style = "bold", bg = "#464646" },
      },
    }
    -- vim.cmd "colorscheme nebulous"
  end,
  material = function()
    vim.g.material_style = "deep ocean"
    -- vim.g.material_style = "darker"
    require("material").setup {
      contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
      borders = true, -- Enable borders between verticaly split windows

      popup_menu = "dark", -- Popup menu style ( can be: 'dark', 'light', 'colorful' or 'stealth' )

      italics = {
        comments = true, -- Enable italic comments
        keywords = true, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false, -- Enable italic variables
      },

      contrast_windows = { -- Specify which windows get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf", -- Darker qf list background
      },

      text_contrast = {
        lighter = true, -- Enable higher contrast text for lighter style
        darker = true, -- Enable higher contrast text for darker style
      },

      disable = {},
      custom_highlights = {}, -- Overwrite highlights with your own
    }
    vim.cmd "colorscheme material"
  end,
  themer = function(theme)
    theme = theme or "onedark" or "kurai"
    local bg = {
      bg = {
        base = "#03070e",
      },
    }
    require("themer").setup {
      colorscheme = theme,
      styles = {
        comment = { style = "italic" },
        ["function"] = { style = "italic" },
        functionbuiltin = { style = "italic" },
        variable = { style = "italic" },
        variableBuiltIn = { style = "italic" },
        parameter = { style = "italic" },
      },
      remaps = {
        palette = {
          kurai = bg,
          kanagawa = bg,
          onedark = bg,
          dracula = bg,
          darknight = bg,
          [theme] = bg,
        },
      },
    }
    -- require("themer.modules.export.nvim").write_colorscheme(require("themer.modules.themes." .. theme))
  end,
}

return setmetatable(M, {
  __call = function(table)
    vim.cmd(O.theme)
  end,
})
-- use "pgdouyon/vim-alayas"
-- require("colorbuddy").colorscheme "onebuddy"
