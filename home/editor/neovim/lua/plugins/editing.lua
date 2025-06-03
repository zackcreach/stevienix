return {
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
		"ggandor/leap.nvim",
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			local leap = require("leap")
			leap.opts.safe_labels = {}
			leap.add_default_mappings()
		end,
	},
	{
		"mattn/emmet-vim",
		ft = { "svelte", "html", "heex", "elixir", "javascript" },
		init = function()
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
		"stevearc/conform.nvim",
		opts = {},
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "biome", "biome-organize-imports", "prettierd" },
					javascriptreact = { "biome", "biome-organize-imports", "prettierd" },
					typescript = { "biome", "biome-organize-imports", "prettierd" },
					typescriptreact = { "biome", "biome-organize-imports", "prettierd" },
					json = { "biome", "prettierd" },
					css = { "prettierd" },
					markdown = { "prettierd" },
					html = { "prettierd" },
					svelte = { "prettierd" },
					lua = { "stylua" },
					elixir = { "mix" },
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
		"mfussenegger/nvim-lint",
		config = function()
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
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"nvim-treesitter/playground",
		},
		lazy = true,
		event = { "VeryLazy" },
		build = ":TSUpdate",
		opts = {
			auto_install = false,
			highlight = {
				enable = true,
			},
			playground = { enable = true },
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
		},
		config = function(_plugin, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
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
