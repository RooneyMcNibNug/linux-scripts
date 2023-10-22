#!/bin/bash

### I use this script to automate the installation of a bunch of basic useful applications via dnf package manager on a fresh local Debian install. 
### Some of these applications are already pre-installed on desktop environments but I've added them anyways for those running from a minimal environment.
### NOTE: This is best to run from wherever you want the git repos to be cloned to (ex: run this script from /home/<user>/Documents

# Initial check to ensure run as root
if [[ $EUID -ne 0 ]]; then
	echo "~ This script must be run as root. Please restart with 'sudo'. ~" 1>&2
	exit 1
fi

## PLEASE CHECK THE FOLLOWING VARIABLES BEFORE RUNNING:

# Path for git clones
user=user # put your username here!
clonepath=/home/user/Documents

# List of Applications
TO_INSTALL="gcc \
gdb \
curl \
lynx \
w3m \
btop \
ncdu \
sysstat \
keepassxc \
gtkhash \
wireguard-tools \
tor \
proxychains \
nmap \
tcpdump \
wget2 \
ccrypt \
age \
firefox \
thunderbird \
gnupg \
irssi \
onionshare \
nano \
vim \
emacs \
bat \
fd-find \
git-delta \
podman \
ansible \
peek \
gimp \
trimage \
binwalk \
gedit \
git \
screen \
geany \
idle3 \
libreoffice \
evince \
foliate \
pandoc \
pdfgrep \
ocrmypdf \
easyeffects \
mpv \
strawberry \
cdrdao \
abcde \
peek \
scribus \
nvme-cli \
vagrant \
ifuse \
the_silver_searcher \
rsync \
syncthing \
qflipper \
mame-tools \
arduino \
tomb \
mariadb-server \
mariadb-client"

echo "~ Upgrading already installed packages via apt.. ~"
echo ""
# Update and upgrade current packages
apt-get update -y && apt-get upgrade -y
#Remove any cruft packages
apt-get autoremove -y

echo ""
echo "~ Finished upgrading. ~"
echo "~ Installing new packages via apt.. ~"
echo ""

# Install list of applications
apt-get -y install $TO_INSTALL
apt-get -y install multimedia-all

echo ""
echo "~ Finished installing. ~"
echo "~ Installing magic-wormhole.. ~"
echo ""

pip3 install magic-wormhole

echo ""
echo "~ Finished installing. ~"
echo "~ Installing Signal Desktop.. ~"
echo ""

# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key:
wget2 -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  tee /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install Signal:
apt update -y && apt install -y signal-desktop

echo ""
echo "~ Finished installing. ~"
echo "~ Installing dbeaver.. ~"
echo ""

wget2 https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
apt-get -y ./https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

echo ""
echo "~ Finished installing. ~"
echo "~ Cloning git repos.. ~"
echo ""

cd $clonepath
git clone https://github.com/RooneyMcNibNug/pihole-stuff && chown -R $user pihole-stuff && \
git clone https://github.com/wustho/epr && chown -R $user epr && \
git clone https://github.com/jufabeck2202/localpdfmerger && chown -R $user localpdfmerger && \
git clone https://github.com/asciimoo/wuzz && chown -R $user wuzz && \
git clone https://github.com/netspooky/pdiff && chown -R $user pdiff && \
git clone https://github.com/firstlookmedia/dangerzone && chown -R $user dangerzone && \
git clone https://github.com/svenstaro/miniserve && chown -R $user miniserve && \
git clone https://github.com/SoptikHa2/desed && chown -R $user desed \

echo ""
echo "~ Finished cloning. ~"
echo "~ Installing Rust (rustup).. ~"
echo ""

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup --version

echo ""
echo "~ Finished installing. ~"
echo "~ Installing Findomain (enumerator).. ~"
echo ""

cd $clonepath
git clone https://github.com/findomain/findomain.git
chown -R $user findomain
cd findomain
cargo build --release
sudo cp target/release/findomain /usr/bin/
findomain --version

echo ""
echo "~ Finished installing. ~"
echo "~ Downloading Tor Browser.. ~"
echo ""

cd $clonepath
# check for version changes -> https://dist.torproject.org/torbrowser/
wget2 https://dist.torproject.org/torbrowser/12.5.4/tor-browser-linux64-12.5.4_ALL.tar.xz.asc
tar xvf tor-browser-linux*.tar.xz
chown -R $user tor-browser-linux*

echo ""
echo "~ Finished downloading. ~"
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
