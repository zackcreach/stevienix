{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaConfig = /* lua */ ''
      require("options")
      require("lz.n").load("plugins")
    '';
    plugins = with pkgs.vimPlugins; [
      lz-n

      # git
      gitsigns-nvim
      vim-fugitive
      vim-rhubarb
      git-messenger-vim

      # autocomplete	
      nvim-cmp
      blink-cmp
      windsurf-nvim
      cmp-nvim-lsp

      # ai
      codecompanion-nvim

      # database
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion

      # editing
      vim-surround
      vim-repeat
      emmet-vim
      conform-nvim
      nvim-lint
      nvim-treesitter
      nvim-treesitter-textobjects
      comment-nvim
      treesj

      # fuzzy
      telescope-nvim
      plenary-nvim
      nvim-web-devicons
      telescope-symbols-nvim

      # lsp
      vim-elixir
      nvim-lspconfig

      # snippets
      luasnip
      cmp_luasnip

      # testing
      vim-projectionist
      vim-test
      vim-dispatch
      vimux

      # ui
      gbprod-nord
      lualine-nvim
      nvim-colorizer-lua
      nvim-tree-lua
      vim-smoothie
      vim-tmux-navigator
    ];
  };

  xdg.configFile.nvim = {
    source = ./neovim;
    recursive = true;
  };
}
