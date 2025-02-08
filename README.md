# Automated Backup Script

This is a simple **Bash script** that automatically backs up files from a source directory to a backup location. The script compresses the contents into a timestamped `.tar.gz` archive.

## Features
- Automates the backup process.
- Saves backups in a structured folder with timestamps.
- Excludes the source directory itself and only archives its contents.
- Ensures the backup directory exists before running.

## Prerequisites
Make sure you have the following installed:
- **Linux/macOS** (or Windows with WSL)
- **Bash Shell**
- `tar` command-line utility

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/glenjaysondmello/Automated-Backup-Script.git
   cd backup-script
   ```
2. Give execute permissions to the script:
   ```bash
   chmod +x backup.sh
   ```

## Usage
Run the script using:
```bash
./backup.sh
```

## Script Breakdown
```bash
#!/bin/bash

# Define source and backup directories
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"

# Generate a timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Archive only the contents of SOURCE_DIR, not the directory itself
tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

# Print confirmation
echo "Backup Completed: $BACKUP_DIR/$BACKUP_FILE"
```

### Key Points:
- `mkdir -p "$BACKUP_DIR"` → Creates the backup directory if it doesn't exist.
- `tar -czvf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .` → Compresses only the contents, not the directory itself.
- `TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")` → Generates a unique timestamp for each backup.

## Example Directory Structure
### Before Running the Script:
```
~/Documents
├── file1.txt
├── file2.pdf
└── Projects/
    ├── project1.txt
    └── project2.docx
```

### After Running the Script:
```
~/AutoBackups/backups/
└── backup_2025-02-09_12-30-00.tar.gz
```

### When Extracted:
```bash
tar -xzvf backup_2025-02-09_12-30-00.tar.gz
```
Results in:
```
file1.txt
file2.pdf
Projects/
  ├── project1.txt
  └── project2.docx
```

## Contributing
Feel free to fork this project and improve it by adding new features like:
- Automatic scheduling with `cron` jobs.
- Incremental backups.
- Cloud storage support (Google Drive, AWS S3, etc.).

## License
This project is licensed under the **MIT License**.

## Author
**Your Name**  
GitHub: [glenjaysondmello](https://github.com/glenjaysondmello)
