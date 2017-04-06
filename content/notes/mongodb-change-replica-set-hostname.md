+++
date = "2017-04-05T11:36:43-07:00"
title = "mongodb change replica set hostname"
draft = true

+++

MongoDB by default take the hostname when creating replica set. In a
replica set, the node communicate by that hostname. If the hostname
wasn't resolveable then they will not be able to talk to each other.
A way to solve them is using ip address or some public/private DNS 
as hostname.

Changing hostname is easy, by following these steps.

```
cfg = rs.conf();
cfg.members[0].host = "newhostname.tld:27017";
rs.reconfig(cfg);
```
