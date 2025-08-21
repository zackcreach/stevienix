{ self
, pkgs
, ...
}: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  networking.hostName = "promenade";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystems = true;
      allowBroken = true;
    };

    hostPlatform = "aarch64-darwin";
  };

  system = {
    primaryUser = "zack";

    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
    activationScripts.activeSettings.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      dock.autohide = true;
      trackpad.Clicking = true;
      trackpad.TrackpadThreeFingerDrag = true;
      trackpad.Dragging = true;
      finder.ShowPathbar = true;
      finder.ShowStatusBar = true;
      loginwindow.GuestEnabled = false;
      loginwindow.autoLoginUser = "zack";
    };
  };

  users.users.zack = {
    shell = pkgs.zsh;
    home = "/Users/zack";
    openssh.authorizedKeys.keys = [
      # ssh-add -L
      # we might need services.ssh.enable = true;
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0PMZX36AvlE6+w7TWF0Nvg4QBl6rV+xuaffQDR6Mcs cardno:26_329_662"
    ];
  };

  # https://write.rog.gr/writing/using-touchid-with-tmux/#creating-a-etcpamdsudo_local-file-using-nix-darwin
  # https://github.com/LnL7/nix-darwin/pull/787
  # security.pam.enableSudoTouchIdAuth = true;
  environment.etc."pam.d/sudo_local".text = ''
    # Managed by Nix Darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    auth       sufficient     pam_tid.so
  '';

  programs.gnupg = {
    agent.enable = true;
    agent.enableSSHSupport = true;
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
