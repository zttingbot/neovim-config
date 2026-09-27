---Bootstrap and configure lazy.nvim.
---
---On first run, clones lazy.nvim (stable branch) into `stdpath("data")/lazy/lazy.nvim`
---and exits on failure. Then imports every spec returned from lua/plugins/*.lua.
---@see :help lazy.nvim-configuration

-- Bootstrap lazy.nvim
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
  spec = { { import = "plugins" } },
  defaults = { lazy = false, version = false }, -- version = false: track latest commit, not tags
  install = { colorscheme = { "habamax" } }, -- built-in fallback during installs
  checker = { enabled = true, notify = false }, -- check for updates in the background, silently
  change_detection = { notify = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      -- unused built-in runtime plugins, disabled for faster startup
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
}

require("lazy").setup(opts)
