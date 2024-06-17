{ self
, pkgs
, ...
}: {
  # List packages installed in system profile. To search by name, run:
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystems = true;
    };

    hostPlatform = "aarch64-darwin";
  };

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      dock.autohide = true;
      trackpad.Clicking = true;
      trackpad.TrackpadThreeFingerDrag = false;
      finder.ShowPathbar = true;
      finder.ShowStatusBar = true;
      loginwindow.GuestEnabled = false;
      loginwindow.autoLoginUser = "zack";
    };
  };

  users.users.zack.home = "/Users/zack";

  # https://write.rog.gr/writing/using-touchid-with-tmux/#creating-a-etcpamdsudo_local-file-using-nix-darwin
  # https://github.com/LnL7/nix-darwin/pull/787
  # security.pam.enableSudoTouchIdAuth = true;
  environment.etc."pam.d/sudo_local".text = ''
    # Managed by Nix Darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    auth       sufficient     pam_tid.so
  '';

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.stdenvNoCC.mkDerivation {
        pname = "roboto-mono-lig";
        version = "0826cad";

        src = pkgs.fetchFromGitHub {
          repo = "fonts";
          owner = "guoguojin";
          rev = "0826cad84e4a703a28add59d32c4600d68f1b426";
          sha256 = "sha256-gP5NQx01KhISU8RYdzn1qAkIfMsY9H5Wxj7KWmBtV1I=";
        };

        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp LigaRobotoMono-*.ttf $out/share/fonts/truetype
        '';
      })
    ];
  };

  # garbage collection
  nix.gc = {
    automatic = true;
    interval = {
      # 0 indexed from Sunday, 3 is Wednesday
      Weekday = 3;
      Hour = 11;
    };
    options = "--delete-older-than 1w";
  };

  environment.systemPackages = with pkgs; [ comma ];
}
