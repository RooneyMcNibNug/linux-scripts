### Script to convert any .doc, .docx and .txt files found within a directory to .md files.
#
### This does not include format conversions, unfortunately, but the goal is to get them into a note taking system
### that supports markdown (among other use cases).
### REQUIRES: pandoc

#!/bin/bash

# Conversion functionality
convert_to_markdown() {
    file=$1
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"
    markdown_file="${filename}.md"

    echo "Converting $file to Markdown..."

    case "$extension" in
        docx|doc)
            pandoc -s "$file" -t markdown -o "$markdown_file"
            ;;
        txt)
            pandoc "$file" -f plain -t markdown -o "$markdown_file"
            ;;
        *)
            echo "Unsupported file format: $file"
            return
            ;;
    esac

    echo "Converted $file to Markdown: $markdown_file"
}

# Recursively convert the files in the specified directory
convert_files_in_directory() {
    directory=$1

    for file in "$directory"/*; do
        if [ -d "$file" ]; then
            # If it's a directory, recursively call the function
            convert_files_in_directory "$file"
        elif [ -f "$file" ]; then
            # If it's a file, check if it's .docx, .doc, or .txt and if so convert it
            convert_to_markdown "$file"
        fi
    done
}

if [ $# -eq 0 ]; then
    echo "Usage: ./convert_to_markdown.sh <directory>"
    exit 1
fi

directory=$1

if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist."
    exit 1
fi

convert_files_in_directory "$directory"
