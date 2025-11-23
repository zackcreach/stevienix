{ config, pkgs, ... }:

{
  systemd.services.whiteboard = {
    description = "Whiteboard (Docker Compose)";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    requires = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "zack";
      Group = "users";
      WorkingDirectory = "/home/zack/dev/whiteboard";

      ExecStart = "${pkgs.docker}/bin/docker compose -f docker-compose.yml up -d";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";

      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
