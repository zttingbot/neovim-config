---Treesitter plugins: parsers and everything built on the syntax tree.
---
---Each plugin in this folder has its own file returning a single spec;
---lazy.nvim loads them all through the "plugins.treesitter" import in config/lazy.lua.
---@see :help lazy.nvim-plugin-spec

---@type LazySpec
return {}
