+++
date = "2021-03-13T23:59:08-08:00"
title = 'docker, apple m1, nginx and standard_init_linux.go:211: exec user process caused "exec format error"'
draft = false

tags = ["docker", "apple m1"]
+++

# Summary

This article is a note about building docker image for amd64 from an
Apple M1 macbook. The error is usually something similar to this

```
standard_init_linux.go:211: exec user process caused "exec format error"
```

To fix that you need to specify `--platform amd64` in your docker build

```
docker build --platform amd64 -t axcoto/website:$(GIT_COMMIT) .
```

# The whole story

Today I got a new M1 laptop so that I can run Slack and Chrome at the
same time. My macbook air is too slow so that I cannot use Slack at all.

I have a very simple dockerfile

```
FROM nginx:1.19

COPY public /usr/share/nginx/html
```

Once build and push to docker, then run on my k8s cluster, I got this

```
standard_init_linux.go:211: exec user process caused "exec format error"
```

How can that happen, I just add my static file. No compilation. Turn out
the image we built, without specifing anything is for arm64 cpu
architecture. To fix that, we have to explicitly specify an cpu arch
when cross building the image. Regardless, it's alwys better to be
specificed with what we want


```
docker build --platform amd64 -t axcoto/website:$(GIT_COMMIT) .
```

Then the image will be able to run on amd64 cpu.
