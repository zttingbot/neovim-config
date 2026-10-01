---smart-splits.nvim: move between and resize Neovim splits and tmux panes with the same keys.
---
---<C-h/j/k/l> moves to the split in that direction; at the edge of Neovim it
---moves to the neighbouring tmux pane instead. <A-h/j/k/l> resizes the same
---way. The matching tmux bindings live in ~/.config/tmux/tmux.conf.
---
---The keys run the plugin's own commands (:SmartCursorMoveLeft,
---:SmartResizeLeft, ...), which do the same when typed by hand.
---@see https://github.com/mrjones2014/smart-splits.nvim
---@see :help smart-splits

---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  -- Load at startup: it sets tmux's @pane-is-vim pane variable, which is how
  -- tmux knows to pass <C-h/j/k/l> through to Neovim instead of switching
  -- panes.
  lazy = false,
  -- Normal mode only, so insert mode keeps <C-k> for typing special
  -- characters (digraphs, e.g. <C-k> n ? → ñ).
  keys = {
    { "<C-h>", "<cmd>SmartCursorMoveLeft<CR>", desc = "Go to left split/pane" },
    { "<C-j>", "<cmd>SmartCursorMoveDown<CR>", desc = "Go to lower split/pane" },
    { "<C-k>", "<cmd>SmartCursorMoveUp<CR>", desc = "Go to upper split/pane" },
    { "<C-l>", "<cmd>SmartCursorMoveRight<CR>", desc = "Go to right split/pane" },
    { "<A-h>", "<cmd>SmartResizeLeft<CR>", desc = "Resize split left" },
    { "<A-j>", "<cmd>SmartResizeDown<CR>", desc = "Resize split down" },
    { "<A-k>", "<cmd>SmartResizeUp<CR>", desc = "Resize split up" },
    { "<A-l>", "<cmd>SmartResizeRight<CR>", desc = "Resize split right" },
  },
  opts = {},
}
