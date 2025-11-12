{ inputs, pkgs, config, ... }: {
  home.sessionVariables = {
    REF_API_KEY = "op read op://cli/ref/api_key";
    CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
  };

  programs.zsh.shellAliases = {
    c = "claude";
    cc = "claude --continue";
  };




  home.packages = with pkgs; [
    python3
    python3Packages.pipx
  ];

  home.sessionVariables = { };

  xdg.configFile."claude" = {
    source = ./config;
    recursive = true;
  };

  programs.git.ignores = [ ".claude" "CLAUDE.md" "!home/ai/config/CLAUDE.md" ".playwright-mcp" ];
  programs = {
    opencode = {
      enable = true;
      settings = {
        model = "zionlab/gpt-oss:120b";
        small_model = "zionlab/qwen3-coder:30b-a3b";
        permission = {
          "*" = "ask";
          edit = "ask";
          "git push" = "ask";
          "git status" = "allow";
          "git diff" = "allow";
          "npm run build" = "allow";
          ls = "allow";
          pwd = "allow";
        };
        theme = "nord";
        keybinds = {
          input_newline = "enter";
          input_submit = "ctrl+y";
        };
        provider = {
          zionlab = {
            npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "https://zaia.zionlab.online/v1";
              headers = {
                CF-Access-Client-Secret = "{env:CF_ACCESS_CLIENT_SECRET}";
                CF-Access-Client-Id = "{env:CF_ACCESS_CLIENT_ID}";
              };
            };
            models = {
              "qwen3-coder:30b-a3b" = {
                tools = true;
                reasoning = false;
                options = {
                  num_ctx = 16534;
                };
              };
              "gpt-oss:120b" = {
                tools = false;
                reasoning = false;
                options = {
                  num_ctx = 16534;
                };
              };
            };
          };
          anthropic = {
            npm = "@ai-sdk/anthropic";
            options = {
              apiKey = "$ANTHROPIC_API_KEY";
            };
            models = {
              "claude-sonnet-4-20250514" = {
                tools = true;
                reasoning = true;
                options = {
                  temperature = 0.7;
                };
              };
              "claude-3-5-haiku-latest" = {
                tools = true;
                reasoning = false;
                options = {
                  temperature = 0;
                };
              };
            };
          };
        };
      };
    };
    aichat = {
      enable = true;
      settings = {
        model = "ollama:Qwen3-Coder-30B-A3B";
        theme = "dark";
        clients = [
          {
            type = "openai-compatible";
            name = "ollama";
            api_base = "http://symphony:11434/v1";
            models = [
              { name = "Qwen3-Coder-30B-A3B"; }
              {
                name = "gemma3:27b";
                supports_function_calling = true;
                supports_vision = true;
              }
            ];
          }
        ];
      };
    };

  };

  xdg.configFile."aichat/dark.tmTheme".source = inputs.nord-tmtheme + "/Nord.tmTheme";
  xdg.configFile."aichat/roles" = {
    source = ./roles;
    recursive = true;
  };
}
