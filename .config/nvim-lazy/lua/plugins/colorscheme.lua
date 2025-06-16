return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 2,
        float_style = "none",
        on_highlights = function(hl, palette)
          hl.NormalFloat = { bg = palette.none }
          hl.FloatBorder = { bg = palette.none }
          hl.FloatTitle = { bg = palette.none }
          hl.MiniDiffOverAdd = { fg = palette.blue, bg = palette.bg_dim }
          hl.MiniDiffOverDelete = { fg = palette.red, bg = palette.bg_dim }
          hl.MiniDiffOverChange = { fg = palette.blue, bg = palette.bg_dim }
          hl.DiffChange = { fg = palette.grey0, bg = palette.none }
          -- hl.BlinkCmpSignatureHelpBorder = { fg = palette.grey0, bg = palette.red }
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
