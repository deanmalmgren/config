#!/usr/bin/python

"""Go through all of the files in the root of the config repository
and add them as dotted soft links. e.g., 

    ~/.bashrc -> bashrc
"""

import glob
import os
import sys
import shutil

def replace_with_softlink(filename, linkname):
    """create softline and remove if it already exists
    """
    if os.path.exists(linkname):
        try:
            os.remove(linkname)
        except OSError:
            shutil.rmtree(linkname)
    os.symlink(filename, linkname)

    sys.stderr.write("ln -s %s %s\n"%(filename, linkname))


if __name__=="__main__":

    this_filename = os.path.abspath(__file__)
    this_dirname = os.path.dirname(this_filename)
    filenames = glob.iglob(os.path.join(this_dirname,"*"))
    for filename in filenames:
        if filename != this_filename and not filename.endswith("~"):
            linkname = os.path.expanduser(
                os.path.join("~", '.' + os.path.basename(filename))
            )
            replace_with_softlink(filename, linkname)

    # create soft links for other files
    filenames = (
        os.path.join(".ssh", "config"),
    )
    for filename in filenames:
        linkname = os.path.expanduser(os.path.join("~", filename))
        replace_with_softlink(os.path.join(this_dirname, filename), linkname)
