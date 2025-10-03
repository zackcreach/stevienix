return {
	{
		"nvim-lspconfig",
		after = function()
			local lsp_config = require("lspconfig")
			local on_attach = function(_, buffer_nr)
				vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = buffer_nr })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer_nr })
				vim.keymap.set("n", "<leader>aa", vim.lsp.buf.code_action, { buffer = buffer_nr })
			end

			-- original lexical
			lsp_config.lexical.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				cmd = { "lexical" },
			})

			-- expert
			-- lsp_config.lexical.setup({
			-- 	cmd = { "/Users/zack/dev/expert/apps/expert/burrito_out/expert_darwin_arm64" },
			-- 	root_dir = function(fname)
			-- 		return require("lspconfig").util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
			-- 	end,
			-- 	filetypes = { "elixir", "eelixir", "heex" },
			-- })

			-- lsp_config.tailwindcss.setup({
			-- 	cmd = { "/opt/homebrew/bin/tailwindcss-language-server" },
			-- 	on_attach = on_attach,
			-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
			-- })

			lsp_config.ts_ls.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_config.biome.setup({
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
