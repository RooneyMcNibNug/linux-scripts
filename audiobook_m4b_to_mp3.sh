## Script to take an audiobook .m4b file, get metadata, and extract the chapters as seperate .mp3 files into a folder with the same title as the audiobook file
#
## REQUIRED DEPENDENCIES: ffmpeg, id3v2 

#!/bin/bash

# Initial track number
track=1

# Process the file and its metadata
process_file() {
    local input_file="$1"
    local name="${input_file%.*}"
    local title=$(basename "$(pwd)")
    local output_dir="${name}"

    # Create output directory
    mkdir -p "$output_dir"

    # Convert to mp3s
    ffmpeg -i "$input_file" -acodec libmp3lame -ar 22050 -ab 64k "${output_dir}/${name}.mp3"
    local full_file_path="${output_dir}/${name}.mp3"

    # Extract chapter info using ffprobe
    ffprobe -v error -show_entries chapter=start_time,end_time,title -of default=noprint_wrappers=1:nokey=1 "$full_file_path" > chapters.txt

    while IFS= read -r start && IFS= read -r end && IFS= read -r chapter; do
        chapter=$(printf "%02d" "$chapter")  # Zero-pad chapter number
        chapter_file="${output_dir}/${title} - ${chapter}.mp3"
        echo "Processing chapter: $chapter"

        # Split chapters
        ffmpeg -loglevel error -stats -i "$full_file_path" -ss "$start" -to "$end" -codec:a copy -metadata track="$chapter" "$chapter_file"
        
        # Add ID3 tags
        id3v2 --song "$chapter" "$chapter_file"
        id3v2 --album "$title" "$chapter_file"
        id3v2 --track "$track" "$chapter_file"
        
        echo "$title - $chapter"
        track=$((track + 1))
    done < chapters.txt

    # Cleanup
    rm chapters.txt
    rm "$full_file_path"
}

# Process only .m4b files
for file in *.m4b; do
    [ -e "$file" ] || continue  # skip if no files found
    process_file "$file"
done
