{environment, ...}: {
  environment.shellAliases = {
    ssht2 = "/run/current-system/sw/bin/ssh -t \"$@\" tmux new -A \"Jack\"";
  };
}
