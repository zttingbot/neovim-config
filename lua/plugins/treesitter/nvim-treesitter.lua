---nvim-treesitter: parsers for treesitter highlighting, folds and indent.
---
---Treesitter parses each buffer into a syntax tree, which Neovim uses for
---highlighting and folding that follow the code's structure. Neovim bundles
---parsers for only a few languages; this plugin downloads and compiles the
---rest and adds a treesitter-based indentexpr.
---
---Uses the `main` branch, the rewrite for Neovim 0.12+. Compiling parsers
---needs the tree-sitter CLI (tree-sitter-cli) and a C compiler; check both
---with :checkhealth nvim-treesitter.
---@see https://github.com/nvim-treesitter/nvim-treesitter/tree/main
---@see :help nvim-treesitter
---@see :help treesitter

---Parsers to install. Missing ones are installed in the background at
---startup, so this list is what makes a parser part of the config on every
---machine; `:TSInstall` alone installs on the current machine only.
---
---Entries are language names, not filetypes (`tsx` for typescriptreact,
---`bash` for sh). To find the name for the current buffer:
---  :lua =vim.treesitter.language.get_lang(vim.bo.filetype)
---Neovim already bundles c, lua, markdown, query, vim and vimdoc.
local PARSERS = {
  -- Shell and config formats
  "bash",
  "json",
  "toml",
  "yaml",

  -- Git: `git diff` output and the buffers git opens in the editor
  "diff",
  "git_rebase", -- `git rebase -i` todo list
  "gitcommit",

  -- Programming languages
  "python",

  -- Web
  "css",
  "html",
  "javascript",
  "tsx",
  "typescript",

  -- Injections: never a buffer's own language; they highlight code embedded
  -- in another one
  "jsdoc", -- /** @param */ comments in JavaScript and TypeScript
  "luadoc", -- ---@type annotations in Lua
  "luap", -- Lua patterns in string.match, gsub, ...
  "regex", -- regex literals in JavaScript, Python, ...
}

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- The main branch doesn't support lazy-loading.
  lazy = false,
  -- Recompile installed parsers when the plugin updates, so they match its
  -- queries.
  build = ":TSUpdate",
  config = function()
    -- Asynchronous; parsers that are already installed are skipped.
    require("nvim-treesitter").install(PARSERS)

    ---Use treesitter for highlighting, folds and indent in buffers whose
    ---filetype has a parser installed; other buffers keep the regex syntax.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      desc = "Enable treesitter highlight, folds and indent",
      ---@param args vim.api.keyset.create_autocmd.callback_args
      callback = function(args)
        -- pcall: fails when no parser is installed for this filetype
        if not pcall(vim.treesitter.start, args.buf) then
          return
        end
        -- Fold options are window-local; [0][0] sets them for this buffer in
        -- the current window only.
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- nvim-treesitter's indent is experimental; it takes over from
        -- smartindent only in buffers with a parser.
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
