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
nmap \
tcpdump \
ccrypt \
tomb \
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
peek \
scribus \
ifuse"

echo "~ Upgrading current packages via dnf.. ~"
echo ""
# Update and upgrade current packages
dnf upgrade -y

echo ""
echo "~ Finished upgrading. ~"
echo "~ Installing new packages via dnf.. ~"
echo ""

# Install list of applications
dnf install -y $TO_INSTALL

echo ""
echo "~ Finished installing. ~"
echo "~ Cleaning dnf.. ~"
echo ""

# Delete cached dnf info
dnf clean all

echo "~ Finished cleaning. ~"
echo "~ Cloning git repos.. ~"
echo ""

git clone https://github.com/RooneyMcNibNug/pihole-stuff && \
git clone https://github.com/aboul3la/Sublist3r.git && \
git clone https://github.com/wustho/epr && \
git clone https://github.com/jufabeck2202/localpdfmerger && \
git clone https://github.com/asciimoo/wuzz && \
git clone https://github.com/netspooky/pdiff && \
git clone https://github.com/firstlookmedia/dangerzone && \
git clone https://github.com/svenstaro/miniserve && \
git clone https://github.com/SoptikHa2/desed

echo "~ Finished cloning. ~"
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
