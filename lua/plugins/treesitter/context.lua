---nvim-treesitter-context: sticky header of the enclosing code.
---
---When the start of the current function, class or block scrolls off the top
---of the window, its first line stays pinned there, so you always see where
---the cursor is.
---@see https://github.com/nvim-treesitter/nvim-treesitter-context

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  -- Load after startup finishes: nothing is scrolled on the first screen.
  event = "VeryLazy",
  opts = {
    -- At most 3 pinned lines, so deep nesting doesn't cover the window.
    max_lines = 3,
    -- Show only the first line of a multi-line signature.
    multiline_threshold = 1,
  },
}
