#!/usr/bin/python

"""This script can be used to configure a *nix machine to use all of
my personal dotted configuration files. This script basically goes
through all of the files in the root of this repository and adds
them as dotted soft links. e.g.,

    ~/.bashrc -> bashrc

It also installs the crontab, which can be optionally disabled using
the --no-crontab command line options.
"""

import glob
import os
import sys
import shutil
from optparse import OptionParser
import subprocess

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
    disallowed_files = set((
        this_filename,
        os.path.join(this_dirname, "README.md"),
    ))
    filenames = glob.iglob(os.path.join(this_dirname,"*"))
    for filename in filenames:
        if filename not in disallowed_files and not filename.endswith("~"):
            linkname = os.path.expanduser(
                os.path.join(homedir, '.' + os.path.basename(filename))
            )
            replace_with_softlink(filename, linkname)

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
        self.add_option(
            "--no-crontab", dest="crontab", action="store_false",
            help="Specify a remote host on which to setup this configuration.",
        )

        # set the default options
        self.set_defaults(
            homedir=os.path.expanduser("~"),
            crontab=True,
        )

if __name__=="__main__":

    parser = ConfigParser()
    options, args = parser.parse_args()

    local_setup_softlinks(options.homedir)

    # install the crontab
    if options.crontab:
        cmd = ["crontab", os.path.join(options.homedir, ".crontab")]
        subprocess.call(cmd)
        sys.stderr.write(' '.join(cmd) + '\n')
