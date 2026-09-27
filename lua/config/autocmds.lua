---Core autocommands, no plugin dependencies.
---
---All autocmds share the `user_config` augroup; `clear = true` prevents duplicates when
---this file is re-sourced.

local group = vim.api.nvim_create_augroup("user_config", { clear = true })

---Briefly highlight the yanked region.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})

---Reopen files at the last cursor position (the `"` mark from shada), skipping it if
---that line no longer exists.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Restore last cursor position",
  ---@param args vim.api.keyset.create_autocmd.callback_args
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lines = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lines then
      -- pcall: the column may be past end of line
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
