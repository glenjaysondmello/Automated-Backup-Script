#!/bin/bash

source .env

echo "Available Backups: "
ls -lh "$BACKUP_DIR"

read -p "Enter the Encrypted Backup File to Restore: " ENCRYPTED_FILE

read -p "Enter the Restore Location (default: $HOME/RestoredFiles): " RESTORE_DIR
RESTORE_DIR=${RESTORE_DIR:-"$HOME/RestoredFiles"}

mkdir -p "$RESTORE_DIR"

gpg --batch --yes --passphrase "$ENCRYPTION_PASSPHRASE" -d "$BACKUP_DIR/$ENCRYPTED_FILE" | tar -xzv -C "$RESTORE_DIR"
# tar -xzvf "$BACKUP_DIR/$BACKUP_FILE" -C "$RESTORE_DIR"

if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") Restore successful: $ENCRYPTED_FILE to $RESTORE_DIR" >>"$LOG_FILE"
    echo "Backup restored to: $RESTORE_DIR"
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") Restore failed: $ENCRYPTED_FILE" >>"$LOG_FILE"
    echo "Restore failed"
fi
