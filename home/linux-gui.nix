{ pkgs, ... }:

{
  home.packages = [
    pkgs.gnome.nautilus
  ];

  home.sessionVariables = {
    "BROWSER" = "firefox";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
  };
}
