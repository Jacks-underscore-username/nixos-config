{pkgs, ...}: let
  user = "jackc";
in {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target" "shutdown.target"];
    unitConfig = {
      Type = "oneshot";
      ConditionUser = user;
      # Conflicts = ["shutdown.target"];
      # Before = ["shutdown.target"];

      User = user;
      Environment = ["HOME=/home/${user}"];
    };
    script = ''
      ${pkgs.openssh}/bin/ssh 192.168.4.62 'echo "Hello from the other server!" | wall'
    '';
  };
}
