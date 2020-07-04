### List each unique file-type in a directory (recursively) by most common to least. 

find . -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr # | tee filetypes.txt
