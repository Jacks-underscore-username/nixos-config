{pkgs}:
pkgs.writeShellScriptBin "git-clone" ''
  if [ "$
    echo "Usage: git-clone-regex <repository_url> <regex_pattern> [target_directory]"
    echo "Example: git-clone-regex https://github.com/owner/repo '.*\.md$' my-docs"
    echo "  Clones files matching '.*\.md$' from the repository into 'my-docs/'"
    exit 1
  fi

  REPO_URL="$1"
  REGEX_PATTERN="$2"
  TARGET_DIR="''${3:-$(basename "$REPO_URL" .git)}"

  echo "Cloning repository: '$REPO_URL'"
  echo "Extracting files matching regex: '$REGEX_PATTERN'"
  echo "Into directory: '$TARGET_DIR'"
  echo "--------------------------------------------------"

  TEMP_CLONE_DIR=$(mktemp -d -t git-clone-regex-XXXXXXXXXX)
  if [ $? -ne 0 ]; then
      echo "Error: Could not create temporary directory."
      exit 1
  fi
  echo "Temporary clone directory: '$TEMP_CLONE_DIR'"

  trap "echo 'Cleaning up temporary directory: $TEMP_CLONE_DIR'; rm -rf '$TEMP_CLONE_DIR'" EXIT

  if ! ${pkgs.git}/bin/git clone --depth 1 "$REPO_URL" "$TEMP_CLONE_DIR"; then
      echo "Error: Git clone failed."
      exit 1
  fi

  cd "$TEMP_CLONE_DIR" || { echo "Error: Could not enter temporary clone directory."; exit 1; }

  declare -a files_to_move=()
  while IFS= read -r -d $'\0' file; do
      files_to_move+=("$file")
  done < <(${pkgs.findutils}/bin/find . -type f -print0 | grep -Pz "$REGEX_PATTERN")

  if [ ''${
      echo "No files found matching the regex '$REGEX_PATTERN' in the repository."
      exit 0
  fi

  echo "Found ''${
  for file in "''${files_to_move[@]}"; do
    echo "- '$file'"
  done
  echo "--------------------------------------------------"

  cd - > /dev/null
  mkdir -p "$TARGET_DIR"

  for file in "''${files_to_move[@]}"; do
    SOURCE_PATH="$TEMP_CLONE_DIR/$file"
    DEST_PATH="$TARGET_DIR/$(dirname "$file")"

    mkdir -p "$DEST_PATH"

    if [ -f "$SOURCE_PATH" ]; then
        mv "$SOURCE_PATH" "$DEST_PATH"
    else
        echo "Warning: '$SOURCE_PATH' is not a file or no longer exists. Skipping."
    fi
  done

  echo "--------------------------------------------------"
  echo "Extraction complete! Files matching '$REGEX_PATTERN' are in '$TARGET_DIR/'"
''
