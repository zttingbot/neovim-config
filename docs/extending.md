# Extending

Step-by-step guides for common changes. To understand why the steps are what they are, see [Architecture](architecture.md).

## Add a plugin

1. Pick the category folder under `lua/plugins/` that matches what the plugin does. Each folder's `init.lua` says what belongs in it.
2. Create `lua/plugins/<category>/<plugin-name>.lua` and return one spec from it:

   ```lua
   ---plugin-name: what it does, in one line.
   ---
   ---What it adds and anything surprising about it.
   ---@see https://github.com/owner/plugin-name

   ---@type LazySpec
   return {
     "owner/plugin-name",
     event = "VeryLazy",
     opts = {},
   }
   ```

3. Put the plugin's keymaps in the spec's `keys` field, so the first key press loads the plugin. Give each one a `desc`.
4. Add the keymaps to [Keymaps](keymaps.md).
5. Restart Neovim. lazy.nvim installs the plugin.

To check that it worked, open `:Lazy` and find the plugin in the list.

### Add a category

1. Create `lua/plugins/<category>/init.lua`, returning an empty spec, with a header comment that says what belongs in the category. Copy an existing `init.lua` as a template.
2. Add `{ import = "plugins.<category>" }` to `spec` in `lua/config/lazy.lua`.

## Add a language server

1. Add the server's lspconfig name, for example `lua_ls`, to `servers` in `lua/config/tools.lua`. Find the name with `:help lspconfig-all`.
2. Restart Neovim. The server installs and is enabled.

To check that it worked, open a file of that language and run `:checkhealth vim.lsp`.

## Override a server's settings

1. Create `after/lsp/<server>.lua`, where `<server>` is the lspconfig name.
2. Return only the keys you want to change:

   ```lua
   ---@type vim.lsp.Config
   return {
     settings = {},
   }
   ```

3. Restart Neovim.

To check that it worked, run `:checkhealth vim.lsp` and look at the server's settings.

## Add a formatter

1. Add the formatter to `formatters_by_ft` in `lua/plugins/coding/conform.lua`, under the filetype it formats.
2. Add its mason package name, for example `stylua`, to `formatters` in `lua/config/tools.lua`. If it is also a language server you want running, for example for linting, add it to `servers` instead and turn off its formatting in `after/lsp/<server>.lua`, as explained in [Formatting](architecture.md#formatting).
3. Restart Neovim.

To check that it worked, open a file of that filetype and run `:ConformInfo`.

## Add a linter

Linters here run inside a language server, not on their own. For example, bashls runs shellcheck and shows its warnings as diagnostics.

1. Add the server that runs the linter to `servers` in `lua/config/tools.lua`, if it isn't there yet.
2. Add the linter's mason package name, for example `shellcheck`, to `linters` in `lua/config/tools.lua`.
3. Restart Neovim.

To check that it worked, open a file the server handles and look for the linter's warnings. `]d` jumps to the next one and shows its message.

## Add a treesitter parser

1. Find the language name for the current buffer:

   ```vim
   :lua =vim.treesitter.language.get_lang(vim.bo.filetype)
   ```

2. Add that name to `PARSERS` in `lua/plugins/treesitter/nvim-treesitter.lua`.
3. Restart Neovim. The parser compiles in the background.

To check that it worked, run `:checkhealth nvim-treesitter`.
