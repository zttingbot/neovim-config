# Contributing

## Code style

[StyLua](https://github.com/JohnnyMorganz/StyLua) formats all Lua code. Its settings, and the reason for each one, are in [`stylua.toml`](stylua.toml).

To format the current buffer or selection, press `<leader>cf`. To format the whole config from a shell, run StyLua from mason's install directory:

```sh
~/.local/share/nvim/mason/bin/stylua ~/.config/nvim
```

StyLua doesn't cover comments or the layout of a plugin spec. Those rules are in [Style](STYLE.md).

## Changes

- Add or change one plugin per commit.
- When a commit adds, changes or removes a keymap, update [`docs/keymaps.md`](docs/keymaps.md) in the same commit.
- Write commit messages in the [Conventional Commits](https://www.conventionalcommits.org) format: `type(scope): summary`, lowercase and imperative, with no period at the end. Use the plugin category or config area as the scope, for example `feat(lsp): add json schemas with schemastore`.
