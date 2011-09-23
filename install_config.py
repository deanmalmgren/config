#!/usr/bin/python

"""Go through all of the files in the root of the config repository
and add them as dotted soft links. e.g., 

    ~/.bashrc -> bashrc
"""

import glob
import os
import sys
import shutil

if __name__=="__main__":

    this_filename = os.path.abspath(__file__)
    filenames = glob.iglob(os.path.join(os.path.dirname(this_filename),"*"))
    for filename in filenames:
        if filename != this_filename and not filename.endswith("~"):
            linkname = os.path.expanduser(
                os.path.join("~", '.' + os.path.basename(filename))
            )
            if os.path.exists(linkname):
                try:
                    os.remove(linkname)
                except OSError:
                    shutil.rmtree(linkname)
            os.symlink(filename, linkname)
            
            sys.stderr.write("ln -s %s %s\n"%(filename, linkname))
                
            
