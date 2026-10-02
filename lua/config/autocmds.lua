---Core autocommands, no plugin dependencies.
---
---All autocommands share the `user_config` augroup; `clear = true` prevents
---duplicates when this file is re-sourced.

local group = vim.api.nvim_create_augroup("user_config", { clear = true })

---Briefly highlight the yanked region.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})

---Reopen files at the last cursor position (the `"` mark from shada),
---skipping it if that line no longer exists.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Restore last cursor position",
  ---@param args vim.api.keyset.create_autocmd.callback_args
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lines = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lines then
      -- `pcall`: the column may be past the end of the line.
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

---Reload files that changed on disk (a `git checkout`, a tool run in a
---terminal) when Neovim regains focus or a terminal closes. 'autoread' only
---reloads a file when something checks it, and `:checktime` is that check.
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = group,
  desc = "Check for files changed outside Neovim",
  callback = function()
    -- `:checktime` fails in the command-line window, whose buffer is "nofile".
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

---Make splits the same size again when the terminal window is resized.
---Otherwise the splits keep their old sizes and some end up squeezed.
vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  desc = "Equalize splits on resize",
  callback = function()
    -- `:tabdo` visits every tab page and ends on the last one, so return to
    -- the tab that was current.
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})
