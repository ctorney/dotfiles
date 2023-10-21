vim.g.everforest_transparent_background = 2
vim.g.everforest_background = "hard"
vim.g.copilot_assume_mapped = true
vim.g.python3_host_prog = 'python'


return {
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
    },
  },

  -- Set colorscheme to use
  colorscheme = "everforest",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = {true, severity = {min = vim.diagnostic.severity.ERROR}},
    underline = false,
    signs = {true, severity = {min = vim.diagnostic.severity.ERROR}},
    update_in_insert = false,

    },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
           "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

   -- Disable default plugins
  enabled = {
    cmp = true,
    heirline = true,
    bufferline = false,
    neo_tree = false,
    lualine = false,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin"},
      },
    },
  },

  polish = function()

    
    vim.cmd('nnoremap q: <Nop>')
    vim.cmd('cnoremap q: <Nop>')


    vim.g.guicursor = ""


    -- check if eml filetype and if so disable tabline
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        -- print the filetype
        local file_extension = vim.fn.expand('%:e')
        -- check to see if eml appears in the filetype
        if file_extension == "eml" then
          vim.opt.showtabline = 0
          -- disable the textwidth
          vim.opt.textwidth=1000
        else
          vim.opt.showtabline = 2
        end
      end,
      group = general,
      desc = "Disable Tabline for EML",
    })


    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
      end,
      group = general,
      desc = "Disable New Line Comment",
    })
    
  end,
}
