{ pkgs, ... }:
{
  imports = [
    ./ai/client.nix
    ./credentials
    ./editor
    ./ghostty
    ./git
    ./kitty
    ./lang/elixir.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./shell
    ./tmux
    ./work
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    yubikey-manager
  ];

  home.sessionVariables = {
    GPG_TTY = "$(tty)";
    SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry_mac;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    sshKeys = [
      "EE40AB918DA8A265B8DC51B8CC6B29F7887FBC4F"
    ];
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

  programs.home-manager.enable = true;

  programs.zsh.shellAliases = {
    stevie = "sudo darwin-rebuild switch --flake ~/.config/nixos && nix-collect-garbage --delete-older-than 7d";
  };

  xdg.enable = true;
}
