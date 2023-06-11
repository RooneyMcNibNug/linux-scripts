#!/bin/bash

### Quick script to back up needed stuff (besides dotfiles) from a Debain install before an upgrade to the latest ver.
### ex: "bullseye" > "bookworm" 

# Define backup path
read -p "Enter the (full) desired backup path: " bkp_path

time=$(date +%Y%m%d%H%M%S)

bkp_dir="$bkp_path/backup_$time"
mkdir -p "$bkp_dir"

# Backup directories
cp -R /etc "$bkp_dir"
cp -R /var/lib/dpkg "$bkp_dir"
cp -R /var/lib/apt/extended_states "$bkp_dir"

# Backup dpkg selections
dpkg --get-selections '*' > "$bkp_dir/dpkg_selections.txt"

echo "Backup completed successfully. The backup is located at: $bkp_dir"
