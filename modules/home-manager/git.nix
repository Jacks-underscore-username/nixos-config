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
                            FS=\"\\\\t\"; \ # Escape backslash for awk
                            printf \"\\\\n\"; \ # Escape backslash for awk
                            last_commit=\"\"; \
                        } \
                        /^.{40} - / { \
                            if (last_commit != \"\") { \
                                printf \"\\\\n\"; \ # Escape backslash for awk
                            } \
                            print \\\$0; \ # Escape $ for shell
                            last_commit = \\\$1; \ # Escape $ for shell
                            next; \
                        } \
                        /^[0-9\\\\-]+/ { \ # Escape backslash for awk regex, then for shell (total of 4 backslashes)
                            adds=\\\$1; \
                            dels=\\\$2; \
                            filepath=\\\$3; \
                            \
                            color_code=\"\"; \
                            diff_summary=\"\"; \
                            \
                            if (adds == \"-\" && dels != \"-\") { \
                                color_code=\"\\\\033[0;31m\"; \ # Escape backslashes for awk
                                diff_summary=\"(Deleted)\"; \
                            } else if (adds != \"-\" && dels == \"-\") { \
                                color_code=\"\\\\033[0;32m\"; \ # Escape backslashes for awk
                                diff_summary=\"(Added)\"; \
                            } else if (adds != \"-\" && dels != \"-\") { \
                                color_code=\"\\\\033[0;33m\"; \ # Escape backslashes for awk
                                diff_summary=sprintf(\"(+%s, -%s)\", adds, dels); \ # sprintf for safety
                            } else { \
                                color_code=\"\\\\033[0m\"; \ # Escape backslashes for awk
                            } \
                            \
                            printf \"%s%s\\\\033[0m | %s\\\\n\", color_code, filepath, diff_summary; \ # Escape backslashes for awk
                        } \
                    "; \
        }; f
      '';
    };
  };
}
