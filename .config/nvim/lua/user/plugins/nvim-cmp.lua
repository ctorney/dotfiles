
return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp"},
      { name = "luasnip"},
      { name = "buffer"},
      { name = "path"},

    }

    opts.completion = {
      autocomplete = false,
    }
    -- map ctrl-x to abort
    opts.mapping["<C-x>"] = cmp.mapping.abort()
    -- return the new table to be used
    return opts

  end,
}
