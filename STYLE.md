# Style

How the Lua files in this config are written: file headers, comments and plugin specs. For how to make and commit a change, see [Contributing](CONTRIBUTING.md).

The rules describe what the files already do. When a file and this page disagree, follow this page.

## Formatting

[StyLua](https://github.com/JohnnyMorganz/StyLua) formats the code. Its settings, and the reason for each one, are in [`stylua.toml`](stylua.toml).

- Code wraps at 120 columns. StyLua does this.
- Comments wrap at 80 columns. StyLua doesn't touch comments, so wrap them by hand.
- Three kinds of comment line may run past 80 columns, because they can't be split: the summary line of a file header, a `---@see` line, and any other `---@` annotation.

## File header

Every file starts with a header comment written with `---`:

```lua
---plugin-name: what it does.
---
---What the plugin adds, and why it is set up this way. Commands and keys the
---reader can use or check it with, such as :PluginInfo.
---
---A second paragraph, when there is more to say.
---@see https://github.com/owner/plugin-name
---@see :help plugin-name

---@type LazySpec
return {
```

- The first line is a one-line summary that ends with a period. It stays on one line.
- The second line is an empty `---`. Paragraphs in the body are separated the same way.
- The body says what the file adds, why it is set up this way, and how to use or check it.
- `---@see` lines come last, with no empty line before them. Put the repository URL first, then `:help` topics, then any other link, such as a documentation page.
- Leave one empty line after the header. `---@type` goes directly above `return`.

The summary line depends on the kind of file:

| File | Summary line |
| --- | --- |
| Plugin spec | `---plugin-name: what it does.` |
| Category `init.lua` | `---<Category> plugins: what belongs in the folder.` |
| Module in `lua/config/` | `---What it sets up, no plugin dependencies.` |
| File in `after/lsp/` | `---<server> overrides, merged over nvim-lspconfig's lsp/<server>.lua.` |

## Comments

### `---` or `--`

Use `---` for:

- the file header
- LuaCATS annotations, such as `---@type`, `---@param` and `---@see`
- the doc comment of a declaration: a local function, a module-level constant, an autocommand or a `config` function

Use `--` for everything else: a setting, a table entry, a statement.

```lua
---Briefly highlight the yanked region.
vim.api.nvim_create_autocmd("TextYankPost", {
```

```lua
  -- Only needed once typing starts.
  event = "InsertEnter",
```

### What a comment says

- **Say why, not what.** Give the reason for the setting, what would happen without it, or the default it changes. Commands and keys are the exception; see [Explaining commands and keys](#explaining-commands-and-keys).

  ```lua
  -- Good: the reason and the consequence.
  -- Always show the sign column. Otherwise it appears and disappears as signs
  -- come and go, shifting the text sideways.
  opt.signcolumn = "yes"

  -- Bad: repeats the code.
  -- Set signcolumn to yes.
  opt.signcolumn = "yes"
  ```

- **Write for a reader who doesn't know the plugin.** Use plain words. Explain a term the first time it appears, in parentheses: "the next changed block (hunk)".
- **Never list the current members of a set that grows**, such as the plugins in a folder or the servers in an exclude list. Adding an entry should never mean editing a comment. When a comment needs an example, keep it open-ended: "e.g. stylua" or "a, b, ...".
- **Name a role, not a plugin, when the role is enough**: "split navigation", "the completion menu". Replacing that plugin then needs no comment edit. Name the plugin when the comment sends the reader to its file.

### Explaining commands and keys

A command or a key is the exception to "say why, not what". The reader can't guess what it does, so say it.

- Describe the result the reader sees, not the function that runs: "stage the hunk under the cursor", not "calls stage_hunk".
- Explain a command in the file header, in one sentence: the command, then a verb in the present tense.

  ```lua
  ---:PluginInfo shows which tools apply to the current buffer and whether
  ---they are installed.
  ```

- Explain a key in a comment above its keymap. Start with the key and a colon:

  ```lua
  -- <leader>hs: stage the hunk under the cursor, like `git add -p` for just
  -- that block. Press it again on a staged hunk to unstage it.
  ```

- When a shell or Vim command does the same thing, name it in backticks. When the way back isn't obvious, say how to undo or close it.
- Skip the comment when the keymap's `desc` already says everything, as in a list of pickers.
- Explain only the commands and keys the reader will use. When the plugin can list the rest itself, point to that instead: "Press g? to list all its shortcuts."
- List the keys a plugin sets by itself, such as a preset, in the file header as pairs of key and action: `<C-y> accept, <C-e> close`.

### How a comment is written

- Put the comment on its own line, above what it explains, at the same indent. Write full sentences: a capital first letter and a period at the end.
- A trailing comment, on the same line as the code, is a short phrase with no capital and no period:

  ```lua
  "taplo", -- TOML
  ```

- A comment about one key, value or call starts with it, then a colon, then lowercase:

  ```lua
  -- <leader>hS: stage every change in the file (`git add <file>`).
  -- pcall: the column may be past the end of the line.
  ```

- A comment that explains several lines goes once, above the first of them.
- Write `...`, not `…`.

### Notation

| Thing | Written as | Example |
| --- | --- | --- |
| Key | Vim notation, no quotes | `<C-h>`, `]c`, `g?` |
| Ex command | leading colon, no quotes | `:ConformInfo` |
| Vim option | single quotes | `'runtimepath'` |
| String value | double quotes | `"single"` |
| Lua code, a shell command, or keys typed as a sequence | backticks | `` `daf` ``, `` `git add -p` `` |
| Another file | path from the config root | `lua/plugins/lsp/lazydev.lua` |

### Dividers and groups

- Split a long file or a long function into sections with a divider: the title, then dashes up to column 80. Leave an empty line above and below it.

  ```lua
  -- Search ----------------------------------------------------------------------
  ```

- Group the entries of a list under a short label with no period. Leave an empty line between groups.

  ```lua
  -- Shell and config formats
  "bash",
  "json",

  -- Programming languages
  "python",
  ```

- To describe several values at once, use an aligned table, indented under the line it explains:

  ```lua
  --   name    what it is for
  --   other   what it is for, continued on the next line when it is
  --           too long for one
  ```

## Plugin specs

- One file per plugin, and one spec per file. Name the file after the plugin, in kebab-case, without the `.nvim` suffix.
- Write the fields in this order:
  1. Source: the repository, then `name`, `dependencies`, `branch`, `version`.
  2. Loading: `lazy`, `priority`, `event`, `ft`, `cmd`, `keys`.
  3. Setup: `build`, `opts`, `config`.
- Every spec says how it loads, and a comment gives the reason:

  ```lua
  -- Load on the first :PluginInfo or keymap below, not at startup.
  cmd = "PluginInfo",
  ```

- Use `opts`. Use `config` only when setup needs more than `setup(opts)`.
- Annotate the parameters of a callback with `---@param`.

## Keymaps

- Put a plugin's keymaps in the spec's `keys` field, so the first press loads the plugin.
- When a keymap should only exist in the buffers a plugin attached to, set it in the plugin's `on_attach` and make it buffer-local.
- Give every keymap a `desc`: sentence case, no period, naming the action, for example `"Find files"`.
- Write visual mode as `"x"`, not `"v"`.
- When a keymap takes a key away from a plugin or from Vim, the comment says why the key is needed, and where the action it held went.
- For how to describe what a key does, see [Explaining commands and keys](#explaining-commands-and-keys).

## Naming

- A module-level list is a local in `UPPER_SNAKE_CASE`, with a `---` doc comment that says what adding an entry does.
- Name an augroup `user_<area>` and create it with `clear = true`. Give every autocommand a `desc`.
