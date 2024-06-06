{ pkgs, config, lib, ... }: {
  home.packages = [
    pkgs.smug
	(import ./rally.nix { inherit pkgs; })
  ];

	programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key '='
          set -g @thumbs-reverse enabled
          set -g @thumbs-hint-bg-color yellow
          set -g @thumbs-hint-fg-color black
          set -g @thumbs-contrast 1
        '';
      }
      tmux-fzf
nord
      {
        plugin = fuzzback;
        extraConfig = ''
          set -g @fuzzback-bind /
          set -g @fuzzback-popup 1
          set -g @fuzzback-popup-size '90%'
          set -g @fuzzback-fzf-colors '${lib.strings.concatStringsSep "," (lib.attrsets.mapAttrsToList (name: value: name + ":" + value) config.programs.fzf.colors)}'
        '';
      }
    ];

    terminal = "tmux-256color";

		prefix = "C-a";

    extraConfig = ''
		set -g allow-rename off
		set -as terminal-features ',xterm*:RGB'
		set -s escape-time 1
		set -gw mouse on
		set -g base-index 1
		set -g pane-base-index 1
		set -g renumber-windows on
		set -g allow-rename off
		set -g set-clipboard external

		bind ! kill-server
		bind | split-window -h
		bind - split-window -v
		bind > display-popup -E -w 50% -h 50%
		bind BSpace switch-client -l
		bind s display-popup -E -w 80% -h 70% rally
		bind S display-popup -E 'tmux switch-client -t "$(tmux list-sessions -F "#{session_name}"| fzf)"'
		bind Escape copy-mode
		bind-key p paste-buffer
		bind-key -T copy-mode-vi v send-keys -X begin-selection
		bind-key -T copy-mode-vi V send-keys -X select-line
		bind-key -T copy-mode-vi y send-keys -X copy-selection
		bind-key -T copy-mode-vi C-y send-keys -X rectangle-toggle
		bind-key -T copy-mode-vi Escape send-keys -X cancel
		bind -n S-Left previous-window
		bind S-Tab previous-window
		bind -n S-Right next-window
		bind S-Tab next-window
    '';
  };

	  xdg.configFile.smug = {
    source = ./smug;
    recursive = true;
  };
	}
