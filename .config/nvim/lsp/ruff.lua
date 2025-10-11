return {
  -- lsp: https://docs.astral.sh/ruff/editors/setup/#neovim
  -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ruff.lua
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  -- root_dir = (function()
  -- return vim.fs.root(0, root_files)
  -- end)(),
  on_attach = function(client, bufnr)
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  -- HACK: explicitly setting offset encoding:
  -- https://github.com/astral-sh/ruff/issues/14483#issuecomment-2526717736
  capabilities = {
    general = {
      -- positionEncodings = { "utf-8", "utf-16", "utf-32" }  <--- this is the default
      positionEncodings = { "utf-16" },
    },
  },
  init_options = {
    settings = {
      -- https://docs.astral.sh/ruff/editors/settings/
      configurationPreference = "filesystemFirst",
      lineLength = 88,
    },
  },
  settings = {
    ruff = {},
  },
}
