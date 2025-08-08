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
      dls = "reset --soft HEAD^1";
      dlsh = "reset --hard HEAD^1";
      acp = "'!f() { git add -A && git commit && git push }; f()'";
      acpf = "'!f() { git add -A && git commit && git push --force }; f()'";
      plog = "!git_plog";
    };
  };
}
