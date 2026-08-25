# Backup script with rotation and logging

## Description
This Bash script creates a compressed archive of the `source/` directory, saves it to `backups/`, and keeps only the last 3 backups. All actions are logged to `backup.log`.

## Usage
```bash
chmod +x backup.sh
./backup.sh
