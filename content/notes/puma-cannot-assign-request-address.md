+++
date = "2017-09-01T11:02:05-07:00"
title = "Cannot assign requested address - bind(2) for \"::1\""
draft = false

tags = [ "docker", "puma", "rails", ]
categories = [
  "Development",
]

+++

Today I encountered this error during running Puma in Dockerm, using
official 2.3 Ruby image.

```
Cannot assign requested address - bind(2) for "::1" port 3000 (Errno::EADDRNOTAVAIL)
```

Google search found out that
[https://github.com/puma/puma/issues/1062](this issue) and a fixed in
[https://github.com/puma/puma/pull/1318](https://github.com/puma/puma/pull/1318).

However, the fixed wasn't working for me. The core of issue is somehow
even the docker container doesn't support ipv6 but we have an entry like
this:

```
::1 localhost ip6-localhost ip6-loopback
```

in host file. This #1318 supposed to fixed it. It seems the issue caugh
by webpack dev server as well besde Puma. At that point, I was
frustrated and just try to find a way to disable ipv6 in docker
container.

If you're using docker compose you can add this line to disable ipv6,
hence remove the `::1` entry from host file:

```
  sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
```
