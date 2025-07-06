{ pkgs, ... }: {
  imports = [
    ./ai/server.nix
    ./credentials
    ./editor
    ./git
    ./hyprland
    ./kitty
    ./lang/elixir.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./shell
    ./tmux
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    webcord
    nautilus
    vivaldi
  ];

  home.sessionVariables = {
    "BROWSER" = "vivaldi";
  };

  programs.home-manager.enable = true;

  programs.zsh.shellAliases = {
    "gpg-refresh" = "gpg-connect-agent 'scd serialno' 'learn --force' /bye";
    stevie = "sudo nixos-rebuild switch";
    srv = "stevie && nvim";
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../pub.key;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableScDaemon = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    sshKeys = [ "EE40AB918DA8A265B8DC51B8CC6B29F7887FBC4F" ];
  };

  services.open-webui = {
    enable = true;
    # open-webui.openFirewall = true;
    # open-webui.host = "0.0.0.0";
    # open-webui.environment = {
    #   WEBUI_AUTH = "False";
    #   ANONYMIZED_TELEMETRY = "False";
    #   DO_NOT_TRACK = "True";
    #   SCARF_NO_ANALYTICS = "True";
    # };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-gtk";
  };

}
