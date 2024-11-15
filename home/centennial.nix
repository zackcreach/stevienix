{ pkgs, ... }: {
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./lang/lua.nix
    ./aerospace
    ./shell
    ./cloud/gcloud.nix
    ./tmux
    ./kitty
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    yubikey-manager
    hidden-bar
  ];

  # TODO: until home manager supports gpg on MacOS, manually manage agent
  # https://github.com/nix-community/home-manager/pull/5786
  home.file.".gnupg/gpg-agent.conf".text = ''
    ttyname $GPG_TTY
    default-cache-ttl 60
    max-cache-ttl 120
    pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
  '';

  home.file.".gnupg/sshcontrol".text = ''
    EE40AB918DA8A265B8DC51B8CC6B29F7887FBC4F
  '';

  programs.home-manager.enable = true;

  programs.zsh.shellAliases.stevie = "darwin-rebuild switch --flake ~/.config/nixos";

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../pub.key;
        trust = 5;
      }
    ];
  };
}
