{pkgs}:
pkgs.writeShellScriptBin "rm-regex" ''
  if [ -z "$1" ]; then
    echo "Usage: rm-regex \"REGEX\""
    exit 1
  fi

  echo "Searching for files to delete matching regex: '$1'"
  echo "In directory: $(pwd)"
  echo "--------------------------------------------------"

  declare -a files_to_delete=()
  while IFS= read -r -d $'\0' file; do
    files_to_delete+=("$file")
  done < <(${pkgs.findutils}/bin/find . -print0 | ${pkgs.gnugrep}/bin/grep -Pz "$1")

  if [ ''${#files_to_delete[@]} -eq 0 ]; then
    echo "No files found matching the regex '$1'."
    exit 0
  fi

  echo "The following files will be DELETED:"
  for file in "''${files_to_delete[@]}"; do
    echo "- '$file'"
  done
  echo "--------------------------------------------------"

  read -p "Are you sure you want to permanently delete these ''${#files_to_delete[@]} files? (y/N): " confirmation
  if [[ ! "$confirmation" =~ ^[yY]$ ]]; then
    echo "Operation cancelled. No files were deleted."
    exit 0
  fi

  echo "Proceeding with deletion..."
  printf "%s\0" "''${files_to_delete[@]}" | xargs -0 rm -rf

  echo "Deletion complete."
''
