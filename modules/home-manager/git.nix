# inspo: https://discourse.nixos.org/t/fix-collision-with-multiple-jdks/10812/5
{pkgs, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      user.email = "jacksunderscoreusername@gmail.com";
      user.name = "Jacks-underscore-username";
      init.defaultBranch = "main";
      credential = {
        "https://github.com" = {
          helper = [
            ""
            "!/home/jackc/.nix-profile/bin/gh auth git-credential"
          ];
        };
        "https://gist.github.com" = {
          helper = [
            ""
            "!/home/jackc/.nix-profile/bin/gh auth git-credential"
          ];
        };
      };
      safe.directory = ["/persist/nixos"];
    };
  };
}
