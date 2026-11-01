---nvim-dap-python: debug Python files with debugpy.
---
---debugpy runs from mason's own copy but starts the script with the project's
---interpreter, so projects don't need it installed. An active virtual
---environment wins over the search in `resolve_python`. A `.env` file in the
---current directory is loaded into the script's environment.
---@see https://github.com/mfussenegger/nvim-dap-python
---@see :help dap-python

---Folders that hold a project's virtual environment.
local VENV_FOLDERS = { ".venv", "venv" }

---Interpreter for the current file: the nearest virtual environment above it,
---wherever Neovim was started, else `python3`. Returning nothing would run the
---script with debugpy's private Python, which can't see system packages.
---@return string
local function resolve_python()
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    for _, folder in ipairs(VENV_FOLDERS) do
      local python = vim.fs.joinpath(dir, folder, "bin", "python")
      if vim.fn.executable(python) == 1 then
        return python
      end
    end
  end
  return "python3"
end

---@type LazySpec
return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
    -- mason's `setup()` puts `debugpy-adapter` on `$PATH`.
    "mason-org/mason.nvim",
  },
  -- `<leader>dc` loads only nvim-dap, so debugpy must be registered by the time
  -- a Python buffer exists.
  ft = "python",
  opts = {
    -- The defaults add test and remote entries, and a menu on every start.
    include_configs = false,
  },
  ---Register debugpy, then the one way to start it. `setup()` also takes the
  ---debugger's path, so `opts` alone can't express it.
  ---@param _ LazyPlugin
  ---@param opts table
  config = function(_, opts)
    local dap_python = require("dap-python")
    dap_python.resolve_python = resolve_python
    dap_python.setup("debugpy-adapter", opts)
    require("dap").configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Current file",
        program = "${file}",
        -- debugpy's default console can't answer `input()`.
        console = "integratedTerminal",
      },
    }
  end,
}
