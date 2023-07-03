## Check the format and streams of a video file. The actual output is suppressed and discarded, giving a way 
## to determine if the file is corrupt or incomplete based on the exit status of ffprobe.

#!/bin/bash

read -e -p "Enter the directory path: " directory
if [ ! -d "$directory" ]; then
  echo "Directory does not exist."
  exit 1
fi

for file in "$directory"/*; do
  # Check against common video file extensions
  if [[ -f "$file" && ( "$file" =~ \.mp4$ || "$file" =~ \.mkv$ || "$file" =~ \.avi$ ) ]]; then
    # Use ffprobe to check each file's integrity
    ffprobe -v error -show_format -show_streams "$file" > /dev/null 2>&1

    # Check the exit status of ffprobe to determine if each file is corrupt or incomplete
    if [ $? -ne 0 ]; then
      echo "Corrupted or incomplete file: $file"
    fi
  fi
done
