#!/bin/bash

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"
LOG_FILE="$HOME/AutoBackups/backup.log"

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