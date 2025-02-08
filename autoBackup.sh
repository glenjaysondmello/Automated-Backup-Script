#!/bin/bash

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

echo "Backup Completed: $BACKUP_DIR/$BACKUP_FILE"
