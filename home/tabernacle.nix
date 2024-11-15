{ ... }: {
  imports = [
    ./git
    ./editor
    ./lang/elixir.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./lang/lua.nix
    ./shell
    ./tmux
  ];

  home = {
    stateVersion = "24.05";
    username = "zack";
    homeDirectory = "/home/zack";
  };

  programs.home-manager.enable = true;
  programs.zsh.shellAliases.stevie = "sudo nixos-rebuild switch";
}
