---Neovim entry point.
---
---Only loads modules, in a fixed order:
---  1. config.options      leaders + editor options (must precede lazy so plugin keymaps see the leader)
---  2. config.lazy         bootstrap lazy.nvim and load plugin specs from lua/plugins/
---  3. config.keymaps      plugin-independent mappings
---  4. config.autocmds     core autocommands
---  5. config.diagnostics  how LSP and linter diagnostics are shown

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")
