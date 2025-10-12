return {
  -- {
  -- 	dir = "~/workspace/arduino-tools.nvim/",
  -- 	name = "arduino-tools.nvim",
  -- 	ft = { "arduino" },
  -- 	opts = {
  -- 		cli_config = "~/Library/Arduino15/",
  -- 	},
  -- },
  -- {
  --     "inhesrom/remote-ssh.nvim",
  --     branch = "master",
  --     dependencies = {
  --         "inhesrom/telescope-remote-buffer", --See https://github.com/inhesrom/telescope-remote-buffer for features
  --         "nvim-telescope/telescope.nvim",
  --         "nvim-lua/plenary.nvim",
  --         "neovim/nvim-lspconfig",
  --         -- nvim-notify is recommended, but not necessarily required into order to get notifcations during operations - https://github.com/rcarriga/nvim-notify
  --         "rcarriga/nvim-notify",
  --     },
  --     config = function ()
  --         require('telescope-remote-buffer').setup(
  --             -- Default keymaps to open telescope and search open buffers including "remote" open buffers
  --             --fzf = "<leader>fz",
  --             --match = "<leader>gb",
  --             --oldfiles = "<leader>rb"
  --         )
  --
  --         -- setup lsp_config here or import from part of neovim config that sets up LSP
  --         -- local lsp_config = require("lsp.config")
  --
  --         require('remote-ssh').setup({
  --             on_attach = lsp_config.on_attach,
  --             capabilities = lsp_config.capabilities,
  --             filetype_to_server = lsp_config.filetype_to_server
  --         })
  --     end
  -- }

  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",                   -- Load when opening Python files
    keys = {
      { "<leader>fv", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = {                         -- this can be an empty lua table - just showing below for clarity.
      search = {
        venv = {
          command = "fd --full-path '^.*/bin/python$' ~/.venv"
        },
      },           -- if you add your own searches, they go here.
      options = {} -- if you add plugin options, they go here.
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    opts = true,
    keys =
    {
      { '<C-h>', function() require('smart-splits').move_cursor_left() end,  desc = "Go to Left Window" },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end,  desc = "Go to Lower Window" },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end,    desc = "Go to Upper Window" },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = "Go to Right Window" },
    }

  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        "icon",
        "mtime",
      },
      view_options = {
        show_hidden = false,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { "mtime", "desc" },
        },
      },
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = false,
      },
      skip_confirm_for_simple_edits = true,
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.8,
        max_height = 0.8,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      preview_win = {
        -- preview_method = "load",
        -- disable_preview = function(filename)
        --   -- return false for py, txt, md, lua files
        --   if
        --       filename:match("%.py$")
        --       or filename:match("%.txt$")
        --       or filename:match("%.md$")
        --       or filename:match("%.lua$")
        --   then
        --     return false
        --   end
        --   return true
        -- end,
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<Right>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<Esc>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["<Left>"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      {
        "-",
        function()
          require("oil").open_float(nil, { preview = {} })
        end,
        desc = "Open oil at current buffer",
      },
      -- {
      -- 	"<leader>fe",
      -- 	function()
      -- 		require("oil").open_float(nil) --, { preview = {} })
      -- 	end,
      -- 	desc = "Open oil at current buffer",
      -- },
      {
        "<leader>fe",
        function()
          require("oil").open_float(nil, { preview = {} })
        end,
        desc = "Open oil in home directory",
      },
    },
  },
  -- {
  -- 	"obsidian-nvim/obsidian.nvim",
  -- 	-- version = "*", -- recommended, use latest release instead of latest commit
  -- 	lazy = true,
  -- 	ft = "markdown",
  -- 	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- 	-- event = {
  -- 	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  -- 	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  -- 	--   -- refer to `:h file-pattern` for more examples
  -- 	--   "BufReadPre path/to/my-vault/*.md",
  -- 	--   "BufNewFile path/to/my-vault/*.md",
  -- 	-- },
  -- 	dependencies = {
  -- 		-- Required.
  -- 		"nvim-lua/plenary.nvim",
  -- 	},
  -- 	cmd = {
  -- 		"Obsidian",
  -- 	},
  -- 	opts = {
  -- 		workspaces = {
  -- 			{
  -- 				name = "Notes",
  -- 				path = "~/Obsidian/Notes/",
  -- 			},
  -- 		},
  -- 		completion = {
  -- 			-- Enables completion using nvim_cmp
  -- 			nvim_cmp = false,
  -- 			-- Enables completion using blink.cmp
  -- 			blink = true,
  -- 			-- Trigger completion at 2 chars.
  -- 			min_chars = 2,
  -- 		},
  -- 		picker = {
  -- 			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
  -- 			name = "snacks.pick",
  -- 			-- Optional, configure key mappings for the picker. These are the defaults.
  -- 			-- Not all pickers support all mappings.
  -- 			note_mappings = {
  -- 				-- Create a new note from your query.
  -- 				new = "<C-x>",
  -- 				-- Insert a link to the selected note.
  -- 				insert_link = "<C-l>",
  -- 			},
  -- 			tag_mappings = {
  -- 				-- Add tag(s) to current note.
  -- 				tag_note = "<C-x>",
  -- 				-- Insert a tag at the current location.
  -- 				insert_tag = "<C-l>",
  -- 			},
  -- 		},
  -- 	},
  -- },
  {
    "stevearc/stickybuf.nvim",
    opts = {
      -- This function is run on BufEnter to determine pinning should be activated
      get_auto_pin = function(bufnr)
        -- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned.
        -- You can instead return an table that will be passed in as "opts" to `stickybuf.pin`.
        -- The function below encompasses the default logic. Inspect the source to see what it does.
        if vim.bo[bufnr].filetype == "codecompanion" then
          return "filetype"
        end
        return require("stickybuf").should_auto_pin(bufnr)
      end,
    },
  },
  {
    "ctorney/terminal-image.nvim",
    opts = {},
  },
  {
    "nvzone/floaterm",
    lazy = true,
    dependencies = "nvzone/volt",
    opts = {
      border = true,
      size = { h = 60, w = 70 },

      -- to use, make this func(buf)
      mappings = { sidebar = nil, term = nil },

      -- Default sets of terminals you'd like to open
      terminals = {
        { name = "Local" },
        -- cmd can be function too
        { name = "euclid35", cmd = "ssh euclid35" },
        -- More terminals
      },
    },
    -- config = function(_, opts)
    -- 	require("floaterm").setup(opts)
    -- 	-- Ensure colorscheme is applied after floaterm loads
    -- 	-- vim.cmd.colorscheme("everforest")
    -- end,
    cmd = "FloatermToggle",
    keys = {
      {
        "<c-/>",
        function()
          -- vim.cmd.colorscheme("everforest")
          -- vim.api.nvim_set_hl(0, "added", { fg = "#ff0000", bg = "#000000", bold = true })
          -- vim.api.nvim_set_hl(0, "removed", { fg = "#ff0000", bg = "#00f000", bold = true })

          require("floaterm").toggle()
        end,
        mode = { "n", "x", "o", "t", "i" },
        desc = "Toggle FTerm",
      },
    },
  },
  -- {
  -- 	"gbprod/yanky.nvim",
  -- 	opts = {},
  -- },
  {
    "gbprod/substitute.nvim",
    config = true,
    -- opts = {
    -- 	on_substitute = function()
    -- 		require("yanky.integration").substitute()
    -- 	end,
    -- },
    keys = {
      {
        "gs",
        mode = "n",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute",
      },
      {
        "gs",
        mode = "x",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>c",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "blue" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = { jump = { autojump = false } },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  -- Better text-objects
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          m = {
            { "%b()", "%b[]", "%b{}" },
            "^.().*().$",
          },
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
          h = function(opts)
            local cell_marker = "# %%"
            local start_line = vim.fn.search("^" .. cell_marker, "bcnW")

            if start_line == 0 then
              start_line = 1
            else
              if opts == "i" then
                start_line = start_line + 1
              end
            end

            local end_line = vim.fn.search("^" .. cell_marker, "nW") - 1
            if end_line == -1 then
              end_line = vim.fn.line("$")
            end

            if opts == "i" then
              -- Find first non-blank line after start
              local first_nonblank = vim.fn.nextnonblank(start_line)
              if first_nonblank > 0 and first_nonblank <= end_line then
                start_line = first_nonblank
              end

              -- Find last non-blank line before end
              local last_nonblank = vim.fn.prevnonblank(end_line)
              if last_nonblank >= start_line then
                end_line = last_nonblank
              end
            end

            local last_col = math.max(vim.fn.getline(end_line):len(), 1)

            local from = { line = start_line, col = 1 }
            local to = { line = end_line, col = last_col }

            return { from = from, to = to }
          end,
        },
      }
    end,
  },
}
