+++
date = "2021-01-11T12:22:34-08:00"
title = "Declutter your ~/.ssh/config with `Include`"
draft = false

tags = ["Linux", "DevOps"]
+++

I like to puts my server shortcut into `~/.ssh/config` to custom thing
such as username or port so I can do

```
ssh mx1
```

which will become

```
ssh -p 9222 root@mx1.hanami.run
```

But adding config directly into `~/.ssh/config` get messup very quickly
when I started to have more projects and more server. One nice way is to
cleanup this mess is to use `Include` direction.


Instead of this:

```
# In file ~/.ssh/config
Host db1
  Hostname 10.1.1.2
  User db
  IdentityFile ~/.ssh/db
Host db2
  Hostname 10.1.1.2
  User db
  IdentityFile ~/.ssh/db
```

do this:


```
# In file ~/.ssh/config
Include ~/Sites/hanami/config/ssh/config
# Other config
```

Then in file `~/Sites/hanami/config/ssh/config` I can put these:

```
Host db1
  Hostname 10.1.1.2
  User db
  IdentityFile ~/.ssh/db
Host db2
  Hostname 10.1.1.2
  User db
  IdentityFile ~/.ssh/db
```

The cooling about this is I can tell my team to put that single `Include
instruction` and everyone will share the same SSH config.

Note that `Include` has to be put at the top of `~/.ssh/config` file.
