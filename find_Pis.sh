## One-liner for finding any raspberry pi's (with unspoofed MAC) on the network.
## you need nmap for scanning and awk for filtering (outputs IPs here).
sudo nmap -sP 192.168.1.0/24 | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}'
