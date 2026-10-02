---nvim-surround: add, change and delete the pair around existing text.
---
---A pair (surround) is brackets, quotes, an HTML tag or a function call. The
---plugin sets its keys by itself: `ys{motion}{char}` add, `yss` add around
---the line, `cs{old}{new}` change, `ds{char}` delete, `S` add around the
---selection, `<C-g>s` add at the cursor while typing.
---
---E.g. `ysiw)` turns `word` into `(word)`, `cs)"` makes that `"word"` and
---`ds"` gives back `word`. An opening bracket adds spaces inside: `ysiw(`
---gives `( word )`. As {char}, `t` asks for an HTML tag and `f` for a
---function name.
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
