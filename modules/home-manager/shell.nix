{
  pkgs,
  inputs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "thefuck"];
      theme = "robbyrussell";
    };
  };

  home.sessionVariables = {
  };
}
