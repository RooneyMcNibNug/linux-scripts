## Do you have a bunch of your DVDs ripped and/or other media stored on a machine in a particular directory?
## Do you and/or your friends suffer from indecisiveness when it comes to picking out something to watch?
## Do you use VLC?
#
## Well, let Python and VLC decide what you should watch right now!
## You can just change the directory paths with wildcard file extensions within "project_files" to wherever
## you have things stored at the moment.
#
## Stop browsing through all your shit and just watch something already!

import glob
import random
import subprocess

project_files = glob.glob('/media/**/*.mp4') + glob.glob('/media/**/*.mkv') + glob.glob('/media/**/*.avi')

play = random.choice(project_files)
subprocess.run(["vlc", play, "–fullscreen"])
