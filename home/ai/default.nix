{ pkgs, ... }: {
  home.packages = with pkgs; [
    open-webui
  ];

  programs.aichat = {
    enable = true;
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
