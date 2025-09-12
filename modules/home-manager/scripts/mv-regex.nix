{pkgs}:
pkgs.writeShellScriptBin "mv-regex" ''
  if [ "$#" -lt 2 ]; then
    echo "Usage: mv-regex <regex_pattern> <target_directory>"
    exit 1
  fi

  echo "Searching for files to move matching regex: '$1'"
  echo "In directory: $(pwd)"
  echo "--------------------------------------------------"

  declare -a files_to_move=()
  while IFS= read -r -d $'\0' file; do
    files_to_move+=("$file")
  done < <(${pkgs.findutils}/bin/find . -print0 | ${pkgs.gnugrep}/bin/grep -Pz "$1")

  if [ ''${#files_to_move[@]} -eq 0 ]; then
    echo "No files found matching the regex '$1'."
    exit 0
  fi

  echo "The following files will be MOVED:"
  for file in "''${files_to_move[@]}"; do
    echo "- '$file'"
  done
  echo "--------------------------------------------------"

  read -p "Are you sure you want to permanently move these ''${#files_to_move[@]} files? (y/N): " confirmation
  if [[ ! "$confirmation" =~ ^[yY]$ ]]; then
    echo "Operation cancelled. No files were copied."
    exit 0
  fi

  echo "Proceeding with moving..."
  printf "%s\0" "''${files_to_move[@]}" | xargs -0 mv -f -t "$2"

  echo "Moving complete."
''
