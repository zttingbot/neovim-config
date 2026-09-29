---mason-tool-installer: install mason packages from a list, on every machine.
---
---mason.nvim has no list of packages to install, and mason-lspconfig's
---ensure_installed only accepts language servers. This plugin takes one list
---for everything: language servers and the tools conform runs. It only
---installs; mason-lspconfig (plugins/lsp/lspconfig.lua) enables the servers.
---:MasonToolsInstall installs missing entries by hand, :MasonToolsUpdate
---updates them.
---@see https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

---Packages to install. Missing ones are installed in the background at
---startup, so this list is what makes a package part of the config on every
---machine; installing from :Mason alone affects the current machine only.
---
---Servers use lspconfig names (`lua_ls`, not `lua-language-server`; see
---:help lspconfig-all), translated through mason-lspconfig. Other tools use
---mason package names, as :Mason shows them. A formatter that also has an
---lspconfig config (e.g. stylua) must be in automatic_enable's exclude in
---plugins/lsp/lspconfig.lua, or it is started as a server too.
local PACKAGES = {
  -- Language servers ----------------------------------------------------------

  -- Lua
  "lua_ls",

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

  -- Formatters (run by conform, plugins/coding/conform.lua) -------------------

  "stylua", -- Lua
  "ruff", -- Python
}

---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- mason-lspconfig translates the lspconfig names above to mason packages.
  dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
  lazy = false,
  opts = {
    ensure_installed = PACKAGES,
  },
}
