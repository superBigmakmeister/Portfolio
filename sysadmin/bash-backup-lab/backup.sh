#!/usr/bin/bash

#"!/usr/bin/env bash" без кавычек

#set -euo pipefail

SOURCE_DIR="./source"
BACKUP_DIR="./backups"
LOG_FILE="./backup.log"
DATE=$(date +%Y-%m-%d)
BACKUP_NAME="backup_$DATE.tar.gz"
MAX_BACKUPS=3

#echo "Date = $DATE , Source_dir = $SOURCE_DIR , Backup_dir = $BACKUP_DIR , Log_file = $LOG_FILE"

if [ ! -d "./source" ]; then
	echo "Directory Source not found"
	exit 1
fi

tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$SOURCE_DIR" .
	
if [ $? -eq 0 ]; then
	resize_archive=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
# (-f"./BACKUP_NAME")
	echo  "[$(date '+%Y-%m-%d %H:%M:%S')] SUCCESS: Created $BACKUP_DATE ($resize_archive)" >> "$LOG_FILE"
else
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Failed to create archive" >> "$LOG_FILE"
fi

cd "$BACKUP_DIR" || exit 1
archive_list=$(ls -t *.tar.gz 2>/dev/null)
count=$(echo "$archive_list" | wc -l)
if [ $count -gt $MAX_BACKUPS ]; then
    old_archives=$(echo "$archive_list" | tail -n +$((MAX_BACKUPS+1)))
    for old in $old_archives; do
        rm "$old"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Removed old backup: $old" >> "$LOG_FILE"
    done
fi
cd - > /dev/null || exit 1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Backup process completed" >> "$LOG_FILE"
