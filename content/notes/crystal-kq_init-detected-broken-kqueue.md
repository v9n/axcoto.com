+++
date = "2017-05-20T18:14:41-07:00"
title = "crystal kq_init detected broken kqueue"
draft = true

tags = [ "crystal", "study" ]
categories = [
  "Development",
  "DevOps",
  "Code",
  "Issue"
]
+++

I started to try out crystal lang today and got the first issue:

```
[warn] kq_init: detected broken kqueue; not using.: Undefined error: 0
```

This can be solved by upgrade `libevent`.

```
brew upgrade libevent
```

Problem solved.
