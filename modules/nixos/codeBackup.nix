{pkgs, ...}: let
  user = "jackc";
  backupScript = ''
    ${pkgs.openssh}/bin/ssh ${user}@192.168.4.62 \
      -i /persist/home/${user}/.ssh/id_ed25519 \
      -o UserKnownHostsFile=/persist/home/${user}/.ssh/known_hosts \
      'echo "Test message" | wall'
  '';
in {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";

    after = ["network-online.target" "persist.mount"];
    requires = ["network-online.target" "persist.mount"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target" "shutdown.target"];

    stopIfChanged = false;
    serviceConfig = {
      Type = "oneshot";
      User = user;
      Environment = ["HOME=/persist/home/${user}"];
      RemainAfterExit = true;
      ExecStop = backupScript;
    };

    script = backupScript;
  };
}
