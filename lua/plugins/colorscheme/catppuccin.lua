---catppuccin: pastel colorscheme, in the Mocha flavour.
---
---Catppuccin has four flavours, from light to dark: latte, frappe, macchiato,
---mocha. Mocha is the darkest. It also colours other plugins' windows and
---signs through integrations, listed by hand in `opts.integrations` below: a
---plugin added later only matches the theme once its integration is added
---there.
---@see https://github.com/catppuccin/nvim
---@see :help catppuccin

---@type LazySpec
return {
  "catppuccin/nvim",
  -- The repo is named "nvim"; without this, lazy.nvim would register the
  -- plugin as "nvim" and `require("catppuccin")` would not match its name.
  name = "catppuccin",
  -- Colorschemes must load at startup, before other plugins, so their
  -- highlights exist when those plugins define theirs.
  lazy = false,
  priority = 1000,
  opts = {
    -- `flavour`: "latte" (light), "frappe", "macchiato" or "mocha" (darkest).
    flavour = "mocha",
    -- Off: detecting the installed plugins at every startup calls
    -- `vim.pack.get()`, which creates an empty `site/pack/core/opt` that
    -- `:checkhealth` then warns about. The integrations are listed below
    -- instead.
    auto_integrations = false,
    -- One entry per installed plugin that catppuccin has an integration for.
    -- The names are the files in catppuccin's
    -- `lua/catppuccin/groups/integrations/`. `true` turns one on with its
    -- default options.
    integrations = {
      blink_cmp = true,
      fzf = true,
      gitsigns = true,
      mason = true,
      nvim_surround = true,
      render_markdown = true,
      treesitter_context = true,
    },
  },
  ---Apply the options, then activate the theme. lazy.nvim passes `opts` above.
  ---@param _ LazyPlugin
  ---@param opts CatppuccinOptions
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
