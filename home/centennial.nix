{ pkgs, ... }:
{
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./lang/lua.nix
    # ./aerospace
    ./shell
    ./cloud/gcloud.nix
    ./tmux
    ./kitty
    ./ghostty
    ./work
    ./ai
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    yubikey-manager
    hidden-bar
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
    stevie = "sudo darwin-rebuild switch --flake ~/.config/nixos";
    srv = "stevie && nvim";
  };
}
