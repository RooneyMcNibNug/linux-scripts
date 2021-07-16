## Script to slam (force close) all currently open .tomb encrypted containers
## within a system running gnome.
#
## Activates when the lock screen is detected to be triggered after intiailly
## running this script.
#
## Requires Dyne's tomb software: https://www.dyne.org/software/tomb/ 
#
## Best paired with a key-binding such as "SUPER KEY + L" to trigger screen lock.
#
## OPSEC is your friend! 

sleep 15
#BEGIN
gdbus monitor -y -d org.freedesktop.login1 |\
 grep --line-buffered -i "LockedHint" |\
 sed -uE 's/.*LockedHint.*<(.*)>.*/\1/g' |\
(
  while true; do
    read X
     if [ "$X" = "true" ]; then
      tomb slam all #&
     fi
  done
)
