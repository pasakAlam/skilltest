#!/bin/bash
set -e

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="$LOG_DIR/archive"
ACTION_LOG="$LOG_DIR/logrotate_action.log"
MAX_SIZE=$((5 * 1024 * 1024))  # 5 MB

mkdir -p "$ARCHIVE_DIR"

for file in "$LOG_DIR"/*.log; do
  [ -e "$file" ] || continue  # Skip if no .log files found

  size=$(stat -c%s "$file")
  if [ "$size" -gt "$MAX_SIZE" ]; then
    timestamp=$(date +"%Y%m%d_%H%M%S")
    filename=$(basename "$file")
    archive_file="$ARCHIVE_DIR/${filename}_${timestamp}.gz"

    # Archive the file
    gzip -c "$file" > "$archive_file"

    # Truncate original file
    : > "$file"

    # Log the action
    echo "$(date): Archived and truncated $file as $archive_file" >> "$ACTION_LOG"
  fi
done