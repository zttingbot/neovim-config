---lua_ls overrides, merged over nvim-lspconfig's lsp/lua_ls.lua.
---
---`after/` is a directory Neovim searches last on 'runtimepath': after this
---config, the plugins and Neovim's own runtime. Files in it (`after/lsp/`,
---`after/ftplugin/`, `after/queries/`, ...) load after every other file of the
---same kind, so they can override what plugins set.
---
---Neovim builds a server's config by merging every `lsp/<server>.lua` on
---'runtimepath' in that order. nvim-lspconfig ships `lsp/lua_ls.lua` with the
---defaults; this file, being under `after/`, merges last and wins on any key
---both set. This is the override location nvim-lspconfig and
---`:help lsp-config` recommend.
---
---This file holds lua_ls server settings only. Which libraries lua_ls knows
---about (the Neovim runtime, plugin types) is managed by lazydev, in
---`lua/plugins/lsp/lazydev.lua`.
---@see https://github.com/neovim/nvim-lspconfig#config-priority
---@see :help after-directory
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
