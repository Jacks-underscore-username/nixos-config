{pkgs}:
pkgs.writeShellScriptBin "watchBuffer" ''
  ${pkgs.watch}/bin/watch -n1 '
    echo "--- Memory Buffers ---"
    ${pkgs.gnugrep}/bin/grep -E "(Dirty|Writeback|WritebackTmp)" /proc/meminfo | \
      ${pkgs.gawk}/bin/awk '"'"'{
        printf "%s", $1; # Print the key (e.g., Dirty:)
        num_bytes = $2 * 1024;
        if (num_bytes > 1024 * 1024 * 1024) {
          printf " %.2fG\n", num_bytes / (1024*1024*1024);
        } else if (num_bytes > 1024 * 1024) {
          printf " %.2fM\n", num_bytes / (1024*1024);
        } else if (num_bytes > 1024) {
          printf " %.2fK\n", num_bytes / 1024;
        } else {
          printf " %sB\n", num_bytes;
        }
      }'"'"'

    echo -e "\n--- Disk I/O (Cumulative) ---"

    for device in $(${pkgs.coreutils}/bin/ls -1 /sys/block/); do
      if [[ "$device" == "loop"* ]]; then
        continue
      fi

      if [ -r "/sys/block/$device/stat" ]; then
        stats=$(${pkgs.gawk}/bin/awk -v dev_name="$device" '"'"'{
          rd_sectors=$3;
          wr_sectors=$7;
          io_ticks=$10; # This is total I/O time in milliseconds

          rd_bytes = rd_sectors * 512;
          wr_bytes = wr_sectors * 512;

          printf "%s: ", dev_name;

          if (rd_bytes > 1024 * 1024 * 1024) {
            printf "Read: %.2fG ", rd_bytes / (1024*1024*1024);
          } else if (rd_bytes > 1024 * 1024) {
            printf "Read: %.2fM ", rd_bytes / (1024*1024);
          } else if (rd_bytes > 1024) {
            printf "Read: %.2fK ", rd_bytes / 1024;
          } else {
            printf "Read: %sB ", rd_bytes;
          }

          if (wr_bytes > 1024 * 1024 * 1024) {
            printf "Write: %.2fG ", wr_bytes / (1024*1024*1024);
          } else if (wr_bytes > 1024 * 1024) {
            printf "Write: %.2fM ", wr_bytes / (1024*1024);
          } else if (wr_bytes > 1024) {
            printf "Write: %.2fK ", wr_bytes / 1024;
          } else {
            printf "Write: %sB ", wr_bytes;
          }

          printf "I/O Time: %.2fs\n", io_ticks / 1000;
        }'"'"' "/sys/block/$device/stat")

        if [ -n "$stats" ]; then
          echo "$stats"
        fi
      fi
    done
  '
''
