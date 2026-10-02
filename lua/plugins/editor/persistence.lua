---persistence.nvim: save and restore the open files and splits of a project.
---
---When Neovim exits, the open buffers, splits and tabs (a session) are saved
---for the current directory, and inside a git repository for the current
---branch too. Nothing is restored by itself: start Neovim in the same
---directory and press `<leader>qs`. That brings a project back after a reboot,
---where Neovim would otherwise start empty.
---
---Sessions are stored under `stdpath("state")/sessions`, not in the project.
---@see https://github.com/folke/persistence.nvim
---@see :help persistence.nvim.txt

---@type LazySpec
return {
  "folke/persistence.nvim",
  -- Load when a file is opened, which is when there is something to save, or
  -- on the first keymap below.
  event = "BufReadPre",
  keys = {
    -- `<leader>qs`: reopen the files and splits saved for this directory.
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore session",
    },
    -- `<leader>qS`: pick one of the saved sessions from a list.
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select session",
    },
    -- `<leader>ql`: restore the session saved most recently, whatever its
    -- directory.
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last session",
    },
    -- `<leader>qd`: don't save a session when this Neovim exits, e.g. after
    -- opening files that don't belong to the project. The session saved
    -- before stays as it is.
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't save session on exit",
    },
  },
  -- Empty on purpose: the defaults are used, but `setup()` must run to save
  -- on exit.
  opts = {},
}
