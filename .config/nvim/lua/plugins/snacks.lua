local hosts = require("config.hosts")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    version = "*",
    lazy = false,
    ---@type snacks.Config
    opts = {
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
            -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },

            { icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
            -- { icon = " ", key = "h", desc = "Hosts", action = "<leader>fh" },
            -- {
            -- 	icon = " ",
            -- 	key = "g",
            -- 	desc = "Find Text",
            -- 	action = ":lua Snacks.dashboard.pick('live_grep')",
            -- },
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
              -- action = ":lua require('oil').open_float('~/Obsidian/Notes/', { preview = {} })",
            },
            {
              icon = "󰒲 ",
              key = "l",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          -- { section = "header", pane = 1, padding = 4, indent = 60 },

          { text = string.format('NVIM %s', vim.version()), align = 'center', padding = 4 },
          { section = "keys", gap = 1, padding = 4, pane = 1 },
          -- { section = "terminal", cmd = "", padding = 4, height = 6, pane = 2 },
          { icon = " ", title = "Recent Files", padding = 1, gap = 1 },
          { section = "recent_files", opts = { limit = 30 }, indent = 1, padding = 5 }, --, padding = 1, pane = 1 },
          -- { icon = " ", title = "Projects", padding = 1, pane = 2 },
          -- { section = "projects", opts = { limit = 3 }, indent = 1, padding = 1, pane = 2 },
          { section = "startup", padding = 1 },
        },
      },
      indent = { enabled = true },
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      scroll = { enabled = false },
      scratch = { enabled = true, ft = 'markdown' },
      quickfile = { enabled = true },
      image = { enabled = true, force = true, doc = { enabled = false, inline = true, float = false } },
      statuscolumn = { enabled = true },
      picker = {
        enabled = true,
        -- ui_select = true,
        -- formatters = { file = { truncate = 4000, icon_width = 4, git_status_hl = false } },
        -- icons = {
        -- 	files = {
        -- 		enabled = true, -- show file icons
        -- 	},
        -- },
        sources = {
          marksman = {
            finder = require("config.functions").SnacksMarksman,
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
    },
    keys = {
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
        "/",
        -- "<leader>fl",
        function()
          Snacks.picker.lines({ layout = { preview = true, preset = "default", }, matcher = {fuzzy = false} })
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
          Snacks.explorer({ cwd = '~/Obsidian/Notes/', exclude = {} })
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
          Snacks.picker.commands()
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
        "<leader>fp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Search for Plugin Spec",
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
      { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
      { "<leader>fd", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
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
    },
  }
}
