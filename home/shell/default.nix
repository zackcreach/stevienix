{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    entr
    yubikey-manager
    (pkgs.callPackage ./live-grep.nix { })
  ];

  # relocate to scoped modules
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--colors=match:bg:blue"
      "--colors=match:fg:black"
    ];
  };

  # keep creachignore ignored in gitignore but un-ignored in rgignore
  # be careful on indendation here, it can nullify lines
  home.file.".rgignore".text = ''
    !creachignore
    !.env
    !.envrc
    !.direnv
  '';

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "nord";
    };
  };

  programs.zsh = {
    enable = true;
    cdpath = [ "." "$HOME" "$HOME/dev" ];
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    dotDir = "${config.xdg.configHome}/zsh";
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
    dirHashes = {
      co = "$HOME/.config";
      d = "$HOME/dev";
      st = "$HOME/.local/state";
      sh = "$HOME/.local/share";
      ca = "$HOME/.cache";
      ni = "/nix/store";
    };
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      grep = "grep --color=auto";
      cat = "bat --paging=never";
      lg = "live-grep";
      s = "stevie";
      srv = "stevie && nvim";
      reload = "source ${config.xdg.configHome}/zsh/.zshrc";
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      expireDuplicatesFirst = true;
      ignoreDups = true;
      extended = true;
      ignoreSpace = true;
    };
    initContent = ''
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

      			 function w() {
      					fd $1 | entr -c "''${@:2}"
      			}
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f --hidden";
    fileWidgetOptions = [
      "--preview '${pkgs.bat}/bin/bat --color=always {}'"
      "--pointer ' '"
    ];
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    changeDirWidgetOptions = [
      "--preview '${pkgs.eza}/bin/eza --tree --icons --color=always --level 3 --git-ignore {}'"
      "--pointer ' '"
    ];
    historyWidgetOptions = [ "--pointer ' '" ];
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
        format = "on [$symbol$branch]($style)";
      };

      directory = {
        style = "blue";
        format = "[$path]($style)";
      };

      character = {
        success_symbol = "[󰱫](green)";
        error_symbol = "[󰱶](yellow)";
        vicmd_symbol = "[󰱱](blue)";
      };
    };
  };
}
