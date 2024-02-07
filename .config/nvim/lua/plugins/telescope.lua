return {
  {
    "nvim-telescope/telescope.nvim",
    defaults = {
      prompt_prefix = " ",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55 },
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
            local cwd = vim.fn.getcwd()
            local is_inside_git
            vim.fn.system("git rev-parse --is-inside-work-tree")
            is_inside_git = vim.v.shell_error == 0
            if is_inside_git then
              require("telescope.builtin").git_files()
            else
              require("telescope.builtin").find_files()
            end
          end,
          desc = "Find Files",
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
          },
        },
      },
    },
    extensions = {
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
