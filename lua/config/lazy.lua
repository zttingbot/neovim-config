---Bootstrap and configure lazy.nvim.
---
---On first run, clones lazy.nvim (stable branch) into
---`stdpath("data")/lazy/lazy.nvim`, and exits if the clone fails. Then
---imports each category folder under `lua/plugins/`, one file per plugin.
---`:Lazy` opens the plugin manager window to install, update and check
---plugins.
---@see https://github.com/folke/lazy.nvim
---@see :help lazy.nvim-configuration

-- Clone lazy.nvim on first run, so a new machine needs only this config.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local opts = {
  -- One import per category: lazy.nvim does not look inside subfolders of
  -- `lua/plugins/`, so each folder is listed here.
  spec = {
    { import = "plugins.colorscheme" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
  },
  -- `version = false`: track each plugin's latest commit, not its release
  -- tags.
  defaults = { lazy = false, version = false },
  -- Colorscheme for the install window on first run. habamax ships with
  -- Neovim, so it works before catppuccin is installed.
  install = { colorscheme = { "catppuccin", "habamax" } },
  -- Check for plugin updates in the background, without a notification.
  -- `:Lazy` lists them.
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  -- No plugin here needs luarocks. Turning it off also silences its
  -- `:checkhealth lazy` error.
  rocks = { enabled = false },
  -- Same border as 'winborder' (set in `lua/config/options.lua`), which
  -- lazy.nvim doesn't read.
  ui = { border = "single" },
  performance = {
    rtp = {
      -- Built-in runtime plugins this config doesn't use. Disabling them
      -- makes startup faster.
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
}

require("lazy").setup(opts)
