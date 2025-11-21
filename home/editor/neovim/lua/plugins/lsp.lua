return {
	{
		"nvim-lspconfig",
		after = function()
			local on_attach = function(_, buffer_nr)
				vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = buffer_nr })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer_nr })
				vim.keymap.set("n", "<leader>aa", vim.lsp.buf.code_action, { buffer = buffer_nr })
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.lexical = {
				cmd = { "lexical" },
				filetypes = { "elixir", "eelixir", "heex" },
				root_markers = { "mix.exs", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.ts_ls = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "package.json", "tsconfig.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.biome = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
				root_markers = { "biome.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.nil_ls = {
				filetypes = { "nix" },
				root_markers = { "flake.nix", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.lua_ls = {
				filetypes = { "lua" },
				root_markers = { ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			}

			vim.lsp.enable({ "lexical", "ts_ls", "biome", "nil_ls", "lua_ls" })
		end,
	},
}
