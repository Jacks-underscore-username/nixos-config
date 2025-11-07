{pkgs}:
pkgs.writeShellScriptBin "7zip" ''
  if [ "$#" -ne 1 ]; then
    echo "Usage: compress-folder <path_to_folder>"
    echo "Example: compress-folder my_project_data"
    exit 1
  fi

  FOLDER_PATH="$1"
  FOLDER_NAME=$(basename "$FOLDER_PATH")
  OUTPUT_ARCHIVE="''${FOLDER_PATH}.7z"

  if [ ! -d "$FOLDER_PATH" ]; then
    echo "Error: Directory '$FOLDER_PATH' not found."
    exit 1
  fi

  echo "Compressing folder: '$FOLDER_PATH'"
  echo "Output archive: '$OUTPUT_ARCHIVE'"

  if ${pkgs.p7zip.out}/bin/7z a -r -mx=9 -t7z "$OUTPUT_ARCHIVE" "$FOLDER_PATH"; then
    echo "Compression successful. Archive created at '$OUTPUT_ARCHIVE'"
  else
    echo "Error: Compression failed for '$FOLDER_PATH'."
    exit 1
  fi
''
