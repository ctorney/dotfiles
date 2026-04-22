

-- ------------------------------------------------------------------------------------------------
--                          TOOLS - NOICE, WHICHKEY
-- ------------------------------------------------------------------------------------------------
vim.o.cmdheight = 0
require('vim._core.ui2').enable({
  enable = true,
  msg = {
    targets = {
      [''] = 'msg',
      empty = 'cmd',
      bufwrite = 'msg',
      confirm = 'cmd',
      emsg = 'pager',
      echo = 'msg',
      echomsg = 'msg',
      echoerr = 'pager',
      completion = 'cmd',
      list_cmd = 'pager',
      lua_error = 'pager',
      lua_print = 'msg',
      progress = 'pager',
      rpc_error = 'pager',
      quickfix = 'msg',
      search_cmd = 'cmd',
      search_count = 'cmd',
      shell_cmd = 'pager',
      shell_err = 'pager',
      shell_out = 'pager',
      shell_ret = 'msg',
      undo = 'msg',
      verbose = 'pager',
      wildlist = 'cmd',
      wmsg = 'msg',
      typed_cmd = 'cmd',
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})
vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })
require("tiny-cmdline").setup()

vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})


require("which-key").setup({
	-- triggers = {
	-- 	{ "<leader>", mode = { "n", "v" } },
	-- },
	preset = "modern",
	win = {
		no_overlap = false,
		height = { min = 4, max = 50 },
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
	},
	wo = {
		winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
	},
})

-- ------------------------------------------------------------------------------------------------
--                      UTILITIES - SUBSTITUTE, ESCAPE, CONFORM, FLASH
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/gbprod/substitute.nvim",
	"https://github.com/max397574/better-escape.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/folke/flash.nvim",
  "https://github.com/alexekdahl/marksman.nvim",
})

require("better_escape").setup()

require("substitute").setup({
	on_substitute = nil,
	yank_substituted_text = false,
	preserve_cursor_position = false,
	modifiers = nil,
	highlight_substituted_text = {
		enabled = true,
		timer = 500,
	},
	range = {
		prefix = "s",
		prompt_current_text = false,
		confirm = false,
		complete_word = false,
		subject = nil,
		range = nil,
		suffix = "",
		auto_apply = false,
		cursor_position = "end",
	},
	exchange = {
		motion = false,
		use_esc_to_cancel = true,
		preserve_cursor_position = false,
	},
})

require("conform").setup({
	notify_on_error = true,
	format_on_save = false,
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "blue" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
	ormatters = {
		stylua = {
			prepend_args = { "--column-width", "179" },
		},
	},
})

require("flash").setup({
	jump = { autojump = false },
	modes = {
		char = {
			enabled = true,
			autohide = true,
		},
	},
	highlight = {
		-- show a backdrop with hl FlashBackdrop
		backdrop = false,
	},
})

-- Substitute (Normal)
vim.keymap.set("n", "gs", function()
	require("substitute").operator()
end, { desc = "Substitute" })

-- Substitute (Visual)
vim.keymap.set("x", "gs", function()
	require("substitute").visual()
end, { desc = "Substitute" })

-- Format buffer (Normal, Visual, Select, Operator-pending)
vim.keymap.set({ "n", "v", "s", "o" }, "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- Flash (Normal, Visual, Operator-pending)
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

-- Flash Treesitter (Normal, Visual, Operator-pending)
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })


require("marksman").setup({
  max_marks = 100,
  minimal = true,
  silent = true,
  disable_default_keymaps = true,
})

vim.keymap.set("n", "<leader>ma", function() require("marksman").add_mark() end, { desc = "Add mark" })
vim.keymap.set("n", "<leader>mn", function() require("marksman").goto_next() end, { desc = "Go to next mark" })
vim.keymap.set("n", "<leader>mp", function() require("marksman").goto_previous() end, { desc = "Go to previous mark" })
vim.keymap.set("n", "<leader>m1", function() require("marksman").goto_mark(1) end, { desc = "Go to mark 1" })
vim.keymap.set("n", "<leader>m2", function() require("marksman").goto_mark(2) end, { desc = "Go to mark 2" })
vim.keymap.set("n", "<leader>m3", function() require("marksman").goto_mark(3) end, { desc = "Go to mark 3" })
vim.keymap.set("n", "<leader>m4", function() require("marksman").goto_mark(4) end, { desc = "Go to mark 4" })
  
