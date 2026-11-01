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

`<CR>` on a file and `q` close the split only when `-` opened it. In a folder opened with `nvim .`, `:e .` or `:Oil`, `<CR>` opens the file in place and `q` brings back the previous buffer.

| Keys | Mode | Action |
| --- | --- | --- |
| `-` | n | Open the file explorer in a split on the right, or go to the parent folder inside it |
| `<CR>` | n | Open the file or folder under the cursor; a file closes the explorer split |
| `<C-x>` | n | Open the entry under the cursor in a horizontal split |
| `<C-r>` | n | Reload the listing from disk |
| `g.` | n | Toggle hidden files |
| `q` | n | Close the explorer and its split |
| `g?` | n | List every oil key |

## Sessions

A session is the set of open files, splits and tabs. One is saved per directory when Neovim exits; inside a git repository, each branch has its own.

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>qs` | n | Restore the session for the current directory |
| `<leader>qS` | n | Select a session from a list |
| `<leader>ql` | n | Restore the last saved session |
| `<leader>qd` | n | Don't save a session on exit |

## Git

### Status window

`<leader>gs` works anywhere inside a git repository. The other keys work in the status window it opens; `g?` lists all of them.

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>gs` | n | Open the status window (`git status`) on the right |
| `=` | n | Toggle the inline diff of the file or hunk |
| `dv` | n | Side-by-side diff of the file |
| `s` | n, x | Stage the file, hunk or selected lines |
| `u` | n, x | Unstage the file, hunk or selected lines |
| `-` | n, x | Toggle staged |
| `X` | n | Discard the change |
| `<CR>` | n | Open the file |
| `)` / `(` | n | Next / previous file or hunk |
| `cc` | n | Commit; `:wq` saves the message and commits |
| `cvc` | n | Commit, with the diff under the message |
| `ca` | n | Amend the last commit |
| `gq` | n | Close the status window |
| `g?` | n | List every status window key |

### Hunks

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
| `<leader>hD` | n | Diff against HEAD~1 |
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
| `<BS>` | i | Between an empty pair: delete both characters |
| `<CR>` | i | Between brackets: open an indented block |

With `|` as the cursor:

```text
<leader>a      f(|a, b)    →  f(b, a)
<M-e>$         (|foobar    →  (|foobar)
<BS>           (|)         →  |
```

`<M-e>` puts a letter at each place the closing bracket can go: press one to pick it, or `$` for the end of the line.

## Surround

A surround is the pair around text: brackets, quotes, a tag or a function call. `{char}` names the pair: `)`, `"`, `t` for an HTML tag or `f` for a function call. With the cursor on `word`:

```text
ysiw)          word      →  (word)
cs)"           (word)    →  "word"
ds"            "word"    →  word
ysiwtb<CR>     word      →  <b>word</b>
ysiwflen<CR>   word      →  len(word)
```

An opening bracket adds spaces inside: `ysiw(` gives `( word )`.

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

## Debug

Debugging works for Python. Set a breakpoint, start with `<leader>dc`, then step or continue. The script runs in a terminal split below. In the variables window, `<CR>` expands an entry. A `○` in the sign column marks a breakpoint the debugger couldn't set. [`nvim-dap-python.lua`](../lua/plugins/debug/nvim-dap-python.lua) explains which Python runs the script.

`<leader>dl` reruns the same module after `<leader>dm`, but whichever file is open after `<leader>dc`.

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Set a breakpoint that stops only when a condition is true |
| `<leader>dc` | n | Start debugging the file, or continue to the next breakpoint |
| `<leader>dm` | n | Debug a Python module, by name |
| `<leader>dM` | n | Debug a Python module, including library code |
| `<leader>dl` | n | Rerun the last session |
| `<leader>dn` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step out |
| `<leader>dt` | n | Stop debugging |
| `<leader>dv` | n | Toggle the variables window |
| `<leader>df` | n | Toggle the call stack window |
| `<leader>de` | n | Evaluate the expression under the cursor |
| `<leader>de` | x | Evaluate the selection |
| `<leader>dr` | n | Toggle the debug console, for typing expressions |

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
