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
      acp = "add -A && commit && push";
      acpf = "add -A && commit && push --force";
      plog = ''
        !f() { \
            git log --pretty=format:"%Cred%H%Creset - %C(yellow)%an%Creset, %C(cyan)%ar%Creset%n%s" \
                    --numstat \
                    --diff-filter=ACDMR \
                    --no-color \
                    "$@" \
                    | awk "BEGIN { FS=\"\\\\t\"; printf \"\\\\n\"; last_commit=\"\"; } /^.{40} - / { if (last_commit != \"\") { printf \"\\\\n\"; } print \\\$0; last_commit = \\\$1; next; } /^[0-9\\\\-]+/ { adds=\\\$1; dels=\\\$2; filepath=\\\$3; color_code=\"\"; diff_summary=\"\"; if (adds == \"-\" && dels != \"-\") { color_code=\"\\\\033[0;31m\"; diff_summary=\"(Deleted)\"; } else if (adds != \"-\" && dels == \"-\") { color_code=\"\\\\033[0;32m\"; diff_summary=\"(Added)\"; } else if (adds != \"-\" && dels != \"-\") { color_code=\"\\\\033[0;33m\"; diff_summary=sprintf(\"(+%s, -%s)\", adds, dels); } else { color_code=\"\\\\033[0m\"; } printf \"%s%s\\\\033[0m | %s\\\\n\", color_code, filepath, diff_summary; }"; \
        }; f
      '';
    };
  };
}
