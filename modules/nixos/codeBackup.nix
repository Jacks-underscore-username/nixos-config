{...}: {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";
    wantedBy = ["multi-user.target"];
  };
}
