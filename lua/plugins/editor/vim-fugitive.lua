---vim-fugitive: git commands and a repo status window inside Neovim.
---
---`:Git` (or `:G`) with no arguments opens the status window: the unstaged
---and staged files, with keys to read each diff, stage and commit. Any other
---`:Git <args>` runs that git command, e.g. `:Git push`. Changed blocks (hunks)
---inside the file being edited are handled by gitsigns
---(`lua/plugins/editor/gitsigns.lua`).
---Press `g?` in the status window to list all its keys.
---@see https://github.com/tpope/vim-fugitive
---@see :help fugitive

---@type LazySpec
return {
  "tpope/vim-fugitive",
  -- Load at startup. The plugin keeps its code in autoload/ until a command
  -- runs, so this costs almost nothing, and a restored session can reopen the
  -- status window or a `fugitive://` diff buffer.
  lazy = false,
  keys = {
    -- `<leader>gs`: open the status window on the right, like `git status`, so
    -- `<CR>` opens files beside it. `gq` closes it.
    { "<leader>gs", "<cmd>botright vertical Git<CR>", desc = "Git status" },
  },
}
