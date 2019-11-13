#!/bin/bash

### Quick listing of shared libraries. This script is to avoid running the ldd command 
### so that it does not execute anything, but also list full paths of shared libraries.

find /bin -type f -perm /a+x -exec ldd {} \; | grep so | sed -e '/^[^\t]/ d' | sed -e 's/\t//' | sed -e 's/.*=..//' | sed -e 's/ (0.*)//' | sort | uniq | sort
