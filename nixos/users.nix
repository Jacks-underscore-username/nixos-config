{
  inputs,
  outputs,
  ...
}: {
  users.users.jackc = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "plugdev" "dialout" "tty" "jackaudio"];
    # TODO: Figure out actual passwords.
    initialPassword = "0";
  };

  systemd.tmpfiles.rules = [
    "d /persist/home/ 1777 root root -"
    "d /persist/home/jackc 0770 jackc users -"
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users.jackc = import ../home-manager/home.nix;
    backupFileExtension = "backup";
  };
}
