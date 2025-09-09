return {
	{
		"vim-projectionist",
		event = "User DeferredUIEnter",
		before = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					-- Elixir
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
					-- Javascript
					["*.jsx"] = {
						alternate = {
							"{}.test.jsx",
						},
						type = "source",
					},
					["*.test.jsx"] = {
						alternate = {
							"{}.jsx",
						},
						type = "test",
					},
					["*.js"] = {
						alternate = {
							"{}.test.js",
						},
						type = "source",
					},
					["*.test.js"] = {
						alternate = {
							"{}.js",
						},
						type = "test",
					},
					-- Typescript
					["*.tsx"] = {
						alternate = {
							"{}.test.tsx",
						},
						type = "source",
					},
					["*.test.tsx"] = {
						alternate = {
							"{}.tsx",
						},
						type = "test",
					},
					["*.ts"] = {
						alternate = {
							"{}.test.ts",
						},
						type = "source",
					},
					["*.test.ts"] = {
						alternate = {
							"{}.ts",
						},
						type = "test",
					},
				},
			}
		end,
	},
	{
		"vim-test",
		after = function()
			local pickers = require("telescope.pickers")
			local sorters = require("telescope.sorters")
			local finders = require("telescope.finders")

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

			local function get_file_paths()
				local picker = pickers.new({
					finder = finders.new_oneshot_job({ "tmux-file-paths" }, {
						entry_maker = function(entry)
							local _, _, filename, lnum = string.find(entry, "(.+):(%d+)")

							return {
								value = entry,
								ordinal = entry,
								display = entry,
								filename = filename,
								lnum = tonumber(lnum),
								col = 0,
							}
						end,
					}),
					sorter = sorters.get_generic_fuzzy_sorter(),
					previewer = require("telescope.previewers").vim_buffer_vimgrep.new({}),
				})

				picker:find()
			end

			g.VimuxRunnerQuery = {
				window = "󰆣 ",
			}

			g.VimuxOrientation = "h"
			g.VimuxHeight = "30%"
			g.VimuxCloseOnExit = true

			g["test#preserve_screen"] = false
			g["test#strategy"] = {
				nearest = "vimux",
				file = "vimux",
				suite = "vimux",
			}
			g["test#neovim#term_position"] = "vert"
			g.dispatch_compilers = {
				elixir = "exunit",
				javascript = "vitest",
			}
			g["test#echo_command"] = 0
			g["test#filename_modifier"] = ":p"
			g["test#javascript#runner"] = "vitest"
			g["test#javascript#project_root"] = "assets"
			g["test#javascript#vitest#executable"] = "npm run --prefix assets env -- vitest"
			g["test#custom_strategies"] = {
				vimux_watch = function(args)
					vim.cmd("call VimuxInterruptRunner()")
					vim.cmd(string.format("call VimuxRunCommand('fd . | entr -c %s')", args))
				end,
			}

			map("n", "<leader>tt", "<CMD>TestFile -strategy=vimux_watch<CR>")
			map("n", "<leader>tn", "<CMD>TestNearest -strategy=vimux_watch<CR>")
			map("n", "<leader>t.", "<CMD>TestLast<CR>")
			map("n", "<leader>tv", "<CMD>TestVisit<CR>zz")
			map("n", "<leader>t<BS>", "<CMD>A<CR>")
			map("n", "<leader>tV", "<CMD>vsplit+A<CR>")
			map("n", "<leader>ts", "<CMD>TestSuite -strategy=vimux_watch<CR>")
			map("n", "<leader>tc", "<CMD>VimuxCloseRunner<CR>")
			map("n", "<leader>tf", get_file_paths)
			map({ "n", "v" }, "<C-c><C-c>", send_to_tmux)

			map("n", "<leader>ru", function()
				if vim.g.VimuxRunnerType == "window" then
					vim.g.VimuxRunnerType = "pane"
					vim.g.VimuxCloseOnExit = true
				else
					vim.g.VimuxRunnerType = "window"
				end
			end)
		end,
	},
}
