---render-markdown.nvim: display markdown rendered inside the buffer.
---
---Draws headings, lists, checkboxes, tables, code blocks and quotes with
---icons and highlights instead of raw markdown syntax. Raw text comes back
---on the cursor line and in insert mode, so editing is unchanged.
---:RenderMarkdown toggle switches it off and on.
---@see https://github.com/MeanderingProgrammer/render-markdown.nvim
---@see :help render-markdown

---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  -- Only needed in markdown buffers.
  ft = "markdown",
  opts = {},
}
