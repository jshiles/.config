-- lua/plugins/theme.lua
return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure it loads first
		priority = 1000, -- make sure it loads first
		opts = {
			style = "storm", -- Other options: night, day, moon
			-- vim.o.guifont = "Hack Nerd Font:h10",
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
}
