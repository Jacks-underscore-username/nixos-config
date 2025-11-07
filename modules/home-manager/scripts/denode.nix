{pkgs}:
pkgs.writeShellScriptBin "denode" ''
  target_directory=''${target_directory:-.}

  # Check if the target directory exists
  if [ ! -d "$target_directory" ]; then
    echo "Error: Directory '$target_directory' not found."
    exit 1
  fi

  echo "Searching for 'node_modules' folders with associated lock files in '$target_directory'..."

  total_space_saved_bytes=0 # Initialize a counter for total bytes saved

  # Use find to locate all node_modules directories
  find "$target_directory" -type d -name "node_modules" | while read -r node_modules_folder; do
    # Get the parent directory of node_modules
    parent_dir=$(dirname "$node_modules_folder")

    # Check for the presence of package-lock.json or bun.lockb in the parent directory
    if [[ -f "$parent_dir/package-lock.json" || -f "$parent_dir/bun.lockb" ]]; then
      echo "Found: $node_modules_folder (with associated lock file in $parent_dir)"

      # Get the size of the node_modules folder before asking for confirmation
      # using 'du -sb' for size in bytes, suppressing errors
      folder_size_bytes=$(du -sb "$node_modules_folder" 2>/dev/null | awk '{print $1}')

      if [ -z "$folder_size_bytes" ]; then
          folder_size_bytes=0 # Set to 0 if du failed or folder is empty
      fi

      echo "Size: $(numfmt --to=iec-i --suffix=B --padding=7 "$folder_size_bytes")"

      read -rp "Do you want to delete this folder? (y/N): " confirmation
      if [[ "$confirmation" =~ ^[Yy]$ ]]; then
        echo "Deleting '$node_modules_folder'..."
        rm -rf "$node_modules_folder"
        echo "'$node_modules_folder' deleted."

        # Add the size of the deleted folder to the total
        total_space_saved_bytes=$((total_space_saved_bytes + folder_size_bytes))
      else
        echo "Skipping '$node_modules_folder'."
      fi
    else
      echo "Skipping: $node_modules_folder (no 'package-lock.json' or 'bun.lockb' found in $parent_dir)"
    fi
  done

  echo ""
  echo "Scan complete."


  human_readable_space=$(numfmt --to=iec-i --suffix=B "$total_space_saved_bytes")
  echo "Total disk space saved: $human_readable_space"
''
