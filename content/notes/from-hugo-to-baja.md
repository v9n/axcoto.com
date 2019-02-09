+++
date = "2019-02-08T17:43:46-08:00"
title = "From hugo to baja"
draft = false

tags = ["baja", "project"]
+++

I have been useing Hugo and promoted it among my friends for last few years.
It works great, super fast, and very easy to navigate between laptops
since I just need to drop hugo binary in my PATH.

However, Hugo gains tractions and add so many features which I don't need and
I feel overwhelm. I started to think of building a very minimal, simple tool
to generate Go template.

That's how Baja is born. It has a few concepts:

- No pagination: I hate to click around, especially with static site.
  It's so fast that I prefer to ship an index page contains everything.

- No messing around with config file: I don't want to have to create any
  config file to write a blog. All I want to say is, here are my
markdown, here are my template, give me HTML. Of course, some advanced
features need config such as deployment

- Easy and Flexible theme: Let's say I have a file call
  `project/baja.md`. I want to use a different template from normal
article, instead of manualy define layout. All I want is simply create
`themes/project.html` or `theme/project/baja.html`.

- Deployment: I want built in deployment for rsync and kubernetes.
  That's my 2 main use case where I host my site.

- Asset: A static site still need some CSS, and time to time I have to
  do thing like `?v=1` to force refresh CSS. I don't want to add
  JavaScript transpiler to my tiny blog. In the past, I used some bash
  tip to convert the CSS path by appending its md5 hash. I want that
  built-in now.


You can view the source of [this
website](https://github.com/v9n/axcoto.com) 

- theme:
- content:

If you think baja may fit your need, give it a try. Download the `baja`
from Github and get writing:

To generate based theme and skeleton folders:

```
baja init
```

To add a new post:

```
baja new notes "from hugo to baja"
```

When you write, preview it:

```
baja server
```

Then visit http://localhost:2803 and keep writing. The content will be
re-build when you made change.

When it's time to deploy:

```
baja deploy
```

If you don't like baja, it mayne a template that you can build more
feature on top of it.
