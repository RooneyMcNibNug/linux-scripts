#!/bin/bash

### I use this script to automate the installation of a bunch of basic useful applications via dnf package manager on a fresh local Fedora install. 
### Some of these applications are already pre-installed on desktop environments but I've added them anyways for those running from a minimal environment.

# Initial check to ensure run as root
if [[ $EUID -ne 0 ]]; then
	echo "~ This script must be run as root. Please restart with 'sudo'. ~" 1>&2
	exit 1
fi

# List of Applications
TO_INSTALL="gcc \
gdb \
htop \
sysstat \
wavemon \
keepassxc \
gtkhash \
tor \
proxychains \
nmap\
tcpdump \
firefox \
thunderbird \
gnupg \
ricochet \
irssi \
magic-wormhole \
onionshare \
nano \
vim \
emacs \
gedit \
git \
geany \
libreoffice \
evince \
pdfgrep \
ocrmypdf \
ffmpeg \
peek \
scribus"

# Update and upgrade current packages
dnf upgrade -y

# Install list of applications
dnf install -y $TO_INSTALL

echo ""
echo "~ Finished installing. ~"
echo "~ Cleaning.. ~"
echo ""

# Delete cached dnf info
dnf clean all

echo "~ Finished cleaning. ~"
echo ""
echo "

 ________________________
 |All done,              |
 |enjoy your new software|
 ------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||"
