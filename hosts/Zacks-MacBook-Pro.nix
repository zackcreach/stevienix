{
  self,
  pkgs,
  ...
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

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users.zack.home = "/Users/zack";

  security.pam.enableSudoTouchIdAuth = true;

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

  nix.gc = {
    automatic = true;
    interval = {
      # 0 indexed from Sunday, 3 is Wednesday
      Weekday = 3;
      Hour = 11;
    };
    options = "--delete-older-than 1w";
  };
}
