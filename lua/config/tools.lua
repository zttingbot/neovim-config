---Language servers, formatters and linters to install, no plugin dependencies.
---
---Plain data, read by two plugin specs:
---`lua/plugins/lsp/mason-tool-installer.lua` installs every entry, and
---`lua/plugins/lsp/lspconfig.lua` enables the servers. `init.lua` doesn't load
---this module; those specs `require()` it.
---
---These lists make a server or tool part of the config on every machine.
---Installing from `:Mason` alone affects the current machine only, and a
---server installed that way is not enabled.

---Language servers. Adding an entry installs the server and enables it.
---Entries are lspconfig names (`lua_ls`, not `lua-language-server`; see
---`:help lspconfig-all`), which mason-lspconfig translates to mason packages.
local SERVERS = {
  -- Lua
  "lua_ls",

  -- Shell and config formats
  "bashls",
  "jsonls",
  "taplo", -- TOML
  "yamlls",

  -- Programming languages
  "basedpyright", -- Python
  "ruff", -- Python linting; also conform's Python formatter

  -- Web
  "cssls",
  "html",
  "vtsls", -- JavaScript and TypeScript
}

---Formatters that conform runs (`lua/plugins/coding/conform.lua`). Adding an
---entry installs it but never starts it as a server. Entries are mason
---package names, as `:Mason` shows them.
local FORMATTERS = {
  "stylua", -- Lua
  "shfmt", -- shell scripts
  "prettier", -- web and data formats, in Prettier projects
}

---Linters that a language server runs by itself, e.g. shellcheck for bashls's
---diagnostics. Adding an entry installs it; nothing in this config starts it.
---Entries are mason package names, as `:Mason` shows them.
local LINTERS = {
  "shellcheck", -- shell scripts, through bashls
}

return {
  servers = SERVERS,
  formatters = FORMATTERS,
  linters = LINTERS,
}
