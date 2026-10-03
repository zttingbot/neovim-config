---mason-tool-installer: install mason packages from a list, on every machine.
---
---mason.nvim has no list of packages to install, and mason-lspconfig's
---`ensure_installed` only accepts language servers. This plugin takes one
---list for everything: the servers and formatters in `lua/config/tools.lua`.
---It only installs; `lua/plugins/lsp/lspconfig.lua` enables the servers.
---Missing packages install in the background.
---
---`:MasonToolsInstall` installs missing packages by hand, and
---`:MasonToolsUpdate` updates them.
---@see https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local tools = require("config.tools")

---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    -- Only translates the lspconfig names in `lua/config/tools.lua` to mason
    -- packages. `lua/plugins/lsp/lspconfig.lua` enables the servers instead.
    { "mason-org/mason-lspconfig.nvim", opts = { automatic_enable = false } },
  },
  -- Load after the first screen: checking for missing packages reads mason's
  -- package registry, which slows startup, and nothing needs it right away.
  event = "VeryLazy",
  opts = {
    ensure_installed = vim.list_extend(vim.deepcopy(tools.servers), tools.formatters),
  },
  ---Set up, then start the install check. The plugin starts it on `VimEnter`,
  ---which has already passed when `VeryLazy` loads it.
  ---@param _ LazyPlugin
  ---@param opts table
  config = function(_, opts)
    local mti = require("mason-tool-installer")
    mti.setup(opts)
    mti.run_on_start()
  end,
}
