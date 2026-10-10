---oil.nvim: edit the filesystem like a buffer.
---
---Opens a directory as a normal buffer: create, rename, move and delete files
---by editing lines, then apply the changes with `:w`. Replaces netrw.
---Press `g?` inside an oil buffer to list all its shortcuts.
---@see https://github.com/stevearc/oil.nvim
---@see :help oil

---Whether oil shares the tab with another normal (non-floating) window, as
---when `-` opens it in a split.
local function in_split()
  local wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == ""
  end, vim.api.nvim_tabpage_list_wins(0))
  return #wins > 1
end

---@type LazySpec
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load at startup so it can take over directory buffers (`nvim .`,
  -- `:e dir/`) before netrw does.
  lazy = false,
  keys = {
    -- `-`: open the file explorer in a split on the right, like `<leader>gs`,
    -- instead of replacing the current buffer. Inside oil the same key is
    -- oil's own "go to parent" map, so pressing it again goes up. `q` closes
    -- the split.
    { "-", "<cmd>botright vsplit | Oil<CR>", desc = "Open file explorer" },
  },
  opts = {
    default_file_explorer = true,
    -- Don't ask for confirmation when the only changes are new files or
    -- folders.
    skip_confirm_for_simple_edits = true,
    -- Icon and name only (the default); no size, permissions or mtime columns.
    columns = { "icon" },
    -- Merged over oil's defaults, such as `signcolumn = "no"` and
    -- `conceallevel = 3`.
    win_options = {
      number = false,
      relativenumber = false,
      -- The cursor line is the only indicator of the selected entry.
      cursorline = true,
    },
    view_options = {
      -- Hide dotfiles; `g.` shows them again.
      show_hidden = false,
    },
    keymaps = {
      -- `q`: close oil, like help and `:Lazy`. In a split (how `-` opens it)
      -- the split closes too; otherwise, as with `nvim .`, the previous buffer
      -- comes back.
      ["q"] = {
        callback = function()
          if in_split() then
            vim.cmd.close()
          else
            require("oil.actions").close.callback()
          end
        end,
        desc = "Close oil",
        mode = "n",
      },
      -- `<CR>`: open the entry under the cursor. From a split, a file closes
      -- the split and opens in the window that is left, so it fills the
      -- screen; a directory opens inside the split. Going through `oil.select`
      -- keeps its "Save changes?" prompt for unsaved edits.
      ["<CR>"] = {
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          if not in_split() or not entry or entry.type == "directory" then
            return oil.select()
          end
          oil.select({
            ---@param bufnr integer
            handle_buffer_callback = function(bufnr)
              vim.cmd.close()
              vim.cmd.buffer(bufnr)
            end,
          })
        end,
        desc = "Open entry",
        mode = "n",
      },
      -- `<C-h>` and `<C-l>` are removed so split navigation works inside oil:
      -- oil's buffer-local maps would win over the global ones. The actions
      -- they held move to the two keys below.
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      -- `<C-x>`: open the entry under the cursor in a horizontal split.
      ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
      -- `<C-r>`: reload the listing from disk.
      ["<C-r>"] = "actions.refresh",
    },
  },
}
