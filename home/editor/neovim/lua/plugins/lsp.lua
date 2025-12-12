return {
	{
		"nvim-lspconfig",
		after = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Set global capabilities for all servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Configure Expert (official Elixir LSP)
			vim.lsp.config("expert", {
				cmd = { "expert", "--stdio" },
				filetypes = { "elixir", "eelixir", "heex", "surface" },
				root_markers = { "mix.exs", ".git" },
			})

			-- Configure TypeScript
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			})

			-- Configure Biome
			vim.lsp.config("biome", {
				cmd = { "biome", "lsp-proxy" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"json",
					"jsonc",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
				},
				root_markers = { "biome.json", "biome.jsonc" },
			})

			-- Configure Nix
			vim.lsp.config("nil_ls", {
				cmd = { "nil" },
				filetypes = { "nix" },
				root_markers = { "flake.nix", "flake.lock", ".git" },
			})

			-- Configure Lua
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
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
			})

			-- Set up keybindings using LspAttach autocmd
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = bufnr })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
					vim.keymap.set("n", "<leader>aa", vim.lsp.buf.code_action, { buffer = bufnr })
				end,
			})

			-- Enable all servers
			vim.lsp.enable("expert")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("biome")
			vim.lsp.enable("nil_ls")
			vim.lsp.enable("lua_ls")
		end,
	},
}
