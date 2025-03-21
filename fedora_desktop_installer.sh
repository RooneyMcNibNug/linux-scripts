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
tmux \
lynx \
w3m \
btop \
ncdu \
sysstat \
keepassxc \
gtkhash \
wireguard-tools \
tor \
onionscan \
proxychains-ng \
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
python3-pip \
bat \
fd-find \
git-delta \
podman \
ansible \
gimp \
trimage \
peek \
binwalk \
gedit \
git \
screen \
geany \
idle3 \
libreoffice \
evince \
calibre \
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
dnf group install multimedia -y

echo ""
echo "~ Finished installing. ~"
echo "~ Installing Mullvad Browser via dnf.. ~"
echo ""

dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
dnf upgrade -y
dnf install -y mullvad-browser --skip-broken

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
#flatpak install -y fedora org.kde.kate
flatpak install -y flathub cc.arduino.arduinoide
flatpak install -y flathub org.duckstation.DuckStation
flatpak install -y flathub com.mojang.Minecraft
flatpak install -y flathub com.makemkv.MakeMKV
flatpak install -y org.tenacityaudio.Tenacity
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub io.github.seadve.Kooha
flatpak install -y flathub org.kde.kdenlive
flatpak install -y flathub com.spotify.Client

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
git clone https://github.com/SoptikHa2/desed && chown -R $user desed && \
git clone https://github.com/bhavsec/reconspider.git && chown -R $user reconspider \

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
wget2 https://files.dyne.org/tomb/Tomb-2.10.tar.gz # check for version changes -> https://files.dyne.org/tomb/
tar xvfz Tomb-2.10.tar.gz
chown -R $user Tomb-2.9
cd Tomb-2.10
sudo make install

echo ""
echo "~ Finished installing. ~"
echo "~ Downloading Tor Browser.. ~"
echo ""

cd $clonepath
# check for version changes -> https://dist.torproject.org/torbrowser/
# Follow https://support.torproject.org/tbb/how-to-verify-signature/ to verify sig
wget2 https://dist.torproject.org/torbrowser/13.0.14/tor-browser-linux-x86_64-13.0.14.tar.xz
wget2 https://dist.torproject.org/torbrowser/13.0.14/tor-browser-linux-x86_64-13.0.14.tar.xz.asc
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
