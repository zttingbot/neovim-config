---jsonls overrides, merged over nvim-lspconfig's lsp/jsonls.lua.
---
---jsonls has no schemas of its own: without them it only checks JSON syntax.
---This gives it SchemaStore's catalog (`lua/plugins/lsp/schemastore.lua`), so
---known config files get key completion, hover docs and validation of their
---fields.
---
---`vim.lsp.enable()` reads this file at startup, so the catalog (a large
---table, ~25 ms to load) is required in `before_init` instead, which runs only
---when the server starts, i.e. when the first JSON buffer opens. The client
---keeps a reference to `config.settings`, so it is filled in place, not
---replaced.
---@see :help lsp-config
---@see https://github.com/b0o/SchemaStore.nvim#usage

---@type vim.lsp.Config
return {
  settings = {
    json = {
      validate = { enable = true },
    },
  },
  ---@param _ lsp.InitializeParams
  ---@param config vim.lsp.ClientConfig
  before_init = function(_, config)
    -- `@as table`: `settings` is typed as any LSP value, so without the cast
    -- lua_ls rejects adding a `schemas` field to it.
    local json = config.settings.json --[[@as table]]
    json.schemas = require("schemastore").json.schemas()
  end,
}
