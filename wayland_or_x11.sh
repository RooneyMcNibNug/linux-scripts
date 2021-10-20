## Oneliner to simply show if you are currently using wayland or X11

loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}'
