---nvim-lspconfig + mason-lspconfig: server configs, enabled when installed.
---
---Neovim 0.12 has a built-in LSP client (vim.lsp.config / vim.lsp.enable);
---nvim-lspconfig only ships default configs as `lsp/<server>.lua` (command,
---filetypes, root markers), so it needs no setup(). mason-lspconfig calls
---vim.lsp.enable() for every mason-installed server. Which servers get
---installed is listed in plugins/lsp/mason-tool-installer.lua.
---
---Keymaps are Neovim's defaults: K hover, grn rename, gra code action,
---grr references, gri implementation, grt type definition, gO document
---symbols, [d / ]d diagnostics, <C-s> signature help (insert mode).
---Check attached servers with :checkhealth vim.lsp.
---@see https://github.com/neovim/nvim-lspconfig
---@see https://github.com/mason-org/mason-lspconfig.nvim
---@see :help lsp
---@see :help mason-lspconfig

---@type LazySpec
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  lazy = false,
  opts = {
    -- vim.lsp.enable() every mason-installed server, including ones added
    -- from :Mason. stylua has an lspconfig config, so it would be enabled as
    -- a server; it's excluded because conform already runs it, and as a
    -- server it would also set 'formatexpr' in Lua buffers.
    automatic_enable = { exclude = { "stylua" } },
  },
}
