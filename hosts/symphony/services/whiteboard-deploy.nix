{ config, pkgs, ... }:

{
  systemd.services.whiteboard-deploy = {
    description = "Whiteboard Auto-Deploy";
    after = [ "network.target" ];

    path = with pkgs; [
      git
      openssh
      elixir
      erlang
      nodejs
      tailwindcss_4
      esbuild
      rsync
      coreutils
      gnugrep
      gawk
      gnumake
      gcc
      pkg-config
    ];

    environment = {
      HOME = "/home/zack";
      MIX_HOME = "/home/zack/.mix";
      HEX_HOME = "/home/zack/.hex";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      GIT_TERMINAL_PROMPT = "0";
    };

    serviceConfig = {
      Type = "oneshot";
      User = "zack";
      Group = "users";
      WorkingDirectory = "/home/zack/dev/whiteboard";

      # Load environment variables (DATABASE_URL, SECRET_KEY_BASE) for migrations
      EnvironmentFile = "/etc/whiteboard/env";

      # Run the mix deploy task
      ExecStart = "${pkgs.elixir}/bin/mix deploy";

      # Don't restart on failure (timer will retry)
      Restart = "no";

      # Give it time to complete
      TimeoutStartSec = "10min";
    };
  };

  systemd.timers.whiteboard-deploy = {
    description = "Whiteboard Auto-Deploy Timer";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      # Run every 5 minutes
      OnCalendar = "*:0/5";

      # Run immediately if missed (e.g., system was off)
      Persistent = true;

      # Randomize start time by up to 30 seconds to avoid thundering herd
      RandomizedDelaySec = "30s";

      # Don't accumulate missed runs
      AccuracySec = "1min";
    };
  };

  # Grant zack sudo privileges for deployment tasks
  security.sudo.extraRules = [
    {
      users = [ "zack" ];
      commands = [
        {
          command = "${pkgs.rsync}/bin/rsync";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl restart whiteboard";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl is-active whiteboard";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
