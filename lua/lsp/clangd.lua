local M = {}
M.setup = function() end
M.ftplugin = function()
  local lsp_status = require "lsp-status"
  vim.opt_local.commentstring = [[// %s]]

  local lspconfig = require "lspconfig"
  local lsputil = lspconfig.util

  local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = lsputil.validate_bufnr(bufnr)
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    vim.lsp.buf_request(
      bufnr,
      "textDocument/switchSourceHeader",
      params,
      lsputil.compat_handler(function(err, result)
        if err then
          error(tostring(err))
        end
        if not result then
          print "Corresponding file can’t be determined"
          return
        end
        vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
      end)
    )
  end

  local clangd_flags = { "--background-index", "--query-driver=**/arm-none-eabi-*,**/x86_64-linux-*" }
  table.insert(clangd_flags, "--cross-file-rename")
  table.insert(clangd_flags, "--header-insertion=never")

  -- TODO: clangd_extensions + lsp-installer??
  require("clangd_extensions").setup {
    server = {
      -- cmd = require("lsp.config").get_cmd "clangd",
      -- cmd_env = require("lsp.config").get_cmd_env "clangd",

      extra_cmd_args = clangd_flags,
      commands = {
        ClangdSwitchSourceHeader = {
          function()
            switch_source_header_splitcmd(0, "edit")
          end,
          description = "Open source/header in current buffer",
        },
        ClangdSwitchSourceHeaderVSplit = {
          function()
            switch_source_header_splitcmd(0, "vsplit")
          end,
          description = "Open source/header in a new vsplit",
        },
        ClangdSwitchSourceHeaderSplit = {
          function()
            switch_source_header_splitcmd(0, "split")
          end,
          description = "Open source/header in a new split",
        },
      },

      init_options = { clangdFileStatus = true },
      handlers = lsp_status.extensions.clangd.setup(),
      capabilities = (function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = { "utf-16" }
        return capabilities
      end)(),
    },
    extensions = {
      -- defaults:
      -- Automatically set inlay hints (type hints)
      autoSetHints = true,
      -- Whether to show hover actions inside the hover window
      -- This overrides the default hover handler
      hover_with_actions = true,
      -- These apply to the default ClangdSetInlayHints command
      inlay_hints = {
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- wheter to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- whether to show variable name before type hints with the inlay hints or not
        show_variable_name = false,
        parameter_hints_prefix = O.lsp.parameter_hints_prefix,
        other_hints_prefix = O.lsp.other_hints_prefix,
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
      },
    },
  }
end
return M
