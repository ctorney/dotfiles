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
        { "<leader>ff", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fs", "<cmd>Telescope aerial<cr>", desc = "Symbols (aerial)" },
        { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find" },
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
