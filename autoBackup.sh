#!/bin/bash

source .env

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
ENCRYPTED_FILE="$BACKUP_FILE.gpg"

mkdir -p "$BACKUP_DIR"
touch "$LOG_FILE"

# tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .
tar -czvf - -C "$SOURCE_DIR" . | gpg --symmetric --batch --passphrase "$ENCRYPTION_PASSPHRASE" -o "$BACKUP_DIR/$ENCRYPTED_FILE"

if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H-%M-%S") Backup Successful: $ENCRYPTED_FILE" >>"$LOG_FILE"
    echo "Encrypted backup completed: $ENCRYPTED_FILE"

    echo "AutoBackup Pro successfully created $ENCRYPTED_FILE" | \
    mail -s "AutoBackup Pro: Backups Succcessful - $ENCRYPTED_FILE" "$EMAIL"
else
    echo "$(date +"%Y-%m-%d %H-%M-%S") Encryption backup Failed: $BACKUP_FILE" >>"$LOG_FILE"
    echo "Encryption backup failed"
    
    echo "AutoBackup Pro failed to create a backup at $TIMESTAMP" | \
    mail -s "AutoBackup Pro: Backup Failed" "$EMAIL"
fi

BACKUP_COUNT=$(ls -1 $BACKUP_DIR/*.gpg 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    echo "Retention policy: Found $BACKUP_COUNT backups, removing old ones..."
    OLD_BACKUPS=$(ls -1t $BACKUP_DIR/*.gpg | tail -n +$((MAX_BACKUPS + 1)))

    for file in $OLD_BACKUPS; do
        rm -f "$file"
        echo "$(date +"%Y-%m-%d %H:%M:%S") Old backup removed: $(basename "$file")" >> "$LOG_FILE"
        echo "Removed old backup: $(basename "$file")"
    done
else
    echo "Retention policy: $BACKUP_COUNT backups present, within limit ($MAX_BACKUPS)."
fi