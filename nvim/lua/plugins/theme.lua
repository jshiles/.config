-- =================================================================
-- Theme
-- =================================================================
return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure the theme is loaded first
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("tokyonight").setup({
			transparent = true, -- Enable transparent background
			styles = {
				sidebars = "transparent", -- Make sidebars transparent
				floats = "transparent", -- Make floating windows transparent
			},
		})
		vim.cmd("colorscheme tokyonight-storm")
	end,
}
