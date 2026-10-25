---Neovim entry point: loads the `lua/config/` modules in order.
---
---`config.options` runs before `config.lazy` so plugin keymaps see the leader.
---The startup order is in `docs/architecture.md` (Overview).

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")
