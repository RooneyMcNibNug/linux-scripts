# My quick script for converting Canon EOS DSLR raw images (.CR2) to .TIFF files for editing.
# This will avoid a segfault bug that is apparently still around in some versions of ufraw.
# Run from working directory.
# Run commented-out exiv2 line for privacy enhancements.


photo = ("*.CR2")

for $photo in $cwd
do
  ufraw-batch $photo --out-type=tif --wb=camera --black-point=auto --nozip
done

# exiv2 -da rm *.TIFF

# optional: --exposure=0.33 --out-depth=8
