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
                    --name-only \
                    --follow \
                    --no-color \
                    "$@" \
                    | awk " \
                        BEGIN { \
                        FS=\"\\t\"; \
                        printf \"\n\"; \
                        last_commit=\"\"; \
                        } \
                        /^.{40} - / { \
                        if (last_commit != \"\") { \
                            printf \"\n\"; \
                        } \
                        print \$0; \
                        last_commit = \$1; \
                        next; \
                        } \
                        /^[0-9\\-]+/ { \
                        adds=\$1; \
                        dels=\$2; \
                        filepath=\$3; \
                        \
                        color_code=\"\"; \
                        diff_summary=\"\"; \
                        \
                        # Determine status based on additions/deletions (heuristic) \
                        if (adds == \"-\" && dels != \"-\") { \
                            color_code=\"\\033[0;31m\"; /* Red for Deleted */ \
                            diff_summary=\"(Deleted)\"; \
                        } else if (adds != \"-\" && dels == \"-\") { \
                            color_code=\"\\033[0;32m\"; /* Green for Added */ \
                            diff_summary=\"(Added)\"; \
                        } else if (adds != \"-\" && dels != \"-\") { \
                            color_code=\"\\033[0;33m\"; /* Yellow for Modified */ \
                            diff_summary=\Sprintf(\"(+%s, -%s)\", adds, dels); \
                        } else { \
                            color_code=\"\\033[0m\"; /* No Color */ \
                        } \
                        \
                        # Print formatted line \
                        printf \"%s%s\\033[0m | %s\n\", color_code, filepath, diff_summary; \
                        } \
                    "; \
        }; f
      '';
    };
  };
}
