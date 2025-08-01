{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaConfig = /* lua */ ''
      vim.notify = function(msg, level, opts)
      -- Suppress plenary messages
      	if msg:match("ENOENT: no such file or directory: /tmp/plenary_curl") then
      		return
      	end
      	vim.api.nvim_echo({{msg}}, true, {})
      end

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
      fidget-nvim
      render-markdown-nvim

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
      comment-nvim
      treesj
      (nvim-treesitter.withPlugins (plugins: nvim-treesitter.allGrammars))
      nvim-treesitter-textobjects
      nvim-treesitter-endwise
      playground

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
      aerial-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./neovim;
    recursive = true;
  };
}
