{pkgs, ...}: {
  programs.ssh.matchBlocks = {
    "relay" = {
      hostname = "170.205.31.42";
      user = "jack";
      port = 43;
    };
    "server" = {
      hostname = "";
      user = "jackc";
    };
  };
}
