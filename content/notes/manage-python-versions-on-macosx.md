+++
date = "2019-07-02T11:42:23-07:00"
title = "Manage python version on Mac with pyenv"
draft = false

tags = ['Python', 'pyenv']
+++

I'm not a Python programmer but due to job constraint I end up writing
Python code. Being used to Ruby's RVM, I struggle to get something
similar for Python.

This is a process that works for me and I hope it might work for you.
The primary tool I used to manage different Python version is `pyenv`.

## Install pyenv

An easy step.

```
brew install pyenv
```

## Install dependencies

`pyenv` will compile Python from sources. Thus we need many library. On
Linux, these are usually in `lib*` or `*devel` package. On Mac, we use
`homebrew` for everything.

```
brew install zlib openssl
```

## Install a python version

Now that you have `pyenv`, you can start to install Python for real. Not
so quick. If you are on Linux, lots of library is in standard place
where python compiler expect. But if you are on Mac, we usually have 2
places:

- Xcode command line tools
- Homebrew

Homebrew has lot of stuff such as above `zlib`. Therefore we need to set
a few extra environment var to point to these.

```
# Setup env
export FLAGS="${FLAGS} -I$(brew --prefix zlib)/include -I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="${LDFLAGS} -L$(brew --prefix zlib)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix zlib)/include -I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
export PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
```

Now you can compile and install any Python version:

```
# See what is avaibale
pyenv install --list

# Install specificed version
pyenv install -v 3.7.3
```

## Setup PATH

As always, in order to override default system Python, we prepend our
PATH with path to our custom Python.

This is usually done in shell rc file

- bash: ~/.bashrc
- zsh: ~/.zshrc

Add this block to the end:

```
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```

## Using pyenv's Python version

In a given directory, run this

```
pyenv local 3.7.3
```

This will also create a file call `.python-version` in your current
directory. Later on, when you cd into this directory again, the right
Python version will automatically load for you.

Example

```
# default system python cuz no `.python-version` file is found
➜ cd ~
➜ python -V
Python 2.7.15

# When I move into this directory, python version changed
➜ cd ~/src/axcoto.com
➜ python -V
Python 3.7.3
```

## Install requirements.txt with native dependencies

Similarly to `pyenv install`, if any packages need native library you
will need to set those `LDFLAGS`, `CPPFLAGS` before run `pip install`

Example, if you need `geoip` package, you will have to do:


```
brew install libGeoIp
export LDFLAGS="${LDFLAGS}  -L/usr/local/lib"
export CFLAGS="${CFLAGS} -I/usr/local/include"
```

How do you know where these lib are locate? Most of time they are in
`/usr/local/lib` and `/usr/local/include`

```
ls /usr/local/lib/ | grep libGeo
libGeoIP.1.dylib
libGeoIP.a
libGeoIP.dylib
```

Libraries that don't located in `/usr/local/lib` means they aren't
linked by `homebrew` so they usually in `/usr/local/lib/[name]`. When
you run `brew install`, it will tell you that the package isn't linked
and the path to it etc. Just pay attention to the `brew install` output
and you should be good.

## How does pyenv work

During install, `pyenv` install python versions into `~/.pyenv/versions`

```
ls -la ~/.pyenv/versions
total 0
drwxr-xr-x  4 vinh  staff  128 Jul  7 12:57 .
drwxr-xr-x  4 vinh  staff  128 Jul  7 00:38 ..
drwxr-xr-x  6 vinh  staff  192 Jul  7 13:00 3.6.7
drwxr-xr-x  6 vinh  staff  192 Jul  7 00:38 3.7.3
```

the script we add to our `shell rc` file prepend `pyenv path` to a file
call `python`.

```
➜ echo $PATH
/Users/vinh/.pyenv/shims:/Users/vinh/.pyenv/bin:/Users/vinh/.cargo/bin:/Users/vinh/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Users/vinh/.rvm/bin:/Users/vinh/bin:/Users/vinh/go/bin:

➜ which python
/Users/vinh/.pyenv/shims/python
```

This file isn't the Python executable but a shell script that try to
load and use `exec` to replace the shell process with the right Python
version.

```
➜ cat /Users/vinh/.pyenv/shims/python
#!/usr/bin/env bash
set -e
[ -n "$PYENV_DEBUG" ] && set -x

program="${0##*/}"
if [[ "$program" = "python"* ]]; then
  for arg; do
    case "$arg" in
    -c* | -- ) break ;;
    */* )
      if [ -f "$arg" ]; then
        export PYENV_FILE_ARG="$arg"
        break
      fi
      ;;
    esac
  done
fi

export PYENV_ROOT="/Users/vinh/.pyenv"
exec "/usr/local/Cellar/pyenv/1.2.11/libexec/pyenv" exec "$program" "$@"
```

Knowing this detail will help you debug any issue with `pyenv` not
loading or picking up the right Python version. You can simply debug the
PATH or the shim script.
