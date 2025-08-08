{pkgs}:
pkgs.writeShellScriptBin "git_plog" ''
  # Define ANSI color codes
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  NC='\033[0m' # No Color

  # Check if a commit hash was provided as an argument
  if [ -z "$1" ]; then
    echo -e "$\{YELLOW}Usage: git-pretty-log.sh <commit-hash>$\{NC}"
    exit 1
  fi

  COMMIT_HASH=$1

  # Get the list of changed files and their statuses
  # M: Modified, A: Added, D: Deleted, R: Renamed, C: Copied, U: Untracked
  FILES=$(git diff-tree --no-commit-id --name-status -r "$COMMIT_HASH")

  # Iterate over each changed file
  echo "$FILES" | while IFS=$'\t' read -r status filepath; do
    case "$status" in
      M)
        COLOR=$YELLOW
        ;;
      A)
        COLOR=$GREEN
        ;;
      D)
        COLOR=$RED
        ;;
      R*) # Renamed (R followed by digits for similarity index)
        COLOR=$BLUE
        # Extract new path for renamed files
        filepath=$(echo "$filepath" | awk '{print $2}')
        ;;
      *)
        COLOR=$NC # Default for others
        ;;
    esac

    # Get a short diff summary for the file
    # Using --numstat to get insertions and deletions, then formatting it
    DIFF_SUMMARY=$(git diff "$COMMIT_HASH^" "$COMMIT_HASH" -- "$filepath" | \
                   grep -E '^\+\+\+|^\-\-\-' | \
                   head -n 2 | \
                   sed -e 's/+++ b\//++++ /' -e 's/--- a\//---- /' | \
                   tr '\n' ' ' | \
                   sed 's/ $//')

    # Pad the filepath to ensure alignment
    # You might need to adjust the padding length based on your typical file paths
    # 50 characters is a good starting point
    printf "%-50s %b| %s%b\n" "$filepath" "$COLOR" "$DIFF_SUMMARY" "$NC"
  done
''
