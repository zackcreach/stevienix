{ pkgs, ... }: {
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./lang/lua.nix
    ./shell
    ./tmux
    ./kitty
    ./hyprland
    ./security
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    webcord
    nautilus
  ];

  home.sessionVariables = {
    "BROWSER" = "firefox";
  };

  programs.home-manager.enable = true;

  programs.zsh.shellAliases = {
    "gpg-refresh" = "gpg-connect-agent 'scd serialno' 'learn --force' /bye";
    stevie = "sudo nixos-rebuild switch";
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
    pinentryPackage = pkgs.pinentry-gnome3;
    enableScDaemon = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    sshKeys = [ "EE40AB918DA8A265B8DC51B8CC6B29F7887FBC4F" ];
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
