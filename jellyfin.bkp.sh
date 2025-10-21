#!/bin/bash
TIME=$(date +%Y%m%d%H%M%S)
VER=$(jellyfin --version 2>&1 | awk '// {print $NF}')

systemctl stop jellyfin

# Back up the needed dirs
mkdir -p /media/backups/jellyfin.${TIME}_${VER}
cp -a /var/lib/jellyfin /media/backups/jellyfin.${TIME}_${VER}/data
cp -a /etc/jellyfin /media/backups/jellyfin.${TIME}_${VER}/config

# Optional compression of the backups for offsite
tar -czf "/media/backups/jellyfin.${TIME}_${VER}.tar.gz" -C /media/backups jellyfin.${TIME}_${VER}

systemctl start jellyfin
