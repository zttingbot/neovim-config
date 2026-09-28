---nvim-treesitter-textobjects: text objects and motions from the syntax tree.
---
---Adds functions, classes and parameters as text objects (`daf`, `vic`,
---`cia`), motions between functions (`]f`, `[f`) and swapping of parameters.
---Uses the `main` branch, which matches nvim-treesitter's `main`.
---@see https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main

---Keymap that selects a text object, for visual and operator-pending mode.
---@param lhs string
---@param query string capture name, e.g. "@function.outer"
---@param desc string
---@return LazyKeysSpec
local function select(lhs, query, desc)
  return {
    lhs,
    function()
      require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
    end,
    mode = { "x", "o" },
    desc = desc,
  }
end

---Keymap that jumps to a text object, in normal, visual and operator-pending
---mode.
---@param lhs string
---@param fn "goto_next_start"|"goto_previous_start"|"goto_next_end"|"goto_previous_end"
---@param query string capture name, e.g. "@function.outer"
---@param desc string
---@return LazyKeysSpec
local function move(lhs, fn, query, desc)
  return {
    lhs,
    function()
      require("nvim-treesitter-textobjects.move")[fn](query, "textobjects")
    end,
    mode = { "n", "x", "o" },
    desc = desc,
  }
end

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  -- Keymaps are defined below, so the plugin loads on first use.
  keys = {
    select("af", "@function.outer", "Around function"),
    select("if", "@function.inner", "Inside function"),
    select("ac", "@class.outer", "Around class"),
    select("ic", "@class.inner", "Inside class"),
    select("aa", "@parameter.outer", "Around parameter"),
    select("ia", "@parameter.inner", "Inside parameter"),
    -- ]c and ]a are left alone: Neovim uses them for diff hunks and the
    -- argument list.
    move("]f", "goto_next_start", "@function.outer", "Next function start"),
    move("[f", "goto_previous_start", "@function.outer", "Previous function start"),
    move("]F", "goto_next_end", "@function.outer", "Next function end"),
    move("[F", "goto_previous_end", "@function.outer", "Previous function end"),
    {
      "<leader>a",
      function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end,
      desc = "Swap parameter with next",
    },
    {
      "<leader>A",
      function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end,
      desc = "Swap parameter with previous",
    },
  },
  opts = {
    -- Jump forward to the next text object when the cursor isn't inside one
    -- (e.g. `vif` before a function selects that function).
    select = { lookahead = true },
    -- Record motions in the jumplist, so <C-o> jumps back.
    move = { set_jumps = true },
  },
}
