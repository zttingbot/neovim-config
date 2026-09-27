---fzf-lua: fuzzy finder for files, text, buffers and more.
---
---A Lua front end to the fzf binary. Uses ripgrep and fd when they are
---installed and falls back to grep and find when they are not.
---@see https://github.com/ibhagwan/fzf-lua
---@see :help fzf-lua

---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load on the first :FzfLua command or keymap below, not at startup.
  cmd = "FzfLua",
  keys = {
    { "<leader><space>", "<cmd>FzfLua files<CR>", desc = "Find files" },
    { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Grep project" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
    { "<leader>fw", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "Grep selection" },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
    { "<leader>fh", "<cmd>FzfLua helptags<CR>", desc = "Help tags" },
    { "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Buffer diagnostics" },
    { "<leader>f.", "<cmd>FzfLua resume<CR>", desc = "Resume last picker" },
    { "<leader>/", "<cmd>FzfLua lgrep_curbuf<CR>", desc = "Grep current buffer" },
  },
  opts = {
    -- "default-title": the default layout, with the picker name shown as the
    -- window title instead of in the prompt.
    "default-title",
    winopts = {
      -- Single border, like vim.o.winborder (fzf-lua doesn't read that option).
      border = "single",
      -- The preview has its own border setting (default "rounded"), so it has
      -- to be set separately to match the picker.
      preview = { border = "single" },
    },
  },
}
