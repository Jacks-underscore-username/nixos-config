{...}: {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";
    after = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    unitConfig = {
      Type = "oneshot";
      Conflicts = ["shutdown.target"];
      Before = ["shutdown.target"];
    };
    script = ''
      echo "Hello World!"
    '';
  };
}
