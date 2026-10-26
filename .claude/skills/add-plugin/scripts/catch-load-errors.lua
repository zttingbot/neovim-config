---Runs inside Neovim for run-checks.sh: loads a plugin and fails on any error.
---
---Loaded with --cmd, before init.lua, so it sees errors from startup on. A
---failing plugin setup neither sets v:errmsg nor changes Neovim's exit code:
---lazy.nvim catches it and only reports it.

local errors = {}

---@param msg string|string[]
local function record(msg)
  table.insert(errors, type(msg) == "table" and table.concat(msg, "\n") or tostring(msg))
end

-- lazy.nvim runs each plugin's init and config through lazy.core.util.try()
-- and reports failures with that module's error(). Hook error() as soon as
-- the module loads: a plugin may replace vim.notify before it fails.
local require_original = require
_G.require = function(name)
  local module = require_original(name)
  if name == "lazy.core.util" then
    _G.require = require_original
    local lazy_error = module.error
    module.error = function(msg, opts)
      record(msg)
      return lazy_error(msg, opts)
    end
  end
  return module
end

-- Errors plugins report themselves. lazy.nvim's own are titled "lazy.nvim"
-- and already recorded by the hook above.
local notify = vim.notify
vim.notify = function(msg, level, opts)
  if level == vim.log.levels.ERROR and not (opts and opts.title == "lazy.nvim") then
    record(msg)
  end
  return notify(msg, level, opts)
end

---@param name string
---@param module string
local function load(name, module)
  -- Headless Neovim has no UI, so lazy.nvim never fires VeryLazy by itself.
  vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy", modeline = false })
  if not require("lazy.core.config").plugins[name] then
    record("lazy.nvim has no plugin named " .. name)
    return
  end
  require("lazy").load({ plugins = { name } })
  if module ~= "" then
    local ok, err = pcall(require, module)
    if not ok then
      record(tostring(err):match("[^\n]+"))
    end
  end
end

---Load the plugin named in $PLUGIN and require $MODULE, if set. Exit with
---status 1 if anything reported an error.
function check_plugin()
  local ok, err = pcall(load, os.getenv("PLUGIN"), os.getenv("MODULE") or "")
  if not ok then
    record(err)
  end
  -- Run callbacks plugins scheduled, which may report errors too.
  vim.wait(100, function()
    return false
  end)
  -- vim.notify at ERROR level also sets v:errmsg, so it may be recorded already.
  if vim.v.errmsg ~= "" and not vim.tbl_contains(errors, vim.v.errmsg) then
    record(vim.v.errmsg)
  end
  if #errors > 0 then
    io.stderr:write(table.concat(errors, "\n"), "\n")
    vim.cmd("cquit 1")
  end
end
