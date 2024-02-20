local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    defaults = {
      prompt_prefix = " ",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.5 },
        vertical = { mirror = false },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
    },
    keys = function()
      return {
        -- { "<leader>fF", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        {
          "<leader>fF",
          function()
            require("telescope.builtin").find_files({
              cwd = "~",
            })
          end,
          desc = "Find Config Files",
        },
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fs", "<cmd>Telescope aerial<cr>", desc = "Symbols (aerial)" },
        { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo list" },
        { "<leader>fE", "<cmd>Telescope file_browser path=~<cr>", desc = "File browser (root)" },
        -- { "<leader>fF", "<cmd>Telescope find_files<cr>", desc = "Find files (root)" },
        {
          "<leader>fe",
          "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
          desc = "File browser (current wd)",
        },
        { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find" },
        {
          "<leader>fg",
          function()
            local cwd = vim.fn.getcwd()
            local is_inside_git
            vim.fn.system("git rev-parse --is-inside-work-tree")
            is_inside_git = vim.v.shell_error == 0
            if is_inside_git then
              local git_dir =
                vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
              git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
              local opts = {
                cwd = git_dir,
              }
              require("telescope.builtin").live_grep(opts)
            else
              require("telescope.builtin").live_grep()
            end
          end,
          desc = "Live grep project",
        },
        {
          "<leader>ff",
          function()
            local cwd = vim.fn.expand("%:p") -- vim.fn.getcwd()
            local is_inside_git
            vim.fn.system("git rev-parse --is-inside-work-tree")
            is_inside_git = vim.v.shell_error == 0
            if is_inside_git then
              require("telescope.builtin").git_files({ hidden = true })
            else
              require("telescope.builtin").find_files({ hidden = true })
            end
          end,
          desc = "Find Files",
        },
        {
          "<leader>fF",
          function()
            require("telescope.builtin").find_files({
              cwd = "~",
              hidden = true,
            })
          end,
          desc = "Find files (root)",
        },
        {
          "<leader>fc",
          function()
            require("telescope.builtin").find_files({
              cwd = vim.fn.stdpath("config"),
              find_command = { "rg", "--files", "--sort", "modified" },
            })
          end,
          desc = "Find Config Files",
        },
        {
          "<leader>fS",
          function()
            require("telescope.builtin").lsp_document_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<leader>fm",
          function()
            require('telescope').extensions.bookmarks.list()

            -- local marks = require("marks")
            -- local buffers = marks.bookmark_state['groups'][0]['marks']
            -- local results = {}
            -- for _, bufid in ipairs(buffers) do
            --   local marks = buffers[value]
            --   for _, line in ipairs(marks) do
            --     table.insert(results, marks[line])
            --   end
            -- end

            -- for index, value in ipairs(results) do
            --   print(index, value)
            -- end
            -- local marks = bookmarks:all_to_list()
    --         print(vim.inspect(bookmarks))
    --         require("arshlib")
    --         local opts = {}
    --         local results = {}
    --       opts.path_display = {"smart"}
    --         -- basic telescope configuration
    --         local conf = require("telescope.config").values
    --         local bookmarks = require("marks").bookmark_state
    --         print(vim.inspect(bookmarks))
    --         print(bookmarks)
    --         local entry_display = require("telescope.pickers.entry_display")
    --         local file_paths = {}
    --         local harpoon_files = require("harpoon"):list()
    --         local marks = vim.api.nvim_exec2("marks", {output=true})
    --         -- Pop off the header.
    -- table.remove(marks, 1)
    --
    -- for i = #marks - 1, 3, -1 do
    --     local mark, line, col, filename = marks[i]:match(
    --         [[([%w<>%."'%^%]%[]+)%s+(%d+)%s+(%d+)%s+(.*)]])
    --     table.insert(
    --         results,
    --         {
    --             mark = mark,
    --             lnum = tonumber(line),
    --             col = tonumber(col),
    --             text = filename,
    --         }
    --     )
    -- end
    --
    -- local all_builtin = _t({"<", ">", "[", "]", ".", "^", '"', "'"})
    -- local builtin_marks = _t(require("marks").mark_state.builtin_marks)
    --
    -- results =
    --     vim.tbl_filter(function(line)
    --         if all_builtin:contains(line.mark) and not builtin_marks:contains(line.mark) then
    --             return false
    --         end
    --         return true
    --     end, results) --[[@as table]]
    --
    -- local displayer =
    --     entry_display.create({
    --         separator = "▏",
    --         items = {
    --             {width = 3},
    --             {width = 4},
    --             {width = 3},
    --             {remaining = true},
    --         },
    --     })
    --
    -- local make_display = function(entry)
    --     local filename = tutils.transform_path(opts, entry.filename)
    --     return displayer{
    --         {entry.mark, "WarningMsg"},
    --         {entry.lnum, "SpellCap"},
    --         {entry.col, "Comment"},
    --         {filename, "ErrorMsg"},
    --     }
    -- end
    --
    --       require("telescope.pickers")
    --         .new({}, {
    --     prompt_title = "Marks",
    --     finder =  require("telescope.finders").new_table({
    --         results = marks,
    --         entry_maker = function(e)
    --             -- local bufnr, _, _, _ = unpack(fn.getpos(("'"):format(e.mark)))
    --             -- This, for whatever reason doesn't return the correct filename
    --             -- local filename = api.nvim_buf_get_name(bufnr)
    --
    --             local filename = fn.expand(e.text)
    --             -- If the path doesn't exist, it means it's the current file
    --             if filename == "" or not uv.fs_access(filename, "R") then
    --                 filename = api.nvim_buf_get_name(0)
    --             end
    --
    --             return {
    --                 value = e,
    --                 ordinal = e.mark,
    --                 display = make_display,
    --                 mark = e.mark,
    --                 lnum = e.lnum,
    --                 col = e.col,
    --                 start = e.col,
    --                 text = e.text,
    --                 filename = filename,
    --             }
    --         end,
    --     }),
    --     previewer = conf.grep_previewer(opts),
    --     sorter = conf.generic_sorter(opts),
    --     push_cursor_on_edit = true,
    -- }):find()
          end,
          desc = "List bookmarks"
        },
        {
          "<leader>fh",
          function()
            -- basic telescope configuration
            local conf = require("telescope.config").values
            local file_paths = {}
            local harpoon_files = require("harpoon"):list()
            for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
            end

          require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
           })
          :find()
          end, 
          desc = "Harpoon list"
        },

      }
    end,
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["q"] = require("telescope.actions").close,
            ["/"] = function(prompt_bufnr)
              local fb_utils = require("telescope._extensions.file_browser.utils")
              local selections = fb_utils.get_selected_files(prompt_bufnr, false)
              local search_dirs = vim.tbl_map(function(path)
                return path:absolute()
              end, selections)
              if vim.tbl_isempty(search_dirs) then
                local current_finder = action_state.get_current_picker(prompt_bufnr).finder
                search_dirs = { current_finder.path }
              end
              actions.close(prompt_bufnr)
              require("telescope.builtin").live_grep({ search_dirs = search_dirs })
            end,
          },
        },
      },
    },
    extensions = {
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
      },
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        time_format = "",
        saved_only = false,
      },
      aerial = {
        -- Display symbols as <root>.<parent>.<symbol>
        show_nesting = {
          ["_"] = false, -- This key will be the default
          json = true, -- You can set the option for specific filetypes
          yaml = true,
        },
      },
    },
  },
}
