### Sometimes you find a super obscure album, podcast, or anything else in a youtube playlist and you want to save it all in order locally.
#
### This script will do that! 
#
### Execute this script and provide STDIN of the playlist link. It will ask you if you want reverse order (this is often good for chronological stuff based
### on the upload date of each video) and then generate HQ mp3s with a playlist in a directory titled "mp3" from your $PWD.
#
### DEPENDENCIES: yt-dlp; jq

#!/bin/bash

# Accept playlist URL from standard input
read -p "Enter the YouTube playlist URL: " playlist_url

# Ask the user if they want to reverse the playlist order from how it is presented first-to-last from the playlist link
read -p "Reverse playlist order (oldest uploaded as first in playlist)? (yes/no): " reverse_option

# Set up downloads for each video in the list
if [[ $reverse_option == "yes" ]]; then
    video_list=$(yt-dlp --flat-playlist -j --playlist-reverse "$playlist_url" | jq -r '.id')
else
    video_list=$(yt-dlp --flat-playlist -j "$playlist_url" | jq -r '.id')
fi

# Create directory for MP3 files
mkdir -p mp3

# Iterate over each video in the playlist and download
counter=1
while read -r video_id; do
    # Download video as MP3 in highest quality
    yt-dlp -x --audio-format mp3 --audio-quality 0 --ignore-config -o "mp3/$counter-%(title)s.%(ext)s" "https://www.youtube.com/watch?v=$video_id"

    counter=$((counter + 1))
done <<< "$video_list"

# Create playlist file
echo "#EXTM3U" > mp3/playlist.m3u
counter=1
for mp3_file in mp3/*.mp3; do
    echo "#EXTINF:-1,$counter-$(basename "$mp3_file" | cut -d'-' -f2- | cut -d'.' -f1)" >> mp3/playlist.m3u
    echo "mp3/$(basename "$mp3_file")" >> mp3/playlist.m3u

    counter=$((counter + 1))
done

echo "~~~ Done! ~~~"
