return {
	{
		"nvim-lspconfig",
		after = function()
			local lsp_config = require("lspconfig")
			local configs = require("lspconfig.configs")
			local on_attach = function(client, buffer_nr)
				vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = buffer_nr })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer_nr })
				vim.keymap.set("n", "<leader>aa", vim.lsp.buf.code_action, { buffer = buffer_nr })
			end

			lsp_config.lexical.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				cmd = { "lexical" },
			})

			lsp_config.tailwindcss.setup({
				cmd = { "/opt/homebrew/bin/tailwindcss-language-server" },
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_config.ts_ls.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_config.nil_ls.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_config.lua_ls.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
}
