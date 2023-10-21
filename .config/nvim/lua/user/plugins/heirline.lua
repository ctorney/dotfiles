return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astronvim.utils.status")
    local get_hlgroup = require("astronvim.utils").get_hlgroup
    opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          -- add the neovim mode indicator with a red background and blue text
          
          -- status.component.mode { mode_text = { padding = { left = 1, right = 1 }}},
          -- add the vim mode component
          status.component.mode {
            -- enable mode text with padding as well as an icon before it
            mode_text = { padding = { right = 1, left = 1 } },
            -- set the text colour to be red and make it bold
            hl = { fg = "#D3C6AA" },


            -- surround the component with a separators
            surround = {
              -- it's a left element, so use the left separator
              separator = "left",
              -- set the color of the surrounding based on the current mode using astronvim.utils.status module
              color = function() return { main = "bg" } end,
            },
          },
          status.component.git_branch(),
          status.component.file_info { filetype = {}, filename = false, file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          -- remove the 2nd mode indicator on the right
        }

      
    -- -- return the final configuration table
    -- opts.colors = {
    --       HeirlineNormal.fg = "#ffffff",
    --           HeirlineNormal.bg = "#1E2326",:wqa
    --     }

    return opts
  end,
}
