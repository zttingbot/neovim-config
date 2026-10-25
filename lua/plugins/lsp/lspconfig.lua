---nvim-lspconfig: default server configs, enabled from the list in `lua/config/tools.lua`.
---
---Neovim 0.12 has a built-in LSP client (`vim.lsp.config`, `vim.lsp.enable`).
---nvim-lspconfig only ships default configs as `lsp/<server>.lua` (command,
---filetypes, root markers), so it needs no `setup()`. This spec enables the
---servers listed in `lua/config/tools.lua`; mason-tool-installer installs the
---same list.
---
---The servers are enabled here, not by mason-lspconfig's `automatic_enable`:
---that loads mason's package registry to find the installed servers, which
---added about 80 ms to every startup. A fixed list costs about 15 ms. Tools
---that are both a formatter and a server (e.g. stylua) are never started as
---servers unless they are in the servers list.
---
---Keymaps are Neovim's defaults (`:help lsp-defaults`), listed in
---`docs/keymaps.md`. `:checkhealth vim.lsp` shows which servers are attached.
---@see https://github.com/neovim/nvim-lspconfig
---@see :help lsp

---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  -- mason's `setup()` puts its `bin/` on `$PATH`, which must happen before a
  -- server starts.
  dependencies = { "mason-org/mason.nvim" },
  ---Enable every listed server. A server starts when a buffer of one of its
  ---filetypes opens.
  config = function()
    vim.lsp.enable(require("config.tools").servers)
  end,
}
