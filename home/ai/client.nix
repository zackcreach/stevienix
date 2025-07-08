{ ... }: {
  programs.aichat = {
    enable = true;
    settings = {
      model = "ollama:gemma3:27b";
      clients = [
        {
          type = "openai-compatible";
          name = "ollama";
          api_base = "http://192.168.1.200:11434/v1";
          models = [
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
}
