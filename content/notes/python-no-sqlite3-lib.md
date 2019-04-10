+++
date = "2019-04-05T14:45:56-07:00"
title = "python no sqlite3 lib"
draft = false

tags = ['python', 'pyenv', 'sqlite']
+++

I have been doing some Python recently, not that I like Python but it's
what my company use. And I work on infrastructure but have been trying
out some Django tasks.

My workflow typically use `pyenv` to install Python, from there I used
`virualenv` to create a bundle.

```
pyenv install 3.6.8
python-build: use openssl from homebrew
python-build: use readline from homebrew
Downloading Python-3.6.8.tar.xz...
-> https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz
Installing Python-3.6.8...
python-build: use readline from homebrew
WARNING: The Python sqlite3 extension was not compiled. Missing the
SQLite3 lib?
Installed Python-3.6.8 to /Users/vinh/.pyenv/versions/3.6.8
```

Not a big deal, but without SQLite, when you use Python shell such as
IPython, the history isn't saved.

This happens on Mac, probably due to homebrew messing with system
library path.

SQLite header are come from XCode tool, make sure you install xcode
command line tool then run this:

```
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
pyenv install 3.6.8
```

You may want to event but that into your env such as `.bashrc` or
`.zshenv` to avoid running it everytime.

The new pythong installed by `pyenv` will be able to compile sqlite3
extension.
