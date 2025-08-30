{ pkgsStable, ... }: {
  home.packages = with pkgsStable; [
    open-webui
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
    openFirewall = true;
  };
}
