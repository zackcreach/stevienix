{ pkgs, ... }: {
  imports = [
    ../../imports/git
    ../../imports/editor
    ../../imports/lang/elixir.nix
    ../../imports/lang/nix.nix
    ../../imports/lang/node.nix
    ../../imports/lang/lua.nix
    ../../imports/shell
    ../../imports/cloud/gcloud.nix
    ../../imports/tmux
    ../../imports/kitty
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  programs.zsh.shellAliases.stevie = "darwin-rebuild switch --flake ~/.config/nixos";

  home.packages = with pkgs; [
    yubikey-manager
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

  home.username = "zack";

  # programs.zsh.initExtra = ''
  #   export GPG_TTY="$(tty)"
  #   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  # '';

  # TODO: until home manager supports gpg on MacOS, keep this commented out
  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-gnome3;
  #   enableScDaemon = true;
  #   enableSshSupport = true;
  #   defaultCacheTtl = 60;
  #   maxCacheTtl = 120;
  #   sshKeys = [ "EE40AB918DA8A265B8DC51B8CC6B29F7887FBC4F" ];
  # };
}
