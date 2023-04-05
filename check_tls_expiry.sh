#!/bin/bash

## Quick check on domain/port for when the TLS expires - nothing fancy, just nice to have in terminal
## and just long enough of an openssl one-liner to do more manually than this.

echo "What domain do you want to check against? [ex: jojamart.com]" 

read DOM

echo "What port for the domain? [ex: 443]"

read PORT

echo | openssl s_client -servername "$DOM" -connect "$DOM:$PORT" | openssl x509 -noout -dates
