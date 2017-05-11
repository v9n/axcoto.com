+++
date = "2017-05-11T13:02:23-07:00"
title = "replay production traffic"
draft = true

+++

It's hard to predict production traffic with benchmark. Benchmark tend
to hit same spot which may make us hit the cache all the time. Example,
let's say we do the simple thing such as:

```
ab mysite.local
wrk mysite.local
```

Those tools hit the same URL over and over, and the db will cache some
of query in disk io, in memory or whatever.

So the best way to ensure benchmark is re-play the traffic. We should
re-play only request with no side ejject. Side effect may cause emails
go out, notification is being send.

An example is to re-paly only GET/HEAD. `gor` made this very easy.

## Step 1: Capture the traffic


```bash
sudo /usr/local/bin/gor  --input-raw :80 --output-file=requests.gor \
    --http-allow-method GET \
    --http-allow-method HEAD \
    --http-allow-method OPTIONS
```

Let's it run for awhile and you will have bunch of `*.gor` file.

## Step 2: Replay

Now we have the request log, we can easily re-play them to any endpoint:

```
uliminit -n 65000
gor --input-file "*.gor" --output-http "noty.im"
```

I set the ulimit because we need to open lots of tcp socket depend on
how is our traffic. Gor will happliy send the same request payload, in
exact same order, and interval between them to our endpoint

## Bonus:

Realtime production benchmark

```
sudo /usr/local/bin/gor  --input-raw :32846 --output-http "noty.im"
```

By adjusting `output-http` instead of `file` we can replay them on
realtime to another host. This is very useful when doing migration to a
new server/config and want to see how they are perform compare to old
one
