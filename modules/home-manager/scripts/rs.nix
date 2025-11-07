{pkgs}:
pkgs.writeShellScriptBin "rs" ''
  #!/bin/bash

  # Define destination for better readability
  SOURCE=$1
  DESTINATION=$2

  # Check if rsync is installed
  if ! command -v rsync &> /dev/null; then
      echo "Error: rsync is not installed."
      exit 1
  fi

  # Check if tput is available
  if ! command -v tput &> /dev/null; then
      echo "Error: tput is not installed. It's needed for terminal control."
      exit 1
  fi

  # Trap Ctrl+C to clean up the terminal
  cleanup() {
      echo "" # New line after the script finishes
      tput cnorm # Restore cursor
      exit 0
  }
  trap cleanup SIGINT

  # Hide cursor
  tput civis

  echo "Starting rsync synchronization..."
  echo "" # Placeholder for the current file line
  echo "" # Placeholder for the progress2 line

  # Get the initial cursor position for the progress bar
  # We'll put the current file on the line above
  PROGRESS_LINE=$(tput  lines)
  CURRENT_FILE_LINE=$((PROGRESS_LINE - 1))

  # Start rsync and pipe its output to a while loop
  sudo rsync -av --delete --info=progress2 "$SOURCE" "$DESTINATION" 2>&1 | \
  while IFS= read -r line; do
      # Check if the line looks like an rsync progress2 update
      if [[ "$line" =~ ^\s*[0-9,\.]+[MGK]?B\s+.*% ]]; then
          # Move cursor to the progress line, clear it, print line, move back
          tput cuu 1 # Move cursor up one line from the bottom of the screen
          tput el    # Clear to end of line
          echo "$line"
      elif [[ "$line" =~ ^[a-zA-Z0-9].* ]]; then # Looks like a file or directory name
          # Move cursor to the current file line, clear it, print line, move back
          tput cuu 2 # Move cursor up two lines from the bottom of the screen
          tput el    # Clear to end of line
          echo "Processing: $(basename "$line")"
          tput cud 1 # Move cursor down one line
      fi
  done

  cleanup # Ensure cleanup runs after rsync completes
''
