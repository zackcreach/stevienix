return {
	"tpope/vim-surround",
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
		"sbdchd/neoformat",
		lazy = true,
		event = { "VeryLazy" },
		init = function()
			-- Format on save
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	group = vim.api.nvim_create_augroup("fmt", { clear = true }),
			-- 	command = "undojoin | Neoformat",
			-- })

			-- Force specific formatting engines
			vim.g.neoformat_enabled_typescript = { "prettierd" }
			vim.g.neoformat_enabled_javascript = { "prettierd" }
			vim.g.neoformat_enabled_json = { "prettierd" }
			vim.g.neoformat_enabled_css = { "prettierd" }
			vim.g.neoformat_enabled_markdown = { "prettierd" }
			vim.g.neoformat_enabled_html = { "prettierd" }
			vim.g.neoformat_enabled_svelte = { "prettierd" }
			vim.g.neoformat_enabled_lua = { "stylua" }
			vim.g.neoformat_enabled_elixir = { "mixformat" }
		end,
	},
	-- Linter
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				elixir = { "credo" },
			}

			local group = vim.api.nvim_create_augroup("MyLinter", {})

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				pattern = { "*.ex", "*.exs" },
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
			ensure_installed = "all",
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
}
