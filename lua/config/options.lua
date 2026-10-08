---Core editor options, no plugin dependencies.
---
---Loaded first from `init.lua`: leaders are set here because lazy.nvim reads
---them when it registers plugin keymaps.
---
---Kept in sync with `stylua.toml`
---  - 'shiftwidth' = 2 matches `indent_width = 2`, so Lua typed here is already
---    indented the way stylua writes it.
---@see :help option-list

-- Leader keys -----------------------------------------------------------------

-- `<leader>`: prefix for your own mappings (e.g. `<leader>ff`). Space is
-- easy to reach and does almost nothing in normal mode (it just moves right,
-- like `l`).
vim.g.mapleader = " "

-- `<localleader>`: prefix for filetype-specific, buffer-local mappings (e.g.
-- only in markdown or LaTeX buffers). Backslash is Vim's traditional default
-- leader.
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- UI --------------------------------------------------------------------------

-- Show line numbers in the left column, so a line named in an error message
-- or a diff is easy to find.
opt.number = true

-- Show other lines as a distance from the cursor, so counts like `5j` or `3dd`
-- can be read off the screen. With 'number' also on, the cursor line keeps its
-- absolute number ("hybrid" numbering).
opt.relativenumber = true

-- Highlight the line the cursor is on, so it is easy to find after a jump or
-- when switching between windows.
opt.cursorline = true

-- Always show the sign column (diagnostics, git changes, breakpoints).
-- Otherwise it appears and disappears as signs come and go, shifting the text
-- sideways.
opt.signcolumn = "yes"

-- Don't show "-- INSERT --" in the command line; the statusline already shows
-- the current mode.
opt.showmode = false

-- Enable 24-bit RGB colors. Most modern colorschemes need this to look right.
opt.termguicolors = true

-- Long lines soft-wrap at the window edge ('wrap' is on by default). Break
-- them at a space or punctuation instead of in the middle of a word.
opt.linebreak = true

-- Indent the wrapped part of a line to match its start, so a wrapped line
-- doesn't look like a new, unindented one.
opt.breakindent = true

-- Keep at least 8 lines visible above and below the cursor when scrolling, so
-- you always see some context instead of editing at the window edge.
opt.scrolloff = 8

-- Editing ---------------------------------------------------------------------

-- Enable the mouse in all modes: click to move, scroll, drag to select, and
-- drag split borders to resize.
opt.mouse = "a"

-- Yank, delete and put use the system clipboard (the `+` register), so text
-- moves between Neovim and other apps. On Linux this needs wl-clipboard
-- (Wayland) or xclip/xsel (X11). See `:checkhealth provider`.
opt.clipboard = "unnamedplus"

-- The Tab key inserts spaces instead of a literal tab character, so
-- indentation looks the same in every editor and diff.
opt.expandtab = true

-- Number of spaces per indent level, used by `>>`, `<<`, `=` and auto-indent.
-- See "Kept in sync" above.
opt.shiftwidth = 2

-- How wide a real tab character is displayed. Kept equal to 'shiftwidth' so
-- files that do contain tabs line up with your own indentation.
opt.tabstop = 2

-- In visual block mode (`<C-v>`), let the cursor move past the end of a line,
-- so a block can be a full rectangle even when some of its lines are shorter.
opt.virtualedit = "block"

-- Save undo history to disk, so you can undo changes even after closing and
-- reopening a file. Stored under `stdpath("state")/undo`.
opt.undofile = true

-- Folding ---------------------------------------------------------------------

-- Folds come from treesitter where a parser exists (set per buffer in
-- `lua/plugins/treesitter/nvim-treesitter.lua`). These options only control how
-- they start and look.

-- Open all folds by default; close them yourself with `zc` / `zM`. 99 is just
-- "deeper than any real nesting".
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Show a closed fold as its first line, with syntax highlighting, instead of
-- the default "+-- 12 lines: ..." text.
opt.foldtext = ""

-- Search ----------------------------------------------------------------------

-- Searches ignore case: `/foo` also matches `Foo` and `FOO`, so you don't have
-- to remember how a name is capitalized.
opt.ignorecase = true

-- A pattern with an uppercase letter is matched exactly instead: `/Foo` matches
-- only `Foo`. Applies to typed patterns, not to `*` / `#`.
opt.smartcase = true

-- Windows ---------------------------------------------------------------------

-- `:vsplit` opens the new window on the right (the default is left).
opt.splitright = true

-- `:split` opens the new window below (the default is above).
opt.splitbelow = true

-- Default border for floating windows: LSP hover, diagnostics, and plugin
-- popups that leave their border unset (e.g. oil's confirmation and `g?` help).
-- "single" is thin lines with sharp corners. Plugins that don't use this
-- option set the same border in their own specs.
opt.winborder = "single"

-- Sessions --------------------------------------------------------------------

-- What a session saves and restores, both for `:mksession` and for the session
-- plugin (`lua/plugins/editor/persistence.lua`) when Neovim exits. This is
-- Neovim's default minus two words:
--   blank     windows whose buffer can't be reopened, e.g. the quickfix list
--             or a file explorer, would come back as empty windows
--   terminal  a terminal window would rerun its command on restore: a new
--             shell, or a one-off command such as `git push` run again
opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize" }

-- Providers -------------------------------------------------------------------

-- Turn off the remote-plugin providers. They let Neovim run plugins written in
-- Node, Perl, Python or Ruby (through pynvim and similar packages); every
-- plugin here is Lua, so none are needed. Without this, Neovim looks for each
-- one and `:checkhealth vim.provider` warns that they are missing. Editing
-- those languages is unaffected: language servers and formatters are separate
-- programs (see `lua/config/tools.lua`). The clipboard provider stays on.
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Performance -----------------------------------------------------------------

-- Milliseconds of idle time before Neovim writes the swap file and fires the
-- `CursorHold` event. The default is 4000. A lower value makes features that
-- react to idle time feel instant (diagnostic popups, highlighting the word
-- under the cursor, git signs).
opt.updatetime = 250
