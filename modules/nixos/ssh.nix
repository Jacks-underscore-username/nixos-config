{pkgs, ...}: {
  programs.bash.shellAliases = {
    "ssh relay" = "ssh -p 43 jack@170.205.31.42";
    "relay" = "ssh -p 43 jack@170.205.31.42";
  };
}
