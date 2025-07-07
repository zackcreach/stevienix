{ pkgsStable, ... }: {
  home.packages = with pkgsStable; [
    open-webui
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
