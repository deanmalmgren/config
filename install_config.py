#!/usr/bin/python

"""This script can be used to configure a linux machine to use all of
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

from fabric.api import *

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

def local_setup_softlinks():
    """this function sets up a bunch of soft links to configuration
    files within this repository.  
    """
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

class ConfigParser(OptionParser):
    __doc__ = __doc__

    def __init__(self, *args, **kwargs):

        # use the docstring as the description
        kwargs.update({"description": __doc__})
        OptionParser.__init__(self, *args, **kwargs)

        # add some options
        self.add_option(
            "--hostname", dest="hostname", type="str",
            help="Specify a remote host on which to setup this configuration.",
        )

        # set the default options
        self.set_defaults(
            hostname="",
        )

def _annotate_hosts_with_ssh_config_info():
    """use local ssh config to alter env.hosts for usage with fabric

    http://markpasc.typepad.com/blog/2010/04/loading-ssh-config-settings-for-fabric.html
    """
    from os.path import expanduser
    from paramiko.config import SSHConfig

    def hostinfo(host, config):
        hive = config.lookup(host)
        if 'hostname' in hive:
            host = hive['hostname']
        if 'user' in hive:
            host = '%s@%s' % (hive['user'], host)
        if 'port' in hive:
            host = '%s:%s' % (host, hive['port'])
        return host

    try:
        config_file = file(expanduser('~/.ssh/config'))
    except IOError:
        pass
    else:
        config = SSHConfig()
        config.parse(config_file)
        keys = [config.lookup(host).get('identityfile', None)
                for host in env.hosts]
        env.key_filename = [expanduser(key) for key in keys if key is not None]
        env.hosts = [hostinfo(host, config) for host in env.hosts]        
        
if __name__=="__main__":

    parser = ConfigParser()
    options, args = parser.parse_args()

    # local mode
    if not options.hostname:
        local_setup_softlinks()

    # setup a remote server
    else:
        
        # get root directory
        local_dir = os.path.dirname(os.path.abspath(__file__))

        # get fabric to use your local ssh config
        env.hosts = [options.hostname]
        _annotate_hosts_with_ssh_config_info()
        host_string = env.hosts[0]

        # extract the username for this host
        username = None
        if "@" in host_string:
            username = host_string.split("@")[0]

        with settings(host_string=env.hosts[0]):

            # install mercurial
            sudo("apt-get install mercurial")

            # copy .ssh/config to remote server to make it easy to clone
            # this repository
            run("mkdir -p ~/.ssh")
            put(os.path.join(local_dir, ".ssh", "config"), 
                os.path.join(".ssh", "config"))

            # clone the repository to the remote server
            run("hg clone ssh://poisson//home/rdm/config")

            # run the setup script on remote server
            with cd("config"):
                run("./install_config.py")
