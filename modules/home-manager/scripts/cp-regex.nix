{pkgs}:
pkgs.writeShellScriptBin "cp-regex" ''
  if [ "$#" -lt 2 ]; then
    echo "Usage: cp-regex <regex_pattern> <target_directory>"
    exit 1
  fi

  echo "Searching for files to copy matching regex: '$1'"
  echo "In directory: $(pwd)"
  echo "--------------------------------------------------"

  declare -a files_to_copy=()
  while IFS= read -r -d $'\0' file; do
    files_to_copy+=("$file")
  done < <(${pkgs.findutils}/bin/find . -print0 | ${pkgs.gnugrep}/bin/grep -Pz "$1")

  if [ ''${#files_to_copy[@]} -eq 0 ]; then
    echo "No files found matching the regex '$1'."
    exit 0
  fi

  echo "The following files will be COPIED:"
  for file in "''${files_to_copy[@]}"; do
    echo "- '$file'"
  done
  echo "--------------------------------------------------"

  read -p "Are you sure you want to permanently copy these ''${#files_to_copy[@]} files? (y/N): " confirmation
  if [[ ! "$confirmation" =~ ^[yY]$ ]]; then
    echo "Operation cancelled. No files were copied."
    exit 0
  fi

  echo "Proceeding with copying..."
  printf "%s\0" "''${files_to_copy[@]}" | xargs -0 cp -r --parents "$2"

  echo "Copying complete."
''
