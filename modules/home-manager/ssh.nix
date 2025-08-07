{pkgs, ...}: {
  programs.ssh.extraConfig = ''
    Host relay
      Hostname 170.205.31.42
      User jack
      Port 43
  '';
  #     "relay" = {
  #       hostname = "170.205.31.42";
  #       user = "jack";
  #       port = 43;
  #     };
  #     "server" = {
  #       hostname = "";
  #       user = "jackc";
  #     };
  #   };
}
