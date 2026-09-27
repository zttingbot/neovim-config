---Colorscheme: catppuccin, Mocha flavour.
---
---Catppuccin is a pastel theme with four flavours, from light to dark: latte,
---frappe, macchiato, mocha. Mocha is the darkest. The theme ships highlight
---integrations for common plugins (gitsigns, telescope, treesitter, …), turned
---on by default, so plugins added later match the theme without extra setup.
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
    -- Flavour: "latte" (light), "frappe", "macchiato", or "mocha" (darkest).
    flavour = "mocha",
  },
  ---Apply the options, then activate the theme. lazy.nvim passes `opts` above.
  ---@param _ LazyPlugin
  ---@param opts CatppuccinOptions
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
