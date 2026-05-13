{pkgs, ...}: let
  user = "jackc";
  ssh-settings =
    "${pkgs.openssh}/bin/ssh"
    + " -i /persist/home/${user}/.ssh/id_ed25519"
    + " -o UserKnownHostsFile=/persist/home/${user}/.ssh/known_hosts";
  ssh-command = "${ssh-settings} root@192.168.4.62";

  btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
  pv = "${pkgs.pv}/bin/pv";
  # Remote server uses its own btrfs from PATH
  remoteBtrfs = "btrfs";

  localSnapshotDir = "/persist/.snapshots/code";
  remoteMountPoint = "/mnt/ssd";
  remoteSnapshotDir = "${remoteMountPoint}/codeBackups";
  remoteSsdUuid = "e8c4d542-f51e-4b34-b04c-92064ee47820";

  backupScript = pkgs.writeShellScript "code-backup" ''
    set -euo pipefail

    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    SNAP_NAME="code-''${TIMESTAMP}"
    LOCAL_SNAP="${localSnapshotDir}/''${SNAP_NAME}"
    PREV_SNAP_FILE="${localSnapshotDir}/.latest"

    echo "=== Code backup starting at ''${TIMESTAMP} ==="

    # Ensure local snapshot directory exists
    mkdir -p "${localSnapshotDir}"

    # Clean up any orphaned local snapshots not tracked by .latest
    if [ -f "''${PREV_SNAP_FILE}" ]; then
      KEEP=$(cat "''${PREV_SNAP_FILE}")
    else
      KEEP=""
    fi
    for snap in "${localSnapshotDir}"/code-*; do
      [ -d "''${snap}" ] || continue
      if [ "''${snap}" != "''${KEEP}" ]; then
        echo "Cleaning up orphaned snapshot: ''${snap}"
        ${btrfs} subvolume delete "''${snap}" 2>/dev/null || true
      fi
    done

    # Create a read-only snapshot of /persist/code
    echo "Creating snapshot of /persist/code..."
    ${btrfs} subvolume snapshot -r /persist/code "''${LOCAL_SNAP}"
    echo "Created local snapshot: ''${LOCAL_SNAP}"

    # Mount the btrfs SSD on the remote if not already mounted
    echo "Connecting to remote and ensuring SSD is mounted..."
    ${ssh-command} "mkdir -p ${remoteMountPoint} && (mountpoint -q ${remoteMountPoint} && mount -o remount,rw ${remoteMountPoint} || mount -o rw,noatime,compress=zstd UUID=${remoteSsdUuid} ${remoteMountPoint})"
    echo "Remote SSD mounted."

    # Ensure remote snapshot directory exists
    ${ssh-command} "mkdir -p ${remoteSnapshotDir}"

    # Send snapshot to remote — incremental if a previous snapshot exists
    if [ -f "''${PREV_SNAP_FILE}" ]; then
      PREV_SNAP=$(cat "''${PREV_SNAP_FILE}")
      if [ -d "''${PREV_SNAP}" ]; then
        echo "Sending incremental snapshot (parent: $(basename "''${PREV_SNAP}"))..."
        if ${btrfs} send -p "''${PREV_SNAP}" "''${LOCAL_SNAP}" \
          | ${pv} -f -W \
          | ${ssh-command} "${remoteBtrfs} receive ${remoteSnapshotDir}"; then
          echo "Incremental send succeeded."

          # Clean up the old local snapshot
          ${btrfs} subvolume delete "''${PREV_SNAP}"
          echo "Deleted old local snapshot: $(basename "''${PREV_SNAP}")"

          # Clean up the old remote snapshot
          PREV_SNAP_BASENAME=$(basename "''${PREV_SNAP}")
          ${ssh-command} "${remoteBtrfs} subvolume delete ${remoteSnapshotDir}/''${PREV_SNAP_BASENAME}" || true
          echo "Deleted old remote snapshot: ''${PREV_SNAP_BASENAME}"
        else
          echo "Incremental send failed, falling back to full send..."
          # Delete the failed partial snapshot on remote if it exists
          ${ssh-command} "${remoteBtrfs} subvolume delete ${remoteSnapshotDir}/''${SNAP_NAME}" 2>/dev/null || true

          echo "Sending full snapshot..."
          ${btrfs} send "''${LOCAL_SNAP}" \
            | ${pv} -f -W \
            | ${ssh-command} "${remoteBtrfs} receive ${remoteSnapshotDir}"

          # Clean up old snapshots since we did a full send
          ${btrfs} subvolume delete "''${PREV_SNAP}" 2>/dev/null || true
        fi
      else
        echo "Previous snapshot not found, sending full snapshot..."
        ${btrfs} send "''${LOCAL_SNAP}" \
          | ${pv} -f -W \
          | ${ssh-command} "${remoteBtrfs} receive ${remoteSnapshotDir}"
      fi
    else
      echo "No previous snapshot found, sending full snapshot..."
      ${btrfs} send "''${LOCAL_SNAP}" \
        | ${pv} -f -W \
        | ${ssh-command} "${remoteBtrfs} receive ${remoteSnapshotDir}"
    fi

    # Record current snapshot as the latest
    echo "''${LOCAL_SNAP}" > "''${PREV_SNAP_FILE}"
    echo "=== Backup complete: ''${SNAP_NAME} ==="
  '';
in {
  # Expose the backup script so the manual wrapper can call it directly
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "code-backup" ''exec ${backupScript} "$@"'')
  ];

  systemd.services.code-backup = {
    enable = true;
    description = "Backup the code folder via btrfs send/receive";

    after = ["network-online.target"];
    wants = ["network-online.target"];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = backupScript;
    };
  };

  systemd.timers.code-backup = {
    enable = true;
    description = "Run code backup periodically";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
      RandomizedDelaySec = "5m";
    };
  };
}
