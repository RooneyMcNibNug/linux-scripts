##Quick removal of "duplicated" extension in the name of a file - this can cause issues for maybe obvious reasons.
##Example here is .PNG, which if in the name of the file can prevent PNG images from loading properly in things 
##like Gnome Image Viewer.

find . -type f -name '*.png' -exec sh -c '
    for pathname do
        mv -- "$pathname" "${pathname%.png}"
    done' sh {} +
