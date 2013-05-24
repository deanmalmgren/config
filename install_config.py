#!/usr/bin/python

"""This script can be used to configure a *nux machine to use all of
my personal dotted configuration files. This script basically goes
through all of the files in the root of this repository and adds
them as dotted soft links. e.g.,

    ~/.bashrc -> bashrc
"""

import glob
import os
import sys
import shutil
from optparse import OptionParser

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

def local_setup_softlinks(homedir):
    """this function sets up a bunch of soft links to configuration
    files within this repository.  
    """
    this_filename = os.path.abspath(__file__)
    this_dirname = os.path.dirname(this_filename)
    filenames = glob.iglob(os.path.join(this_dirname,"*"))
    for filename in filenames:
        if filename != this_filename and not filename.endswith("~"):
            linkname = os.path.expanduser(
                os.path.join(homedir, '.' + os.path.basename(filename))
            )
            replace_with_softlink(filename, linkname)

    # # create soft links for other files
    # filenames = (
    #     os.path.join(".ssh", "config"),
    # )
    # for filename in filenames:
    #     linkname = os.path.expanduser(os.path.join(homedir, filename))
    #     replace_with_softlink(os.path.join(this_dirname, filename), linkname)

class ConfigParser(OptionParser):
    __doc__ = __doc__

    def __init__(self, *args, **kwargs):

        # use the docstring as the description
        kwargs.update({"description": __doc__})
        OptionParser.__init__(self, *args, **kwargs)

        # add some options
        self.add_option(
            "--homedir", dest="homedir", type="str",
            help="Specify a remote host on which to setup this configuration.",
        )

        # set the default options
        self.set_defaults(
            homedir=os.path.expanduser("~"),
        )

if __name__=="__main__":

    parser = ConfigParser()
    options, args = parser.parse_args()

    local_setup_softlinks(options.homedir)
