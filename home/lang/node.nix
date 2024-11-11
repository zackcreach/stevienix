{ pkgs, ... }: {
  home.sessionVariables = {
    PRETTIERD_DEFAULT_CONFIG = "$HOME/prettier.config.js";
  };

  home.packages = with pkgs; [
    nodePackages_latest.typescript-language-server
    nodejs_22
    prettierd
    eslint_d
    tailwindcss-language-server
    yarn
  ];

  home.file = {
    "prettier.config.js".text = ''
      module.exports = {
        arrowParens: 'always',
        printWidth: 80,
        semi: false,
        singleQuote: true,
        tabWidth: 2,
        trailingComma: 'es5',
        importOrder: [
          '<THIRD_PARTY_MODULES>',
          '^(pages|components|utils)/(.*)$',
          '^[./]',
        ],
        importOrderSeparation: true,
        importOrderSortSpecifiers: true,
      }
    '';
  };

  programs.zsh.shellAliases = {
    D = "echo -e '\n// Removing deps/';rm -rf deps/";
  };
}
