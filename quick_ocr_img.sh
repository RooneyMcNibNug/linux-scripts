## I wanted an easier script to OCR images and not only print the discovered text but also dump it into a text file for later,
## so I whipped this small shell script up.
#
## REQUIRED DEPENDENCY: tesseract (https://github.com/tesseract-ocr/tesseract)

#!/bin/bash

# Func to display error message and exit
die() {
  echo "$1" >&2
  exit 1
}

# Check if the correct arg present
if [[ $# -ne 1 ]]; then
  die "usage example: ocr /home/user/pictures/photo_of_book.jpg"
fi

# Get image path from arg
image_path="$1"

# Check if file exists
if [[ ! -f "$image_path" ]]; then
  die "File not found: $image_path"
fi

# OCR time
text_output=$(tesseract "$image_path" stdout)

# tesseract error checking
if [[ $? -ne 0 ]]; then
  die "Sorry, tesseract couldn't recognize text in the image"
fi

# Creaet filename same as image name
output_file="${image_path%.*}.txt"

# Write the OCR text to file
echo "$text_output" > "$output_file"

#Print out text and also point to the text file that has retained it as well
echo "$text_output"

echo "========================================================="
echo "                 END OF OCR TEXT"
echo "========================================================="
echo "Recognized text has also been saved to: $output_file (in current working directory)"
