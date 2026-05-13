{lib, ...}: {
  security.sudo.extraRules = [
    {
      users = ["jackc"];
      commands =
        builtins.map (cmd: {
          command = cmd;
          options = ["NOPASSWD"];
        })
        [
          "/run/current-system/sw/bin/nixos-rebuild *"
        ];
    }
  ];
}
