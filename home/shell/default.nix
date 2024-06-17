{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    entr
  ];

  # relocate to scoped modules
  home.sessionVariables = {
    ERL_AFLAGS = "-kernel shell_history enabled";
    MANPAGER = "nvim +Man!";
    PRETTIERD_DEFAULT_CONFIG = "$HOME/dev/ozone/prettier.config.js";
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "nord";
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
    shellAliases = {
      vi = "nvim";
      I = "echo -e '\n// IEX Phoenix Server';iex -S mix phx.server";
      D = "echo -e '\n// Removing deps/';rm -rf deps/";
      grep = "history | grep --color=auto";
      cat = "bat --paging=never";
      stevie = "darwin-rebuild switch --flake ~/.config/nix-darwin";
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      expireDuplicatesFirst = true;
      ignoreDups = true;
      extended = true;
      ignoreSpace = true;
    };
    initExtra = ''
      if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
      else
      export EDITOR='nvim'
      fi

      autoload -Uz edit-command-line

      zle -N edit-command-line

      bindkey -M viins '^f' edit-command-line

      bindkey -M vicmd '^i' edit-command-line

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      function zvm_after_init() {
      	 zvm_bindkey viins '^R' fzf-history-widget
      	 bindkey -M viins '^f' edit-command-line
       }
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden -g !.git";
    defaultOptions = [ "--reverse" "--ansi" "--color=bg+:-1,fg:15,fg+:-1,prompt:6,header:5,pointer:2,hl:3,hl+:3,spinner:05,info:15,border:15" ];
  };

  programs.bat.enable = true;

  programs.fd.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 10000;

      format = "$directory $git_branch $git_status $line_break $line_break $character ";

      hostname = {
        ssh_symbol = "󰐻 ";
        style = "bold yellow";
      };

      git_branch = {
        symbol = "󰊢 ";
        style = "purple";
        format = "on [$symbol$branch]($style) ";
      };

      directory = {
        style = "blue";
        format = "[$path]($style) ";
      };

      character = {
        success_symbol = "[󰱫 ](green)";
        error_symbol = "[󰱶 ](yellow)";
        vicmd_symbol = "[󰱱 ](blue)";
      };
    };
  };
}
# TODO
# source $ZSH/plugins/elixir/elixir.plugin.zsh
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/zack/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/zack/google-cloud-sdk/completion.zsh.inc'; fi
# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/zack/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/zack/google-cloud-sdk/path.zsh.inc'; fi
# eval "$(/opt/homebrew/bin/brew shellenv)"
