+++
date = "2019-07-02T11:42:23-07:00"
title = "Manage python version on Mac with puenv"
draft = false

tags = ['Python', 'pyenv']
+++


Python is a great programming language with a huge eco system. From automation, to hacking, to reverse engineering, to web dev, to UI, audio processing. Yet, it doesn't have an easy to use workflow when it come to manage python version and even python dependencies.

It's a bit tricky and not quite straightforward with multiple tools.

```
brew install pyenv
```

Now that you have `pyenv`, you can start to install Python for real

```

```

Now, when you need create a separate virtualenv you run this . 

Normally on Mac, you use `homebrew` to install/manage native depencies so you may want to run this:


```
LDFLAGS="-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib" CFLAGS="-I/usr/local/include" pip install -r requirements.txt
```
