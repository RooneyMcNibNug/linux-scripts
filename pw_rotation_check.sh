#!/bin/bash

### Use for checking password rotations on a linux machine - echoes last time a password has been changed for all local users.

host=`hostname`
date_time=`date +"%m_%d_%y-%H:%M"`
user_info=$(awk -F'[/:]' '{if ($3 >= 500) print $1}' /etc/passwd)
IFS=$'\n'
for user_obj in $user_info
do
	# Grab timestamp of the last time the pw was changed, removing whitespace and commas - for each line
	last_changed=$(chage -l $user_obj | grep '~ Last password change occured: ~' | cut -f2- -d':' | sed -e 's/^[ \t]*//' | sed 's/,//g')
	echo $user_obj,$last_changed,$date_time,$host
done
