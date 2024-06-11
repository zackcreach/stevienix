{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs_22
    nodePackages_latest.typescript-language-server
  ];
}
