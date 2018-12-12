#!/bin/bash

### a pretty lame .sh to wipe the EXIF from all files in an entire directory. exiftool (https://en.wikipedia.org/wiki/ExifTool)
### is required in order to run this script ($ apt-get install exiftool). Just plop this .sh in the dir of files you want metadata wiped from.

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
for y in *
do
        (echo -e "${GREEN}~ Displaying metadata found ~${NO_COLOR}" ; exiftool -f * ; echo -e "${GREEN}~ Running EXIF tool ~${NO_COLOR}" ; exiftool -all= -ext "*" "$y" ;)
done
