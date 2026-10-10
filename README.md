# Neovim config

A personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) and Neovim's built-in LSP client, with one file per plugin.

## Requirements

- Neovim 0.12 or later
- git
- A [Nerd Font](https://www.nerdfonts.com) set as the terminal font
- [fzf](https://github.com/junegunn/fzf); [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) are optional but faster
- The [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/tree/master/crates/cli) and a C compiler, to build parsers
- A clipboard provider: wl-clipboard on Wayland, xclip or xsel on X11

## Install

1. Back up your current config, if you have one:

   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone this repository:

   ```sh
   git clone https://github.com/zttingbot/neovim-config.git ~/.config/nvim
   ```

3. Start Neovim:

   ```sh
   nvim
   ```

   The first start installs lazy.nvim and every plugin. Language servers, formatters, linters and treesitter parsers then install in the background.

4. When the installs finish, restart Neovim and run `:checkhealth` to find anything missing.

## Update

- `:Lazy update` updates plugins and writes the new commits to `lazy-lock.json`. Commit that file to pin the same versions on every machine.
- `:MasonToolsUpdate` updates language servers, formatters and linters.

## Documentation

- [Architecture](docs/architecture.md): how the config starts up, loads plugins and wires up language servers.
- [Keymaps](docs/keymaps.md): every shortcut, grouped by task.
- [Extending](docs/extending.md): add plugins, language servers, formatters and parsers.
- [Style](STYLE.md): how comments and plugin specs are written.
- [Contributing](CONTRIBUTING.md): formatting, changes and commit messages.
