---lua_ls overrides, merged over nvim-lspconfig's lsp/lua_ls.lua.
---
---How `after/lsp/` files merge over the defaults is in `docs/architecture.md`
---(LSP pipeline).
---
---This file holds lua_ls server settings only. Which libraries lua_ls knows
---about (the Neovim runtime, plugin types) is managed by lazydev, in
---`lua/plugins/lsp/lazydev.lua`.
---@see https://github.com/neovim/nvim-lspconfig#config-priority
---@see :help lsp-config

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      diagnostics = {
        -- File headers use `---@see :help ...`, but lua_ls expects a symbol
        -- name after `@see` and flags every one of them.
        disable = { "luadoc-miss-see-name" },
      },
    },
  },
}
