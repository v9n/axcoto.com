+++
title = "Using btrfs with docker"
draft = false
date = "2016-12-16T19:54:58-08:00"

tags = [ "docker", "storage", "btrfs" ]
categories = [
  "DevOps",
]
+++

I recently have some issue with docker and btrfs which makes me want to
learn more about it. The reason I have used `btrfs` is to solve some
issues with device mapper.

I use docker with `btrfs`. Recently, for some reasons the
`/var/lib/docker` grow to 100% disk space and docker unable to start
with some error about opening db file or so.

I tried to take a snapshot of EBS volume and resize it with `resize2fs`
as I always do when resizing volume on EBS. But turning out that doesn't
work due to `btrfs`.

Luckily I found an much nicer way to increase. Simply add a new volume,
then using this:

```
sudo btrfs device add -f /dev/xvdc /var/lib/docker
```

This adds extra space to `/var/lib/docker`. At least, this will make
docker start backup and I can backup my docker image or inspect/debug
some existing container.

