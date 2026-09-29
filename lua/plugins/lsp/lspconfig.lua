---nvim-lspconfig + mason-lspconfig: server configs, installed and enabled.
---
---Neovim 0.12 has a built-in LSP client (vim.lsp.config / vim.lsp.enable);
---nvim-lspconfig only ships default configs as `lsp/<server>.lua` (command,
---filetypes, root markers), so it needs no setup(). mason-lspconfig installs
---the servers in SERVERS through mason and calls vim.lsp.enable() for every
---mason-installed server.
---
---Keymaps are Neovim's defaults: K hover, grn rename, gra code action,
---grr references, gri implementation, grt type definition, gO document
---symbols, [d / ]d diagnostics, <C-s> signature help (insert mode).
---Check attached servers with :checkhealth vim.lsp.
---@see https://github.com/neovim/nvim-lspconfig
---@see https://github.com/mason-org/mason-lspconfig.nvim
---@see :help lsp
---@see :help mason-lspconfig

---Servers to install. Missing ones are installed in the background at
---startup, so this list is what makes a server part of the config on every
---machine; installing from :Mason alone affects the current machine only.
---
---Entries are lspconfig server names, not filetypes or mason package names
---(`lua_ls`, not `lua-language-server`); see :help lspconfig-all.
local SERVERS = {
  -- Lua
  "lua_ls",
  "stylua", -- formatter used by conform; also runs as a formatting-only server

  -- Shell and config formats
  "bashls",
  "jsonls",
  "taplo", -- TOML
  "yamlls",

  -- Programming languages
  "basedpyright", -- Python

  -- Web
  "cssls",
  "html",
  "vtsls", -- JavaScript and TypeScript
}

---@type LazySpec
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  lazy = false,
  opts = {
    ensure_installed = SERVERS,
    -- vim.lsp.enable() every mason-installed server, including ones added
    -- from :Mason outside SERVERS.
    automatic_enable = true,
  },
}
