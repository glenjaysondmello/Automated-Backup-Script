Here's the **updated `README.md`** file that reflects your improved, secure, and feature-rich **AutoBackup Pro** project with encryption, logging, GUI menus, email alerts, retention policy, and Google Drive integration readiness:

---

# 🚀 AutoBackup Pro — Encrypted Backup & Restore Toolkit

AutoBackup Pro is a **secure, automated Bash-based backup and restore utility** with optional email alerts, retention control, encryption using GPG, and an intuitive terminal-based menu powered by `whiptail`.

## 🔒 Features

* **Encrypted Backups** (`.tar.gz.gpg`) using GPG symmetric encryption.
* **Interactive TUI Menu** with options to Backup, Restore, or View Logs.
* **Auto Logging** of backup/restore operations.
* **Email Notifications** on success/failure.
* **Retention Policy**: Auto-deletes oldest backups beyond the max allowed.
* **One-Command Installer**: Easily install as a global command (`autobackup`).
* **Restore Interface**: Browse and decrypt backups safely.

## ✅ Prerequisites

* Linux/macOS or WSL
* `bash`, `gpg`, `tar`, `whiptail`, `mailutils`, and optionally `rclone` for cloud
* SMTP configured (`ssmtp` or `msmtp`) for email alerts

## 📦 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/glenjaysondmello/Automated-Backup-Script.git
   cd Automated-Backup-Script
   ```

2. Make all scripts executable:

   ```bash
   chmod +x *.sh
   ```

3. Configure your `.env` file:

   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

4. Install globally:

   ```bash
   ./install.sh
   ```

   ✅ Now you can run it from anywhere using:

   ```bash
   autobackup
   ```

To uninstall:

```bash
./uninstall.sh
```

## 🛠 .env Configuration Example

```env
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/AutoBackups/backups"
LOG_FILE="$HOME/AutoBackups/backup.log"
MAX_BACKUPS=5
ENCRYPTION_PASSPHRASE="MyStrongPassword123!"
EMAIL="youremail@example.com"
```

## 📂 Usage

### 📁 Backup

```bash
autobackup
# Or directly:
./autoBackup.sh
```

Creates encrypted `.tar.gz.gpg` backup of `$SOURCE_DIR`, logs the result, and emails you.

### 🔄 Restore

```bash
./restore.sh
```

* Choose an encrypted `.gpg` file
* Specify (or accept default) restore location
* Decrypts and extracts

### 📜 View Logs

From menu:

```bash
autobackup → View Backup Log
```

Or directly:

```bash
cat "$LOG_FILE"
```

## 📑 Sample Scripts

### 🔐 `autoBackup.sh` (Encrypted Backup with Retention)

```bash
tar -czvf - -C "$SOURCE_DIR" . | \
gpg --symmetric --batch --passphrase "$ENCRYPTION_PASSPHRASE" -o "$BACKUP_DIR/$ENCRYPTED_FILE"
```

* Sends success/failure emails
* Prunes old backups based on `MAX_BACKUPS`

### 🔓 `restore.sh`

```bash
gpg --batch --yes --passphrase "$ENCRYPTION_PASSPHRASE" -d "$BACKUP_DIR/$ENCRYPTED_FILE" | \
tar -xzv -C "$RESTORE_DIR"
```

### 📋 `menu.sh`

`whiptail` GUI lets you:

* Backup
* Restore
* View logs
* Exit

## ☁️ Optional Cloud Support

You can use [`rclone`](https://rclone.org) to upload backups to:

* Google Drive
* Dropbox
* OneDrive
* S3, etc.

Example command:

```bash
rclone copy "$BACKUP_DIR/$ENCRYPTED_FILE" remote:backups --log-file="$LOG_FILE"
```

> ⚠️ If distributing this script to others, avoid hardcoding sensitive `client_id` or secrets. Guide users to configure their own remotes using `rclone config`.

## ⏰ Automation with `cron`

Schedule a daily backup:

```bash
crontab -e
```

Add:

```bash
0 0 * * * /usr/local/bin/autobackup
```

## 🧪 Example Structure

**Before Backup**

```
~/Documents/
├── file1.txt
└── Notes/
    └── note.md
```

**After Backup**

```
~/AutoBackups/backups/
└── backup_2025-07-31_22-45-00.tar.gz.gpg
```

**After Restore**

```
~/RestoredFiles/
├── file1.txt
└── Notes/
    └── note.md
```

## 🙌 Contributing

Contributions welcome! Ideas:

* GUI version (Zenity)
* Incremental backups
* Cloud sync options
* Password prompts with confirmation

## 📜 License

MIT License

## 👤 Author

**Glen Jayson D'Mello**
GitHub: [glenjaysondmello](https://github.com/glenjaysondmello)

---

Would you like this saved as a `README.md` file now?
