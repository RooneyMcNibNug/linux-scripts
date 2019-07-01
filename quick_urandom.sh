#!/bin/bash
# I trust you, /dev/urandom

echo "How many characters do you want in your string?" 

read strlen

echo "Include special characters? [y/n]"

read char
if [[ $char == y ]]; then
   cat /dev/urandom | tr -dc 'a-zA-Z0-9`~@#$%^&*()-_=+[{]}\:;<,>.?/' | fold -w $strlen | head -n 1
else
   cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $strlen | head -n 1
fi
