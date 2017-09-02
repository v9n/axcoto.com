+++
date = "2017-05-24T12:43:31-07:00"
title = "openvpn allow same user connection from multiple machine"
draft = false

tags = [ "openvpn" ]
categories = [
  "devops",
]
+++

It's common in OpenVPN worlrd where each of user allow to have only one
active connection to server. If an user try to connect from other
machine, the other will be disconnected.

Basically, each client require their own cert/key with an **unique**
common name(whcih is default behaviour). While we should of course use
different cert/key for every user, it's fine to allow same user connect
from multiple machine.

To by pass this, we can simply set this in `/etc/openvpn/openvpn.conf`

```
duplicate-cn
```

So why were this was turn off by default given its usefulness?

