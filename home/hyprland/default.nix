{ pkgs, ... }:

{
  imports = [
    # status bar
    ./waybar.nix
    # notifications
    ./dunst.nix
  ];

  programs.wofi.enable = true;

  home.packages = [
    pkgs.swaybg
    pkgs.grim
    pkgs.grimblast
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.waypaper
  ];

  services.cliphist.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;

    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 3;
        # "col.active_border" = "rgb(F48FB1) rgb(78A8FF) 45deg";
        "col.active_border" = "rgb(8FBCBB) rgb(B48EAD) 45deg";
        "col.inactive_border" = "rgba(2E3440aa)";
        layout = "master";
        resize_on_border = true;
      };

      monitor = [
        "DP-1, 2560x1440@144, 0x0, 1, vrr, 1"
      ];

      # window rules to force windows in certain areas
      # run hyprctl clients to see stats
      windowrulev2 = [
        "workspace 2, class:firefox"
        "workspace 3, class:webcord"
      ];

      # only execute these on startup
      exec-once = [
        "swaybg -i ~/wallpaper -m fill"
        "waybar"
        "kitty rally"
        "nm-applet"
        "[workspace 2 silent] firefox"
        "hyprctl setcursor Bibata-Modern-Ice 22"
        "[workspace 3 silent] webcord"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        orientation = "left";
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
        # TODO: find replacements for these config errors
        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "overshot,0.05,0.9,0.1,1.1"
          "overshot,0.13,0.99,0.29,1."
        ];
        animation = [
          "windows,1,7,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,7,overshot,slidevert"
        ];
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, q, killactive,"
        "$mainMod SHIFT, q, exit,"

        "$mainMod, f, fullscreen, 0"
        "$mainMod, m, fullscreen, 1"

        "ALT, Return, exec, kitty"

        "ALT, d, exec, wofi --show drun -I"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod CTRL, h, swapwindow, l"
        "$mainMod CTRL, l, swapwindow, r"
        "$mainMod CTRL, k, swapwindow, u"
        "$mainMod CTRL, j, swapwindow, d"
        "$mainMod ALT, h, moveintogroup, l"
        "$mainMod ALT, l, moveintogroup, r"
        "$mainMod ALT, k, moveintogroup, u"
        "$mainMod ALT, j, moveintogroup, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod ALT, 1, movetoworkspace, 1"
        "$mainMod ALT, 2, movetoworkspace, 2"
        "$mainMod ALT, 3, movetoworkspace, 3"
        "$mainMod ALT, 4, movetoworkspace, 4"
        "$mainMod ALT, 5, movetoworkspace, 5"
        "$mainMod ALT, 6, movetoworkspace, 6"
        "$mainMod ALT, 7, movetoworkspace, 7"
        "$mainMod ALT, 8, movetoworkspace, 8"
        "$mainMod ALT, 9, movetoworkspace, 9"
        "$mainMod ALT, 0, movetoworkspace, 10"

        "$mainMod SHIFT, v, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # end settings
    };
  };
}
