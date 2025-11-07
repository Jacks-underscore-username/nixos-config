{pkgs}:
pkgs.writeShellScriptBin "denode" ''
  target_directory=/persist/code

  echo "Searching for 'node_modules' folders with associated lock files in '$target_directory'..."

  total_space_saved_bytes=0

  # Use process substitution to avoid the subshell issue
  while read -r node_modules_folder; do
      parent_dir=$(dirname "$node_modules_folder")

      if [[ -f "$parent_dir/package-lock.json" || -f "$parent_dir/bun.lock" ]]; then
        folder_size_bytes=$(du -sb "$node_modules_folder" 2>/dev/null | awk '{print $1}')

        if [ -z "$folder_size_bytes" ]; then
            folder_size_bytes=0
        fi

        echo "Deleting '$node_modules_folder'..."
         rm -rf "$node_modules_folder"

        total_space_saved_bytes=$((total_space_saved_bytes + folder_size_bytes))
      fi
  done < <(find "$target_directory" -type d -name "node_modules" -not -path "*/node_modules/*")

  echo ""
  echo "Scan complete."

  human_readable_space=$(numfmt --to=iec-i --suffix=B "$total_space_saved_bytes")
  echo "Total disk space saved: $human_readable_space"
''
