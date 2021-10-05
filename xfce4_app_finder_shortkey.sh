## I got tired of not having a shortkey for the Application Finder in XFCE4 by default & wanted a quick oneliner
## to get this done. Superkey (solely) binds to opening App FInder after running this script.

xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/Super_L" --create --type string --set "xfce4-appfinder"
