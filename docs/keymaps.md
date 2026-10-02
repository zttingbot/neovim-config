# Keymaps

`<leader>` is Space and `<localleader>` is `\`. To search every mapping from inside Neovim, press `<leader>fk`.

Modes: `n` normal, `x` visual, `o` operator-pending (after `d`, `y`, `c`, ...), `i` insert.

## General

| Keys | Mode | Action |
| --- | --- | --- |
| `<Esc>` | n | Clear search highlight |

## Splits and panes

The same keys move between Neovim splits and tmux panes: at the edge of Neovim they go to the neighbouring tmux pane.

| Keys | Mode | Action |
| --- | --- | --- |
| `<C-h>` / `<C-l>` | n | Go to the left / right split or pane |
| `<C-j>` / `<C-k>` | n | Go to the lower / upper split or pane |
| `<A-h>` / `<A-l>` | n | Resize the split left / right |
| `<A-j>` / `<A-k>` | n | Resize the split down / up |

## Find

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Grep project |
| `<leader>fw` | n | Grep word under cursor |
| `<leader>fw` | x | Grep selection |
| `<leader>fb` | n | Find buffers |
| `<leader>fr` | n | Recent files |
| `<leader>fh` | n | Help tags |
| `<leader>fk` | n | Keymaps |
| `<leader>fd` | n | Buffer diagnostics |
| `<leader>f.` | n | Resume last picker |
| `<leader>/` | n | Grep current buffer |

## File explorer

Oil shows a folder as a buffer. Edit the lines to create, rename, move or delete files, then save with `:w` to apply the changes.

| Keys | Mode | Action |
| --- | --- | --- |
| `-` | n | Open the file explorer, or go to the parent folder inside it |
| `<CR>` | n | Open the file or folder under the cursor |
| `<C-x>` | n | Open the entry under the cursor in a horizontal split |
| `<C-r>` | n | Reload the listing from disk |
| `g.` | n | Toggle hidden files |
| `q` | n | Close the explorer |
| `g?` | n | List every oil key |

## Git

These keys only exist in buffers for files inside a git repository.

| Keys | Mode | Action |
| --- | --- | --- |
| `]c` | n | Next hunk |
| `[c` | n | Previous hunk |
| `<leader>hs` | n | Stage hunk, or unstage a staged one |
| `<leader>hs` | x | Stage selected lines |
| `<leader>hr` | n | Reset hunk |
| `<leader>hr` | x | Reset selected lines |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hp` | n | Preview hunk in a popup |
| `<leader>hi` | n | Preview hunk inline |
| `<leader>hb` | n | Blame line |
| `<leader>hB` | n | Toggle line blame |
| `<leader>hd` | n | Diff against index |
| `<leader>hD` | n | Diff against last commit |
| `<leader>hq` | n | Hunks to quickfix |
| `<leader>hQ` | n | Repo hunks to quickfix |
| `ih` | o, x | Select hunk |

## Code

| Keys | Mode | Action |
| --- | --- | --- |
| `af` / `if` | o, x | Around / inside function |
| `ac` / `ic` | o, x | Around / inside class |
| `aa` / `ia` | o, x | Around / inside parameter |
| `]f` / `[f` | n, x, o | Next / previous function start |
| `]F` / `[F` | n, x, o | Next / previous function end |
| `<leader>a` | n | Swap parameter with next |
| `<leader>A` | n | Swap parameter with previous |
| `<leader>cf` | n, x | Format buffer or selection |
| `<M-e>` | i | Fast wrap: move the closing bracket or quote after the next word or expression |

## Surround

A surround is the pair around text: brackets, quotes, a tag or a function call. `{char}` names the pair, for example `)` or `"`. `t` asks for an HTML tag and `f` for a function name.

| Keys | Mode | Action |
| --- | --- | --- |
| `ys{motion}{char}` | n | Add a pair around the motion |
| `yss{char}` | n | Add a pair around the line |
| `ds{char}` | n | Delete the pair |
| `cs{old}{new}` | n | Change the pair |
| `S{char}` | x | Add a pair around the selection |
| `<C-g>s{char}` | i | Add a pair at the cursor |
| `yS` / `ySS` / `cS` / `gS` / `<C-g>S` | n, x, i | Same as above, with the pair on its own lines |

## LSP

Neovim's default keymaps, active when a language server is attached.

| Keys | Mode | Action |
| --- | --- | --- |
| `K` | n | Hover documentation |
| `grn` | n | Rename symbol |
| `gra` | n, x | Code action |
| `grr` | n | References |
| `gri` | n | Implementation |
| `grt` | n | Type definition |
| `gO` | n | Document symbols |
| `<C-s>` | i | Signature help |

## Diagnostics

| Keys | Mode | Action |
| --- | --- | --- |
| `]d` / `[d` | n | Next / previous diagnostic, and open its message |
| `<C-w>d` | n | Show the diagnostic message under the cursor |

## Completion

| Keys | Mode | Action |
| --- | --- | --- |
| `<C-space>` | i | Open the menu, or show documentation |
| `<C-n>` / `<C-p>` | i | Next / previous item |
| `<C-y>` | i | Accept |
| `<C-e>` | i | Close the menu |
| `<Tab>` / `<S-Tab>` | i | Next / previous snippet field |

## Folds

Folds follow the syntax tree and start open.

| Keys | Mode | Action |
| --- | --- | --- |
| `zc` / `zo` | n | Close / open the fold under the cursor |
| `zM` / `zR` | n | Close / open all folds |
