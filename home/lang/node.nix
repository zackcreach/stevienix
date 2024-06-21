{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    yarn
    nodejs_22
    nodePackages_latest.typescript-language-server
    tailwindcss-language-server
    prettierd
  ];
}
