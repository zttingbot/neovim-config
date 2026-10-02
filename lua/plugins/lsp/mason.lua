---mason.nvim: package manager for LSP servers, formatters, linters and DAP servers.
---
---Downloads each tool into `stdpath("data")/mason` so it doesn't have to be
---installed system-wide, and puts mason's `bin/` on `$PATH` so Neovim finds it.
---`:Mason` opens the UI to browse, install and update packages; press `g?`
---inside it to list its shortcuts.
---@see https://github.com/mason-org/mason.nvim
---@see :help mason.nvim

---@type LazySpec
return {
  "mason-org/mason.nvim",
  -- Load at startup. `setup()` prepends mason's `bin/` to `$PATH`, which must
  -- happen before any server starts.
  lazy = false,
  opts = {
    -- Same border as 'winborder', which mason doesn't read.
    ui = { border = "single" },
  },
}
