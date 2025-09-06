{ inputs, ... }: {
  programs = {
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
    claude-code = {
      enable = true;
      mcpServers = {
        # customTransport = {
        #   customOption = "value";
        #   timeout = 5000;
        #   type = "websocket";
        #   url = "wss://example.com/mcp";
        # };
        # database = {
        #   args = [
        #     "-y"
        #     "@bytebase/dbhub"
        #     "--dsn"
        #     "postgresql://user:pass@localhost:5432/db"
        #   ];
        #   command = "npx";
        #   env = {
        #     DATABASE_URL = "postgresql://user:pass@localhost:5432/db";
        #   };
        #   type = "stdio";
        # };
        # filesystem = {
        #   args = [
        #     "-y"
        #     "@modelcontextprotocol/server-filesystem"
        #     "/tmp"
        #   ];
        #   command = "npx";
        #   type = "stdio";
        # };
        # github = {
        #   type = "http";
        #   url = "https://api.githubcopilot.com/mcp/";
        # };
      };
      settings = {
        # hooks = {
        #   PostToolUse = [
        #     {
        #       hooks = [
        #         {
        #           command = "nix fmt $(jq -r '.tool_input.file_path' <<< '$CLAUDE_TOOL_INPUT')";
        #           type = "command";
        #         }
        #       ];
        #       matcher = "Edit|MultiEdit|Write";
        #     }
        #   ];
        #   PreToolUse = [
        #     {
        #       hooks = [
        #         {
        #           command = "echo 'Running command: $CLAUDE_TOOL_INPUT'";
        #           type = "command";
        #         }
        #       ];
        #       matcher = "Bash";
        #     }
        #   ];
        # };
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
          defaultMode = "acceptEdits";
          deny = [
            "WebFetch"
            "Bash(curl:*)"
            "Read(./.env)"
            "Read(./secrets/**)"
          ];
          disableBypassPermissionsMode = "disable";
        };
        statusLine = {
          command = "input=$(cat); echo \"[$(echo \"$input\" | jq -r '.model.display_name')] 📁 $(basename \"$(echo \"$input\" | jq -r '.workspace.current_dir')\")\"";
          padding = 0;
          type = "command";
        };
        theme = "dark";
      };
    };
    opencode = {
      enable = true;
      settings = {
        model = "ollama/Qwen3-Coder-30B-A3B";
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
            };
          };
        };
      };
    };
  };

  xdg.configFile."aichat/dark.tmTheme".source = inputs.nord-tmtheme + "/Nord.tmTheme";
  xdg.configFile."aichat/roles" = {
    source = ./roles;
    recursive = true;
  };
}
