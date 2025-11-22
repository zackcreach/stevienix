{ config, pkgs, ... }:

{
  systemd.services.whiteboard = {
    description = "Whiteboard";
    after = [ "network.target" "postgresql.service" ];
    wants = [ "postgresql.service" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      # Phoenix configuration
      PHX_SERVER = "true";
      PHX_HOST = "symphony";
      PORT = "4000";
      POOL_SIZE = "10";

      # Production environment
      MIX_ENV = "prod";
      RELEASE_DISTRIBUTION = "none";

      # Locale settings
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    serviceConfig = {
      Type = "exec";
      User = "whiteboard";
      Group = "whiteboard";
      WorkingDirectory = "/var/lib/whiteboard";

      # Use systemd's EnvironmentFile for secrets
      EnvironmentFile = "/etc/whiteboard/env";

      # Start the release
      ExecStart = "/var/lib/whiteboard/bin/whiteboard start";
      ExecStop = "/var/lib/whiteboard/bin/whiteboard stop";

      # Restart policy
      Restart = "on-failure";
      RestartSec = "5s";

      # Security hardening
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [ "/var/lib/whiteboard" ];

      # Resource limits
      LimitNOFILE = "65536";
    };
  };

  # Create whiteboard user and group
  users.users.whiteboard = {
    isSystemUser = true;
    group = "whiteboard";
    home = "/var/lib/whiteboard";
    createHome = true;
    description = "Whiteboard application user";
  };

  users.groups.whiteboard = { };
}
