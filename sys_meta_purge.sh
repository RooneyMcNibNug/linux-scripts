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

## Tools required: shred, ...

for i in {160..164} {164..160} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo; echo -e "\E[31m WARNING:" ; for i in {160..164} {164..160} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo
echo -e "\E[31mThis will permantly delete several system/user logs and session data."
echo -e "\E[31mPlease make sure you review the code before running and comment out unwanted jobs."
echo -e "\E[31mThis script needs to run as root."

read -p "Press enter to continue."

echo -e "\e[92m[+] Cleaning Firefox cookies, cache, session(s)..."
# shred -fun 1 ~/.mozilla/firefox/*.default/cookies.sqlite
# shred -fun 1 ~/.mozilla/firefox/*.default/*.sqlite ~/.mozilla/firefox/*default/sessionstore.js
# shred -fun 1 ~/.cache/mozilla/firefox/*.default/*
echo "Done."

echo -e "[+] Cleaning Nautilus recent files list..."
# shred -fun 1 ~/.local/share/recently-used.xbel
echo "Done."

echo -e "[+] Clearing journalctl..."
# journalctl --flush
# journalctl --vacuum-size=1G --vacuum-time=5d --vacuum-files=5
echo "Done."

echo -e "[+] Clearing /var/log/syslog(s)..." 
# truncate -s 0 /var/log/syslog*
# shred -fun 1 /var/log/syslog.*.gz
echo "Done."

echo -e "[+] Clearing /var/log/user.log(s)..."
# truncate -s 0 /var/log/user.log*
# shred -fun 1 /var/log/user.log.*.gz
echo "Done."

echo -e "[+] Clearing /var/log/auth.log(s)..."
# truncate -s 0 /var/log/auth.log*
# shred -fun 1 /var/log/auth.log.*.gz
echo "Done."

echo -e "[+] Clearing /var/log/tor/*..."
# truncate -s 0 /var/log/tor/log*
# shred -fun 1 /var/log/tor/log.*.gz
echo "Done."

echo -e "[+] Clearing user login logs..."
# truncate -s 0 /var/log/btmp*
# truncate -s 0 /var/log/lastlog*
# truncate -s 0 /var/log/wtmp*
echo "Done."

# echo -e "[+] Clearing .ssh known_hosts..."
# truncate -s 0 ~/.ssh/known_hosts
# echo "Done."

echo -e "[+] Clearing bash history"
# history -c
echo "Done."
