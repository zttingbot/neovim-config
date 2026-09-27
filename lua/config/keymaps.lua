---Plugin-independent keymaps.
---
---Plugin mappings belong in each spec's `keys` field (lua/plugins/<category>/*.lua) so lazy.nvim
---can load the plugin on first use.

---@see vim.keymap.set
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
