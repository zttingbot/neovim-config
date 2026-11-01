---nvim-dap-python: debug Python files and modules with debugpy.
---
---debugpy runs from mason's own copy but starts the script with the project's
---interpreter, so projects don't need it installed. An active virtual
---environment wins over the search in `resolve_python`. A `.env` file in the
---current directory is loaded into the script's environment.
---`:nmap <leader>d` lists the debug keys.
---@see https://github.com/mfussenegger/nvim-dap-python
---@see :help dap-python

---Folders that hold a project's virtual environment.
local VENV_FOLDERS = { ".venv", "venv" }

-- Offer the last module again at the prompt.
local last_module

---Interpreter of a virtual environment directly inside `dir`, if it has one.
---@param dir string
---@return string?
local function venv_python(dir)
  for _, folder in ipairs(VENV_FOLDERS) do
    local python = vim.fs.joinpath(dir, folder, "bin", "python")
    if vim.fn.executable(python) == 1 then
      return python
    end
  end
end

---Find the nearest working virtual environment above the file or directory.
---An empty `.venv` must not hide a working one further up. Buffers without a
---file search from the current directory. Fall back to `python3`: returning
---nothing would use debugpy's private Python, which can't see system packages.
---@param source? string path to search from instead of the current file
---@return string
local function resolve_python(source)
  local root = vim.fs.root(source or 0, function(name, dir)
    return vim.list_contains(VENV_FOLDERS, name) and venv_python(dir) ~= nil
  end)
  return root and venv_python(root) or "python3"
end

---Debug `python -m <name>` through a separate key so starting the current file
---doesn't show a configuration menu every time.
---@param extra? table settings added to the configuration
local function debug_module(extra)
  vim.ui.input({ prompt = "Python module: ", default = last_module }, function(module)
    if not module or module == "" then
      return
    end
    last_module = module
    require("dap").run(vim.tbl_extend("force", {
      type = "python",
      request = "launch",
      name = "Module " .. module,
      module = module,
      console = "integratedTerminal",
      -- A module runs from the current directory, and the open file may belong
      -- to another project. Leave `pythonPath` unset for an active virtual
      -- environment so nvim-dap-python can select its interpreter.
      pythonPath = function()
        if not (vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX) then
          return resolve_python(vim.fn.getcwd())
        end
      end,
    }, extra or {}))
  end)
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
  keys = {
    { "<leader>dm", debug_module, desc = "Debug a Python module" },
    {
      "<leader>dM",
      function()
        debug_module({ justMyCode = false })
      end,
      desc = "Debug a Python module, including library code",
    },
  },
  opts = {
    -- The defaults add test and remote entries, and a menu on every start.
    include_configs = false,
  },
  ---Register debugpy, then the default way to start it. `setup()` also takes
  ---the debugger's path, so `opts` alone can't express it.
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
