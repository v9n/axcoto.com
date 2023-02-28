+++
date = "2023-02-27T21:26:59-08:00"
title = "How to fix \"Package is in a very bad inconsistent state\" error in Ubuntu/Debian"
draft = false

tags = ["Ubuntu", "Debian", "DevOps", "Apt"]
+++

On Ubuntu/Debian, Python2/Python3 is still a mess, especially on some
old system like Ubuntu 18. This leads to sometime people try to install
Python3 from deadsnakes PPA, and sometime they might ended up cleaning
up Python2 or relink python to the wrong one.

Ubuntu system has many thing rely on `python2` and some particular code
is Python3.

When a system enter into this state many error happens such as:

```
dpkg: error processing package gyp (--configure):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of python3-pip:
 python3-pip depends on python3:any (>= 3.4~); however:
  Package python3 is not configured yet.
```

Or 

```
Total 0 files, 0 directories removed.
dpkg: warning: while removing python-pkg-resources, directory '/usr/lib/python2.7/dist-packages/pkg_resources/extern' not empty so not removed
dpkg: warning: while removing python-pkg-resources, directory '/usr/lib/python2.7/dist-packages/pkg_resources/_vendor/packaging' not

dpkg: error processing package python3-apt (--configure):
 dependency problems - leaving unconfigured
Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
Errors were encountered while processing:
 python3
 python3-pip
 python3-software-properties
 python3-apt
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

The correct way is to generally perform:

- Remove those PPA such as deadsnakes in source list. never ever use deadsnake PPA in
  2023
- Remove/Purge these packages

Example:

```
apt purge python3
apt remove python3
```

At some poin you will get some crypt error about Python. These are just
the result of `apt/dpkg` ended up calling some python wrapper script.
Simple try to edit and temporary comment some useless line (doesn't do
any real work but the script failed to be intepreter).

Eventually apt will come into a clean enough state. At that time trying
to do:

```
apt update
apt dist-upgrade
```

Eventually you will down to this particular error:

```
dpkg: error processing package python3 (--configure):
 package is in a very bad inconsistent state; you should
 reinstall it before attempting configuration
Errors were encountered while processing:
 python3
```

To fix this is also quite simple:

```
dpkg --remove --force-remove-reinstreq python3
apt-get remove python3
apt-get autoremove && apt-get autoclean
```

After this we can start to install python2/3 again