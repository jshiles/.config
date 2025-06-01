-- lua/plugins/lsp.lua
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
			-- For formatting, ensure conform.nvim is loaded (handled in formatting.lua)
			-- and necessary formatters are in mason's ensure_installed (handled in formatting.lua)
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Setup Mason
			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = {
					"pyright", -- Python
					"gopls", -- Go
					"lua_ls", -- Lua
					"jsonls", -- JSON
					"sqlls", -- SQL
					"bashls", -- Bash/Shell (Bonus)
					"marksman", -- Markdown (Bonus)
					"dockerls", -- Dockerfile (Bonus)
					"yamlls", -- YAML (Bonus)
					"lemminx", -- XML (Bonus)
					"ruff_lsp",
				},
				automatic_installation = true,
			})

			-- Setup nvim-cmp.
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Setup lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.ruff_lsp.setup({ -- <--- ADD RUFF LSP CONFIG
				capabilities = capabilities,
				-- Optional: you can pass settings here if needed, but pyproject.toml is preferred
				init_options = {
					settings = {
						lineLength = 90,
						args = {}, -- e.g. {"--config=/path/to/custom/ruff.toml"}
					},
				},
			})
			-- Go
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			-- JSON
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			-- SQL
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})

			-- Global mappings.
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostics List" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- Add formatting on save if conform.nvim is not handling it or for LSP-specific formatting
					-- However, it's better to let conform.nvim handle this for consistency.
					-- If you still want LSP-based formatting on save as a fallback:
					-- if client.supports_method("textDocument/formatting") then
					--   vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
					--   vim.api.nvim_create_autocmd("BufWritePre", {
					--     group = "LspFormat",
					--     buffer = bufnr,
					--     callback = function()
					--       vim.lsp.buf.format({ async = false })
					--     end,
					--   })
					-- end
				end,
			})
		end,
	},
}
