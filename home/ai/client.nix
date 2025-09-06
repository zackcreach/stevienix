{ inputs, ... }: {
  home.sessionVariables = {
    ANTHROPIC_API_KEY = "op read op://Shared/claude-dwc/api_key";
  };

  programs = {
    claude-code = {
      enable = true;
      settings = {
        includeCoAuthoredBy = false;
        permissions = {
          additionalDirectories = [
            "./creachignore/"
          ];
          allow = [
            "Bash(git diff:*)"
            "Edit"
          ];
          ask = [
            "Bash(git push:*)"
          ];
          defaultMode = "plan";
          deny = [
            "WebFetch"
            "Bash(curl:*)"
            "Read(./.env)"
            "Read(./secrets/**)"
          ];
          disableBypassPermissionsMode = "disable";
        };
        statusLine = {
          command = "input=$(cat); current_dir=\"$(echo \"$input\" | jq -r '.workspace.current_dir')\"; dir_name=\"$(basename \"$current_dir\")\"; model=\"$(echo \"$input\" | jq -r '.model.display_name')\"; if command -v git >/dev/null 2>&1 && git -C \"$current_dir\" rev-parse --is-inside-work-tree >/dev/null 2>&1; then branch=$(git -C \"$current_dir\" --no-optional-locks branch --show-current 2>/dev/null); git_info=\" on 󰊢 $branch\"; else git_info=\"\"; fi; printf \"%s%s [%s]\" \"$dir_name\" \"$git_info\" \"$model\"";
          padding = 0;
          type = "command";
        };
        theme = "dark";
        vim = true;
      };
    };
    opencode = {
      enable = true;
      settings = {
        model = "ollama/Qwen3-Coder-30B-A3B";
        small_model = "ollama/gemma3:27b";
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
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "http://symphony:11434/v1";
            };
            models = {
              "Qwen3-Coder-30B-A3B" = {
                tools = true;
                reasoning = false;
                options = {
                  num_ctx = 16534;
                };
              };
              "gemma3:27b" = {
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
