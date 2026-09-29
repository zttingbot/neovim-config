---nvim-web-devicons: file-type icons.
---
---Shared by every plugin that shows file icons.
---Needs a Nerd Font in the terminal.
---@see https://github.com/nvim-tree/nvim-web-devicons

---@type LazySpec
return {
  "nvim-tree/nvim-web-devicons",
  -- Loaded only when another plugin requires it.
  lazy = true,
}
