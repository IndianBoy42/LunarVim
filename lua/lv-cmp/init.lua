local M = {}
local texsym, _ = require("nvim-web-devicons").get_icon("main.tex", "tex")
local iconmap = {
  buffer = "   [Buffer]",
  path = "   [Path]",
  nvim_lsp = "   [LSP]",
  -- luasnip = "   [Luasnip]",
  spell = "暈[Spell]",
  nvim_lua = " [Lua]",
  latex_symbols = texsym .. " [Latex]",
  calc = "   [Calc]",
}
local default_sources = {
  {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "copilot" },
  },
  {
    -- { name = "buffer" },
    { name = "path" },
    -- { name = "latex_symbols" },
    { name = "calc" },
    -- { name = "cmp_tabnine" },
  },
}
function M.sources(list)
  local cmp = require "cmp"
  cmp.setup.buffer { sources = cmp.config.sources(unpack(list)) }
end

function M.autocomplete(enable)
  require("cmp").setup.buffer { completion = { autocomplete = enable } }
end

function M.add_sources(highprio, lowprio)
  M.sources(vim.list_extend(vim.list_extend({ highprio }, default_sources), { lowprio }))
end

function M.setup()
  local cmp = require "cmp"
  local lspkind = require "lspkind"
  local luasnip = require "luasnip"

  local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local feedkeys = vim.api.nvim_feedkeys
  local function check_back_space()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
  end

  function M.supertab(when_cmp_visible)
    return function()
      if cmp.visible() then
        when_cmp_visible()
      elseif luasnip.expand_or_jumpable() then
        feedkeys(t "<Plug>luasnip-expand-or-jump", "", false)
      else
        local ok, neogen = pcall(require, "neogen")
        if ok and neogen.jumpable() then
          feedkeys(t "<cmd>lua require'neogen'.jump_next()<cr>", "", false)
        elseif check_back_space() then
          feedkeys(t "<tab>", "n", false)
        else
          feedkeys(t "<Plug>(Tabout)", "", false)
          -- fallback()
        end
      end
    end
  end

  local confirmopts = {
    select = false,
  }
  local cmdline_confirm = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  }

  local function double_mapping(invisible, visible)
    return cmp.mapping(function()
      if cmp.visible() then
        visible()
      else
        invisible()
      end
    end, {
      "i",
      "s",
      "c",
    })
  end

  local function autocomplete()
    cmp.complete { reason = cmp.ContextReason.Auto }
  end

  local function complete_or(mapping)
    return double_mapping(autocomplete, mapping)
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = "menu,menuone,noinsert",
      -- autocomplete = true,
    },
    preselect = cmp.PreselectMode.None,
    -- confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },
    -- experimental = { ghost_text = true },

    window = {
      documentation = cmp.config.window.bordered {
        border = "single",
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
      },
    },

    -- TODO: better mapping setup for enter, nextitem and close window
    mapping = {
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      -- ["<C-p>"] = cmp.mapping.select_prev_item(),
      -- ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = complete_or(cmp.select_prev_item),
      ["<C-n>"] = complete_or(cmp.select_next_item),
      ["<Down>"] = cmp.mapping {
        i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      },
      ["<Up>"] = cmp.mapping {
        i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      },
      ["<M-l>"] = complete_or(cmp.confirm),
      -- TODO: overload this with Luasnip close choice node
      ["<M-h>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
      ["<Esc>"] = cmp.mapping(cmp.mapping.close(), { "c" }),
      -- ["<Esc>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
      -- ["<Left>"] = cmp.mapping.close(confirmopts),
      -- ["<Right>"] = cmp.mapping {
      --   c = cmp.mapping.confirm(cmdline_confirm),
      -- },
      ["<CR>"] = cmp.mapping {
        i = cmp.mapping.confirm(confirmopts),
        -- c = cmp.mapping.confirm(cmdline_confirm),
      },
      ["<Tab>"] = cmp.mapping {
        c = cmp.mapping.confirm(cmdline_confirm),
        -- i = cmp.mapping.confirm(confirmopts),
        i = M.supertab(cmp.select_next_item),
      },
      ["<S-TAB>"] = cmp.mapping {
        c = function()
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
          else
            autocomplete()
          end
        end,
        i = M.supertab(cmp.select_prev_item),
      },
    },

    -- You should specify your *installed* sources.
    sources = cmp.config.sources(unpack(default_sources)),

    formatting = {
      format = lspkind.cmp_format(O.plugin.cmp.lspkind),
    },
    -- formatting = {
    --   format = function(entry, vim_item)
    --     -- fancy icons and a name of kind
    --     vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
    --     -- set a name for each source
    --     vim_item.menu = iconmap[entry.source.name]
    --     return vim_item
    --   end,
    -- },
  }

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
      { name = "cmdline_history" },
    },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline("=", {
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }, {
      { name = "cmdline_history" },
    }),
  })
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }, {
      { name = "cmdline_history" },
    }),
  })
end

return M
