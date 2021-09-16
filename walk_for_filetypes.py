## Search for files by extension (recursively) with this tiny python script
## Just edit the desired path in the code and file extension(s) accordingly
## This should print the full path to each file found

import os
   
# Using os.walk()
for dirpath, dirs, files in os.walk('/var'): 
  for filename in files:
    fname = os.path.join(dirpath,filename)
    if fname.endswith('.log'):
      print(fname)
