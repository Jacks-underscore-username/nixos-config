{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
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
      aliases = {
        dlc = "reset --soft HEAD^1";
        dlcs = "reset --soft HEAD^1";
        dlch = "reset --hard HEAD^1";
        slc = ''!f() { LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B); git reset --soft HEAD^1 && git add -A && git commit -m "$LAST_COMMIT_MESSAGE" && git push --force; }; f'';
        acp = ''!f() { git add -A && git commit -m "$@" && git push; }; f'';
        acpf = ''!f() { git add -A && git commit -m "$@" && git push --force; }; f'';
        plog = "!git_plog";
      };
    };
  };
}
