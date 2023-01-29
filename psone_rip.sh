#!/bin/bash

## Dump a Playstation 1 disc into .bin, .cue, and .iso files with linux
#
## Requires cdrdao & bchunk packages
#
## You can use something like https://github.com/m35/jpsxdec with jar to
## inspect media on the disc afterwards :)

export DIR=$HOME/Documents/psx

if [ "$1" == "--help" ]; then
  echo "Preserve your Playstastion 1 disks! 

Usage:
  $(basename ${0}) [{--no-subchannel] [{--help}] [filename]

The [filename] is mandatory.

Available parameters:
  --help      Displays the info here (helps)
  --no-subchannel  Don't extract any subchannel data. Subchannel data is used for copy protection 
                   on certain games. This looks for it to work correctly, but it may fail if there is none 
                   present, so you can retry and pass this param if you run into any initial issues against a disc.

NOTE: Please check some of the variables in the script/feel free to change them according to your needs.

ANOTHER NOTE: This script requires the following packages:
- cdrdao
- bchunk"

  exit 0
fi

if [ $1 -z -o $2 -n ]; then
    echo "\nERROR: Invalid usage.\n"
    echo "\n  USAGE: ./psone_rip.sh [filename]\n"
    echo "\n  where filename is the desired name (without extensions).\n"
fi

while [ "${1}" != "" ]; do
    if [[ ! -e $DIR ]]; then
       mkdir $DIR
    elif [ "${1}" = "--nosubchan" ]; then
		NOSUBCHAN="true"
		shift 2
	else
		FILE=$1
		shift
	fi
done

# Ripping:
cd /usr/bin
if [ "$NOSUBCHAN" = "true" ]; then
        ./cdrdao read-cd --read-raw --datafile $DIR/$FILE.bin --device /dev/sr0 --driver generic-mmc-raw $DIR/$FILE.toc # with subchannel data
    else
        ./cdrdao read-cd --read-raw --read-subchan rw_raw --datafile $DIR/$FILE.bin --device /dev/sr0 --driver generic-mmc-raw $DIR/$FILE.toc #without subchannel data
fi

toc2cue $DIR/$FILE.toc $DIR/$FILE.cue
bchunk -s -w $DIR/$FILE.bin $DIR/$FILE.cue $DIR/$FILE
