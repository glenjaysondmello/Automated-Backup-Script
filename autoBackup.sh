#!/bin/bash

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"
LOG_FILE="$HOME/AutoBackups/backup.log"

MAX_BACKUPS=5

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"
touch "$LOG_FILE"

tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H-%M-%S") Backup Successful: $BACKUP_FILE" >>"$LOG_FILE"
    echo "Backup completed: $BACKUP_FILE"
else
    echo "$(date +"%Y-%m-%d %H-%M-%S") Backup Failed: $BACKUP_FILE" >>"$LOG_FILE"
    echo "Backup failed"
fi

BACKUP_COUNT=$(ls -1 $BACKUP_DIR/*.tar.gz 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    echo "Retention policy: Found $BACKUP_COUNT backups, removing old ones..."
    OLD_BACKUPS=$(ls -1t $BACKUP_DIR/*.tar.gz | tail -n +$((MAX_BACKUPS + 1)))

    for file in $OLD_BACKUPS; do
        rm -f "$file"
        echo "$(date +"%Y-%m-%d %H:%M:%S") Old backup removed: $(basename "$file")" >> "$LOG_FILE"
        echo "Removed old backup: $(basename "$file")"
    done
else
    echo "Retention policy: $BACKUP_COUNT backups present, within limit ($MAX_BACKUPS)."
fi