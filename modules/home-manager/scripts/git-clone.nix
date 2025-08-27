{pkgs}:
pkgs.writeShellScriptBin "git-clone" ''
  # --- Argument Parsing ---
  if [ "$#" -lt 2 ]; then
    echo "Usage: git-clone-regex <repository_url> <regex_pattern> [target_directory]"
    echo "Example: git-clone-regex https://github.com/owner/repo '.*\.md$' my-docs"
    echo "  Clones files matching '.*\.md$' from the repository into 'my-docs/'"
    exit 1
  fi

  REPO_URL="$1"
  REGEX_PATTERN="$2"
  TARGET_DIR="''${3:-$(basename "$REPO_URL" .git)}" # Default target dir is repo name

  echo "Cloning repository: '$REPO_URL'"
  echo "Extracting files matching regex: '$REGEX_PATTERN'"
  echo "Into directory: '$TARGET_DIR'"
  echo "--------------------------------------------------"

  # Create a temporary directory for the full clone
  TEMP_CLONE_DIR=$(mktemp -d -t git-clone-regex-XXXXXXXXXX)
  if [ $? -ne 0 ]; then
      echo "Error: Could not create temporary directory."
      exit 1
  fi
  echo "Temporary clone directory: '$TEMP_CLONE_DIR'"

  # Ensure the temporary directory is cleaned up on exit
  trap "echo 'Cleaning up temporary directory: $TEMP_CLONE_DIR'; rm -rf '$TEMP_CLONE_DIR'" EXIT

  # Clone the full repository into the temporary directory (shallow clone for efficiency)
  if ! ${pkgs.git}/bin/git clone --depth 1 "$REPO_URL" "$TEMP_CLONE_DIR"; then
      echo "Error: Git clone failed."
      exit 1
  fi

  # Navigate into the temporary clone directory
  cd "$TEMP_CLONE_DIR" || { echo "Error: Could not enter temporary clone directory."; exit 1; }

  # Find files matching the regex
  # Using -print0 and -Pz for robustness with filenames
  declare -a files_to_move=()
  while IFS= read -r -d $'\0' file; do
      files_to_move+=("$file")
  done < <(${pkgs.findutils}/bin/find . -type f -print0 | grep -Pz "$REGEX_PATTERN")

  if [ ''${#files_to_move[@]} -eq 0 ]; then
      echo "No files found matching the regex '$REGEX_PATTERN' in the repository."
      exit 0 # Exit successfully if no files matched
  fi

  echo "Found ''${#files_to_move[@]} files matching the regex:"
  for file in "''${files_to_move[@]}"; do
    echo "- '$file'"
  done
  echo "--------------------------------------------------"

  # Create the target directory if it doesn't exist
  # Go back to the original calling directory first for correct pathing
  cd - > /dev/null # Go back to original directory from where script was called
  mkdir -p "$TARGET_DIR"

  # Move the selected files to the target directory
  for file in "''${files_to_move[@]}"; do
    # Calculate source path relative to original TEMP_CLONE_DIR
    SOURCE_PATH="$TEMP_CLONE_DIR/$file"

    # Calculate the destination path, preserving subdirectory structure
    # dirname and basename from coreutils/findutils are needed here
    DEST_PATH="$TARGET_DIR/$(dirname "$file")"

    mkdir -p "$DEST_PATH" # Ensure target subdirectory exists

    if [ -f "$SOURCE_PATH" ]; then # Ensure it's a file before moving
        mv "$SOURCE_PATH" "$DEST_PATH"
    else
        echo "Warning: '$SOURCE_PATH' is not a file or no longer exists. Skipping."
    fi
  done

  # The trap will clean up TEMP_CLONE_DIR automatically on exit

  echo "--------------------------------------------------"
  echo "Extraction complete! Files matching '$REGEX_PATTERN' are in '$TARGET_DIR/'"
''
