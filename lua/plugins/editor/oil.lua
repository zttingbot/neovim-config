---oil.nvim: edit the filesystem like a buffer.
---
---Opens a directory as a normal buffer: create, rename, move and delete files
---by editing lines, then apply the changes with :w. Replaces netrw.
---Press g? inside an oil buffer to list all its shortcuts.
---@see https://github.com/stevearc/oil.nvim
---@see :help oil

---@type LazySpec
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load at startup so it can take over directory buffers (`nvim .`,
  -- `:e dir/`) before netrw does.
  lazy = false,
  keys = {
    -- Inside oil, `-` is oil's own "go to parent" map, so pressing it again
    -- goes up.
    { "-", "<cmd>Oil<CR>", desc = "File explorer" },
  },
  opts = {
    default_file_explorer = true,
    -- Don't ask for confirmation when the only changes are new files or
    -- folders.
    skip_confirm_for_simple_edits = true,
    -- Icon and name only (the default); no size, permissions or mtime columns.
    columns = { "icon" },
    -- Merged over oil's defaults (signcolumn = "no", conceallevel = 3, ...).
    win_options = {
      number = false,
      relativenumber = false,
      -- The cursor line is the only indicator of the selected entry.
      cursorline = true,
    },
    view_options = {
      -- Hide dotfiles; toggle with g.
      show_hidden = false,
    },
    keymaps = {
      -- Close with q (back to the previous buffer), like help and :Lazy.
      ["q"] = { "actions.close", mode = "n" },
    },
  },
}
