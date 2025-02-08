#!/bin/bash

BACKUP_DIR="$HOME/AutoBackups/backups"

echo "Available Backups: "
ls -l "$BACKUP_DIR"

read -p "Enter the Backup File to Restore: " BACKUP_FILE

read -p "Enter the Restore Location (default: $HOME/RestoredFiles): " RESTORE_DIR
RESTORE_DIR=${RESTORE_DIR:-"$HOME/RestoredFiles"}

mkdir -p "$RESTORE_DIR"

tar -xzvf "$BACKUP_DIR/$BACKUP_FILE" -C "$RESTORE_DIR"

echo "Backup restored to: $RESTORE_DIR"
