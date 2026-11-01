---nvim-dap: run a program step by step, with breakpoints and variables.
---
---Talks to a separate debugger program and knows no language by itself: each
---language has its own spec in this folder. `:nmap <leader>d` lists its keys,
---`:DapShowLog` shows why a session failed to start, and `:checkhealth dap`
---checks the setup.
---@see https://github.com/mfussenegger/nvim-dap
---@see :help dap.txt

---The variables window, kept so `<leader>dv` closes the one it opened.
local variables_window

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<CR>", desc = "Start or continue debugging" },
    { "<leader>dn", "<cmd>DapStepOver<CR>", desc = "Step over" },
    { "<leader>di", "<cmd>DapStepInto<CR>", desc = "Step into" },
    { "<leader>do", "<cmd>DapStepOut<CR>", desc = "Step out" },
    { "<leader>dt", "<cmd>DapTerminate<CR>", desc = "Stop debugging" },
    {
      "<leader>dv",
      function()
        local widgets = require("dap.ui.widgets")
        variables_window = variables_window or widgets.sidebar(widgets.scopes)
        variables_window.toggle()
      end,
      desc = "Toggle variables",
    },
    {
      "<leader>de",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Evaluate expression",
    },
    {
      "<leader>de",
      function()
        -- `hover()` reads only a `v` selection by itself; with `V` or `<C-v>`
        -- it would evaluate the word under the cursor. The indent has to go
        -- too, or Python rejects a selected line as badly indented.
        local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
        local selection = vim.text.indent(0, table.concat(lines, "\n"))
        vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
        require("dap.ui.widgets").hover(function()
          return selection
        end)
      end,
      mode = "x",
      desc = "Evaluate selection",
    },
    { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "Toggle debug console" },
  },
  ---Use the colorscheme's debugger colors. nvim-dap would otherwise draw its
  ---signs in the sign column's color, and it keeps signs that already exist.
  config = function()
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected" })
    -- `Visual`: the default, `debugPC`, has no background in a transparent
    -- colorscheme, which would leave the current line unmarked.
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "Visual" })
  end,
}
