local keymap = vim.keymap

keymap.set("n", "<localleader>e", "<CMD>DBUIToggle<CR>", { buffer = true })
keymap.set("n", "<CR>", "<PLUG>(DBUI_JumpToForeignKey)", { buffer = true })
