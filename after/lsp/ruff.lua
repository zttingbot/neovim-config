---ruff overrides, merged over nvim-lspconfig's lsp/ruff.lua.
---
---The ruff server runs alongside the buffer's main Python server for its
---lint diagnostics and quick fixes only. Formatting stays with conform
---(ruff_format in plugins/coding/conform.lua), and hover stays with the main
---server, as Ruff's editor docs recommend.
---
---The capabilities are cleared in on_init, which runs before the client
---attaches: Neovim reads them on attach to decide whether to set 'formatexpr'
---and the K hover map, so a server without them sets neither. ruff would
---otherwise register formatting again after startup (dynamic registration),
---so the client also tells it that it doesn't accept that for formatting.
---@see :help lsp-config
---@see https://docs.astral.sh/ruff/editors/setup/#neovim

---@type vim.lsp.Config
return {
  capabilities = {
    textDocument = {
      formatting = { dynamicRegistration = false },
      rangeFormatting = { dynamicRegistration = false },
    },
  },
  ---@param client vim.lsp.Client
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.server_capabilities.hoverProvider = false
  end,
}
