---Core editor options, no plugin dependencies.
---
---Loaded first from init.lua: leaders are set here because lazy.nvim reads them
---when it registers plugin keymaps.
---@see :help option-list
---
---Kept in sync with stylua.toml
---  - shiftwidth = 2 matches indent_width = 2, so Lua typed here is already
---    indented the way stylua writes it.

-- Leader keys -----------------------------------------------------------------

-- <leader>: prefix for your own mappings (e.g. <leader>ff). Space is easy to reach
-- and does almost nothing in normal mode (it just moves right, like `l`).
vim.g.mapleader = " "

-- <localleader>: prefix for filetype-specific, buffer-local mappings (e.g. only in
-- markdown or LaTeX buffers). Backslash is Vim's traditional default leader.
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- UI --------------------------------------------------------------------------

-- Show line numbers in the left column.
opt.number = true

-- Show other lines as a distance from the cursor, so counts like `5j` or `3dd`
-- can be read off the screen. With `number` also on, the cursor line keeps its
-- absolute number ("hybrid" numbering).
opt.relativenumber = true

-- Always show the sign column (diagnostics, git changes, breakpoints). Otherwise
-- it appears and disappears as signs come and go, shifting the text sideways.
opt.signcolumn = "yes"

-- Enable 24-bit RGB colors. Most modern colorschemes need this to look right.
opt.termguicolors = true

-- Don't soft-wrap long lines. They run past the window edge and you scroll
-- horizontally, so each screen row is exactly one line of the file.
opt.wrap = false

-- Keep at least 8 lines visible above and below the cursor when scrolling, so
-- you always see some context instead of editing at the window edge.
opt.scrolloff = 8

-- Editing ---------------------------------------------------------------------

-- Enable the mouse in all modes: click to move, scroll, drag to select, and drag
-- split borders to resize.
opt.mouse = "a"

-- Yank, delete and put use the system clipboard (the `+` register), so text moves
-- between Neovim and other apps. On Linux this needs wl-clipboard (Wayland) or
-- xclip/xsel (X11). See `:checkhealth provider`.
opt.clipboard = "unnamedplus"

-- The Tab key inserts spaces instead of a literal tab character.
opt.expandtab = true

-- Number of spaces per indent level, used by `>>`, `<<`, `=` and auto-indent.
-- See "Kept in sync" above.
opt.shiftwidth = 2

-- How wide a real tab character is displayed. Kept equal to `shiftwidth` so files
-- that do contain tabs line up with your own indentation.
opt.tabstop = 2

-- Indent new lines automatically from the code structure (e.g. one level deeper
-- after `{`). Filetype indent scripts or treesitter take over when available.
opt.smartindent = true

-- Save undo history to disk, so you can undo changes even after closing and
-- reopening a file. Stored under `stdpath("state")/undo`.
opt.undofile = true

-- Search ----------------------------------------------------------------------

-- Searches ignore case: `/foo` also matches `Foo` and `FOO`.
opt.ignorecase = true

-- ...unless the pattern contains an uppercase letter: `/Foo` then matches only
-- `Foo`. Applies to typed patterns, not to `*` / `#`.
opt.smartcase = true

-- Windows ---------------------------------------------------------------------

-- `:vsplit` opens the new window on the right (the default is left).
opt.splitright = true

-- `:split` opens the new window below (the default is above).
opt.splitbelow = true

-- Performance -----------------------------------------------------------------

-- Milliseconds of idle time before Neovim writes the swap file and fires the
-- `CursorHold` event. The default is 4000. A lower value makes features that
-- react to idle time feel instant (diagnostic popups, highlighting the word
-- under the cursor, git signs).
opt.updatetime = 250
