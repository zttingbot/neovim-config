---which-key.nvim: popup of available keymaps.
---
---Pause after a prefix (<leader>, g, [, ], z, ...) and a popup lists the keys
---that can follow, using each keymap's `desc`.
---@see https://github.com/folke/which-key.nvim
---@see :help which-key.nvim.txt

---@type LazySpec
return {
  "folke/which-key.nvim",
  -- Load after startup finishes: the popup isn't needed to draw the first
  -- screen.
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer keymaps",
    },
  },
  opts = {
    -- Names for prefixes that only group other keymaps. Modes match the
    -- keymaps inside the group (<leader>fw also exists in visual mode).
    spec = {
      { "<leader>f", group = "find", mode = { "n", "x" } },
    },
    win = {
      -- The default "classic" preset sets border = "none", which overrides
      -- vim.o.winborder, so the border is set here too.
      border = "single",
    },
  },
}
