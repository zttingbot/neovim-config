---Diagnostic display, no plugin dependencies.
---
---Controls how errors and warnings from LSP servers and linters are shown.
---Since Neovim 0.11 virtual text is off by default, leaving only a sign and an
---underline; this turns the message back on at the end of the line.
---Colors come from the colorscheme's Diagnostic* highlight groups.
---@see :help vim.diagnostic.config()

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  -- When several diagnostics share a line, the most severe one wins: its sign
  -- is shown and it comes first in virtual text and floats.
  severity_sort = true,

  -- Wait until insert mode is left instead of redrawing on every keystroke,
  -- which flags half-typed code as errors.
  update_in_insert = false,

  -- Underline errors and warnings only; hints and info (e.g. "is not
  -- accessed") keep just their sign and message.
  underline = { severity = { min = severity.WARN } },

  -- Message at the end of the line. The server name is added only when more
  -- than one server reports diagnostics for the buffer.
  virtual_text = { spacing = 2, source = "if_many", prefix = "●" },

  -- Nerd Font icons in the sign column, instead of the default E/W/I/H letters.
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.INFO] = " ",
      [severity.HINT] = "󰌵 ",
    },
  },

  -- Full-message popup (<C-w>d, and after ]d / [d below). Its border comes from
  -- vim.o.winborder in config/options.lua.
  float = { source = "if_many" },

  -- ]d / [d also open the float, for messages too long for virtual text.
  jump = {
    ---@param diagnostic vim.Diagnostic?
    ---@param bufnr integer
    on_jump = function(diagnostic, bufnr)
      if diagnostic then
        vim.diagnostic.open_float({ bufnr = bufnr })
      end
    end,
  },
})
