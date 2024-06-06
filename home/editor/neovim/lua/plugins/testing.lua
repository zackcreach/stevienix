return {
	{
		"tpope/vim-projectionist",
		init = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["*.ex"] = {
						alternate = {
							"{}_test.exs",
						},
						type = "source",
					},
					["*_test.exs"] = {
						alternate = {
							"{}.ex",
						},
						type = "test",
					},
				},
			}
		end,
	},
	{
		"janko/vim-test",
		lazy = true,
		event = { "VeryLazy" },
		dependencies = {
			"tpope/vim-dispatch",
			"preservim/vimux",
		},
		config = function()
			local g = vim.g
			local map = vim.keymap.set
			local send_to_tmux = function()
				-- yank text into v register
				if vim.api.nvim_get_mode()["mode"] == "n" then
					vim.cmd('normal vip"vy')
				else
					vim.cmd('normal "vy')
				end
				-- construct command with v register as command to send
				vim.cmd("call VimuxRunCommand(@v)")
			end

			g.VimuxOrientation = "h"
			g.VimuxHeight = "30"
			g.VimuxCloseOnExit = true

			g["test#preserve_screen"] = false
			g["test#strategy"] = {
				nearest = "vimux",
				file = "vimux",
				suite = "vimux",
			}
			g["test#neovim#term_position"] = "vert"
			g.dispatch_compilers = { elixir = "exunit" }

			g["test#custom_strategies"] = {
				vimux_watch = function(args)
					vim.cmd("call VimuxClearTerminalScreen()")
					vim.cmd("call VimuxClearRunnerHistory()")
					vim.cmd(string.format("call VimuxRunCommand('fd . | entr -c %s')", args))
				end,
			}

			map("n", "<leader>tt", "<CMD>TestFile<CR>")
			map("n", "<leader>tT", "<CMD>TestFile -strategy=vimux_watch<CR>")
			map("n", "<leader>tn", "<CMD>TestNearest<CR>")
			map("n", "<leader>tN", "<CMD>TestNearest -strategy=vimux_watch<CR>")
			map("n", "<leader>t.", "<CMD>TestLast<CR>")
			map("n", "<leader>tv", "<CMD>TestVisit<CR>zz")
			map("n", "<leader>t<BS>", "<CMD>A<CR>")
			map("n", "<leader>tV", "<CMD>vsplit+A<CR>")
			map("n", "<leader>ts", "<CMD>TestSuite<CR>")
			map("n", "<leader>tS", "<CMD>TestSuite -strategy=vimux_watch<CR>")
			map("n", "<leader>tc", "<CMD>VimuxCloseRunner<CR>")
			map({ "n", "v" }, "<C-c><C-c>", send_to_tmux)
		end,
	},
}
