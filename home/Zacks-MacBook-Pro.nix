{ ... }: {
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./lang/lua.nix
    ./shell
    ./cloud/gcloud.nix
    ./tmux
    ./kitty
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  programs.zsh.shellAliases.stevie = "darwin-rebuild switch --flake ~/.config/nix-darwin";
}
