-- show line numbers
vim.opt.number = true
-- use 24-bit RGB colors (your terminal must support this to work - most modern ones do)
vim.opt.termguicolors = true
-- how many spaces should a tab be
vim.opt.tabstop = 2

-- The "Leader key" is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command.
-- The default leader key is backslash. Therefore, if you have a map of <Leader>Q, you can perform that action by typing \Q.
-- see `:help <leader>`
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.opt.regexpengine = 1
vim.opt.clipboard = "unnamed"
vim.opt.errorbells = false
vim.opt.sw = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.nu = true
vim.opt.re = 0
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.loop.os_homedir() .. "/.cache/editor/neovim/lua/options.lua"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.fillchars = "eob: "

if vim.fn.executable("rg") then
	vim.o.grepprg = "rg --vimgrep --hidden -g !.git"
end

-- Suppress plenary messages
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
	if type(msg) == "string" and msg:match("Error executing callback") then
		return
	end
	original_notify(msg, level, opts)
end
