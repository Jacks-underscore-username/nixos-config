{pkgs}:
pkgs.writeShellScriptBin "denode" ''
  target_directory=/persist/code

  echo "Searching for 'node_modules' folders with associated lock files in '$target_directory'..."

  total_space_saved_bytes=0

  find "$target_directory" -type d -name "node_modules" -not -path "*/node_modules/*" | while read -r node_modules_folder; do
      parent_dir=$(dirname "$node_modules_folder")

      if [[ -f "$parent_dir/package-lock.json" || -f "$parent_dir/bun.lock" ]]; then
        echo "Found: $node_modules_folder (with associated lock file in $parent_dir)"

        folder_size_bytes=$(du -sb "$node_modules_folder" 2>/dev/null | awk '{print $1}')

        if [ -z "$folder_size_bytes" ]; then
            folder_size_bytes=0
        fi

        echo "Size: $(numfmt --to=iec-i --suffix=B --padding=7 "$folder_size_bytes")"

        echo "Deleting '$node_modules_folder'..."
        # rm -rf "$node_modules_folder"
        echo "'$node_modules_folder' deleted."

        total_space_saved_bytes=$((total_space_saved_bytes + folder_size_bytes))
      else
        echo "Skipping: $node_modules_folder (no 'package-lock.json' or 'bun.lock' found in $parent_dir)"
      fi
    done

    echo ""
    echo "Scan complete."


    human_readable_space=$(numfmt --to=iec-i --suffix=B "$total_space_saved_bytes")
    echo "Total disk space saved: $human_readable_space"
''
