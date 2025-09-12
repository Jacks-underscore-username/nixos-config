{pkgs}:
pkgs.writeShellScriptBin "rn-regex" ''

  if [ "$#" -lt 2 ]; then
    echo "Usage: rn-regex <search_regex> <replace_string>"
    echo "Example: rn-regex \"^new_(.*)$\"" \"old_$1\"
    echo "  Renames all files prefixed with \"new_\" to \"old_\""
    exit 1
  fi

  START_DIR=$(pwd)

  echo "Searching for files to rename from directory: '$START_DIR'"
  echo "Regex pattern to match: '$1'"
  echo "Replacement string (Perl syntax): '$2'"
  echo "--------------------------------------------------"

  declare -a old_names=()
  declare -a new_names=()
  declare -i num_renames=0

  echo "HERE 1"

  ${pkgs.findutils}/bin/find . -print0 | while IFS= read -r -d $'\0' old_path; do
    echo "HERE 2"
    if [ "$old_path" = "." ]; then
      continue
    fi

    echo "HERE 3"

    new_path=$(
      echo "$old_path" | ${pkgs.perl}/bin/perl -pe "
        BEGIN { \$old_path = shift; chomp \$old_path; }
        s{$1}{$2}g
      "
    )
    echo "HERE 4"

    if [[ "$old_path" != "$new_path" ]]; then
      old_names+=("$old_path")
      new_names+=("$new_path")
      num_renames=$((num_renames + 1))
    fi
    echo "HERE 5"
  done
  echo "HERE 6"

  if [ "$num_renames" -eq 0 ]; then
    echo "No files found that match the regex or would be renamed."
    exit 0
  fi

  echo "The following files will be RENAMED:"
  for i in "''${!old_names[@]}"; do
    echo "- Old: \"''${old_names[$i]}\""
    echo "  New: \"''${new_names[$i]}\""
  done
  echo "--------------------------------------------------"

  read -p "Are you sure you want to permanently rename these $num_renames files? (y/N): " confirmation
  if [[ ! "$confirmation" =~ ^[yY]$ ]]; then
    echo "Operation cancelled. No files were renamed."
    exit 0
  fi

  echo "Proceeding with renaming..."
  for i in "''${!old_names[@]}"; do
    old_file="''${old_names[$i]}"
    new_file="''${new_names[$i]}"
    full_old_path="''${START_DIR%/}/$old_file"
    full_new_path="''${START_DIR%/}/$new_file"
    mkdir -p "$(dirname "''${full_new_path}")"
    mv -v "$full_old_path" "$full_new_path"
  done

  echo "Renaming complete."
''
