#!/bin/bash

### a noob .sh to wipe the metadata from all files in an entire directory. The Metadata Anonymisation Toolkit (https://mat.boum.org/)
### is required in order to run this script ($ apt-get install mat). Just plop this .sh in the dir of files you want metadata wiped from.

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
OLDIFS=$IFS
IFS=$(echo -en "\n\b")
for dir in $(find . -type d)
do
        (echo -e "${GREEN}~ Displaying metadata found ~${NO_COLOR}" ;
        mat2 -d $dir ;
        echo -e "${GREEN}~ Running Metadata Anonymization tool ~${NO_COLOR}" ;
        mat2 $dir ;
        e$
done
IFS=$OLDIFS
