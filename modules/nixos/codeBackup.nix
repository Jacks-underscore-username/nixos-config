{...}: {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    unitConfig = {
      Type = "oneshot";
    };
  };
}
