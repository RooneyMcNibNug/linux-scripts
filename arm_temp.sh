#!/bin/bash

## Quick script to get cpu temp on something like a Raspberry Pi
## Takes CPU temp in millicelsius by default, but converted to standard celsius
## Outputs every one second
## Designed to work not just with Raspberry Pi OS, but other arm64/armfh OSes as well

while true;
do
    temp=$(</sys/class/thermal/thermal_zone0/temp);
    echo "$((temp/1000)) c";
    sleep  1;
done
