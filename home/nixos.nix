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
    ./linux-gui.nix
    ./hyprland
    ./passwords.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  programs.zsh.shellAliases.stevie = "sudo nixos-rebuild switch";

  home.packages = with pkgs; [
    webcord
  ];

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
}
