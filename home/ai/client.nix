{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    opencode
  ];

  programs.aichat = {
    enable = true;
    settings = {
      model = "ollama:Qwen3-Coder-30B-A3B";
      theme = "dark";
      clients = [
        {
          type = "openai-compatible";
          name = "ollama";
          api_base = "http://192.168.1.200:11434/v1";
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

  xdg.configFile."aichat/dark.tmTheme".source = inputs.nord-tmtheme + "/Nord.tmTheme";
  xdg.configFile."aichat/roles" = {
    source = ./roles;
    recursive = true;
  };

  xdg.configFile."opencode/opencode.json".source = ./opencode.json;
}
