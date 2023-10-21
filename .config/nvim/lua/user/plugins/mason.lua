-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "lua_ls",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "prettier",
        -- "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "python",
      })

      opts.handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.configurations = 
          {
            {
              -- The first three options are required by nvim-dap
              type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
              request = 'launch';
              name = "Launch file";
              program = "${file}";
              pythonPath = "python3";
              justMyCode = false;
            }}

            require('mason-nvim-dap').default_setup(config)
          end,

        }
      end,
    },
  }
