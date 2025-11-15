{pkgs, ...}: let
  user = "jackc";
  ssh-settings =
    "${pkgs.openssh}/bin/ssh"
    + " -i /persist/home/${user}/.ssh/id_ed25519"
    + " -o UserKnownHostsFile=/persist/home/${user}/.ssh/known_hosts";
  ssh-command = "${ssh-settings} ${user}@192.168.4.62";
in let
  backupScript = ''
    ${ssh-command} 'echo "Test message" | wall'

    ${pkgs.rsync}/bin/rsync -avz --delete --info=progress2 --stats  -e '${ssh-settings}' /persist/code/ ${user}@192.168.4.62:/mnt/ssd/codeBackups/latest
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
