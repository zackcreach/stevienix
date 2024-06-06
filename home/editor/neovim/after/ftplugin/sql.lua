local keymap = vim.keymap

keymap.set("n", "<localleader>e", "<CMD>DBUIToggle<CR>", { buffer = true })
-- visually select the area under the cursor and run the query
keymap.set("n", "<C-c><C-c>", ":normal vip<CR><PLUG>(DBUI_ExecuteQuery)", { buffer = true })
keymap.set("n", "<localleader>F", ":%!sql-formatter-cli .<CR>", { buffer = true })
keymap.set("n", "<localleader>f", ":normal vip<CR>:!sql-formatter-cli<CR>", { buffer = true })
keymap.set("n", "<leader>w", "<PLUG>(DBUI_SaveQuery)", { buffer = true })
