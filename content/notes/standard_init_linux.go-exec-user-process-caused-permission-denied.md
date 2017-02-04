+++
draft = true
date = "2017-02-03T21:58:45-08:00"
title = "standard_init_linux"

+++

Recently I setup a new Jenkins server and I mount the workspace into a EBS volume. When attempting
to run them with compose, I got this error

```
docker-compose run app /trinity/bin/build
standard_init_linux.go:175: exec user process caused "permission denied"
```

A bit of google tell me this is a SE Linux issue but I'm using Ubuntu. So probably it's an apparmor
thing. I tried to temp disable it but still.

Only finally I realized I mount the volume with `noexec`. When mouting with `noexec`, we cannot run
an executable file from that volume. This is great security where we can mount volume as a data volume
only without executing binary from it.

So my fixed was to remount without `noexec` since this is just a build machine

```
sudo mount -o  remount,defaults,auto,noatime /dev/xvdb
```

But what if we don't want this 
