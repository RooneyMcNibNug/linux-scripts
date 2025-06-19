#!/usr/bin/env fish

### ASSUMES YOU ARE USING FISH SHELL!
### This script automates the installation of a bunch of basic useful applications via the pacman package manager on a fresh local Arch-based install.
### Some of these applications are already pre-installed on desktop environments but I've added them anyways for those running from a minimal environment.
### NOTE: This is best to run from wherever you want the git repos to be cloned to (ex: run this script from /home/<user>/Documents)

# Initial check to ensure run as root
if test $EUID -ne 0
    echo "~ This script must be run as root. Please restart with 'sudo'. ~" >&2
    exit 1
end

## PLEASE CHECK THE FOLLOWING VARIABLES BEFORE RUNNING:

# Path for git clones
set user "user" # put your username here!
set clonepath "/home/user/Documents"

echo "~ Installing new packages via pacman.. ~"
echo ""

# Install list of applications
sudo pacman -S --noconfirm beets btop calibre cdrdao cups flatpak gimp git ifuse keepassxc magic-wormhole nmap pdfgrep rsync scribus strawberry tenacity tor ufw vim wget yt-dlp

echo ""
echo "~ Finished installing. ~"
echo "~ Cloning git repos.. ~"
echo ""

cd $clonepath
git clone https://github.com/RooneyMcNibNug/linux-scripts
chown -R $user linux-scripts

git clone https://github.com/RooneyMcNibNug/pihole-stuff
chown -R $user pihole-stuff

git clone https://github.com/wustho/epr
chown -R $user epr

git clone https://github.com/jufabeck2202/localpdfmerger
chown -R $user localpdfmerger

git clone https://github.com/firstlookmedia/dangerzone
chown -R $user dangerzone

git clone https://github.com/SoptikHa2/desed
chown -R $user desed

git clone https://github.com/bhavsec/reconspider.git
chown -R $user reconspider

echo "~ Finished cloning repositories. ~"
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
