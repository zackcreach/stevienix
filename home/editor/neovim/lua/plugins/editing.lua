return {
	{ "vim-surround" },
	{ "vim-repeat" },
	{
		"emmet-vim",
		ft = { "svelte", "html", "heex", "elixir", "javascript" },
		before = function()
			vim.g.user_emmet_settings = {
				["javascript.jsx"] = {
					extends = "jsx",
				},
				elixir = {
					extends = "html",
				},
				eelixir = {
					extends = "html",
				},
				heex = {
					extends = "html",
				},
			}
			vim.g.user_emmet_mode = "inv"
		end,
	},
	-- Auto formatting
	{
		"conform.nvim",
		after = function()
			require("conform").setup({
				formatters = {
					biome = { require_cwd = true },
				},
				formatters_by_ft = {
					css = { "prettierd" },
					elixir = { "mix" },
					html = { "prettierd" },
					javascript = { "biome-check", "prettierd" },
					javascriptreact = { "biome-check", "prettierd" },
					json = { "biome", "prettierd" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					nix = { "nixpkgs_fmt" },
					svelte = { "prettierd" },
					typescript = { "biome-check", "prettierd" },
					typescriptreact = { "biome-check", "prettierd" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
	-- Linter
	{
		"nvim-lint",
		after = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				elixir = { "credo" },
				javascript = { "biomejs" },
				javascriptreact = { "biomejs" },
				typescript = { "biomejs" },
				typescriptreact = { "biomejs" },
			}

			local group = vim.api.nvim_create_augroup("MyLinter", {})

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				pattern = { "*.ex*", "*.{js,ts}*" },
				callback = function()
					lint.try_lint()
				end,
				group = group,
			})
		end,
	},
	{
		"nvim-treesitter",
		after = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				highlight = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["ia"] = "@attribute.inner",
							["aa"] = "@attribute.outer",
							["ic"] = "@comment.inner",
							["ac"] = "@comment.outer",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["am"] = "@class.outer",
							["im"] = "@class.inner",
							["ib"] = "@block.inner",
							["ab"] = "@block.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = false,
						goto_next_start = {
							["]]"] = "@function.outer",
						},
						goto_next_end = {
							["]["] = "@function.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
						},
						goto_previous_end = {
							["[]"] = "@function.outer",
						},
					},
				},
			})
		end,
	},
	{
		"comment.nvim",
		after = function()
			require("Comment").setup({})
		end,
	},
	{
		"treesj",
		after = function()
			local treesj = require("treesj")
			local map = vim.keymap.set

			treesj.setup({ use_default_keymaps = false, max_join_length = 1000 })

			map("n", "<leader>n", require("treesj").toggle)
			map("n", "<leader>N", function()
				treesj.toggle({ split = { recursive = true } })
			end)
		end,
	},
}
