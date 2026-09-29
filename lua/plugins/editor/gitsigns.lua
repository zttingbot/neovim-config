---gitsigns.nvim: git change signs in the sign column, plus hunk actions.
---
---Marks added, changed and deleted lines against the index, and lets you jump
---between hunks, stage or reset them, preview the diff and blame a line
---without leaving the buffer.
---@see https://github.com/lewis6991/gitsigns.nvim
---@see :help gitsigns

---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  -- Load when a file is opened, so signs are there on the first draw.
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Keymaps are set here instead of in `keys` so they are buffer-local and
    -- only exist in buffers gitsigns attached to (files inside a git repo).
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Navigation ------------------------------------------------------------

      -- ]c: jump to the next changed block (hunk) in the file. In a diff
      -- window (:diffthis, <leader>hd) it keeps Vim's own meaning instead:
      -- jump to the next diff change.
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next hunk")
      -- [c: same as ]c, but jumps to the previous hunk.
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Previous hunk")

      -- Staging and resetting -------------------------------------------------

      -- <leader>hs: stage the hunk under the cursor, like `git add -p` for just
      -- that block. Press it again on a staged hunk to unstage it.
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
      -- <leader>hr: reset the hunk under the cursor, which throws away your
      -- edits to that block and restores the staged version. `u` undoes it.
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      -- Visual <leader>hs / <leader>hr: same as above, but only for the
      -- selected lines. line(".") and line("v") are the two ends of the
      -- selection.
      map("x", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selected lines")
      map("x", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset selected lines")
      -- <leader>hS: stage every change in the file (`git add <file>`).
      map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
      -- <leader>hR: reset every change in the file back to the staged version.
      map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

      -- Viewing changes -------------------------------------------------------

      -- <leader>hp: popup with the hunk's old and new lines. Press it again to
      -- jump into the popup; move the cursor away (or q inside it) to close it.
      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
      -- <leader>hi: show the old lines inline, above the new ones, until the
      -- cursor moves.
      map("n", "<leader>hi", gs.preview_hunk_inline, "Preview hunk inline")

      -- Blame -----------------------------------------------------------------

      -- <leader>hb: popup with the author, date and full message of the commit
      -- that last changed this line.
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      -- <leader>hB: toggle a faint "author, time ago - summary" note at the end
      -- of the cursor line.
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

      -- Diffs -----------------------------------------------------------------

      -- <leader>hd: side-by-side diff against the staged version, i.e. what
      -- `git diff` shows. Close it with :q in the other window.
      map("n", "<leader>hd", gs.diffthis, "Diff against index")
      -- <leader>hD: side-by-side diff against the commit before HEAD ("~" is
      -- HEAD~1): your last commit plus anything uncommitted.
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff against last commit")

      -- Quickfix --------------------------------------------------------------

      -- <leader>hq: put this file's hunks in the quickfix list and open it.
      -- <CR> jumps to one; :cnext / :cprev move between them.
      map("n", "<leader>hq", gs.setqflist, "Hunks to quickfix")
      -- <leader>hQ: same, for every changed file in the repo. Handy for
      -- reviewing everything before a commit.
      map("n", "<leader>hQ", function()
        gs.setqflist("all")
      end, "Repo hunks to quickfix")

      -- Text object -----------------------------------------------------------

      -- ih: the hunk under the cursor, usable after an operator or in visual
      -- mode: `vih` selects it, `dih` deletes it, `yih` yanks it.
      map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
    end,
  },
}
