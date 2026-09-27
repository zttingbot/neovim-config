---lualine.nvim: statusline.
---
---Shows mode, git status, diagnostics, file info and cursor position in one
---statusline across the bottom, themed from the active colorscheme.
---@see https://github.com/nvim-lualine/lualine.nvim
---@see :help lualine.txt

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load after startup finishes: the statusline isn't needed to draw the
  -- first screen, so startup stays fast.
  event = "VeryLazy",
  opts = {
    options = {
      -- "auto" picks the lualine theme named after the active colorscheme
      -- (catppuccin-mocha), so it follows flavour changes by itself.
      theme = "auto",
      -- One statusline across the bottom instead of one per window.
      globalstatus = true,
      -- Flat look: no glyphs between sections or between items inside a
      -- section, just colored blocks.
      section_separators = "",
      component_separators = "",
    },
  },
}
