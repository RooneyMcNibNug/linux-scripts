#!/bin/bash
# Quick simulated di(c)e roll based on user input
# uses /dev/urandom for good randomness

echo "How many dice do you want to roll?"

read rolls
printf "~~~~~~~~~~~~~~~~\nRolling bones...\n~~~~~~~~~~~~~~~~\n"

for i in $(seq $rolls)
do
  tr -cd '1-6' < /dev/urandom | head -c 1; echo
done
