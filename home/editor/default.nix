{...}:
{
	programs.neovim = {
		enable = true;
	};

	xdg.configFile.nvim = {
		source = ./neovim;
		recursive = true;
	};
}
