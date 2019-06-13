\\#!/bin/bash

echo -n $'\E[31m'
echo $''
echo $'@@@@@@@@@@   @@@@@@@@  @@@@@@@   @@@@@@   @@@@@@@    @@@@@@   @@@@@@@   @@@@@@      @@@@@@@   @@@  @@@  @@@@@@@    @@@@@@@@  @@@@@@@@  '
echo $'@@@@@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@@     @@@@@@@@  @@@  @@@  @@@@@@@@  @@@@@@@@@  @@@@@@@@  '
echo $'@@! @@! @@!  @@!         @@!    @@!  @@@  @@!  @@@  @@!  @@@    @@!    @@!  @@@     @@!  @@@  @@!  @@@  @@!  @@@  !@@        @@!       '
echo $'!@! !@! !@!  !@!         !@!    !@!  @!@  !@!  @!@  !@!  @!@    !@!    !@!  @!@     !@!  @!@  !@!  @!@  !@!  @!@  !@!        !@!       '
echo $'@!! !!@ @!@  @!!!:!      @!!    @!@!@!@!  @!@  !@!  @!@!@!@!    @!!    @!@!@!@!     @!@@!@!   @!@  !@!  @!@!!@!   !@! @!@!@  @!!!:!    '
echo $'!@!   ! !@!  !!!!!:      !!!    !!!@!!!!  !@!  !!!  !!!@!!!!    !!!    !!!@!!!!     !!@!!!    !@!  !!!  !!@!@!    !!! !!@!!  !!!!!:    '
echo $'!!:     !!:  !!:         !!:    !!:  !!!  !!:  !!!  !!:  !!!    !!:    !!:  !!!     !!:       !!:  !!!  !!: :!!   :!!   !!:  !!:       '
echo $':!:     :!:  :!:         :!:    :!:  !:!  :!:  !:!  :!:  !:!    :!:    :!:  !:!     :!:       :!:  !:!  :!:  !:!  :!:   !::  :!:       '
echo $':::     ::    :: ::::     ::    ::   :::   :::: ::  ::   :::     ::    ::   :::      ::       ::::: ::  ::   :::   ::: ::::   :: ::::  '
echo $' :      :    : :: ::      :      :   : :  :: :  :    :   : :     :      :   : :      :         : :  :    :   : :   :: :: :   : :: ::   '
echo $''

## Tools required: shred, tct-utils, ...

for i in {160..164} {164..160} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo; echo -e "\E[31m WARNING:" ; for i in {160..164} {164..160} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo
echo -e "\E[31mThis will permantly delete several system/user logs and session data."
echo -e "\E[31mPlease make sure you review the code before running and comment out unwanted jobs."
echo -e "\E[31mThis script needs to run as root."

read -p "Press enter to continue."

echo -e "\e[92m[i] Clearing System Security Services Daemon (SSSD)..."
# systemctl stop sssd
# shred -fun 2 /var/lib/sss/db/*
# systemctl restart sssd
# sss_cache -E
echo "Done."

echo -e "\e[92m[i] Cleaning Firefox cookies, cache, session(s)..."
# shred -fun 2 ~/.mozilla/firefox/*.default/cookies.sqlite
# shred -fun 2 ~/.mozilla/firefox/*.default/*.sqlite ~/.mozilla/firefox/*default/sessionstore.js
# shred -fun 2 ~/.cache/mozilla/firefox/*.default/*
echo "Done."

echo -e "[i] Cleaning Chromium cache..."
# shred -fun 2 /home/$USER/.cache/chromium/Default/Cache/*
# shred -fun 2 /home/$USER/.cache/chromium/Default/Code Cache/js/*
echo "Done."

echo -e "[i] Cleaning Nautilus recent files list..."
# shred -fun 2 ~/.local/share/recently-used.xbel
# shred -fun 2 ~/.local/share/gvfs-metadata/*
echo "Done."

echo -e "[i] Clearing journalctl..."
# journalctl --flush
# journalctl --vacuum-size=1G --vacuum-time=5d --vacuum-files=5
echo "Done."

echo -e "[i] Clearing /var/log/syslog(s)..." 
# truncate -s 0 /var/log/syslog*
# shred -fun 2 /var/log/syslog.*.gz
echo "Done."

echo -e "[i] Clearing /var/log/user.log(s)..."
# truncate -s 0 /var/log/user.log*
# shred -fun 2 /var/log/user.log.*.gz
echo "Done."

echo -e "[i] Clearing /var/log/auth.log(s)..."
# truncate -s 0 /var/log/auth.log*
# shred -fun 2 /var/log/auth.log.*.gz
echo "Done."

echo -e "[i] Clearing /var/log/mail*ils..."
# truncate -s 0 /var/log/mail.*
# truncate -s 0 /var/log/maillog
echo "Done."

echo -e "[i] Clearing /var/log/tor/*..."
# truncate -s 0 /var/log/tor/log*
# shred -fun 2 /var/log/tor/log.*.gz
echo "Done."

echo -e "[i] Clearing user login logs..."
# truncate -s 0 /var/log/btmp*
# truncate -s 0 /var/log/lastlog*
# truncate -s 0 /var/log/wtmp*
echo "Done."

# echo -e "[i] Clearing .ssh known_hosts..."
# truncate -s 0 ~/.ssh/known_hosts
echo "Done."

echo -e "[i] Clearing USB cache buffer..."
# echo 3 > /proc/sys/vm/drop_caches
echo "Done."

echo -e "[i] Clearing dmesg..."
# dmesg -c
echo "Done."

echo -e "[i] Emptying Trash..."
# truncate -s 0 ~/.local/share/Trash/files 
# truncate -s 0~/.local/share/Trash/info
echo "Done."

echo -e "[i] Clearing bash history"
# truncate -s 0 /home/$USER/.bash_history
# history -c
echo "Done."
