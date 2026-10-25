# Style

## Formatting

[StyLua](https://github.com/JohnnyMorganz/StyLua) formats the code with [`stylua.toml`](stylua.toml): `<leader>cf` for the buffer or selection, or for the whole config:

```sh
~/.local/share/nvim/mason/bin/stylua ~/.config/nvim
```

Wrap comments by hand at 80 columns. Header summaries and `---@` annotations may run longer.

## Plugin example

One file per plugin, named after its repository in lowercase kebab-case without `.nvim`: smart-splits.nvim is `smart-splits.lua`, blink.cmp is `blink-cmp.lua`. A few long names keep only the part that identifies the plugin, such as `lspconfig.lua` for nvim-lspconfig and `context.lua` for nvim-treesitter-context; catppuccin/nvim is `catppuccin.lua`.

```lua
---fzf-lua: fuzzy finder for files, text, buffers and more.
---
---`:FzfLua` with no arguments lists every picker.
---@see https://github.com/ibhagwan/fzf-lua
---@see :help fzf-lua

---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
    { "<leader>fw", "<cmd>FzfLua grep_visual<CR>", mode = "x", desc = "Grep selection" },
  },
  opts = {
    -- The preview has its own border, so set it too to match the picker.
    winopts = { border = "single", preview = { border = "single" } },
  },
}
```

- Other headers say what belongs in the folder (category `init.lua`), what the module sets up (`lua/config/`), or which server it overrides (`after/lsp/`).
- Field order, skipping unused ones:
  - Source: repository, `name`, `dependencies`, `branch`, `version`
  - Loading: `lazy`, `priority`, `event`, `ft`, `cmd`, `keys`
  - Setup: `build`, `opts`, `config`
- Comment on loading only when the trigger hides a constraint, such as a colorscheme that must load first.
- Leave out options that keep their default. Use `config` only when setup needs more than `setup(opts)`.

## Comments and notation

- Comment on reasons, constraints and surprises, like the `preview` comment above, not on what the code says.
- Use plain words and explain unfamiliar terms. Name a plugin only when its identity matters.
- Explain shared behavior once, above the block; link to [Architecture](docs/architecture.md) when it spans files.
- Keep changing lists in code, not in comments.
- Use `---` for file headers and documented functions, constants and autocommands; `--` for everything else.
- Trailing comments are only for short labels: `"taplo", -- TOML`.

In prose and comments, write these as shown:

| Item | Example |
| --- | --- |
| Key | `` `<leader>cf` `` |
| Ex or shell command | `` `:ConformInfo` ``, `` `git add -p` `` |
| Lua name, event or register | `` `opts` ``, `` `FileType` ``, `` `+` `` |
| Path from the config root | `` `lua/config/tools.lua` `` |
| Vim option | `'runtimepath'` |
| String value | `"single"` |
| Plugin, tool or language | fzf-lua, StyLua, Lua |

## Keymaps and naming

Plugin keymaps go in `keys`, as above. Keymaps only for buffers a plugin attached to go in its `on_attach`, buffer-local:

```lua
-- `<leader>hs`: stage the hunk under the cursor; press it again to unstage.
vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
```

- Comment a keymap only when `desc` needs context, such as how to undo it or where a key it replaced went. Describe what the user sees, not the function.
- Keymaps that need no plugin go in `lua/config/keymaps.lua`. Update [`docs/keymaps.md`](docs/keymaps.md) when keymaps change.
- In a plugin's header, name the command that lists its keys and any unusual behavior. The full key list lives in `docs/keymaps.md`.
- Use `snake_case` for locals and functions, `UPPER_SNAKE_CASE` for module-level lists.
- Name augroups `user_<area>`, created with `clear = true`. Give every autocommand a `desc`.
