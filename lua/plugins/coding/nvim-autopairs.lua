---nvim-autopairs: insert the closing bracket or quote as you type the opening one.
---
---Typing ( [ { " ' ` inserts its pair; typing the closing character steps over
---it instead of adding another; <BS> between a pair deletes both; <CR>
---between brackets opens an indented block. Brackets after an accepted
---function completion come from the completion menu, not from this plugin.
---@see https://github.com/windwp/nvim-autopairs
---@see :help nvim-autopairs

---@type LazySpec
return {
  "windwp/nvim-autopairs",
  -- Only needed once typing starts.
  event = "InsertEnter",
  opts = {
    -- Use the syntax tree to decide when to pair, e.g. no extra quote when
    -- typing one inside a string.
    check_ts = true,
    -- <M-e> right after an opening character: pick where to put its closing
    -- one (end of the next word, expression, ...) to wrap existing text.
    fast_wrap = {},
  },
}
