---
name: add-plugin
description: Add a Neovim plugin to this config. It writes the plugin's spec, wires it up, documents its keys, installs it and checks that it loads. Use when the user wants to add, install or try a plugin, or asks for an editor feature that needs one, even if they don't say "plugin".
---

# Add a plugin

1. Run `git status`, so you can tell your changes from ones the user already had.
2. Read the plugin's README and default options upstream, or in `~/.local/share/nvim/lazy/<lazy-name>/` if it's installed. If a plugin in `lua/plugins/` already covers part of the same job, ask the user whether to replace it or keep both; never remove a plugin on your own. If both stay, make sure their keys don't clash.
3. Write `lua/plugins/<category>/<file>.lua` as in [STYLE.md's plugin example](../../../STYLE.md#plugin-example), setting only options that differ from the defaults. Use the category whose `init.lua` header fits; a new category also needs an import in `lua/config/lazy.lua`.
4. Wire up what the plugin needs:
   - **Colorscheme:** catppuccin's integration keys are the file names in `~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/groups/integrations/` (fzf-lua is `fzf`). If one matches, add it to `integrations` in `lua/plugins/colorscheme/catppuccin.lua`.
   - **Parser:** add it to `PARSERS` in `lua/plugins/treesitter/nvim-treesitter.lua`.
   - **External program:** add it to Requirements in `README.md`.
5. Add its keys to `docs/keymaps.md`, next to related ones, after checking each key is free.
6. Install it with `nvim --headless "+Lazy! install" +qa`. `git diff lazy-lock.json` should only add entries for the plugins you added (and their dependencies), and only drop entries for specs you deleted.
7. Run the checks, then fix and rerun until they print `OK`:

   ```sh
   .claude/skills/add-plugin/scripts/run-checks.sh <lazy-name> [lua-module]
   ```

   They fail on StyLua errors, on any error while Neovim starts and loads the plugin (caught by `scripts/catch-load-errors.lua`), and when the module can't be required.
8. Ask the user to try the plugin. Commit only when asked, on the current branch: one line, `feat(<plugin>): <what it adds>`, with no body or attribution.

## Replacing a plugin

Only after the user chose to replace one:

- Run `git grep -n -i <old-name>` and update or remove every mention: its spec, its keys in `docs/keymaps.md`, its catppuccin integration, other specs' dependencies.
- `Lazy! clean` removes every installed plugin that no spec lists. Before running it, check that `require("lazy.core.config").to_clean` holds only the old plugin and its dependencies.

## Gotchas

- **Lazy name:** the spec's `name` field, or else the repo name: `catppuccin/nvim` is `catppuccin`, `stevearc/oil.nvim` is `oil.nvim`. The file name drops `.nvim` (`oil.lua`).
- **Defaults:** `lua/config/lazy.lua` sets `lazy = false` and `version = false`. A spec without a trigger already loads at startup, so write `lazy = false` only next to `keys` or `cmd`, as oil does. Pin `version` only when the main branch needs compiling (blink.cmp), and note it in `docs/architecture.md`.
- **Borders:** plugins don't read `'winborder'`; set their own border option to `"single"`.
- **Key clashes:** a plugin's buffer-local keys win over global ones. oil's `<C-h>` and `<C-l>` hid split navigation until they were set to `false`.
- **Headless:** `VeryLazy` never fires (there is no UI), so call `require("lazy").load({ plugins = { "<lazy-name>" } })` before using such a plugin. Use `Lazy! install`, since `sync` and `update` move every pin. The smart-splits "no backend detected" line is expected.
