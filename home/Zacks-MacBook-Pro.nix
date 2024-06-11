{ ... }: {
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./shell.nix
    ./cloud/gcloud.nix
    ./tmux
    ./kitty
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
