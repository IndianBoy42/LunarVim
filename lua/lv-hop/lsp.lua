local M = {}
local hop = require "hop"
local hint_with = hop.hint_with
local get_command_opts = hop.get_command_opts
local utils = require "telescope.util"
M.lsp_diagnostics = {
  get_hint_list = function(self, opts)
    local diags = utils.diagnostics_to_tbl()
  end,
}
M.lsp_symbols = {
  get_hint_list = function(self, hint_opts)
    -- TODO: complete this part
    local params = vim.lsp.util.make_position_params()
    local results_lsp, err = vim.lsp.buf_request_sync(
      0,
      "textDocument/documentSymbol",
      params,
      hint_opts.timeout or 10000
    )
    if err then
      vim.api.nvim_err_writeln("Error when finding document symbols: " .. err)
      return
    end

    if not results_lsp or vim.tbl_isempty(results_lsp) then
      print "No results from textDocument/documentSymbol"
      return
    end

    local locations = {}
    for _, server_results in pairs(results_lsp) do
      vim.list_extend(locations, vim.lsp.util.symbols_to_items(server_results.result, 0) or {})
    end

    locations = utils.filter_symbols(locations, {}) -- TODO: opts
    if locations == nil then
      -- error message already printed in `utils.filter_symbols`
      return
    end

    if vim.tbl_isempty(locations) then
      return
    end
  end,
}
M.hop_diagnostics = function(opts)
  hint_with(M.lsp_diagnostics, get_command_opts(opts))
end
M.hop_symbols = function(opts)
  hint_with(M.hint_lsp_symbols, get_command_opts(opts))
end
return M
