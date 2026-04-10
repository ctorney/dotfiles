-- ------------------------------------------------------------------------------------------------
--                                            SNACKS.NVIM
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

function SnacksMarksman()
  local marksman = require("marksman")
  local marks = marksman.get_marks()

  local results = {}
  for name, mark in pairs(marks) do
    table.insert(results, {
      text = name,
      file = mark.file,
      pos = { tonumber(mark.line) or 1, tonumber(mark.col) or 1 },
      display = string.format("%s %s:%d", name, vim.fn.fnamemodify(mark.file, ":~:."), mark.line),
    })
  end

  return results
end

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

			{ text = { string.format("NVIM %s", vim.version()), hl = "header" }, align = "center", padding = 4 },
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
	quickfile = { enabled = true },
	image = { enabled = true, force = true, doc = { enabled = false, inline = true, float = false } },
	statuscolumn = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			marksman = {
				finder = SnacksMarksman,
				format = "file",
				preview = "file",
				confirm = "jump", -- simple: uses Snacks' jump action to open file/pos
				-- keymaps to trigger the action
				win = {
					input = {
						keys = {
							["<C-x>"] = { "mark_delete", mode = { "n", "i" } },
						},
					},
					list = {
						keys = {
							["dd"] = "mark_delete",
						},
					},
				},
				-- custom action that deletes marks using marksman.delete_mark
				actions = {
					mark_delete = function(picker)
						-- get selected items, fallback to current item
						local items = picker:selected({ fallback = true })
						if not items or #items == 0 then
							vim.notify("No mark selected", vim.log.levels.WARN)
							return
						end

						local ok, marksman = pcall(require, "marksman")
						if not ok or type(marksman.delete_mark) ~= "function" then
							vim.notify("marksman.delete_mark not available", vim.log.levels.ERROR)
							return
						end

						local removed = 0
						for _, item in ipairs(items) do
							local name = tostring(item.text or "")
							vim.notify("Deleting mark: " .. name)
							if name ~= "" then
								local ok2, res = pcall(marksman.delete_mark, name)
								if ok2 then
									removed = removed + 1
								else
									vim.notify(("Error deleting mark '%s'"):format(name), vim.log.levels.ERROR)
								end
							end
						end

						if removed > 0 then
							vim.schedule(function()
								picker:refresh() -- update the list so deleted marks disappear
							end)
						end

						vim.notify(removed .. " mark(s) deleted")
					end,
				},
			},
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
})

vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete.delete()
end, { desc = "Close Buffer" })

vim.keymap.set("n", "<leader>f/", function()
	Snacks.picker.grep({ buffers = true })
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word under cursor" })

vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>fn", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })

vim.keymap.set("n", "/", function()
	Snacks.picker.lines({ layout = { preview = true, preset = "default" }, matcher = { fuzzy = false } })
end, { desc = "Buffer lines" })

vim.keymap.set("n", "<leader><CR>", function()
	Snacks.picker.buffers({ sort_lastused = false, current = false })
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

vim.keymap.set("n", "<leader>fo", function()
	Snacks.explorer({ cwd = "~/Obsidian/Notes/", exclude = {} })
end, { desc = "Find Obsidian Files" })

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fG", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })

vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })

vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })

vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

vim.keymap.set("n", "<leader>fy", function()
	Snacks.picker.registers()
end, { desc = "Clipboard History" })

vim.keymap.set("n", "<leader>sc", function()
	Snacks.picker.commands({ layout = { preview = false, preset = "select" }, matcher = { fuzzy = false } })
end, { desc = "Commands" })

vim.keymap.set("n", "<leader>f?", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })

vim.keymap.set("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>f'", function()
	Snacks.picker.marks()
end, { desc = "Marks" })

vim.keymap.set("n", "<leader>fm", function()
	Snacks.picker.marksman()
end, { desc = "Project Marks" })

vim.keymap.set("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "Man Pages" })

vim.keymap.set("n", "<leader>fu", function()
	Snacks.picker.undo()
end, { desc = "Undo History" })

vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References", nowait = true })

vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })

vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>fd", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

vim.keymap.set("n", "<leader>fs", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })

vim.keymap.set("n", "<leader>fS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
