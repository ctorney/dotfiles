return {
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",                                                                    -- Load when opening Python files
    keys = {
      { "<leader>fv", "<cmd>VenvSelect<cr>", desc = 'Virtual Environment Selector' }, -- Open picker on keymap
    },
    opts = {                                                                          -- this can be an empty lua table - just showing below for clarity.
      search = {
        venv = {
          command = "fd --full-path '^.*/bin/python$' ~/.venvs"
        },
      },           -- if you add your own searches, they go here.
      options = {} -- if you add plugin options, they go here.
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    version = '2.0.4',
    lazy = false,
    opts = true,
    keys =
    {
      { '<C-h>', function() require('smart-splits').move_cursor_left() end,  mode = { "n", "i" }, desc = "Go to Left Window" },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end,  mode = { "n", "i" }, desc = "Go to Lower Window" },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end,    mode = { "n", "i" }, desc = "Go to Upper Window" },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, mode = { "n", "i" }, desc = "Go to Right Window" },
    }

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
    version = "*",
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
    "alexekdahl/marksman.nvim",
    keys = {
      {
        "<leader>ma",
        function() require("marksman").add_mark() end,
        desc = "Add mark",
      },
      {
        "<leader>mn",
        function() require("marksman").goto_next() end,
        desc = "Go to next mark",
      },
      {
        "<leader>mp",
        function() require("marksman").goto_previous() end,
        desc = "Go to previous mark",
      },
      {
        "<leader>m1",
        function() require("marksman").goto_mark(1) end,
        desc = "Go to mark 1",
      },
      {
        "<leader>m2",
        function() require("marksman").goto_mark(2) end,
        desc = "Go to mark 2",
      },
      {
        "<leader>m3",
        function() require("marksman").goto_mark(3) end,
        desc = "Go to mark 3",
      },
      {
        "<leader>m4",
        function() require("marksman").goto_mark(4) end,
        desc = "Go to mark 4",
      },
    },
    opts = {
      max_marks = 100,
      minimal = true,
      silent = true,
      disable_default_keymaps = true,
    },
  },
  {
    "numtostr/FTerm.nvim",
    version = "*",
    opts = {
      dimensions = { height = 0.6, width = 0.6 },
      border = "rounded",
    },
    keys = {
      {
        "<c-.>",
        function()
          require("FTerm").toggle()
        end,
        mode = { "n", "x", "o", "t", "i" },
        desc = "Toggle FTerm",
      },
    },
  },
  {
    "gbprod/substitute.nvim",
    version = "*",
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
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    version = "*",
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
    version = "*",
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
    version = "*",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    version = "*",
    config = true,
  },
{
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	opts = {},
	keys = {
		{
			"<leader>r",
			function() require("rip-substitute").sub() end,
			mode = { "n", "x" },
			desc = " rip substitute",
		},
	},
},

  -- Better text-objects
  {
    "nvim-mini/mini.ai",
    version = "*",
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
