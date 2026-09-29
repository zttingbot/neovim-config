---conform.nvim: run code formatters on the current buffer.
---
---Calls an external formatter (stylua, prettier, ...) for the buffer's
---filetype and applies the result as a minimal diff, so marks, folds and the
---cursor stay put. Filetypes without a formatter listed here fall back to
---their language server's formatting. Formatting is manual: nothing runs on
---save. :ConformInfo shows which formatters apply to the current buffer and
---whether they are installed.
---@see https://github.com/stevearc/conform.nvim
---@see :help conform

---@type LazySpec
return {
  "stevearc/conform.nvim",
  -- Load on the first :ConformInfo or keymap below, not at startup.
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      -- In visual mode only the selected lines are formatted.
      mode = { "n", "x" },
      desc = "Format buffer or selection",
    },
  },
  opts = {
    -- Formatters are binaries conform runs, not plugins, so each one must be
    -- installed through mason: every formatter listed here must also be in
    -- PACKAGES in plugins/lsp/mason-tool-installer.lua.
    formatters_by_ft = {
      -- stylua reads stylua.toml at the config root.
      lua = { "stylua" },
      -- ruff reads ruff.toml / pyproject.toml ([tool.ruff]) from the project.
      python = { "ruff_format" },
    },
    default_format_opts = {
      -- No formatter listed for the filetype: ask the language server
      -- instead. Not every server can format; :ConformInfo shows what
      -- applies to the current buffer.
      lsp_format = "fallback",
    },
  },
}
