---SchemaStore.nvim: the schemastore.org catalog of JSON schemas, as Lua.
---
---Language servers only check a file against a schema they are given; this
---plugin supplies schemas for hundreds of common config files (package.json,
---tsconfig.json, ...), matched by file name. It is a data library with no
---setup: server overrides in after/lsp/ pass its schemas to their server.
---@see https://github.com/b0o/SchemaStore.nvim

---@type LazySpec
return {
  "b0o/SchemaStore.nvim",
  -- Loaded the first time a server that uses it starts and require()s it.
  lazy = true,
}
