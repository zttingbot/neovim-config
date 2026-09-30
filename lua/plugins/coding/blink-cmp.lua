---blink.cmp: completion menu.
---
---Shows completions from LSP servers, file paths, snippets and words in open
---buffers as you type. On Neovim 0.11+ it tells servers what it supports by
---itself, so no LSP setup is needed. Snippets expand with Neovim's built-in
---vim.snippet; friendly-snippets supplies them for common languages.
---
---Keys (the "default" preset): <C-y> accept, <C-n>/<C-p> next/previous,
---<C-space> open menu or docs, <C-e> close, <Tab>/<S-Tab> jump between
---snippet fields.
---@see https://github.com/saghen/blink.cmp
---@see https://cmp.saghen.dev

---@type LazySpec
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  -- Release tags download a prebuilt Rust fuzzy matcher; the global
  -- `version = false` would track main, which has to be compiled with cargo.
  version = "1.*",
  -- Only needed once typing starts.
  event = "InsertEnter",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      -- Setting a key to false removes it from the preset; the rest stay.
      -- The preset uses <C-k> to show/hide the function signature popup,
      -- but it never passes the key on to Vim, which uses <C-k> in insert
      -- mode to type special characters (<C-k> n ? → ñ, <C-k> a ' → á).
      -- Removing it gives <C-k> back to Vim. The signature popup still
      -- opens by itself while typing arguments, and <C-s> opens it too.
      ["<C-k>"] = false,
    },
    completion = {
      -- Borders set here: blink.cmp doesn't read vim.o.winborder.
      menu = { border = "single" },
      -- Show the selected item's documentation next to the menu after a
      -- short pause.
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "single" } },
    },
    -- Signature help popup while typing function arguments.
    signature = { enabled = true, window = { border = "single" } },
    -- Where suggestions come from. All sources show together in one menu.
    sources = {
      --   lazydev   module and plugin names inside require("…"), only in
      --             Lua files of this config (see providers below)
      --   lsp       the language server for the buffer (lua_ls,
      --             basedpyright, ...): functions, variables, fields, types
      --   path      file and folder names when typing a path, e.g. "./
      --   snippets  code templates with blanks to fill in: type a short word
      --             (`def`, `for`), accept, then <Tab> jumps to each blank.
      --             They come from friendly-snippets (dependencies above)
      --   buffer    words already in open buffers, useful where no language
      --             server runs
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      -- Only for sources that aren't built into blink, like lazydev.
      providers = {
        -- lazydev (lua/plugins/lsp/lazydev.lua) is what makes lua_ls
        -- understand Neovim's API in this config. This adds its own
        -- completions (e.g. `fzf-lua` inside require("")) to the menu.
        -- score_offset = 100 ranks them above lua_ls's so they come first.
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
  },
}
