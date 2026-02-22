{pkgs, ...}: {
  users.users.jackc.shell = pkgs.fish;

  programs.fish = {
    enable = true;
    shellInit = "starship init fish | source";
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
