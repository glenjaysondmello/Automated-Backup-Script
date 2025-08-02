# Automated Backup & Restore Script

This project contains Bash scripts for automating file backups and restoration. The **autobackup.sh** script creates compressed backups of a directory, while **restore.sh** allows users to restore a selected backup to a specified location.

## Features
- **Automated Backup:** Archives files into a timestamped `.tar.gz` file.
- **Backup Storage:** Saves backups in a structured folder.
- **Easy Restore:** Lists available backups and allows restoring them to a user-defined location.
- **Ensures Directories Exist:** Automatically creates missing directories before backup or restoration.

## Prerequisites
- Linux/macOS (or Windows with WSL)
- Bash Shell
- `tar` utility

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/glenjaysondmello/Automated-Backup-Script.git
   cd Automated-Backup-Script
   ```
2. Grant execution permissions:
   ```bash
   chmod +x autobackup.sh restore.sh
   ```

## Usage
### Running the Backup Script (`autobackup.sh`)
```bash
./autobackup.sh
```
This will create a backup of `~/Documents/` and save it to `~/AutoBackups/backups/` as a `.tar.gz` file.

### Running the Restore Script (`restore.sh`)
```bash
./restore.sh
```
- Lists all available backups.
- Prompts the user to select a backup file.
- Prompts for the restore location (default: `~/RestoredFiles`).
- Extracts the backup contents into the restore location.

## Script Breakdown
### **autobackup.sh**
```bash
#!/bin/bash

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

echo "Backup Completed: $BACKUP_DIR/$BACKUP_FILE"
```

### **restore.sh**
```bash
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
```

## Example Directory Structure
### Before Running the Script:
```
~/Documents/
├── file1.txt
├── file2.pdf
└── Projects/
    ├── project1.txt
    └── project2.docx
```

### After Running the Backup Script:
```
~/AutoBackups/backups/
└── backup_2025-02-09_12-30-00.tar.gz
```

### After Restoring the Backup:
```
~/RestoredFiles/
├── file1.txt
├── file2.pdf
└── Projects/
    ├── project1.txt
    └── project2.docx
```

## Automating with `cron`
To schedule automatic backups, use `cron`:
1. Open the cron editor:
   ```bash
   crontab -e
   ```
2. Add the following line to run the backup daily at midnight:
   ```bash
   0 0 * * * /path/to/autobackup.sh
   ```

## Contributing
Enhancements like cloud storage integration (Google Drive, AWS S3) or incremental backups are welcome. Feel free to fork and improve this script.

## License
MIT License

## Author
**Your Name**  
GitHub: [glenjaysondmello](https://github.com/glenjaysondmello)

