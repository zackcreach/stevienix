{ pkgs, ... }:
{
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "$HOME/.npm-packages";
    # BIOME_CONFIG_PATH = "$HOME/biome.json";
  };

  home.sessionPath = [
    "$HOME/.npm-packages/bin"
  ];

  home.packages = with pkgs; [
    nodePackages_latest.typescript-language-server
    nodejs_22
    eslint_d
    tailwindcss-language-server
    yarn
    biome
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
    "biome.json".text = ''
      {
      	"$schema": "https://biomejs.dev/schemas/2.0.0/schema.json",
      	"vcs": {
      		"enabled": false,
      		"clientKind": "git",
      		"useIgnoreFile": false
      	},
      	"formatter": {
      		"enabled": true,
      		"indentStyle": "space"
      	},
      	"assist": { "actions": { "source": { "organizeImports": "on" } } },
      	"javascript": {
      		"formatter": {
      			"quoteStyle": "single",
      			"semicolons": "asNeeded",
      			"indentStyle": "space",
      			"trailingCommas": "es5"
      		}
      	},
      	"json": {
      		"formatter": {
      			"indentStyle": "space"
      		}
      	}
      }
    '';
  };
}
