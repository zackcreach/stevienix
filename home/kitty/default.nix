{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    keybindings = {
      "cmd+r" = "send_text all rally\r";
      "cmd+k" = "send_text terminal,application \x63\x6C\x65\x61\x72\x0A";
      "cmd+t" = "no_op";
      "cmd+a" = "no_op";
      "cmd+s" = "no_op";
      "cmd+w" = "no_op";
      "cmd+b" = "no_op";
      "cmd+/" = "no_op";
    };

    settings = {
      macos_titlebar_color = "background";
      macos_show_window_title_in = "none";
      confirm_os_window_close = "0";
      sync_to_monitor = "no";
    };

    font = {
      name = "Liga Roboto Mono";
      size = 16.0;
      # TODO: this sucks can we just commit the fonts we need to a fonts folder inside nix?
      package =
        pkgs.fetchFromGitHub
        {
          repo = "fonts";
          owner = "guoguojin";
          rev = "0826cad84e4a703a28add59d32c4600d68f1b426";
          sha256 = "sha256-gP5NQx01KhISU8RYdzn1qAkIfMsY9H5Wxj7KWmBtV1I=";
        };
    };

    shellIntegration.enableZshIntegration = true;

    extraConfig = ''
      italic_font Roboto Mono Italic

      # Seti
      symbol_map U+E5FA-U+E631 RobotoMono Nerd Font
      # Devicons
      symbol_map U+E700-U+E7C5 RobotoMono Nerd Font
      # Font Awesome
      symbol_map U+F000-U+F2E0 RobotoMono Nerd Font
      # Font Awesome Extension
      symbol_map U+E200-U+E2A9 RobotoMono Nerd Font
      # Material Design
      symbol_map U+F500-U+FD46 RobotoMono Nerd Font
      # Weather
      symbol_map U+E300-U+E3EB RobotoMono Nerd Font
      # Octicons
      symbol_map U+F400-U+F4A9,U+2665-U+26A1 RobotoMono Nerd Font
      # Powerline
      symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 RobotoMono Nerd Font
      # Powerline Extras
      symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D4 RobotoMono Nerd Font
      # IEC Power
      symbol_map U+23FB-U+23FE,U+2B58 RobotoMono Nerd Font
      # Font Logos
      symbol_map U+F300-U+F32D RobotoMono Nerd Font
      # Pomicons
      symbol_map U+E000-U+E00A RobotoMono Nerd Font
      # Codeicons
      symbol_map U+EA60-U+EBEB RobotoMono Nerd Font

      include ./themes/nord.conf
    '';
  };

  xdg.configFile."kitty/themes/nord.conf".text = ''
    # Nord Colorscheme for Kitty
    # Based on:
    # - https://gist.github.com/marcusramberg/64010234c95a93d953e8c79fdaf94192
    # - https://github.com/arcticicestudio/nord-hyper

    foreground            #D8DEE9
    background            #2E3440
    selection_foreground  #000000
    selection_background  #FFFACD
    url_color             #0087BD
    cursor                #81A1C1

    # black
    color0   #3B4252
    color8   #4C566A

    # red
    color1   #BF616A
    color9   #BF616A

    # green
    color2   #A3BE8C
    color10  #A3BE8C

    # yellow
    color3   #EBCB8B
    color11  #EBCB8B

    # blue
    color4  #81A1C1
    color12 #81A1C1

    # magenta
    color5   #B48EAD
    color13  #B48EAD

    # cyan
    color6   #88C0D0
    color14  #8FBCBB

    # white
    color7   #E5E9F0
    color15  #ECEFF4
  '';
}
