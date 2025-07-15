#!/bin/bash

BACKUP_DIR="$HOME/AutoBackups/backups"
LOG_FILE="$HOME/AutoBackups/backup.log"

echo "Available Backups: "
ls -lh "$BACKUP_DIR"

read -p "Enter the Backup File to Restore: " BACKUP_FILE

read -p "Enter the Restore Location (default: $HOME/RestoredFiles): " RESTORE_DIR
RESTORE_DIR=${RESTORE_DIR:-"$HOME/RestoredFiles"}

mkdir -p "$RESTORE_DIR"
touch "$LOG_FILE"

tar -xzvf "$BACKUP_DIR/$BACKUP_FILE" -C "$RESTORE_DIR"

if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") Restore successful: $BACKUP_FILE to $RESTORE_DIR" >>"$LOG_FILE"
    echo "Backup restored to: $RESTORE_DIR"
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") Restore failed: $BACKUP_FILE" >>"$LOG_FILE"
    echo "Restore failed"
fi
