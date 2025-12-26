
-- ------------------------------------------------------------------------------------------------
--                                            SNACKS.NVIM
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/folke/snacks.nvim"
})

local Snacks = require("snacks")
Snacks.setup({
	styles = {
		snacks_image = {
			relative = "editor",
			col = -1,
		},
	},
	dim = { enabled = true },
	dashboard = {
		enabled = true,
		pane_gap = 10,
		preset = {
			keys = {
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
				{
					icon = " ",
					key = "r",
					desc = "Recent Files",
					action = ":lua Snacks.dashboard.pick('oldfiles')",
				},
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{
					icon = " ",
					key = "o",
					desc = "Obsidian",
					action = ":lua Snacks.explorer({cwd = '~/Obsidian/Notes/', exclude = {}})",
				},
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {

      {text = { string.format("NVIM %s", vim.version()), hl='header'  }, align = "center", padding = 4},
			{ section = "keys", gap = 1, padding = 4, pane = 1 },
			{ icon = " ", title = "Recent Files", padding = 1, gap = 1 },
			{ section = "recent_files", opts = { limit = 30 }, indent = 1, padding = 5 }, --, padding = 1, pane = 1 },
		},
	},
	indent = { enabled = true },
	bufdelete = { enabled = true },
	notifier = { enabled = true },
	scroll = { enabled = false },
	scratch = { enabled = true, ft = "markdown" },
	quickfile = { enabled = false },
	image = { enabled = true, force = true, doc = { enabled = false, inline = true, float = false } },
	statuscolumn = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			explorer = {
				enabled = true,
				tree = false,
				follow_file = false,
				layout = { preset = "default", preview = true },
				exclude = { "*/*" },
				include = { "*", ".*" },
				auto_close = true,
				actions = {
					up_and_close = function(picker, item)
						local Tree = require("snacks.explorer.tree")
						picker:set_cwd(vim.fs.dirname(picker:cwd()))
						Tree:close_all(picker:cwd())
						picker:find()
					end,
					enter_and_clear = function(picker, item)
						picker:set_cwd(picker:dir())
						picker.input:set("", "")
						picker:find()
					end,
					smart_enter = function(picker, item, action)
						if not item then
							return
						elseif item.dir then
							picker:set_cwd(picker:dir())
							picker.input:set("", "")
							picker:find()
						else
							Snacks.picker.actions.jump(picker, item, action)
						end
					end,
				},
				focus = "input",
				win = {
					list = {
						keys = {
							["<Tab>"] = { "toggle_focus", mode = { "n", "i" } },
						},
					},
					input = {
						keys = {
							["<Tab>"] = { "toggle_focus", mode = { "n", "i" } },
							["<CR>"] = { "smart_enter", mode = { "n", "i" } },
							["<S-CR>"] = { "explorer_open", mode = { "n", "i" } },
							["<Left>"] = { "up_and_close", mode = { "n", "i" } },
							["<Right>"] = { "enter_and_clear", mode = { "n", "i" } },
							["<C-h>"] = { "toggle_hidden", mode = { "n", "i" } },
						},
					},
				},
			},
		},
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
				},
			},
		},
	},
}
)

local keymaps = {
	{
		"<leader>bd",
		function()
			Snacks.bufdelete.delete()
		end,
		desc = "Close Buffer",
	},
	{
		"<leader>f/",
		function()
			Snacks.picker.grep({ buffers = true })
		end,
		desc = "Grep",
	},
	{
		"<leader>fw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Grep word under cursor",
	},
	{
		"<leader>fg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>fn",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<leader>fq",
		function()
			Snacks.picker.files({
				layout = { position = "center", row = 10, preview = false, preset = "vertical" },
				on_show = function(picker)
					local cursor = vim.api.nvim_win_get_cursor(picker.main)
					local info = vim.api.nvim_win_call(picker.main, vim.fn.winsaveview)
					picker.list:view(cursor[1], info.topline)
					picker:show_preview()
				end,
				matcher = { fuzzy = false },
			})
		end,
		desc = "Buffer lines",
	},
	{
		"/",
		-- "<leader>fl",
		function()
			Snacks.picker.lines({ layout = { preview = true, preset = "default" }, matcher = { fuzzy = false } })
		end,
		desc = "Buffer lines",
	},
	-- {
	-- 	"<leader>fe",
	-- 	function()
	-- 		Snacks.explorer()
	-- 	end,
	-- 	desc = "File Explorer",
	-- },
	{
		"<leader><CR>",
		function()
			Snacks.picker.buffers({ sort_lastused = false, current = false })
		end,
		desc = "Buffers",
	},
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fc",
		function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find Config File",
	},
	{
		"<leader>fo",
		function()
			-- require("oil").open_float("~/Obsidian/Notes/", { preview = {} })
			Snacks.explorer({ cwd = "~/Obsidian/Notes/", exclude = {} })
		end,
		desc = "Find Obsidian Files",
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fG",
		function()
			Snacks.picker.git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},
	{
		"<leader>sb",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	{
		"<leader>sg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>sw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	-- search
	{
		"<leader>fy",
		function()
			Snacks.picker.registers()
		end,
		desc = "Clipboard History",
	},
	{
		"<leader>sc",
		function()
			Snacks.picker.commands({ layout = { preview = false, preset = "select" }, matcher = { fuzzy = false } })
		end,
		desc = "Commands",
	},
	{
		"<leader>f?",
		function()
			Snacks.picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>fk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>f'",
		function()
			Snacks.picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>fm",
		function()
			Snacks.picker.marksman()
		end,
		desc = "Project Marks",
	},
	{
		"<leader>sM",
		function()
			Snacks.picker.man()
		end,
		desc = "Man Pages",
	},
	{
		"<leader>fu",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo History",
	},
	-- LSP
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>.",
		function()
			Snacks.scratch()
		end,
		desc = "Toggle Scratch Buffer",
	},
	{
		"<leader>fd",
		function()
			Snacks.scratch.select()
		end,
		desc = "Select Scratch Buffer",
	},
	{
		"<leader>fs",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>fS",
		function()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
}

for _, map in ipairs(keymaps) do
	local opts = { desc = map.desc }
	if map.silent ~= nil then
		opts.silent = map.silent
	end
	if map.noremap ~= nil then
		opts.noremap = map.noremap
	else
		opts.noremap = true
	end
	if map.expr ~= nil then
		opts.expr = map.expr
	end

	local mode = map.mode or "n"
	vim.keymap.set(mode, map[1], map[2], opts)
end
