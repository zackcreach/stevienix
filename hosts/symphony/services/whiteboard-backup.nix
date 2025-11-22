{ config, pkgs, ... }:

{
  # Create backup directory with proper permissions
  # Also ensure parent directories are traversable by postgres user
  systemd.tmpfiles.rules = [
    "z /home/zack 0711 - - - -"
    "z /home/zack/whiteboard 0755 - - - -"
    "d /home/zack/whiteboard/creachignore/db_backups 0775 zack postgres - -"
  ];

  systemd.services.whiteboard-backup = {
    description = "Whiteboard Database Backup";
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];

    path = with pkgs; [
      postgresql_16
      gzip
      coreutils
    ];

    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      Group = "postgres";

      # Load environment variables (DATABASE_URL)
      EnvironmentFile = "/etc/whiteboard/env";

      # Run pg_dump with gzip compression
      ExecStart = pkgs.writeShellScript "whiteboard-backup" ''
        set -euo pipefail

        BACKUP_DIR="/home/zack/whiteboard/creachignore/db_backups"
        BACKUP_FILE="whiteboard_prod_$(date +%Y-%m-%d).sql.gz"
        BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILE"

        # Extract database name from DATABASE_URL
        # Format: ecto://USER:PASS@HOST/DATABASE or postgresql://USER:PASS@HOST/DATABASE
        DB_NAME=$(echo "$DATABASE_URL" | sed -E 's|.*/([^/?]+).*|\1|')

        # Perform backup with gzip compression
        ${pkgs.postgresql_16}/bin/pg_dump "$DB_NAME" | ${pkgs.gzip}/bin/gzip > "$BACKUP_PATH"

        echo "Backup completed: $BACKUP_PATH"
      '';

      # Don't restart on failure (timer will retry next day)
      Restart = "no";

      # Give it time to complete
      TimeoutStartSec = "30min";
    };
  };

  systemd.timers.whiteboard-backup = {
    description = "Whiteboard Database Backup Timer";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      # Run daily at 3:00 AM
      OnCalendar = "03:00";

      # Run immediately if missed (e.g., system was off)
      Persistent = true;

      # Randomize start time by up to 2 minutes to avoid exact timing
      RandomizedDelaySec = "2min";

      # Standard accuracy
      AccuracySec = "1min";
    };
  };
}
