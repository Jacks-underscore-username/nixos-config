{pkgs}:
pkgs.writeShellScriptBin "watchBuffer" ''
  format_bytes() {
    local bytes=$1
    local KILOBYTE=1024
    local MEGABYTE=$((KILOBYTE * 1024))
    local GIGABYTE=$((MEGABYTE * 1024))

    if (( bytes >= GIGABYTE )); then
      printf "%.2fG" "$(echo "scale=2; $bytes / $GIGABYTE" | bc)"
    elif (( bytes >= MEGABYTE )); then
      printf "%.2fM" "$(echo "scale=2; $bytes / $MEGABYTE" | bc)"
    elif (( bytes >= KILOBYTE )); then
      printf "%.2fK" "$(echo "scale=2; $bytes / $KILOBYTE" | bc)"
    else
      printf "%sB" "$bytes"
    fi
  }
  export -f format_bytes

  watch -n1 '
    echo "--- Memory Buffers ---"
    grep -E "(Dirty|Writeback)" /proc/meminfo | while read -r line; do
      value=$(echo "$line" | awk "{print \$2}")
      unit=$(echo "$line" | awk "{print \$3}")
      printf "%s %s\n" "$(echo "$line" | cut -d: -f1):" "$(format_bytes $((value * 1024)))"
    done
    echo

    echo "--- Disk I/O (Write Sectors) ---"
    ls /sys/block/ | while read -r device; do
      stat_file="/sys/block/$device/stat"
      if [ -f "$stat_file" ]; then
        write_sectors=$(awk "{print \$7}" "$stat_file")
        if [ -n "$write_sectors" ]; then
          printf "%s: %s\n" "$device" "$(format_bytes $((write_sectors * 512)))"
        fi
      fi
    done
  '
''
