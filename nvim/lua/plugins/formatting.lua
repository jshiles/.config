-- lua/plugins/formatting.lua
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { { "ruff", "format", "--line-length=90" } },
				go = { "gofmt", "goimports" },
				json = { "prettier" },
				sql = { "sqlfluff" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		init = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>fm",
				"<cmd>Format<CR>",
				{ noremap = true, silent = true, desc = "Format Buffer" }
			)
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"ruff",
				"gofmt",
				"goimports",
				"prettier", -- Handles JS, TS, JSON, HTML, CSS, MD, YAML etc.
				"sqlfluff",
			})
		end,
	},
}
