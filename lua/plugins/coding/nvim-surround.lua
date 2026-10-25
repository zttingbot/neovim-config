---nvim-surround: add, change and delete the pair around existing text.
---
---A pair (surround) is brackets, quotes, an HTML tag or a function call. The
---plugin sets its own keys, listed in `docs/keymaps.md`, with examples.
---
---In visual mode `S` no longer deletes the selected lines to type over them;
---`c` still does that.
---@see https://github.com/kylechui/nvim-surround
---@see :help nvim-surround.usage

---@type LazySpec
return {
  "kylechui/nvim-surround",
  -- Load after startup: its keys are needed in normal, visual and insert mode,
  -- but not for the first screen.
  event = "VeryLazy",
}
