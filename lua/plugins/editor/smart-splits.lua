---smart-splits.nvim: move between and resize Neovim splits and tmux panes with the same keys.
---
---`<C-h>`, `<C-j>`, `<C-k>` and `<C-l>` move to the split in that direction;
---at the edge of Neovim they move to the neighbouring tmux pane instead.
---`<A-h>`, `<A-j>`, `<A-k>` and `<A-l>` resize the same way. The matching tmux
---bindings live in `~/.config/tmux/tmux.conf`.
---
---Since v3 the plugin only handles Neovim splits; talking to tmux is the job
---of a separate backend plugin. `:checkhealth smart-splits` shows which
---backend is in use.
---
---The keys run the plugin's own commands (`:SmartCursorMoveLeft`,
---`:SmartResizeLeft`, ...), which do the same when typed by hand.
---@see https://github.com/mrjones2014/smart-splits.nvim
---@see :help smart-splits
---@see https://github.com/smart-splits-nvim/backend-tmux

---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  dependencies = { "smart-splits-nvim/backend-tmux" },
  -- Load at startup: the tmux backend sets the `@pane-is-vim` pane option when
  -- it loads, which is how tmux knows to pass `<C-h>`, `<C-j>`, ... through to
  -- Neovim instead of switching panes.
  lazy = false,
  -- Normal mode only, so insert mode keeps `<C-k>` for typing special
  -- characters (digraphs, e.g. `<C-k>n?` → ñ).
  keys = {
    -- Move
    { "<C-h>", "<cmd>SmartCursorMoveLeft<CR>", desc = "Go to left split/pane" },
    { "<C-j>", "<cmd>SmartCursorMoveDown<CR>", desc = "Go to lower split/pane" },
    { "<C-k>", "<cmd>SmartCursorMoveUp<CR>", desc = "Go to upper split/pane" },
    -- `<C-l>`: replaces Neovim's default, which clears the search highlight
    -- and redraws the screen. `<Esc>` clears the highlight instead
    -- (`lua/config/keymaps.lua`), and `:redraw!` redraws.
    { "<C-l>", "<cmd>SmartCursorMoveRight<CR>", desc = "Go to right split/pane" },

    -- Resize
    { "<A-h>", "<cmd>SmartResizeLeft<CR>", desc = "Resize split left" },
    { "<A-j>", "<cmd>SmartResizeDown<CR>", desc = "Resize split down" },
    { "<A-k>", "<cmd>SmartResizeUp<CR>", desc = "Resize split up" },
    { "<A-l>", "<cmd>SmartResizeRight<CR>", desc = "Resize split right" },
  },
  opts = {
    -- `mux.backend`: v3 neither detects nor ships one. Without it, the keys
    -- stop at Neovim's edge and tmux never learns that this pane runs Neovim.
    mux = { backend = "smart-splits-backend-tmux" },
  },
}
