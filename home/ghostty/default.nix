{ pkgs, ... }: {
  # manually added in flake.nix for now
  # home.packages = with pkgs; [
  #   ghostty
  # ];

  xdg.configFile."ghostty/config".text = ''
    theme = nord
    font-family = JetBrains Mono Light
    font-family-italic = Rec Mono Semicasual Italic
    font-family-bold = JetBrains Mono Bold
    font-family-bold-italic = JetBrains Mono Bold Italic
    font-size = 15
  '';
}
