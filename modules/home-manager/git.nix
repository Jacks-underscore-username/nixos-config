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
    aliases = {
      dls = "git reset --soft HEAD^1";
      acp = "git add -A && git commit && git push";
    };
  };
}
