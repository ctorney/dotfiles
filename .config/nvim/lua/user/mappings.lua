-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- map shift-u to redo
    ["U"] = { "<cmd>redo<cr>", desc = "Redo" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- create key mapping to map alt-f4 to close current buffer
    ["<C-c>"] = { "<cmd>w|Bdelete<cr>", desc = "Close current buffer" },
    ["<leader>sl"] = { "<cmd>SlimeSendCurrentLine<cr>", desc = "Send current line" },
    ["<C-S-CR>"] = { "<cmd>SlimeSendCurrentLine<cr><cr>", desc = "Send current line" },
    ["<leader>sf"] = { "<cmd>%SlimeSend<cr>", desc = "Send current file" },

    -- add a key mapping for HopWord with the prefix "Hop"
    ["<leader>h"] = { name = "", desc = "Hop" },
    ["<leader>hw"] = {"<cmd>HopWord<cr>", desc = "Hop to word"},
    ["hh"] = {"<cmd>HopWord<cr>", desc = "Hop to word"},
    ["<leader>hl"] = {"<cmd>HopLine<cr>", desc = "Hop to line"},
    ["<leader>hc"] = {"<cmd>HopChar1<cr>", desc = "Hop to character"},
    ["<leader>hC"] = {"<cmd>HopChar2<cr>", desc = "Hop to double character"},
    ["<ESC>"] = {""},
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    -- Smart Splits
    ["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    ["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    -- ["<C-h>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    -- ["<C-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    -- ["<C-k>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    -- ["<C-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    -- -- ["<leader>fw"] = {function() require("telescope.builtin").find_files({search_dirs = {".", os.getenv("HOME") .. "/workspace"}})  end, desc = "Find workspace files" },
    ["<C-g>"] = {
		  c = { "<cmd>GpChatNew<cr>", "New Chat" },
		  t = { "<cmd>GpChatToggle<cr>", "Toggle Popup Chat" },
		  f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

		  r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
		  a = { "<cmd>GpAppend<cr>", "Append" },
		  b = { "<cmd>GpPrepend<cr>", "Prepend" },
		  p = { "<cmd>GpPopup<cr>", "Popup" },
		  s = { "<cmd>GpStop<cr>", "Stop" },
	  },
	  ["gt"] = {"<cmd>GpChatToggle<cr>", desc = "Toggle Popup Chat"},
	  ["go"] = {"<cmd>GpEmail<cr>", desc = "Write an Email Response"},
  },
  i = {
    -- Smart Splits
    ["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    ["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },

    ["<C-s>"] = { "<cmd>w<cr>", desc = "Save File" },
    ["<C-g>"] = {"<cmd>GpChatToggle<cr>", desc = "Toggle Popup Chat"},
  },
  o = {
    ["<leader>h"] = { name = "", desc = "Hop" },
    ["<leader>hw"] = {"<cmd>HopWord<cr>", desc = "Hop to word"},
    ["<leader>hl"] = {"<cmd>HopLine<cr>", desc = "Hop to line"},
    ["<leader>hc"] = {"<cmd>HopChar1<cr>", desc = "Hop to character"},
    ["<leader>hC"] = {"<cmd>HopChar2<cr>", desc = "Hop to double character"},
  },
  t = {
    -- setting a mapping to false will disable it
     ["<esc>"] = false,
  },
  v = {
    ["<C-S-CR>"] = { "<Plug>SlimeRegionSend", desc = "Send current selection" },
    ["<C-g>"] = {
		c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
		t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Popup Chat" },

		r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
		a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append" },
		b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend" },
		e = { ":<C-u>'<,'>GpExplain<cr>", "Visual Explain" },
		p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
		s = { "<cmd>GpStop<cr>", "Stop" },
  },
  }
    
}
