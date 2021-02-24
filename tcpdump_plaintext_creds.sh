# One-liner for when I need to do a network scan for plaintext creds

tcpdump -n -A -s0 port http or port ftp or port smtp or port imap or  port pop3 | egrep -i 'pass=|pwd=|log=|login=|user=|username=|usr=|pw=|passw=|Passwd=|password=|pass:|user:|usr:|username:|password:|log in:|pass |password |user |' --color=auto --line-buffered -B20
