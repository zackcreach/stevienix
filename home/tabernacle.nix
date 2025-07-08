{ ... }: {
  imports = [
    ./ai/client.nix
    ./editor
    ./git
    ./lang/elixir.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/node.nix
    ./shell
    ./tmux
  ];

  home = {
    stateVersion = "24.05";
    username = "zack";
    homeDirectory = "/home/zack";
  };

  programs.home-manager.enable = true;
  programs.zsh.shellAliases = {
    stevie = "sudo nixos-rebuild switch";
  };
}
