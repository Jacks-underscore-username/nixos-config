{pkgs}:
pkgs.writeShellScriptBin "watchBuffer" ''
  format_bytes() {
    local num=$1
    if (( $(${pkgs.bc}/bin/bc -l <<< "$num > 1024 * 1024 * 1024") )); then
      ${pkgs.coreutils}/bin/printf "%.2fG" "$(${pkgs.bc}/bin/bc -l <<< "scale=2; $num / (1024*1024*1024)")"
    elif (( $(${pkgs.bc}/bin/bc -l <<< "$num > 1024 * 1024") )); then
      ${pkgs.coreutils}/bin/printf "%.2fM" "$(${pkgs.bc}/bin/bc -l <<< "scale=2; $num / (1024*1024)")"
    elif (( $(${pkgs.bc}/bin/bc -l <<< "$num > 1024") )); then
      ${pkgs.coreutils}/bin/printf "%.2fK" "$(${pkgs.bc}/bin/bc -l <<< "scale=2; $num / 1024")"
    else
      ${pkgs.coreutils}/bin/printf "%sB" "$num"
    fi
  }
  export -f format_bytes

  # The main watch command
  ${pkgs.watch}/bin/watch -n1 '
    echo "--- Memory Buffers ---"
    ${pkgs.gnugrep}/bin/grep -E "(Dirty|Writeback)" /proc/meminfo | \
      ${pkgs.gawk}/bin/awk '"'"'{print $1 " " ENVIRON["format_bytes"]($2 * 1024)}'"'"'

    echo -e "\n--- Disk I/O (sectors) ---"
    for device in $(${pkgs.coreutils}/bin/ls /sys/block/); do
      if [ -r "/sys/block/$device/stat" ]; then
        stats=$(${pkgs.gawk}/bin/awk '"'"'{print $3, $7, $11}'"'"' "/sys/block/$device/stat")

        read_sectors=$(echo "$stats" | ${pkgs.gawk}/bin/awk '"'"'{print $1}'"'"')
        write_sectors=$(echo "$stats" | ${pkgs.gawk}/bin/awk '"'"'{print $2}'"'"')
        total_io_time=$(echo "$stats" | ${pkgs.gawk}/bin/awk '"'"'{print $3}'"'"')

        if [ "$read_sectors" -gt 0 ] || [ "$write_sectors" -gt 0 ]; then
          ${pkgs.coreutils}/bin/printf "%s: Read: %s sectors, Write: %s sectors, I/O Time: %sms\n" \
            "$device" "$read_sectors" "$write_sectors" "$total_io_time"
        fi
      fi
    done
  '
''
