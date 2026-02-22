{pkgs, ...}: {
  users.users.jackc.shell = pkgs.fish;

  programs.nix-index.enableFishIntegration = true;

  programs.fish = {
    enable = true;
    shellInit = "starship init fish | source";
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
