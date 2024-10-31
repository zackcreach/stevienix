{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars

    ];
  };

  xdg.configFile.nvim = {
    source = ./neovim;
    recursive = true;
  };
}
