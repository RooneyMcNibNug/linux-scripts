#!/bin/bash

### I use this script to automate the installation of a bunch of basic useful applications via dnf package manager on a fresh local Fedora install. 
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
proxychains-ng \
nmap \
tcpdump \
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
git-delta \
podman \
peek \
binwalk \
gedit \
git \
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
dnf install -y $TO_INSTALL --skip-broken

# Install extra packages for multimedia applications
dnf groupinstall multimedia -y
dnf groupupdate multimedia -y
dnf groupupdate sound-and-video -y

echo ""
echo "~ Finished installing. ~"
echo "~ Installing magic-wormhole.. ~"
echo ""

pip3 install magic-wormhole

echo ""
echo "~ Finished installing. ~"
echo "~ Installing flatpak apps.. ~"
echo ""


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.signal.Signal
flatpak install -y flathub com.vscodium.codium
flatpak install -y flathub cc.arduino.arduinoide
flatpak install -y flathub org.duckstation.DuckStation
flatpak install -y flathub com.mojang.Minecraft
flatpak install -y flathub com.makemkv.MakeMKV

echo ""
echo "~ Finished installing. ~"
echo "~ Installing MariDB/MySQL Toolset.. ~"
echo ""

# Install tools listed at https://mariadb.com/kb/en/mariadb-package-repository-setup-and-usage/
cd $clonepath
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash && sudo apt-get install -y mariadb-server mariadb-client mariadb-backup

echo ""
echo "~ Finished installing. ~"
echo "~ Installing dbeaver.. ~"
echo ""

wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo dnf -y install ./dbeaver-ce-latest-stable.x86_64.rpm --skip-broken

echo ""
echo "~ Finished installing. ~"
echo "~ Installing Terraform.. ~"
echo ""

# Install HashiCorp repo then Terraform
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform

echo ""
echo "~ Finished installing. ~"
echo "~ Cleaning dnf.. ~"
echo ""

# Delete cached dnf info
dnf clean all

echo ""
echo "~ Finished cleaning. ~"
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
echo "~ Installing tomb (Dyne).. ~"
echo ""

cd $clonepath
wget https://files.dyne.org/tomb/Tomb-2.9.tar.gz # check for version changes -> https://files.dyne.org/tomb/
tar xvfz Tomb-2.9.tar.gz
chown -R $user Tomb-2.9
cd Tomb-2.9
sudo make install

echo ""
echo "~ Finished installing. ~"
echo "~ Downloading Tor Browser.. ~"
echo ""

cd $clonepath
wget v12.0/tor-browser-linux64-12.0.2_ALL.tar.xz # check for version changes -> https://dist.torproject.org/torbrowser/
wget https://dist.torproject.org/torbrowser/12.0.2/tor-browser-linux64-12.0_ALL.tar.xz.asc
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
