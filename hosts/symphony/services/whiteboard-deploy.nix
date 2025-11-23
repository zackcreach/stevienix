{ config, pkgs, ... }:

{
  systemd.services.whiteboard-deploy = {
    description = "Whiteboard Auto-Deploy (Docker)";
    after = [ "network.target" "docker.service" ];
    requires = [ "docker.service" ];

    path = with pkgs; [
      git
      openssh
      docker
      elixir
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

      EnvironmentFile = "/etc/whiteboard/env";

      ExecStart = "${pkgs.elixir}/bin/mix deploy";

      Restart = "no";

      TimeoutStartSec = "20min";
    };
  };

  systemd.timers.whiteboard-deploy = {
    description = "Whiteboard Auto-Deploy Timer";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "*:0/5";

      Persistent = true;

      RandomizedDelaySec = "30s";

      AccuracySec = "1min";
    };
  };
}
