---lazydev.nvim: Neovim-aware lua_ls for editing this config.
---
---Without it, lua_ls treats these files as plain Lua: `vim` is an undefined
---global and types like vim.Diagnostic or LazySpec don't resolve. lazydev
---adds the Neovim runtime to lua_ls, plus each plugin as soon as a file
---require()s it, so completion, hover and type checks cover their APIs.
---Only active in Neovim config and plugin files; other Lua projects are left
---alone.
---
---The spec is lazydev's README install (ft = "lua" plus luv types) with
---lazy.nvim's types added. lazydev only manages lua_ls's libraries; other
---lua_ls settings, like disabled diagnostics, live in after/lsp/lua_ls.lua.
---@see https://github.com/folke/lazydev.nvim

---@type LazySpec
return {
  "folke/lazydev.nvim",
  -- Only needed when editing Lua.
  ft = "lua",
  opts = {
    library = {
      -- vim.uv types (luv), loaded only in files that mention vim.uv.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- lazy.nvim's types (LazySpec, LazyConfig) for plugin specs, which
      -- annotate with them without ever calling require("lazy").
      { path = "lazy.nvim", words = { "Lazy" } },
    },
  },
}
