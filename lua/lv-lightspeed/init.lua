local M = {}

function M.config()
  require("lightspeed").setup {
    jump_to_unique_chars = { safety_timeout = 400 },
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    -- full_inclusive_prefix_key = "<c-x>", -- TODO: use <Plug>Lightspeed_X
    -- By default, the values of these will be decided at runtime,
    -- based on `jump_to_first_match`
    -- labels = O.hint_labels,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }
  -- vim.keymap.del({ "o", "x" }, ",")
  vim.keymap.set("n", "s", "<Plug>Lightspeed_omni_s")
end

function M.leap()
  require("leap").set_default_keymaps()
  -- vim.keymap.del({ "o", "x" }, ",")
end

function M.au_unconceal(level)
  vim.opt_local.conceallevel = level
  utils.define_augroups {
    _lightspeed_unconceal = {
      { "User", "LightspeedEnter", "setlocal conceallevel=0" },
      { "User", "LightspeedExit", "setlocal conceallevel=" .. level },
    },
  }
end

return M
