{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    nodejs_22
    nodePackages_latest.typescript-language-server
    prettierd
    tailwindcss-language-server
  ];
}
