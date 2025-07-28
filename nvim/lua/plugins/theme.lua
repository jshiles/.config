-- =================================================================
-- Theme
-- =================================================================
return {
   "folke/tokyonight.nvim",
   lazy = false, -- make sure the theme is loaded first
   priority = 1000, -- make sure to load this before all the other start plugins
   config = function()
      vim.cmd("colorscheme tokyonight-storm")
   end,
}

