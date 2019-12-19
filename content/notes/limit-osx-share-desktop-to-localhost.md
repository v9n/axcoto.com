+++
date = "2019-04-04T09:21:22-07:00"
title = "Secure OSX share desktop to localhost"
draft = false

tags = ["vnc", "security"]
+++

OSX VNC is very useful when you want to remote control your personal
laptop from work. But you don't want it to listen to all IP. Because you
may have a weak password and you may join unsecure network in public.

It would be great if we can limit VNC to localhost only. Then using SSH
local port forwarding to access VNC. And SSH is more secure, and with
keybase login, it's super hard to hack, compare with simple VNC
password.

## Configure VNC to listen on localhost

Run this command:

```
sudo defaults write \
  /Library/Preferences/com.apple.RemoteManagement.plist \
  VNCOnlyLocalConnections -bool yes
```

Once we toggle that flag, we need to reload vnc daemon:

```
cd /System/Library/LaunchDaemons
sudo launchctl unload com.apple.screensharing.plist
sudo launchctl load com.apple.screensharing.plist
```

You can verify this with `netstat`:

```
# before
➜ netstat -na | grep 5900
tcp4       0      0  *.5900                 *.* LISTEN
tcp6       0      0  *.5900                 *.* LISTEN

# after
```

So next question is how to secure SSH. We don't want to use password
alone and use keybase login. Open `/etc/ssh/sshd_config` and add these
lines or change existing one:


```
# /etc/ssh/sshd_config
PasswordAuthentication no
ChallengeResponseAuthentication no
```

We'll need to reload SSH daemon

```
sudo launchctl unload  /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w  /System/Library/LaunchDaemons/ssh.plist
```
Now to run VNC we have to tunnel throuh SSH. From another server you run
this


```
ssh -L 5901:localhost:5900 vinh@10.147.17.184
```

Then on your laptop, open a VNC connection to port `5901` will bring you
to your remote mac.

