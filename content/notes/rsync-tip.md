+++
date = "2017-04-06T12:27:20-07:00"
title = "rsync tip"
draft = false

tags = [ "linux", "rsync", "backup", "bash", "linux-daily" ]
+++

Rsync is a great tool when we need to transfer data. It supports dedupe,
compress out of the box. However, it's quite complex. Below is a list
of tip that I found myself google a lot, so I write them down for me.

### Rsync with sudo

So you have some file only root has acces. Let's use it this way

```
rsync -chavzP --rsync-path="sudo rsync" --stats user@host:/media/gor .
```


### Rsync with an intermediate host
