## Trim a video and turn that clip into a decent .gif
#
## Drop this script into the directory your video is saved at, run it,
## input your specs, and it will create the .gif for you in the same path.
#
## Requires ffmpeg: https://ffmpeg.org
#
## This is a Work In Progress. Probably sub-optimal atm. Such is life.

echo -e "\e[1;35m~~ trim a video and convert the clip to .gif ~~"
echo -e "\e[1;35m== Please use the format in the bracketed examples =="
echo -e "\e[1;35m== or hit 'Enter' for defaults (shown in brackets) =="
echo -e "\e[1;37m==============================================="
read -e -p "enter video you want to convert [lmao.mp4]: " file
read -p "start of clip at what timestamp? [00:00:01]: " start
start=${start:-00:00:01}
read -p "end of clip at what timestamp? [00:00:05]: " end
end=${end:-00:00:05}
#read -p "how many frames per second do you want your .gif to be? [30]: " framerate
#framerate=${framerate:-30}
read -p "what is the desired scale of the image? [480]: " scale
scale=${scale:-480}
read -p "what filename do you want for the gif?: [uwu.gif]" gif
gif=${gif:-uwu.gif}

# Get the framerate of the video file with ffprobe (without the label)
fr=$(ffprobe -v 0 -of compact=p=0 -select_streams 0 -show_entries stream=r_frame_rate $file | cut -c14-)

# Standard output for the previous cmd looks like "2997/100", so let's divide!
framerate=$(echo $(($fr)))

# Create the clip 
ffmpeg -i $file -ss $start -to $end -c:v copy -c:a copy $gif.mp4

# Create the .gif with 'auto-pallette-ing'
ffmpeg -i $gif.mp4 -filter_complex "fps=$framerate,scale=$scale:-1:flags=lanczos,split[x][z];[z]palettegen[y];[x][y]paletteuse" $gif

# OPTIONAL: un-comment the below to remove the trimmed video file (if you just want the gif):
#rm $gif.mp4
