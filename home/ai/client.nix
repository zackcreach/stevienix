{ inputs, pkgs, ... }: {
  home.sessionVariables = {
    ANTHROPIC_API_KEY = "op read op://Shared/claude-dwc/api_key";
    SEMGREP_APP_TOKEN = "op read op://Shared/Semgrep/semgrep_app_token";
    FIGMA_ACCESS_TOKEN = "op read op://Shared/Figma/figma_access_token";
    REF_API_KEY = "op read op://Shared/Ref/ref_api_key";
  };

  home.packages = with pkgs; [
    python3
    python3Packages.pipx
  ];

  home.file.".claude/CLAUDE.md".source = ./config/claude.md;

  programs = {
    claude-code = {
      enable = true;
      settings = {
        includeCoAuthoredBy = false;
        permissions = {
          additionalDirectories = [
            "creachignore/"
          ];
          allow = [
            "WebSearch"
            "Bash(git diff:*)"
            "Bash(git status:*)"
            "Bash(mix test:*)"
            "Edit"
            "Read"
            "Update"
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
      mcpServers = {
        ref = {
          command = "npx";
          args = [ "ref-tools-mcp@latest" ];
          env = {
            REF_API_KEY = "$REF_API_KEY";
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
