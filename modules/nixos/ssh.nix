{pkgs, ...}: {
  programs.bash.shellAliases = {
    "ssh_relay" = "ssh -p 43 jack@170.205.31.42";
    "ssh_server" = "ssh jackc@192.168.4.62";
  };
}
