{pkgs, ...}: let
  user = "jackc";
  backupScript = "${pkgs.openssh}/bin/ssh 192.168.4.62 'echo \"Hello from the other server!\" | wall'";
in {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";

    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

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
