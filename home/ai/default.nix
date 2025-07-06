{ pkgs, ... }: {
  programs.aichat = {
    enable = true;
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
