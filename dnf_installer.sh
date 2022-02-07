#!/bin/bash

### I use this script to automate the installation of a bunch of basic useful applications via dnf package manager on a fresh local Fedora install. 
### Some of these applications are already pre-installed on desktop environments but I've added them anyways for those running from a minimal environment.
### NOTE: This is best to run from wherever you want the git repos to be cloned to (ex: run this script from /home/<user>/Documents

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
podman \
peek \
gedit \
git \
geany \
idle3 \
libreoffice \
evince \
pdfgrep \
ocrmypdf \
peek \
scribus \
nvme-cli \
ifuse \
dnf-plugins-core"

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

echo ""
echo "~ Installing MariDB/MySQL Toolset.. ~"
echo ""

# Install tools listed at https://mariadb.com/kb/en/mariadb-package-repository-setup-and-usage/
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash && sudo apt-get install -y mariadb-server mariadb-client mariadb-backup

echo "~ Finished installing. ~"

echo ""
echo "~ Installing Terraform.. ~"
echo ""

# Install HashiCorp repo then Terraform
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform

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
echo "~ Installing Rust (rustup).. ~"
echo ""

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup --version

echo "~ Finished installing. ~"
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
