+++
date = "2020-02-27T06:00:31-08:00"
title = "Docker: pull access denied, repository does not exist or may require 'docker login'"
draft = true

tags = [DevOps, Docker]
+++

When you see this kind of error on a public repository when doing docker
pull:

```
pull access denied for postgresql, repository does not exist or may
require 'docker login': denied: requested access to the resource is
denied
```

It is actually doesn't mean what it means. Because the repo are public.
It means that you are using an outdated docker version. I think they do
this as a way to force people update docker.

On the very first time this happen to me, I though it's some kind of
docker for mac bugs, but then the second time, third time happen I think
they may doing this on purpose.

It never happen on Ubuntu but it happens to me 3 times in last 9 months.

Did anyone experience this? I would love to here?
