{lib, ...}: {
  security.sudo.extraRules = [
    {
      users = ["jackc"];
      commands =
        builtins.map (cmd: {
          command = cmd;
          options = ["NOPASSWD"];
        })
        ["/home/jackc/.nix-profile/bin/reload"];
    }
  ];
}
