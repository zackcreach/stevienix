{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "d /home/zack/dev/whiteboard/creachignore/db_backups 0775 zack users - -"
  ];

  systemd.services.whiteboard-backup = {
    description = "Whiteboard Database Backup (Docker)";
    after = [ "docker.service" "whiteboard.service" ];
    requires = [ "docker.service" ];

    path = with pkgs; [
      docker
      gzip
      coreutils
    ];

    serviceConfig = {
      Type = "oneshot";
      User = "zack";
      Group = "users";

      ExecStart = pkgs.writeShellScript "whiteboard-backup" ''
        set -euo pipefail

        BACKUP_DIR="/home/zack/dev/whiteboard/creachignore/db_backups"
        BACKUP_FILE="whiteboard_prod_$(date +%Y-%m-%d).sql.gz"
        BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILE"

        # Use docker exec to run pg_dump inside the postgres container
        ${pkgs.docker}/bin/docker exec whiteboard_db pg_dump -U postgres whiteboard_prod | ${pkgs.gzip}/bin/gzip > "$BACKUP_PATH"

        echo "Backup completed: $BACKUP_PATH"
      '';

      Restart = "no";

      TimeoutStartSec = "30min";
    };
  };

  systemd.timers.whiteboard-backup = {
    description = "Whiteboard Database Backup Timer";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "03:00";

      Persistent = true;

      RandomizedDelaySec = "2min";

      AccuracySec = "1min";
    };
  };
}
