{
  lib,
  pkgs,
  ...
}: {
  users.users.jackc.shell = pkgs.fish;

  programs.nix-index.enableFishIntegration = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
      set --erase fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    settings = lib.mkMerge [
      (builtins.fromTOML
        (
          builtins.readFile "${pkgs.starship}/share/starship/presets/jetpack.toml"
        ))
      {
        # palette = lib.mkForce "catppuccin_frappe";
      }
    ];
    # settings = {
    #   character = {
    #     success_symbol = "[➜](bold green)";
    #     error_symbol = "[➜](bold red)";
    #   };
    # };
  };
}
