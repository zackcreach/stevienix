return {
	{
		"neovim/nvim-lspconfig",
		-- after = "nvim-cmp",
		config = function()
			local lsp_config = require("lspconfig")
			local configs = require("lspconfig.configs")
			local on_attach = function(client, buffer_nr)
				vim.keymap.set("n", "<cr>zt", vim.lsp.buf.definition, { buffer = buffer_nr })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer_nr })
				vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = buffer_nr })
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
		end,
	},
}
